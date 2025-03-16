import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class TBoxesShimmer extends StatelessWidget {
  const TBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: TShimmerEffect(width: 150, height: 110)),
            SizedBox(width: ConstantSizes.spaceBtwItems),
            Expanded(child: TShimmerEffect(width: 150, height: 110)),
            SizedBox(width: ConstantSizes.spaceBtwItems),
            Expanded(child: TShimmerEffect(width: 150, height: 110)),
          ],
        ),
      ],
    );
  }
}
