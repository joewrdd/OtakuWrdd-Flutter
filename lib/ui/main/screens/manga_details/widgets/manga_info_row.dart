import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final double? labelWidth;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final EdgeInsets? padding;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = 100,
    this.labelStyle,
    this.valueStyle,
    this.padding = const EdgeInsets.only(bottom: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style:
                  labelStyle ??
                  GoogleFonts.lato(
                    color: ConstantColors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style:
                  valueStyle ??
                  GoogleFonts.lato(color: ConstantColors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
