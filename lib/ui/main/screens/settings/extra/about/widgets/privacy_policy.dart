import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Privacy Policy',
                  style: GoogleFonts.notoSans(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ConstantColors.sixth,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close, color: ConstantColors.sixth),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Last updated: February 8, 2025",
              style: GoogleFonts.notoSans(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: ConstantColors.sixth.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 20),

            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Overview"),
                    _buildParagraph(
                      "OtakuWrdd and its developers take your privacy seriously. We do not sell, rent, or profit from your data. Any information collected is anonymous and used solely to improve the app.",
                    ),

                    _buildSectionTitle(
                      "Information between OtakuWrdd and MyAnimeList",
                    ),
                    _buildParagraph(
                      "When you use OtakuWrdd, it requires permission to access your MyAnimeList account to perform actions like adding anime to your list. OtakuWrdd only synchronizes series you have updated on your device. By using OtakuWrdd, you are subject to MyAnimeList's privacy policy.",
                    ),

                    _buildSectionTitle("Guest Mode"),
                    _buildParagraph(
                      "OtakuWrdd includes a 'guest' mode that still requests information from MyAnimeList to display content. No user-related account information is stored until you grant permission.",
                    ),

                    _buildSectionTitle("Analytics"),
                    _buildParagraph(
                      "OtakuWrdd uses privacy-centric analytics to collect anonymous usage data. This information helps prioritize features and improvements. The data cannot be traced back to individual users.",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(double.infinity, 45),
              ),
              child: Text(
                "I Understand",
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  color: ConstantColors.sixth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(
        title,
        style: GoogleFonts.notoSans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ConstantColors.sixth,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: GoogleFonts.notoSans(
          fontSize: 14,
          color: ConstantColors.sixth.withOpacity(0.9),
          height: 1.4,
        ),
      ),
    );
  }
}
