import 'package:OtakuWrdd/ui/auth/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  final currentPageIndex = 0.obs;
  final isLastPage = false.obs;
  final isAnimating = false.obs;
  final rotationAngle = 0.0.obs;
  final scale = 1.0.obs;

  void updatePageIndicator(int index) {
    currentPageIndex.value = index;
    isLastPage.value = index == 2;
  }

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  Future<void> nextPage() async {
    if (isAnimating.value) return;

    isAnimating.value = true;

    // Initial throw effect (slight scale up)
    for (double i = 1.0; i <= 1.2; i += 0.1) {
      scale.value = i;
      await Future.delayed(const Duration(milliseconds: 20));
    }

    // Fast spinning with dynamic speed
    for (int i = 0; i < 720; i += 15) {
      // Two full rotations
      rotationAngle.value = i.toDouble();
      // Speed up in the middle, slow down at the end
      int delay = i < 360 ? 5 : 8; // Faster first rotation
      await Future.delayed(Duration(milliseconds: delay));
    }

    // Reset rotation and scale with bounce effect
    scale.value = 0.8;
    await Future.delayed(const Duration(milliseconds: 50));
    scale.value = 1.0;
    rotationAngle.value = 0.0;

    if (isLastPage.value) {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(LoginScreen());
    } else {
      int page = pageController.page?.toInt() ?? 0;
      await pageController.animateToPage(
        page + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }

    isAnimating.value = false;
  }

  void skipPage() {
    if (isAnimating.value) return;
    pageController.jumpToPage(2);
    currentPageIndex.value = 2;
    isLastPage.value = true;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
