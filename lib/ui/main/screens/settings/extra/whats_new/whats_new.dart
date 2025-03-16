import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatsNewDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: const Color.fromARGB(255, 26, 26, 26),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bug Fixes!',
                    style: GoogleFonts.notoSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ConstantColors.sixth,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "No new major updates for this release, just some bug fixes and general improvements!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: ConstantColors.sixth,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    child: Text(
                      "Okay!",
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        color: ConstantColors.sixth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
