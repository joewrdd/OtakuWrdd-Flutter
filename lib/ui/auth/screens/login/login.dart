import 'package:OtakuWrdd/common/widgets/design/curved_edges.dart';
import 'package:OtakuWrdd/common/widgets/design/form_divider.dart';
import 'package:OtakuWrdd/common/widgets/mail/social_buttons.dart';
import 'package:OtakuWrdd/ui/auth/screens/login/widgets/login_form.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    height: 450,
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
                    const SizedBox(width: ConstantSizes.sm),
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
                          'Okaeri, Senpai!',
                          style: Theme.of(context).textTheme.headlineLarge!
                              .apply(color: ConstantColors.third),
                        ),
                        Text(
                          'Your anime journey continues here.',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: ConstantColors.third,
                          ),
                        ),
                      ],
                    ),
                    LoginForm(),
                    FormDivider(dividerText: 'Or Continue With'),
                    const SizedBox(height: ConstantSizes.spaceBtwSections),
                    SocialButtons(),
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
