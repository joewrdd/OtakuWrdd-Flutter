import 'package:OtakuWrdd/common/widgets/design/rounded_image.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({
    super.key,
    required this.text,
    this.subText,
    required this.image,
    this.navigationButton = true,
    this.isIcon = false,
    this.icon,
    this.onTap,
    this.backgroundColor = ConstantColors.transparent,
  });

  final String text;
  final String? subText;
  final String image;
  final bool navigationButton;
  final bool isIcon;
  final IconData? icon;
  final void Function()? onTap;
  final Color? backgroundColor;
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
                if (isIcon) const SizedBox(width: 15),
                CustomRoundedImage(
                  width: isIcon ? 31 : 62,
                  height: isIcon ? 30 : 30,
                  isSvg: false,
                  isIcon: isIcon,
                  backgroundColor: backgroundColor,
                  icon: icon,
                  imageUrl: image,
                  padding: const EdgeInsets.symmetric(
                    horizontal: ConstantSizes.spaceBtwItems,
                  ),
                ),
                if (isIcon) const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //          if (subText == null) const SizedBox(height: 15),
                    Text(
                      text,
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: ConstantColors.sixth,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      subText ?? '',
                      style: GoogleFonts.notoSans(
                        fontSize: 10,
                        color: ConstantColors.sixth.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 3),
                    navigationButton
                        ? Icon(
                          Iconsax.arrow_right_3,
                          color: ConstantColors.sixth,
                        )
                        : const SizedBox.shrink(),
                    const SizedBox(width: 16),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 7),
            Divider(
              color: ConstantColors.sixth.withOpacity(0.2),
              height: 0.1,
              indent: 63,
              endIndent: 0,
            ),
          ],
        ),
      ),
    );
  }
}
