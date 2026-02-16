import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../core/constants/api_constants.dart';
import '../../data/models/social_post.dart';

class VideoPlayerScreen extends StatefulWidget {
  final SocialPost post;

  const VideoPlayerScreen({super.key, required this.post});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = false;
  double _currentPosition = 0;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => setState(() => _showControls = !_showControls),
        child: Stack(
          children: [
            // Video placeholder (would be actual video player)
            Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${ApiConstants.thumbnailPath}/${widget.post.imageName}',
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(color: Colors.black),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[900],
                        child: const Icon(Icons.video_library, color: Colors.white54, size: 64),
                      ),
                    ),
                    if (!_isPlaying)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 50),
                      ),
                  ],
                ),
              ),
            ),

            // Controls overlay
            if (_showControls)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(150),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withAlpha(150),
                    ],
                    stops: const [0, 0.2, 0.8, 1],
                  ),
                ),
              ),

            // Top bar
            if (_showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

            // Bottom controls
            if (_showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Column(
                    children: [
                      // Progress bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              _formatDuration((_currentPosition * (widget.post.videoDuration ?? 0)).toInt()),
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Expanded(
                              child: Slider(
                                value: _currentPosition,
                                onChanged: (value) {
                                  setState(() => _currentPosition = value);
                                },
                                activeColor: Theme.of(context).primaryColor,
                                inactiveColor: Colors.white30,
                              ),
                            ),
                            Text(
                              _formatDuration(widget.post.videoDuration ?? 0),
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      // Control buttons
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.replay_10, color: Colors.white, size: 32),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 48,
                              ),
                              onPressed: () {
                                setState(() => _isPlaying = !_isPlaying);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.forward_10, color: Colors.white, size: 32),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.fullscreen, color: Colors.white, size: 32),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Video info panel (bottom sheet style)
            if (_showControls)
              Positioned(
                bottom: 120,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            child: Text(widget.post.ownerName[0]),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post.ownerName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  timeago.format(widget.post.datePosted),
                                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (widget.post.description != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          widget.post.description!,
                          style: const TextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.visibility, color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.post.viewsCount} views',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.favorite, color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.post.likesCount}',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.comment, color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.post.commentsCount}',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
