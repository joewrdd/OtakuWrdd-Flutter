import 'dart:async';
import 'package:OtakuWrdd/common/widgets/success/success.dart';
import 'package:OtakuWrdd/data/repos/authentication/auth.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(
        title: 'Email Sent!',
        message: "Check Your Inbox To Verify.",
      );
    } catch (e) {
      Loaders.errorSnackBar(title: 'Ite-te-te!', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            image: ConstantImages.successAccountGif,
            title: "Your Account Was Successfully Created! ",
            subTitle:
                "Welcome To The World Of OtakuWrdd, The Journey To Discovering New Worlds Starts With A Single Episode. Let's Dive And Make Every Moment Legendary.",
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        ); // Off Destroys The Previous Screen So I Dont Go Back To It
      }
    });
  }

  // Manually Check If Email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: ConstantImages.successfullyRegisterAnimation,
          title: "Your Account Was Successfully Created! ",
          subTitle:
              "Welcome To The World Of OtakuWrdd, The Journey To Discovering New Worlds Starts With A Single Episode. Let's Dive And Make Every Moment Legendary.",
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
