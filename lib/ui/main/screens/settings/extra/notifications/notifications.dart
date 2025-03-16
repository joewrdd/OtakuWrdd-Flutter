import 'dart:ui';

import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/discovery_headers.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/notifications/widgets/notifications_menu_tile.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverScrollController = DiscoverScrollController.instance;
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
              'Notifications',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NotificationsMenuTile(
                        text: 'Enable Airing Notifications',
                        onTap: () {},
                        checkButton: true,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DiscoveryHeaders(
                          text: 'NOTIFICATION LIST PREFERENCES',
                        ),
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                      NotificationsMenuTile(
                        text: 'Watching',
                        onTap: () {},
                        checkButton: true,
                      ),
                      NotificationsMenuTile(
                        text: 'Completed',
                        onTap: () {},
                        checkButton: true,
                      ),
                      NotificationsMenuTile(
                        text: 'Dropped',
                        onTap: () {},
                        checkButton: true,
                      ),
                      NotificationsMenuTile(
                        text: 'On Hold',
                        onTap: () {},
                        checkButton: true,
                      ),
                      NotificationsMenuTile(
                        text: 'Plan to Watch',
                        onTap: () {},
                        checkButton: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 4),
                        child: DiscoveryHeaders(
                          text:
                              'You will receive notifications for shows that are currently airing for each section that is enabled',
                        ),
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
}
