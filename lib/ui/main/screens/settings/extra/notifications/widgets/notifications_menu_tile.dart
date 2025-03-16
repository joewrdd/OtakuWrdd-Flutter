import 'package:OtakuWrdd/ui/main/controllers/notifications_menu_tile_controller.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsMenuTile extends StatelessWidget {
  const NotificationsMenuTile({
    super.key,
    required this.text,
    this.checkButton = false,
    this.isIcon = false,
    this.icon,
    this.onTap,
  });

  final String text;
  final bool checkButton;
  final bool isIcon;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsMenuTileController(), tag: text);
    controller.isChecked.value = checkButton;
    return InkWell(
      onTap: () {
        controller.isChecked.toggle();
        if (onTap != null) onTap!();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: ConstantColors.sixth,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                const Spacer(),
                Obx(
                  () =>
                      controller.isChecked.value
                          ? Icon(
                            Icons.check,
                            color: ConstantColors.sixth,
                            size: 30,
                          )
                          : const SizedBox(width: 30, height: 30),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 7),
            Divider(
              color: ConstantColors.sixth.withOpacity(0.2),
              height: 0.1,
              indent: 15,
              endIndent: 8,
            ),
          ],
        ),
      ),
    );
  }
}
