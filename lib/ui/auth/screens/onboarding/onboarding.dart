import 'package:OtakuWrdd/ui/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:OtakuWrdd/ui/auth/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:OtakuWrdd/ui/auth/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:OtakuWrdd/ui/auth/screens/onboarding/widgets/onboarding_page.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/tools/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ConstantColors.primary,
              ConstantColors.secondary,
              ConstantColors.third,
              ConstantColors.fourth,
              ConstantColors.fifth,
              ConstantColors.sixth,
            ],
          ),
        ),
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                OnBoardingPage(
                  image: ConstantImages.onBoarding1,
                  title: 'Welcome To The World Of OtakuWrdd',
                  subTitle: 'メリークリスマスキリト',
                ),
                OnBoardingPage(
                  image: ConstantImages.onBoarding2,
                  title:
                      '"Power Comes In Response To A Need, Not Desire." - Goku, DBZ',
                  subTitle: "権力は欲望ではなく必要性に応じて生まれます。",
                ),
                OnBoardingPage(
                  image: ConstantImages.onBoarding3,
                  title:
                      '"A Person Grows When They Do What Has To Be Done." - Gintoki, Gintama',
                  subTitle: '人はやるべきことをやることで成長します。',
                ),
              ],
            ),
            Positioned(
              bottom: DeviceUtils.getAppBarHeight(),
              left: ConstantSizes.defaultSpace - 25,
              child: Image.asset(
                color: ConstantColors.third.withOpacity(0.5),
                ConstantImages.japaneseFlower,
                width: 350,
                height: 350,
              ),
            ),
            OnBoardingDotNavigation(),
            OnBoardingNextButton(),
          ],
        ),
      ),
    );
  }
}
