import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/view/widgets/skeleton_filter_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';



import '../../contoller/providers/color_provider.dart';


class SkeletonHomeUi extends ConsumerStatefulWidget {
  const SkeletonHomeUi({super.key,this.hasCitiesBar, this.scrollController});
  final bool? hasCitiesBar;
  final ScrollController? scrollController;

  @override
  ConsumerState createState() => _HomeSkeletonWidgetState();
}

class _HomeSkeletonWidgetState extends ConsumerState<SkeletonHomeUi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(


        backgroundColor:ref.read(themeModeNotifier.notifier)
            .backgroundAppTheme(ref: ref),
        body: SingleChildScrollView(
          controller: widget.scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              widget.hasCitiesBar ?? false
                  ? const Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  //cities skeleton
                  SkeletonFilterWidget(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
                  : const SizedBox(),

              const SkeletonVideoCardA(),
              const SkeletonVideoCardA(),
              const SkeletonVideoCardA(),
              const SkeletonVideoCardA(),
              const SkeletonVideoCardA(),
              const SkeletonVideoCardA(),
              const SkeletonVideoCardA(),
              const SkeletonVideoCardA(),
              const SkeletonVideoCardA(),
              const SkeletonVideoCardA(),
            ],
          ),
        ),
      ),
    );
  }
}



// class SkeletonVideoCard extends StatelessWidget {
//   const SkeletonVideoCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Container(
//         padding: const EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(7),
//             color:
//             Color(0xf3333333)),
//         child: SkeletonItem(
//             child: Column(
//
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               spacing: 2,
//               children: [
//
//                 const SizedBox(height: 10),
//                 SkeletonAvatar(
//                   style: SkeletonAvatarStyle(
//                       width: double.infinity,
//                       height: 230,
//                       borderRadius: BorderRadius.circular(7)),
//                 ),
//                 const SizedBox(height: 10),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 SkeletonLine(
//
//                   style: SkeletonLineStyle(
//
//                       height: 18 / 1.3,
//                       width: 350,
//                       borderRadius: BorderRadius.circular(4)),
//                 ),
//                 const SizedBox(height: 10),
//                 SkeletonLine(
//                   style: SkeletonLineStyle(
//                       height: 18 / 1.3,
//                       width: 100,
//                       borderRadius: BorderRadius.circular(4)),
//                 ),
//
//                 const SizedBox(height: 10),
//                 Row(
//                   children: [
//                     SkeletonLine(
//                       style: SkeletonLineStyle(
//                           height: 18 / 1.3,
//                           width: 80,
//                           borderRadius: BorderRadius.circular(4)),
//                     ),
//                     Expanded(child: SizedBox()),
//                     SkeletonLine(
//                       style: SkeletonLineStyle(
//                           height: 18 / 1.3,
//                           width: 80,
//                           borderRadius: BorderRadius.circular(4)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10,)
//               ],
//             )),
//       ),
//     );  }
// }
//

class SkeletonVideoCardA extends ConsumerWidget {
  const SkeletonVideoCardA({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),
        ),
        child: SkeletonItem(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  height: 230,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              const SizedBox(height: 15),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 18 / 1.3,
                  width: 350,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 18 / 1.3,
                  width: 100,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 18 / 1.3,
                      width: 80,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 18 / 1.3,
                      width: 80,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

