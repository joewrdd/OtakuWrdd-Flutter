import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/ui/main/controllers/anime_list_controller.dart';
import 'package:get/get.dart';

void showSortingOptions(BuildContext context) {
  final controller = Get.find<AnimeListController>();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.grey[900],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Sort List By:',
                style: GoogleFonts.lato(
                  color: ConstantColors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(color: Colors.grey, height: 1),
            Obx(
              () => ListTile(
                leading:
                    controller.currentSortMethod.value ==
                            SortMethod.alphabetical
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                title: Text(
                  'Alphabetical (A-Z)',
                  style: GoogleFonts.lato(color: ConstantColors.white),
                ),
                onTap: () {
                  controller.sortAnimeList(SortMethod.alphabetical);
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(color: Colors.grey, height: 1),
            Obx(
              () => ListTile(
                leading:
                    controller.currentSortMethod.value ==
                            SortMethod.ratingHighest
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                title: Text(
                  'Rating (Highest)',
                  style: GoogleFonts.lato(color: ConstantColors.white),
                ),
                onTap: () {
                  controller.sortAnimeList(SortMethod.ratingHighest);
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(color: Colors.grey, height: 1),
            Obx(
              () => ListTile(
                leading:
                    controller.currentSortMethod.value ==
                            SortMethod.ratingLowest
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                title: Text(
                  'Rating (Lowest)',
                  style: GoogleFonts.lato(color: ConstantColors.white),
                ),
                onTap: () {
                  controller.sortAnimeList(SortMethod.ratingLowest);
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(color: Colors.grey, height: 1),
            Obx(
              () => ListTile(
                leading:
                    controller.currentSortMethod.value == SortMethod.lastUpdated
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                title: Text(
                  'Last Updated',
                  style: GoogleFonts.lato(color: ConstantColors.white),
                ),
                onTap: () {
                  controller.sortAnimeList(SortMethod.lastUpdated);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
