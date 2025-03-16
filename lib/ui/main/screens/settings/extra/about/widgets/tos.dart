import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsOfUseDialog extends StatelessWidget {
  const TermsOfUseDialog({super.key});

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
                  'Terms of Use',
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
              "Last updated: July 6, 2025",
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
                    _buildParagraph(
                      "Please read these terms and conditions carefully before using our Service.",
                    ),

                    _buildSectionTitle("Acceptance of Terms"),
                    _buildParagraph(
                      "By accessing or using OtakuWrdd, you agree to be bound by these Terms. If you disagree with any part, you may not access the Service. You must be over 18 years old to use this Service.",
                    ),

                    _buildSectionTitle("Intellectual Property"),
                    _buildParagraph(
                      "The Service and its original content, features, and functionality are the exclusive property of the developer and are protected by copyright and other laws.",
                    ),

                    _buildSectionTitle("Third-Party Links"),
                    _buildParagraph(
                      "Our Service may contain links to third-party websites or services not owned or controlled by us. We assume no responsibility for the content or practices of any third-party websites.",
                    ),

                    _buildSectionTitle("Termination"),
                    _buildParagraph(
                      "We may terminate or suspend your access immediately, without prior notice, for any reason including if you breach these Terms.",
                    ),

                    _buildSectionTitle("Limitation of Liability"),
                    _buildParagraph(
                      "To the maximum extent permitted by law, we shall not be liable for any indirect, incidental, special, or consequential damages arising out of the use or inability to use our Service.",
                    ),

                    _buildSectionTitle("\"AS IS\" Disclaimer"),
                    _buildParagraph(
                      "The Service is provided \"AS IS\" and \"AS AVAILABLE\" without warranties of any kind, either express or implied.",
                    ),

                    _buildSectionTitle("Changes to Terms"),
                    _buildParagraph(
                      "We reserve the right to modify these Terms at any time. Continued use of the Service after changes constitutes acceptance of the new Terms.",
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
                "I Accept",
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
