import 'dart:ui';
import 'package:OtakuWrdd/data/repos/authentication/auth.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/account/account.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/appearance/appearance.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/face_id/face_id.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/notifications/notifications.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/widgets/settings_menu_tile.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/tip_jar/tip_jar.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/about/about.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/whats_new/whats_new.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverScrollController = Get.put(DiscoverScrollController());
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
              'Settings',
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
        flexibleSpace: Obx(
          () => ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10 * discoverScrollController.opacity.value,
                sigmaY: 10 * discoverScrollController.opacity.value,
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.black.withOpacity(
                  0.2 * discoverScrollController.opacity.value,
                ),
              ),
            ),
          ),
        ),
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
            controller: discoverScrollController.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: ConstantSizes.spaceBtwSections * 4,
                  ),
                  child: Column(
                    children: [
                      //----- MAIN SUBSCRIPTION -----
                      SettingsMenuTile(
                        text: 'Unlock OtakuWrdd Ku+',
                        subText: 'プロの機能 GetNow!',
                        image: ConstantImages.starIcon,
                        onTap: () {},
                        navigationButton: true,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      //----- USER RELATED SETTINGS -----
                      SettingsMenuTile(
                        text: 'Account',
                        image: ConstantImages.accountIcon,
                        onTap: () => Get.to(() => const AccountScreen()),
                        navigationButton: true,
                      ),
                      SettingsMenuTile(
                        text: 'App Icon',
                        subText: 'Kirito',
                        image: ConstantImages.mainLogo,
                        onTap: () {},
                        navigationButton: true,
                      ),
                      SettingsMenuTile(
                        text: 'Appearance',
                        image: ConstantImages.appearanceIcon,
                        onTap: () => Get.to(() => const AppearanceScreen()),
                        navigationButton: true,
                      ),
                      SettingsMenuTile(
                        text: 'Face ID / Passcode',
                        image: ConstantImages.faceIdIcon,
                        onTap: () => Get.to(() => const FaceIdPasscodeScreen()),
                        navigationButton: true,
                      ),
                      SettingsMenuTile(
                        text: 'Notifications',
                        image: ConstantImages.notificationIcon,
                        onTap: () => Get.to(() => const NotificationsScreen()),
                        navigationButton: true,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      //----- APP SETTINGS -----
                      SettingsMenuTile(
                        text: 'What\'s New in v1.0.0',
                        image: ConstantImages.whatsNewIcon,
                        onTap: () => WhatsNewDialog.show(context),
                        navigationButton: false,
                      ),
                      SettingsMenuTile(
                        text: 'Rate OtakuWrdd',
                        image: ConstantImages.rateIcon,
                        onTap:
                            () => _launchUrl(
                              'https://github.com/joewrdd/OtakuWrdd-Flutter',
                            ),
                        navigationButton: false,
                      ),
                      SettingsMenuTile(
                        text: 'About',
                        image: ConstantImages.aboutIcon,
                        onTap: () => Get.to(() => const AboutScreen()),
                        navigationButton: true,
                      ),
                      SettingsMenuTile(
                        text: 'Mana Jar',
                        image: ConstantImages.manaJarIcon,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const TipJarDialog(),
                          );
                        },
                        navigationButton: false,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      //----- LOG OUT -----
                      SettingsMenuTile(
                        text: 'Log Out',
                        image: ConstantImages.logOutIcon,
                        onTap: () => AuthenticationRepository.instance.logout(),
                        navigationButton: false,
                      ),
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
        'Could Not Launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
