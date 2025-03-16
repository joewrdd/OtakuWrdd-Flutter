import 'package:OtakuWrdd/ui/auth/controllers/forget_password/forget_password_controller.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      backgroundColor: ConstantColors.secondary,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ConstantSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Headings
              Text(
                'Forget Password',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwItems),
              Text(
                'Baka, Did You Just Forget Your Password? No Worries, We Got You Covered',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: ConstantSizes.spaceBtwSections * 2),
              // Text Field
              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  validator: Validator.validateEmail,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Iconsax.direct_right),
                    prefixIconColor: ConstantColors.black,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColors.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColors.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: ConstantSizes.spaceBtwSections),
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.sendPasswordResetEmail(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ConstantColors.third,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: ConstantColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
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
