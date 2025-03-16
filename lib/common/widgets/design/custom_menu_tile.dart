import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomMenuTile extends StatelessWidget {
  const CustomMenuTile({
    super.key,
    required this.text,
    this.subText,
    this.checkButton = false,
    this.isIcon = false,
    this.iconColor,
    this.icon,
    this.onTap,
  });

  final String text;
  final String? subText;
  final bool checkButton;
  final bool isIcon;
  final Color? iconColor;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                if (isIcon)
                  Icon(icon, color: iconColor, size: 30)
                else
                  Text(
                    subText ?? '',
                    style: GoogleFonts.notoSans(
                      fontSize: 11,
                      color: ConstantColors.sixth,
                    ),
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
