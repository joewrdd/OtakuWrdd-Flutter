import 'package:OtakuWrdd/common/styles/spacing_style.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.third,
      body: SingleChildScrollView(
        child: Padding(
          padding: CustomSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              // Image
              Image(
                image: AssetImage(image),
                width: HelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              // Title & SubTitle
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(color: ConstantColors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Text(
                subTitle,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.apply(color: ConstantColors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwSections),
              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      ConstantColors.secondary,
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
