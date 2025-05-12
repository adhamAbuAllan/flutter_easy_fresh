import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/const/localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/video_duration_filter.dart';
import '../../contoller/providers/color_provider.dart';
import '../../contoller/providers/video_provider.dart';
import '../../contoller/providers/widgets_porvider.dart';

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
        child:
            child ??
            Text(
              SetLocalization.of(context)!.getTranslateValue(title),
              style: TextStyle(color: isSelected ? Colors.white : null),
            ),
      ),
    );
  }
}

class VideoFilterBarWidgetA extends ConsumerWidget {
  const VideoFilterBarWidgetA({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showUnder30 = ref.watch(didHaveUnder30Min);
    final bool showBetween30And60 = ref.watch(didHaveBetween30And60Min);
    final bool showAbove60 = ref.watch(didHaveOver60Min);

    // Access providers using ref.watch
    final filterProvider = ref.watch(videoFilterProvider.notifier);
    final selectedFilter = ref.watch(videoFilterProvider);
    final videoViewModel = ref.watch(videoNotifierProvider.notifier);

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
              debugPrint("onTap");
              ref.read(isBoxVisibleNotifier.notifier).state =
                  !ref.read(isBoxVisibleNotifier);
              debugPrint("isBoxVisable : ${ref.read(isBoxVisibleNotifier)}");
              //open drawer

              Scaffold.of(context).openDrawer();

              // Fetch all videos
            },
            child: Icon(Icons.filter_list),
          ),
          FilterButton(
            title: "all_videos",
            isSelected: selectedFilter == EnumVideoDurationFilter.allVideos,
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                filterProvider.updateFilter(
                  EnumVideoDurationFilter.allVideos,
                );
                await videoViewModel.getAllVideos(context:context,
                  listPlayId: ref.watch(currentPlayListIdNotifier),
                );
              });

              // Fetch all videos
            },
          ),
          // "Under 30m" filter button
          if (showUnder30)
            FilterButton(
            title: "under_30_m",
            isSelected: selectedFilter == EnumVideoDurationFilter.under30,
            onTap: () {
              filterProvider.updateFilter(EnumVideoDurationFilter.under30);
                videoViewModel.getAllVideos(context:context,





                  listPlayId: ref.watch(currentPlayListIdNotifier),
                );
              }
              //
              // Fetch and filter videos
          ),
          //
          // "30-60m" filter button
          if (showBetween30And60)
            FilterButton(
            title: "30_60_m",
            isSelected:
                selectedFilter == EnumVideoDurationFilter.between30And60,
            onTap: () {
              filterProvider.updateFilter(
                EnumVideoDurationFilter.between30And60,
              );
              Future.microtask(() {
                videoViewModel.getAllVideos(context:context,





                  listPlayId: ref.watch(currentPlayListIdNotifier),
                );
              });
            },
          ),

          // "Above 60m" filter button
          if (showAbove60)
            FilterButton(
            title: "above_60_m",
            isSelected: selectedFilter == EnumVideoDurationFilter.above60,
            onTap: () {
              filterProvider.updateFilter(EnumVideoDurationFilter.above60);
              Future.microtask(() {
                videoViewModel.getAllVideos(context:context,





                  listPlayId: ref.watch(currentPlayListIdNotifier),
                );
              });
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
