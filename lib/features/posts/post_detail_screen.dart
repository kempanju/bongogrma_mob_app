import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/time_utils.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final int postId;
  final String title;

  const PostDetailScreen({
    super.key,
    required this.postId,
    required this.title,
  });

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  bool _isLoading = true;
  String _content = '';
  String _postLink = '';
  DateTime _insertedDate = DateTime.now();
  bool _isFavourite = false;

  @override
  void initState() {
    super.initState();
    _loadPostDetails();
  }

  Future<void> _loadPostDetails() async {
    // Simulated API call - replace with actual API
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _content = '''
        <p>This is the full content of the article. It includes rich HTML formatting.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        <img src="https://picsum.photos/seed/${widget.postId}/600/400" />
        <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        <h3>Key Points</h3>
        <ul>
          <li>First important point</li>
          <li>Second important point</li>
          <li>Third important point</li>
        </ul>
        <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
      ''';
      _postLink = 'https://example.com/article/${widget.postId}';
      _insertedDate = DateTime.now().subtract(Duration(hours: widget.postId * 2));
      _isLoading = false;
    });
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        actions: [
          IconButton(
            icon: Icon(
              _isFavourite ? Icons.favorite : Icons.favorite_border,
              color: _isFavourite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                _isFavourite = !_isFavourite;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share(
                '${widget.title}\n\n$_postLink',
                subject: 'Habari Sasa',
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _stripHtmlTags(widget.title),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              'Posted ${TimeUtils.getDaysAgo(_insertedDate)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Html(
                      data: _content,
                      style: {
                        'body': Style(
                          fontSize: FontSize(16),
                          lineHeight: const LineHeight(1.6),
                        ),
                        'img': Style(
                          width: Width(100, Unit.percent),
                          margin: Margins.symmetric(vertical: 12),
                        ),
                        'h3': Style(
                          fontSize: FontSize(18),
                          fontWeight: FontWeight.bold,
                          margin: Margins.only(top: 16, bottom: 8),
                        ),
                        'ul': Style(
                          margin: Margins.only(left: 16),
                        ),
                        'li': Style(
                          margin: Margins.only(bottom: 4),
                        ),
                      },
                      onLinkTap: (url, _, _) {
                        if (url != null) _launchUrl(url);
                      },
                    ),
                  ),
                  if (_postLink.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(_postLink),
                          icon: const Icon(Icons.open_in_browser),
                          label: const Text('Visit Website'),
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  String _stripHtmlTags(String htmlString) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '').trim();
  }
}
