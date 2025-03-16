import 'package:OtakuWrdd/ui/auth/controllers/login/login_controller.dart';
import 'package:OtakuWrdd/ui/auth/screens/password/forget_password.dart';
import 'package:OtakuWrdd/ui/auth/screens/signup/signup.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ConstantSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  ConstantImages.emailIcon,
                  color: ConstantColors.black,
                  width: 22,
                  height: 22,
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'ex: "kingofthepirates@gmail.com"',
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
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        ConstantImages.passwordIcon,
                        color: ConstantColors.third,
                      ),
                    ),
                  ),
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
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'ex: "ramen"',
                ),
                validator:
                    (value) => Validator.validateEmptyText('Password', value),
              ),
            ),
            const SizedBox(height: ConstantSizes.spaceBtwInputFields / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Transform.scale(
                        scale: 0.8,
                        child: Checkbox(
                          value: controller.rememberMe.value,
                          onChanged:
                              (value) =>
                                  controller.rememberMe.value =
                                      !controller.rememberMe.value,
                          activeColor: ConstantColors.third,
                          shape: const CircleBorder(),
                          side: BorderSide(color: ConstantColors.third),
                          fillColor: WidgetStateProperty.resolveWith<Color>((
                            Set<WidgetState> states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return ConstantColors.third;
                            }
                            return ConstantColors.third.withOpacity(0.5);
                          }),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ),
                    const SizedBox(width: 0),
                    Text(
                      'Remember Me',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: GoogleFonts.dmSans().fontFamily,
                        color: ConstantColors.black,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPasswordScreen()),
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontFamily: GoogleFonts.dmSans().fontFamily,
                      color: ConstantColors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: ConstantSizes.spaceBtwSections),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantColors.third,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      ConstantSizes.inputFieldRadius,
                    ),
                  ),
                ),
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: Text(
                  'Sign In',
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
            const SizedBox(height: ConstantSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ConstantSizes.inputFieldRadius,
                      ),
                    ),
                  ),
                  side: WidgetStateProperty.all(
                    BorderSide(color: ConstantColors.third),
                  ),
                ),
                onPressed: () => Get.to(() => SignUpScreen()),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    color: ConstantColors.third,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
