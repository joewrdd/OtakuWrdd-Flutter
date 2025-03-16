import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class VerticalCoverShimmer extends StatelessWidget {
  const VerticalCoverShimmer({
    super.key,
    this.itemCount = 4,
    this.scrollDirection = Axis.horizontal,
  });

  final int itemCount;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: scrollDirection,
        itemCount: itemCount,
        separatorBuilder:
            (context, index) =>
                const SizedBox(width: ConstantSizes.spaceBtwItems / 2),
        itemBuilder:
            (_, __) => Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: ConstantSizes.spaceBtwItems),
                      // Cover Image Shimmer
                      const TShimmerEffect(
                        width: 140,
                        height: 200,
                        radius: ConstantSizes.sm,
                        baseColor: Color(0x44666666),
                        highlightColor: Color(0x22666666),
                      ),
                      const SizedBox(height: 1.9),
                      const TShimmerEffect(
                        width: 139,
                        height: 14,
                        baseColor: Color(0x44666666),
                        highlightColor: Color(0x22666666),
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
