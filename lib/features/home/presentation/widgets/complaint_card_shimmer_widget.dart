import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class ComplaintsShimmerList extends StatelessWidget {
  const ComplaintsShimmerList({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(height: SizeConfig.height * .005),
        itemBuilder: (context, index) {
          return const ComplaintCardShimmer();
        },
      ),
    );
  }
}

class ComplaintCardShimmer extends StatelessWidget {
  const ComplaintCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ShimmerBox(height: 14, width: SizeConfig.width * 0.35),
                  _ShimmerBox(
                    height: 22,
                    width: SizeConfig.width * 0.18,
                    borderRadius: 6,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(height: 12, width: SizeConfig.width * 0.2),
                        const SizedBox(height: 6),
                        _ShimmerBox(height: 14, width: SizeConfig.width * 0.25),
                      ],
                    ),
                  ),
                  SizedBox(width: SizeConfig.width * 0.04),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(height: 12, width: SizeConfig.width * 0.25),
                        const SizedBox(height: 6),
                        _ShimmerBox(height: 14, width: double.infinity),
                        const SizedBox(height: 4),
                        _ShimmerBox(height: 14, width: SizeConfig.width * 0.6),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 4,
  });

  final double height;
  final double width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300, 
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

// class ComplaintsShimmerList extends StatelessWidget {
//   const ComplaintsShimmerList({super.key, this.itemCount = 6});

//   final int itemCount;

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: itemCount,
//         separatorBuilder: (_, _) =>
//             SizedBox(height: SizeConfig.height * .005),
//         itemBuilder: (context, index) {
//           return const ComplaintCardShimmer();
//         },
//       ),
//     );
//   }
// }


// class ComplaintCardShimmer extends StatelessWidget {
//   const ComplaintCardShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColor.white,
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(color: AppColor.grey),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           children: [
//             // السطر العلوي (العنوان + حالة الشكوى)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _ShimmerBox(height: 14, width: SizeConfig.width * 0.35),
//                 _ShimmerBox(
//                   height: 22,
//                   width: SizeConfig.width * 0.18,
//                   borderRadius: 6,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             const Divider(),
//             const SizedBox(height: 8),

//             // السطر الثاني (رقم الشكوى + الوصف)
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _ShimmerBox(height: 12, width: SizeConfig.width * 0.2),
//                       const SizedBox(height: 6),
//                       _ShimmerBox(height: 14, width: SizeConfig.width * 0.25),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: SizeConfig.width * 0.04),
//                 Expanded(
//                   flex: 2,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _ShimmerBox(height: 12, width: SizeConfig.width * 0.25),
//                       const SizedBox(height: 6),
//                       _ShimmerBox(height: 14, width: double.infinity),
//                       const SizedBox(height: 4),
//                       _ShimmerBox(height: 14, width: SizeConfig.width * 0.6),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ShimmerBox extends StatelessWidget {
//   const _ShimmerBox({
//     super.key,
//     required this.height,
//     required this.width,
//     this.borderRadius = 4,
//   });

//   final double height;
//   final double width;
//   final double borderRadius;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       decoration: BoxDecoration(
//         color: AppColor.middleGrey.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(borderRadius),
//       ),
//     );
//   }
// }
