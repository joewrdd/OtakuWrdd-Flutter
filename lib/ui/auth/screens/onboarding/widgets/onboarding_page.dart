import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/helpers/helper.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.alignment = Alignment.center,
  });

  final String image, title, subTitle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Column(
        children: [
          SizedBox(
            width: HelperFunctions.screenWidth(),
            height: HelperFunctions.screenHeight() * 0.6,
            child: Transform.translate(
              offset:
                  image == ConstantImages.onBoarding1
                      ? const Offset(100, 0)
                      : Offset.zero,
              child:
                  (image.toLowerCase().endsWith('.svg')
                      ? SvgPicture.asset(image)
                      : Image.asset(image, fit: BoxFit.contain)),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: ConstantSizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
