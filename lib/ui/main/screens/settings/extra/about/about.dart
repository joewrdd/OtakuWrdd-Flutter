import 'dart:ui';

import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/about/widgets/about_otaku.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/widgets/settings_menu_tile.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'widgets/privacy_policy.dart';
import 'widgets/tos.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      DiscoverScrollController(),
      tag: 'aboutController',
    );
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 15,
        toolbarHeight: 80,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Iconsax.arrow_left_2, color: ConstantColors.white),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'About',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSans(
                color: ConstantColors.sixth,
                fontSize: 15.3,
              ),
            ),
            const SizedBox(height: ConstantSizes.spaceBtwItems * 2),
          ],
        ),
        flexibleSpace: Obx(() {
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10 * controller.opacity.value,
                sigmaY: 10 * controller.opacity.value,
              ),
              child: Container(
                width: double.infinity,
                height: 115,
                color: Colors.black.withOpacity(0.2 * controller.opacity.value),
              ),
            ),
          );
        }),
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            ConstantImages.mainBackground,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: ConstantSizes.spaceBtwSections * 4,
                  ),
                  child: Column(
                    children: [
                      // App Icon and Version
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(ConstantImages.mainLogo),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'OtakuWrdd 1.0.0',
                              style: GoogleFonts.notoSans(
                                color: ConstantColors.sixth,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '"Ken" (531f79e92)',
                              style: GoogleFonts.notoSans(
                                color: ConstantColors.sixth.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Created With ',
                                    style: GoogleFonts.notoSans(
                                      color: ConstantColors.sixth,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const WidgetSpan(
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.lightBlue,
                                      size: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' By Wrdd Dev',
                                    style: GoogleFonts.notoSans(
                                      color: ConstantColors.sixth,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // About Sectio
                      SettingsMenuTile(
                        text: 'About OtakuWrdd',
                        image: ConstantImages.aboutOtakuIcon,
                        onTap: () => Get.to(() => const AboutOtaku()),
                        navigationButton: true,
                      ),

                      SettingsMenuTile(
                        text: 'Rate OtakuWrdd',
                        image: ConstantImages.rateIcon,
                        onTap:
                            () => _launchUrl(
                              'https://github.com/joewrdd/OtakuWrdd-Flutter',
                            ),
                        navigationButton: true,
                      ),

                      SettingsMenuTile(
                        text: 'Special Thanks',
                        image: ConstantImages.specialThanksIcon,
                        onTap: () {},
                        navigationButton: true,
                      ),

                      SettingsMenuTile(
                        text: 'Report a Bug',
                        image: ConstantImages.reportIcon,
                        onTap:
                            () => _launchUrl(
                              'https://github.com/joewrdd/OtakuWrdd-Flutter',
                            ),
                        navigationButton: true,
                      ),

                      SettingsMenuTile(
                        text: 'Submit a Feature Request',
                        image: ConstantImages.feedbackIcon,
                        onTap:
                            () => _launchUrl(
                              'https://wa.me/76000623?text=Feature%20Request%3A%0A%0ADescription%3A%20%0A%0APriority%3A%20%0A%0AAdditional%20Details%3A%20',
                            ),
                        navigationButton: true,
                      ),
                      SettingsMenuTile(
                        text: 'Privacy Policy',
                        image: ConstantImages.privacyPolicyIcon,
                        onTap: () => Get.dialog(const PrivacyPolicyDialog()),
                        navigationButton: true,
                      ),
                      SettingsMenuTile(
                        text: 'Terms of Use',
                        image: ConstantImages.termsOfServiceIcon,
                        onTap: () => Get.dialog(const TermsOfUseDialog()),
                        navigationButton: true,
                      ),
                      SettingsMenuTile(
                        text: 'Contact',
                        image: ConstantImages.aboutIcon,
                        onTap:
                            () => _launchUrl(
                              'https://wa.me/76000623?text=Hello%2C%0A%0AI%20am%20contacting%20you%20regarding%20OtakuWrdd.%0A%0ASubject%3A%20%0A%0ADetails%3A%20',
                            ),
                        navigationButton: true,
                      ),
                      const SizedBox(height: 20),

                      // Social Media Section
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'SOCIAL MEDIA',
                            style: GoogleFonts.notoSans(
                              color: ConstantColors.sixth.withOpacity(0.7),
                              fontSize: 12,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SettingsMenuTile(
                        text: 'Reddit',
                        image: ConstantImages.redditIcon2,
                        onTap: () => _launchUrl('https://reddit.com/r/joewrdd'),
                      ),
                      SettingsMenuTile(
                        text: 'Discord',
                        image: ConstantImages.discordIcon,
                        onTap: () => _launchUrl('https://discord.gg/joewrdd'),
                      ),
                      SettingsMenuTile(
                        text: '@joewrdd',
                        image: ConstantImages.twitterIcon,
                        onTap: () => _launchUrl('https://twitter.com/joewrdd'),
                      ),
                      SettingsMenuTile(
                        text: 'joewrdd',
                        image: ConstantImages.githubIcon,
                        onTap: () => _launchUrl('https://github.com/joewrdd'),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      await launchUrlString(url);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
