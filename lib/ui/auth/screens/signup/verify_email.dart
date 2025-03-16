import 'package:OtakuWrdd/data/repos/authentication/auth.dart';
import 'package:OtakuWrdd/ui/auth/controllers/signup/verify_email_controller.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/helpers/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      backgroundColor: ConstantColors.third,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ConstantSizes.defaultSpace - 10),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 250,
                    child: Image.asset(
                      ConstantImages.successEmailGif,
                      width: HelperFunctions.screenWidth() * 0.7,
                    ),
                  ),
                  Positioned(
                    top: 249,
                    left: ConstantSizes.defaultSpace - 100,
                    right: ConstantSizes.defaultSpace - 100,
                    child: Container(
                      height: 3,
                      color: ConstantColors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems * 3),
              Text(
                'Verify Your Email Address!',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(color: ConstantColors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Text(
                email ?? '',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.apply(color: ConstantColors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Text(
                'Omedetou Senpai! 🎉 Verify your email now to embark on your epic anime list adventure!',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.apply(color: ConstantColors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      ConstantColors.secondary,
                    ),
                  ),
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: const Text(
                    'Resend Email',
                    style: TextStyle(color: ConstantColors.secondary),
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
