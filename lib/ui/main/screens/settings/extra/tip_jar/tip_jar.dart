import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TipJarDialog extends StatelessWidget {
  const TipJarDialog({super.key});

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
                  'Tip Jar',
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
            const SizedBox(height: 20),

            // Description text
            Text(
              "If you're really loving OtakuWrdd, you can leave additional tips to help support future development! Every bit of support helps keep the features and bug fixes coming during my spare time!",
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: ConstantColors.sixth,
              ),
            ),

            const Divider(color: Colors.grey, height: 40),

            // Tip options
            _buildTipOption('Kawaii Tip', '\$0.99', ConstantImages.kawaiiTip),
            _buildTipOption('Sugoi Tip', '\$1.99', ConstantImages.sugoiTip),
            _buildTipOption(
              'Kakkoii! Tip',
              '\$4.99',
              ConstantImages.kakkoiiTip,
            ),
            _buildTipOption(
              'Subarashii~ Tip',
              '\$9.99',
              ConstantImages.subarashiiTip,
            ),
            _buildTipOption(
              'PLUS ULTRA! Tip',
              '\$14.99',
              ConstantImages.plusUltraTip,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipOption(String title, String price, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),

          Text(
            title,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: ConstantColors.sixth,
            ),
          ),

          const Spacer(),

          SizedBox(
            width: 99,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                price,
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  color: ConstantColors.sixth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
