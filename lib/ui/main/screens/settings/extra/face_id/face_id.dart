import 'dart:ui';

import 'package:OtakuWrdd/common/widgets/design/custom_menu_tile.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/discovery_headers.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class FaceIdPasscodeScreen extends StatelessWidget {
  const FaceIdPasscodeScreen({super.key});

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
              'Face ID/Passcode',
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
                      CustomMenuTile(
                        text: 'Lock With Face ID/Passcode',
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                        onTap: () {},
                        checkButton: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 4),
                        child: DiscoveryHeaders(
                          text:
                              'When enabled, OtakuWrdd will be locked whenever you close the app, and you will need to unlock it with your Face ID, Touch ID, or your device passcode when you reopen the app.',
                        ),
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwSections),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DiscoveryHeaders(text: 'AUTO LOCK TIMER'),
                      ),
                      const SizedBox(height: ConstantSizes.spaceBtwItems / 2),
                      CustomMenuTile(
                        text: 'Immediately',
                        onTap: () {},
                        checkButton: true,
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                      ),
                      CustomMenuTile(
                        text: '30 seconds',
                        onTap: () {},
                        checkButton: true,
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                      ),
                      CustomMenuTile(
                        text: '1 minute',
                        onTap: () {},
                        checkButton: true,
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                      ),
                      CustomMenuTile(
                        text: '2 minutes',
                        onTap: () {},
                        checkButton: true,
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                      ),
                      CustomMenuTile(
                        text: '5 minutes',
                        onTap: () {},
                        checkButton: true,
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                      ),
                      CustomMenuTile(
                        text: '10 minutes',
                        onTap: () {},
                        checkButton: true,
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                      ),
                      CustomMenuTile(
                        text: '30 minutes',
                        onTap: () {},
                        checkButton: true,
                        icon: Iconsax.lock_circle,
                        iconColor: Colors.amber,
                        isIcon: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 4),
                        child: DiscoveryHeaders(
                          text:
                              'OtakuWrdd will lock automatically after the selected time has passed.',
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
