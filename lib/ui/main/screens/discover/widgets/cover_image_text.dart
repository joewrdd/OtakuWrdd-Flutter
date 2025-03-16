import 'package:OtakuWrdd/common/widgets/design/rounded_image.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverImageText extends StatelessWidget {
  const CoverImageText({
    super.key,
    required this.text,
    required this.imageUrl,
    this.subtitle,
    this.onTap,
  });

  final String text;
  final String imageUrl;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: ConstantSizes.spaceBtwItems),
            CustomRoundedImage(
              imageUrl: imageUrl,
              isNetworkImage: true,
              height: 200,
              width: 140,
              fit: BoxFit.cover,
              backgroundColor: Colors.black12,
              onTap: onTap,
            ),
            const SizedBox(height: 1.9),
            SizedBox(
              width: 140,
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  color: ConstantColors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  height: 1.2,
                ),
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: GoogleFonts.lato(
                  color: ConstantColors.white.withOpacity(0.6),
                  fontSize: 10,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
