import 'package:OtakuWrdd/common/widgets/design/curved_edges.dart';
import 'package:OtakuWrdd/common/widgets/design/form_divider.dart';
import 'package:OtakuWrdd/common/widgets/mail/social_buttons.dart';
import 'package:OtakuWrdd/ui/auth/screens/signup/widgets/signup_form.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.secondary.withOpacity(0.9),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: ConstantSizes.defaultSpace - 24,
            right: ConstantSizes.defaultSpace - 24,
            bottom: ConstantSizes.defaultSpace,
          ),
          child: Column(
            children: [
              ClipPath(
                clipper: CustomCurvedEdges(),
                child: Container(
                  color: ConstantColors.third,
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -67,
                          left: -20,
                          child: Image.asset(
                            ConstantImages.loginBackground,
                            width: 600,
                            height: 600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: ConstantSizes.defaultSpace - 15,
                  right: ConstantSizes.borderRadiusSm,
                  bottom: ConstantSizes.appBarHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        ConstantImages.appIcon2,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    const SizedBox(height: ConstantSizes.spaceBtwSections),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hajimemashite!',
                          style: Theme.of(context).textTheme.headlineLarge!
                              .apply(color: ConstantColors.third),
                        ),
                        Text(
                          'Begin your anime adventure today.',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: ConstantColors.third,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: ConstantSizes.spaceBtwSections),
                    SignupForm(),
                    const SizedBox(height: ConstantSizes.spaceBtwSections),
                    FormDivider(dividerText: 'Or Sign up With'),
                    const SizedBox(height: ConstantSizes.spaceBtwSections),
                    SocialButtons(),
                    const SizedBox(height: ConstantSizes.spaceBtwSections),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(
                            color: ConstantColors.third.withOpacity(0.7),
                            fontFamily: GoogleFonts.dmSans().fontFamily,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Sign In',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: ConstantColors.black,
                              fontFamily: GoogleFonts.dmSans().fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
