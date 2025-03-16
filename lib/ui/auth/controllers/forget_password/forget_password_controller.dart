import 'package:OtakuWrdd/data/repos/authentication/auth.dart';
import 'package:OtakuWrdd/ui/auth/screens/password/reset_password.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/helpers/network_manager.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:OtakuWrdd/utils/loaders/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loader
      FullScreenLoader.openLoadingDialog(
        'Processing Your Request...',
        ConstantImages.signInLoader,
      );

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Authentication Call To Send Email Resest Pass
      await AuthenticationRepository.instance.forgetPasswordResetEmail(
        email.text.trim(),
      );

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Screen
      Loaders.successSnackBar(
        title: 'Email Sent.',
        message: 'Email Link Sent To Reset Your Password'.tr,
      );

      // ReDirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Ite-te-te!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Start Loader
      FullScreenLoader.openLoadingDialog(
        'Processing Your Request...',
        ConstantImages.signInLoader,
      );

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Authentication Call To Send Email Resest Pass
      await AuthenticationRepository.instance.forgetPasswordResetEmail(email);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Screen
      Loaders.successSnackBar(
        title: 'Email Sent.',
        message: 'Email Link Sent To Reset Your Password'.tr,
      );
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Ite-te-te!', message: e.toString());
    }
  }
}
