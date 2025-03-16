import 'package:OtakuWrdd/common/widgets/appbar/alt_appbar.dart';
import 'package:OtakuWrdd/common/widgets/design/custom_menu_tile.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/discovery_headers.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/extra/notifications/widgets/notifications_menu_tile.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverScrollController = Get.put(
      DiscoverScrollController(),
      tag: 'appearanceController',
    );
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AltAppBar(
        title: 'Appearance',
        controller: discoverScrollController,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DiscoveryHeaders(text: 'APPEARANCE'),
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                      CustomMenuTile(
                        text: 'Appearance',
                        subText: 'Red Velvet',
                        onTap: () {},
                      ),
                      NotificationsMenuTile(
                        text: 'Increase Contrast',
                        onTap: () {},
                        checkButton: true,
                      ),
                      NotificationsMenuTile(
                        text: 'Enable Continuos Scrolling',
                        onTap: () {},
                        checkButton: true,
                      ),
                      NotificationsMenuTile(
                        text: 'Dislay "Ask Joel" on Lists',
                        onTap: () {},
                        checkButton: true,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DiscoveryHeaders(text: 'DISPLAY'),
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                      CustomMenuTile(
                        text: 'Rating Format',
                        subText: '10 Point (5/10)',
                        onTap: () {},
                      ),
                      CustomMenuTile(
                        text: 'Title Language',
                        subText: 'English (Solo Leveling)',
                        onTap: () {},
                      ),
                      CustomMenuTile(
                        text: 'Staff / Character Language',
                        subText: 'Romaji (Ken Kaneki)',
                        onTap: () {},
                      ),
                      CustomMenuTile(
                        text: 'List Layout',
                        subText: 'Standard',
                        onTap: () {},
                      ),
                      NotificationsMenuTile(
                        text: 'Display Currently Airing First',
                        onTap: () {},
                        checkButton: true,
                      ),
                      CustomMenuTile(
                        text: 'Default Language Page',
                        subText: 'Discover',
                        onTap: () {},
                      ),
                      NotificationsMenuTile(
                        text: 'Remember Last Viewed Anime List',
                        onTap: () {},
                        checkButton: false,
                      ),
                      NotificationsMenuTile(
                        text: 'Remember Last Viewed Manga List',
                        onTap: () {},
                        checkButton: false,
                      ),
                      NotificationsMenuTile(
                        text: 'Remember Last Viewed Feed',
                        onTap: () {},
                        checkButton: false,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DiscoveryHeaders(text: 'NOTES VISIBILITY'),
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                      CustomMenuTile(
                        text: 'Display Notes On Lists',
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                        onTap: () {},
                        checkButton: true,
                      ),
                      CustomMenuTile(
                        text: 'Display Notes On Details Page',
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                        onTap: () {},
                        checkButton: true,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DiscoveryHeaders(text: 'VISIBLE SECTIONS'),
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                      NotificationsMenuTile(
                        text: 'Watching / Reading',
                        onTap: () {},
                        checkButton: true,
                      ),
                      NotificationsMenuTile(
                        text: 'Rewatching / Rereading',
                        onTap: () {},
                        checkButton: false,
                      ),
                      NotificationsMenuTile(
                        text: 'Completed',
                        onTap: () {},
                        checkButton: true,
                      ),
                      NotificationsMenuTile(
                        text: 'Dropped',
                        onTap: () {},
                        checkButton: false,
                      ),
                      NotificationsMenuTile(
                        text: 'On Hold',
                        onTap: () {},
                        checkButton: false,
                      ),
                      NotificationsMenuTile(
                        text: 'Plan To Watch / Read',
                        onTap: () {},
                        checkButton: false,
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
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
