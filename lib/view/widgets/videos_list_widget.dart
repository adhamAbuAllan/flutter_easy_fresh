import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/view/widgets/types_of_list_videos_widgets/show_types_button_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/types_of_list_videos_widgets/types_of_videos_box_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/video_card.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../contoller/providers/widgets_porvider.dart';
import '../../session/new_session.dart';
//
// class VideosListWidget extends ConsumerStatefulWidget {
//   const VideosListWidget({super.key});
//
//   @override
//   ConsumerState createState() => _VideosListWidgetState();
// }
//
// class _VideosListWidgetState extends ConsumerState<VideosListWidget> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(height: 300),
//         Center(
//           child:
//           ref.watch(videoNotifierProvider).loading
//               ? CircularProgressIndicator(color: Colors.white)
//               : ListView.builder(
//             shrinkWrap: true,
//             itemCount:
//             ref
//                 .watch(videoNotifierProvider)
//                 .playListItems
//                 ?.length ??
//                 0,
//             itemBuilder: (context, index) {
//               final video =
//               ref
//                   .watch(videoNotifierProvider)
//                   .playListItems?[index];
//
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Center(
//                   child: Text(
//                     video?.videoTitle ?? "No Title",
//                     style: TextStyle(color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: 50,
//           child: Row(
//             spacing: 16,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   WidgetsBinding.instance.addPostFrameCallback((_) async {
//                     Future.microtask(() {
//                       if (NewSession.get("language", "") == "ar") {
//                         debugPrint("arabic");
//                       } else {
//                         debugPrint("english");
//                       }
//                       ref
//                           .read(videoNotifierProvider.notifier)
//                           .getAllVideos(context:context,
//                         listPlayId:
//                         "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t",
//                       );
//                     });
//                   });
//                 },
//                 child: Text("list 1"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   WidgetsBinding.instance.addPostFrameCallback((_) async {
//                     Future.microtask(() {
//                       ref
//                           .read(videoNotifierProvider.notifier)
//                           .getAllVideos(context:context,
//                         listPlayId:
//                           "PLiMj4nUvC2Jgrw2d4XuhEDE_X69eHRJvX",
//                       );
//                     });
//                   });
//                 },
//                 child: Text("list 2"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   WidgetsBinding.instance.addPostFrameCallback((_) async {
//                     Future.microtask(() {
//                       ref
//                           .read(videoNotifierProvider.notifier)
//                           .getAllVideos(context:context,
//                         listPlayId:
//                         "PLiMj4nUvC2JhWsxIN77Fi-chkVERDFUtt",
//                       );
//                     });
//                   });
//                 },
//                 child: Text("list 3"),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 50,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: VideoFilterBarWidgetA(),
//           ),
//         ),
//         // SizedBox(
//         //   height: 50,
//         //   child: Row(
//         //     spacing: 16,
//         //     mainAxisAlignment: MainAxisAlignment.center,
//         //     crossAxisAlignment: CrossAxisAlignment.center,
//         //     children: [
//         //       ElevatedButton(onPressed: () {
//         //         WidgetsBinding.instance.addPostFrameCallback((_) async {
//         //           VideoState videoState = VideoState();
//         //
//         //           Future.microtask(() {
//         //             ref
//         //                 .read(videoNotifierProvider.notifier)
//         //                 .getAllVideos(context:context,
//         //               listPlayId: "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t"
//         //             );
//         //           });
//         //         });
//         //       }, child: Text("under 30 m")),
//         //       ElevatedButton(onPressed: () {
//         //         WidgetsBinding.instance.addPostFrameCallback((_) async {
//         //           VideoState videoState = VideoState();
//         //
//         //           Future.microtask(() {
//         //             ref
//         //                 .read(videoNotifierProvider.notifier)
//         //                 .getAllVideos(context:context,
//         //               listPlayId: "PLiMj4nUvC2Jgrw2d4XuhEDE_X69eHRJvX"
//         //             );
//         //
//         //           });
//         //         });
//         //       }, child: Text("30 - 60 m")),
//         //       ElevatedButton(onPressed: () {
//         //         WidgetsBinding.instance.addPostFrameCallback((_) async {
//         //           VideoState videoState = VideoState();
//         //
//         //           Future.microtask(() {
//         //             ref
//         //                 .read(videoNotifierProvider.notifier)
//         //                 .getAllVideos(context:context,
//         //               listPlayId: "PLiMj4nUvC2JhWsxIN77Fi-chkVERDFUtt"
//         //             );
//         //           });
//         //         });
//         //       }, child: Text("above 60 m")),
//         //     ],
//         //
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

class ListVideosWithTypeBtn extends ConsumerWidget {
  const ListVideosWithTypeBtn({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return


      GestureDetector(
      onTap: () {
        ref.read(isBoxVisibleNotifier.notifier).state =
            !ref.read(isBoxVisibleNotifier);
      },
      child: Stack(
        alignment:
            NewSession.get("language", "ar") ==
                    "en"
                        ""
                ? Alignment.topLeft
                : Alignment.topRight,
        children: [
          YouTubeVideoCard(scrollController: scrollController),
          ShowTypesButtonWidget(text: "level_of_list",),
          const ShowVideosTypesBoxWidget(), // list of types
        ],
      ),
    );
  }
}
