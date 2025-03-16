import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';

class HorizontalEpisodeShimmer extends StatelessWidget {
  const HorizontalEpisodeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder:
            (_, __) => const SizedBox(width: ConstantSizes.spaceBtwItems),
        itemBuilder:
            (_, __) => Shimmer.fromColors(
              baseColor: Colors.grey[850]!.withOpacity(0.4),
              highlightColor: Colors.grey[700]!.withOpacity(0.4),
              child: Container(
                width: 275,
                height: 155,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
      ),
    );
  }
}
