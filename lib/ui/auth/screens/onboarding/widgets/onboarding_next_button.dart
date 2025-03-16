import 'package:OtakuWrdd/ui/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/tools/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      right: ConstantSizes.defaultSpace,
      bottom: DeviceUtils.getBottomNavigationBarHeight(),
      child: Obx(
        () => Transform.rotate(
          angle: controller.rotationAngle.value * (3.14159 / 180),
          child: Transform.scale(
            scale: controller.scale.value,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ConstantColors.third.withOpacity(
                      controller.isAnimating.value ? 0.3 : 0.2,
                    ),
                    blurRadius: controller.isAnimating.value ? 15 : 10,
                    spreadRadius: controller.isAnimating.value ? 2 : 1,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed:
                    controller.isAnimating.value ? null : controller.nextPage,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: ConstantColors.third,
                      width: 2,
                      style:
                          controller.isAnimating.value
                              ? BorderStyle.solid
                              : BorderStyle.solid,
                    ),
                  ),
                  backgroundColor: ConstantColors.secondary,
                  disabledBackgroundColor: ConstantColors.secondary,
                  padding: EdgeInsets.zero,
                  elevation: controller.isAnimating.value ? 8 : 4,
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: controller.isAnimating.value ? 0.9 : 1.0,
                  child: Image.asset(
                    ConstantImages.kunaiButton,
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
