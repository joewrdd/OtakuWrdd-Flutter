import 'dart:ui';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AltAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AltAppBar({super.key, required this.title, this.controller});

  final String title;
  final DiscoverScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final discoverScrollController =
        controller ??
        Get.put(DiscoverScrollController(), tag: 'defaultAppBarController');
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 15,
      toolbarHeight: 80,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconsax.arrow_left_2, color: ConstantColors.white),
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSans(
                color: ConstantColors.sixth,
                fontSize: 15.3,
              ),
            ),
          ),
          const SizedBox(height: ConstantSizes.spaceBtwItems * 2),
        ],
      ),
      flexibleSpace: Obx(
        () => ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10 * discoverScrollController!.opacity.value,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
