import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Top'),
            Tab(text: 'Photos'),
            Tab(text: 'Videos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTopTrending(),
          _buildPhotoGrid(),
          _buildVideoGrid(),
        ],
      ),
    );
  }

  Widget _buildTopTrending() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: index < 3
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '#${index + 1}',
                style: TextStyle(
                  color: index < 3 ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              'Trending Topic ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('${(10 - index) * 1234} posts'),
            trailing: const Icon(Icons.trending_up),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildPhotoGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: 30,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: CachedNetworkImage(
            imageUrl: 'https://picsum.photos/seed/trending$index/200',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[200]),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.image),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 16 / 12,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/seed/video$index/300/200',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.videocam),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(150),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Row(
                    children: [
                      const Icon(Icons.visibility, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${(index + 1) * 523}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      const Spacer(),
                      Text(
                        '${(index % 5) + 1}:${(index * 7) % 60}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
