import 'package:OtakuWrdd/ui/auth/controllers/signup/signup_controller.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  expands: false,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(
                          ConstantImages.firstNameIcon,
                          color: ConstantColors.third,
                        ),
                      ),
                    ),
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'ex: "Kaneki"',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColors.third),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColors.primary),
                    ),
                  ),
                  validator:
                      (value) =>
                          Validator.validateEmptyText('First Name', value),
                ),
              ),
              const SizedBox(width: ConstantSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(
                          ConstantImages.lastNameIcon,
                          color: ConstantColors.third,
                        ),
                      ),
                    ),
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'ex: "Ken',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColors.third),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColors.primary),
                    ),
                  ),
                  validator:
                      (value) =>
                          Validator.validateEmptyText('Last Name', value),
                ),
              ),
            ],
          ),
          const SizedBox(height: ConstantSizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.username,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(
                    ConstantImages.userNameIcon,
                    color: ConstantColors.black,
                  ),
                ),
              ),
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'ex: "One-Eyed King"',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ConstantColors.third),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ConstantColors.primary),
              ),
            ),
            validator:
                (value) => Validator.validateEmptyText('Username', value),
          ),
          const SizedBox(height: ConstantSizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.email,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(
                    ConstantImages.email2Icon,
                    color: ConstantColors.black,
                  ),
                ),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'ex: "haisesasaki@gmail.com"',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ConstantColors.third),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ConstantColors.primary),
              ),
            ),
            validator: (value) => Validator.validateEmail(value),
          ),
          const SizedBox(height: ConstantSizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 27,
                    height: 27,
                    child: Image.asset(
                      ConstantImages.passwordIcon2,
                      color: ConstantColors.third,
                    ),
                  ),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'ex: "centipede@@7"',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors.third),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors.primary),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                    color: ConstantColors.black,
                  ),
                  onPressed:
                      () =>
                          controller.hidePassword.value =
                              !controller.hidePassword.value,
                ),
              ),
              validator: (value) => Validator.validatePassword(value),
            ),
          ),
          const SizedBox(height: ConstantSizes.spaceBtwInputFields),
          Row(
            children: [
              Obx(
                () => Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    value: controller.privacyPolicy.value,
                    onChanged:
                        (value) =>
                            controller.privacyPolicy.value =
                                !controller.privacyPolicy.value,
                    activeColor: ConstantColors.third,
                    shape: const CircleBorder(),
                    side: BorderSide(color: ConstantColors.third),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
              Text(
                'I agree to',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ConstantColors.black,
                  fontFamily: GoogleFonts.dmSans().fontFamily,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Privacy Policy',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ConstantColors.third,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                '&',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ConstantColors.black,
                  fontFamily: GoogleFonts.dmSans().fontFamily,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms of Use',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ConstantColors.third,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: ConstantSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstantColors.third,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ConstantSizes.inputFieldRadius,
                  ),
                ),
              ),
              onPressed: () => controller.signup(),
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: ConstantColors.secondary,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                      color: ConstantColors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
