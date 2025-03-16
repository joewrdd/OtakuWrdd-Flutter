import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/tools/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ConstantSizes.sm - 2),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading:
            showBackArrow
                ? IconButton(
                  onPressed: () {
                    try {
                      if (Get.isSnackbarOpen) {
                        Get.closeAllSnackbars();
                      }

                      Future.microtask(() {
                        Get.back();
                      });
                    } catch (e) {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(Iconsax.arrow_left_2, color: ConstantColors.white),
                )
                : leadingIcon != null
                ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(leadingIcon, color: ConstantColors.white),
                )
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
