import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef TagCallback = void Function(String tag);

class HashtagText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color hashtagColor;
  final bool underlineHashtags;
  final TagCallback? onHashtagTap;
  final TagCallback? onMentionTap;
  final int? maxLines;
  final TextOverflow? overflow;

  const HashtagText({
    super.key,
    required this.text,
    this.style,
    this.hashtagColor = const Color(0xFF5BCFF2),
    this.underlineHashtags = false,
    this.onHashtagTap,
    this.onMentionTap,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: _buildTextSpan(context),
    );
  }

  TextSpan _buildTextSpan(BuildContext context) {
    final defaultStyle = style ?? DefaultTextStyle.of(context).style;
    final List<InlineSpan> spans = [];

    // Pattern to match hashtags (#word) and mentions (@word)
    final pattern = RegExp(r'(#[a-zA-Z0-9_-]+|@[a-zA-Z0-9_.-]+)');
    
    int lastMatchEnd = 0;
    
    for (final match in pattern.allMatches(text)) {
      // Add text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: defaultStyle,
        ));
      }

      // Add the hashtag/mention
      final tag = match.group(0)!;
      final isHashtag = tag.startsWith('#');
      
      spans.add(TextSpan(
        text: tag,
        style: defaultStyle.copyWith(
          color: hashtagColor,
          decoration: underlineHashtags ? TextDecoration.underline : null,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (isHashtag) {
              onHashtagTap?.call(tag);
            } else {
              onMentionTap?.call(tag);
            }
          },
      ));

      lastMatchEnd = match.end;
    }

    // Add remaining text
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: defaultStyle,
      ));
    }

    return TextSpan(children: spans);
  }
}

class HashtagTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final Color hashtagColor;

  const HashtagTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.maxLines,
    this.onChanged,
    this.hashtagColor = const Color(0xFF5BCFF2),
  });

  @override
  State<HashtagTextField> createState() => _HashtagTextFieldState();
}

class _HashtagTextFieldState extends State<HashtagTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: InputBorder.none,
      ),
      onChanged: widget.onChanged,
    );
  }
}

List<String> extractHashtags(String text) {
  final pattern = RegExp(r'#[a-zA-Z0-9_-]+');
  return pattern.allMatches(text).map((m) => m.group(0)!).toList();
}

List<String> extractMentions(String text) {
  final pattern = RegExp(r'@[a-zA-Z0-9_.-]+');
  return pattern.allMatches(text).map((m) => m.group(0)!).toList();
}
