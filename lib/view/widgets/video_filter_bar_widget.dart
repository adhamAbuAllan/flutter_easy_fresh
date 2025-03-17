import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/video_duration_filter.dart';
import '../../contoller/providers/color_provider.dart';
import '../../contoller/providers/video_provider.dart';

// class VideoFilterBarWidget extends StatelessWidget {
//   const VideoFilterBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final filterProvider = Provider.of<VideoFilterProvider>(context);
//     final ytVideoViewModel = Provider.of<YtVideoViewModel>(context);
//
//     return Card(
//       color: Colors.transparent,
//       elevation: 0,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FilterButton(
//             title: "All Videos",
//             isSelected: filterProvider.selectedFilter == VideoDurationFilter.allVideos,
//             onTap: () {
//               filterProvider.updateFilter(VideoDurationFilter.allVideos); // Set to "All"
//               ytVideoViewModel.getAllVideos(); // Fetch all videos
//             },
//           ),
//           // "Under 30m" filter button
//           FilterButton(
//             title: "Under 30m",
//             isSelected: filterProvider.selectedFilter == VideoDurationFilter.under30,
//             onTap: () {
//               filterProvider.updateFilter(VideoDurationFilter.under30);
//               ytVideoViewModel.getAllVideos(); // Fetch and filter videos
//             },
//           ),
//
//           // "30-60m" filter button
//           FilterButton(
//             title: "30-60m",
//             isSelected: filterProvider.selectedFilter == VideoDurationFilter.between30And60,
//             onTap: () {
//               filterProvider.updateFilter(VideoDurationFilter.between30And60);
//               ytVideoViewModel.getAllVideos();
//             },
//           ),
//
//           // "Above 60m" filter button
//           FilterButton(
//             title: "Above 60m",
//             isSelected: filterProvider.selectedFilter == VideoDurationFilter.above60,
//             onTap: () {
//               filterProvider.updateFilter(VideoDurationFilter.above60);
//               ytVideoViewModel.getAllVideos();
//             },
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }
class FilterButton extends ConsumerWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? child;

  const FilterButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: ref
              .read(themeModeNotifier.notifier)
              .textTheme(ref: ref),
          backgroundColor:
              isSelected
                  ? ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref)
                  : ref
                      .read(themeModeNotifier.notifier)
                      .containerTheme(ref: ref),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onTap,
        child: child ?? Text(title),
      ),
    );
  }
}
// class FilterButton extends StatelessWidget {
//   final String title;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const FilterButton({
//     required this.title,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: TextButton(
//         style: TextButton.styleFrom(
//           foregroundColor:    isSelected ? :
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//         ),
//         onPressed: onTap,
//         child: Text(title),
//       ),
//     );
//   }
// }

// final videoFilterProvider = StateNotifierProvider<VideoFilterProvider, VideoDurationFilter>(
//   (ref) => VideoFilterProvider(),
// );

// final ytVideoViewModelProvider = Provider<YtVideoViewModel>(
//   (ref) => YtVideoViewModel(),
// );

class VideoFilterBarWidgetA extends ConsumerWidget {
  const VideoFilterBarWidgetA({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access providers using ref.watch
    final filterProvider = ref.watch(videoFilterProvider.notifier);
    final selectedFilter = ref.watch(videoFilterProvider);
    final ytVideoViewModel = ref.watch(videoNotifierProvider.notifier);

    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilterButton(
            title: "",
            isSelected: false,
            onTap: () {
              //open drawer

              Scaffold.of(context).openDrawer();

              // Fetch all videos
            },
            child: Icon(Icons.filter_list),
          ),
          FilterButton(
            title: "All Videos",
            isSelected: selectedFilter == EnumVideoDurationFilter.allVideos,
            onTap: () {
              filterProvider.updateFilter(
                EnumVideoDurationFilter.allVideos,
              ); // Set to "All"
              ytVideoViewModel.getAllVideos(
                listPlayId: ref.read(currentPlayListIdNotifier),
              ); // Fetch all videos
            },
          ),
          // "Under 30m" filter button
          FilterButton(
            title: "Under 30m",
            isSelected: selectedFilter == EnumVideoDurationFilter.under30,
            onTap: () {
              filterProvider.updateFilter(EnumVideoDurationFilter.under30);
              ytVideoViewModel.getAllVideos(
                listPlayId: ref.read(currentPlayListIdNotifier),
              ); //
              // Fetch and filter videos
            },
          ),

          // "30-60m" filter button
          FilterButton(
            title: "30-60m",
            isSelected:
                selectedFilter == EnumVideoDurationFilter.between30And60,
            onTap: () {
              filterProvider.updateFilter(
                EnumVideoDurationFilter.between30And60,
              );
              ytVideoViewModel.getAllVideos(
                listPlayId: ref.read(currentPlayListIdNotifier),
              );
            },
          ),

          // "Above 60m" filter button
          FilterButton(
            title: "Above 60m",
            isSelected: selectedFilter == EnumVideoDurationFilter.above60,
            onTap: () {
              filterProvider.updateFilter(EnumVideoDurationFilter.above60);
              ytVideoViewModel.getAllVideos(
                listPlayId: ref.read(currentPlayListIdNotifier),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FilterButtonA extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButtonA({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isSelected ? Colors.blue : Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onTap,
        child: Text(title),
      ),
    );
  }
}
