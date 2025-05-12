import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/video_model.dart';
import '../../contoller/providers/color_provider.dart';

class VideoDetailsBottomSheet extends ConsumerWidget {
  final VideoModel videoModel;

  const VideoDetailsBottomSheet({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      // Adjust initial height
      minChildSize: 0.4,
      // Minimum size before closing
      maxChildSize: 1.0,
      // Full screen height
      expand: false,
      builder: (context, scrollController) {
        final textColor = ref
            .watch(themeModeNotifier.notifier)
            .textTheme(ref: ref);
        final containerColor = ref
            .watch(themeModeNotifier.notifier)
            .containerTheme(ref: ref);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Swipe Down Indicator
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Scrollable Content with Listener
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is OverscrollNotification &&
                        notification.overscroll < 0) {
                      Navigator.pop(
                        context,
                      ); // Close bottom sheet when swiping down
                      return true;
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    // Use DraggableScrollableSheet's controller
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          videoModel.videoTitle,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: textColor),
                        ),
                        const SizedBox(height: 8),
                        buildClickableText(
                          videoModel.videoDescription,
                          textColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildClickableText(String text, Color textColor) {
    final urlRegex = RegExp(r'(https?://[^\s]+)'); // Detects URLs

    List<TextSpan> spans = [];
    text.splitMapJoin(
      urlRegex,
      onMatch: (match) {
        final url = match.group(0)!;
        spans.add(
          TextSpan(
            text: url,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () async => await _launchURL(url),
          ),
        );
        return url;
      },
      onNonMatch: (nonMatch) {
        spans.add(TextSpan(text: nonMatch, style: TextStyle(color: textColor)));
        return nonMatch;
      },
    );

    return SelectableText.rich(TextSpan(children: spans));
  }

  Future<void> _launchURL(String url) async {
    final Uri urlParsed = Uri.parse(url);
    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(
        urlParsed,
        mode:
            LaunchMode
                .externalApplication, // forces opening in an external browser
      );
    } else {
      // Optionally handle error: show a snackbar or log an error message
      debugPrint("Could not launch $url");
    }
  }
}
