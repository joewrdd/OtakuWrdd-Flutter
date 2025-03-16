import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String? subtitle;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final TextStyle? subtitleStyle;

  const StatItem({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
    this.labelStyle,
    this.valueStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style:
              labelStyle ??
              GoogleFonts.lato(
                color: ConstantColors.white.withOpacity(0.6),
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style:
              valueStyle ??
              GoogleFonts.lato(
                color: ConstantColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            style:
                subtitleStyle ??
                GoogleFonts.lato(
                  color: ConstantColors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
          ),
        ],
      ],
    );
  }
}
