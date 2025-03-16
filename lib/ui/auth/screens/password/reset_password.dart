import 'package:OtakuWrdd/ui/auth/controllers/forget_password/forget_password_controller.dart';
import 'package:OtakuWrdd/ui/auth/screens/login/login.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/helpers/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      backgroundColor: ConstantColors.secondary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(CupertinoIcons.clear, color: ConstantColors.third),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ConstantSizes.defaultSpace),
          child: Column(
            children: [
              Image.asset(
                ConstantImages.resetAnimationGif,
                width: HelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Text(
                'Password Reset Email Sent',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Text(
                'Your Account Security is Our Priority! We\'ve Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwSections),
              // Done Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ConstantColors.third,
                  ),
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text(
                    'Done',
                    style: TextStyle(color: ConstantColors.secondary),
                  ),
                ),
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              // Re-Send Email Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.resendPasswordResetEmail(email),
                  child: const Text(
                    'Resend Email',
                    style: TextStyle(color: ConstantColors.black),
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
