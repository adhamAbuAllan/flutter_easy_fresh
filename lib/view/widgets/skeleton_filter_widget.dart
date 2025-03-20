import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';



class SkeletonFilterWidget extends ConsumerWidget {
  const SkeletonFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SkeletonItem(

          child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          SkeletonFilterButtonWidget(),
          SkeletonFilterButtonWidget(),
          SkeletonFilterButtonWidget(),
          SkeletonFilterButtonWidget(),
        ],
      )),
    );
  }
}

class SkeletonFilterButtonWidget extends ConsumerWidget {
  const SkeletonFilterButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
      child: SkeletonAvatar(

          style: SkeletonAvatarStyle(

              width:
                  90,
              height: 40)),
    );
  }
}
