import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoveryHeaders extends StatelessWidget {
  const DiscoveryHeaders({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(color: ConstantColors.sixth, fontSize: 11.8),
    );
  }
}
