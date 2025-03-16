import 'package:OtakuWrdd/ui/auth/controllers/login/login_controller.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ConstantColors.third),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              width: ConstantSizes.iconMd,
              height: ConstantSizes.iconMd,
              image: AssetImage(ConstantImages.google),
            ),
          ),
        ),
        const SizedBox(width: ConstantSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ConstantColors.third),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: ConstantSizes.iconMd,
              height: ConstantSizes.iconMd,
              image: AssetImage(ConstantImages.facebook),
            ),
          ),
        ),
        const SizedBox(width: ConstantSizes.spaceBtwItems),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ConstantColors.third),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: ConstantSizes.iconMd,
              height: ConstantSizes.iconMd,
              image: AssetImage(ConstantImages.github),
            ),
          ),
        ),
      ],
    );
  }
}
