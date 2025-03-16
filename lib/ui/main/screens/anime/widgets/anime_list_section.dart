import 'package:OtakuWrdd/ui/main/controllers/anime_list_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/anime/widgets/anime_list_item.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimeListSection extends StatelessWidget {
  final String title;
  final String sectionKey;
  final RxList<UserAnime> animeList;
  final RxBool isVisible;
  final int count;

  const AnimeListSection({
    super.key,
    required this.title,
    required this.sectionKey,
    required this.animeList,
    required this.isVisible,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeListController>();
    return Column(
      children: [
        // Section header with toggle
        GestureDetector(
          onTap: () => controller.toggleSectionVisibility(sectionKey),
          child: Container(
            color: Colors.grey[900]!.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    color: ConstantColors.white,
                    fontSize: 13,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '$count',
                      style: GoogleFonts.lato(
                        color: ConstantColors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => Icon(
                        isVisible.value
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                        color: ConstantColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Anime list items
        Obx(
          () =>
              isVisible.value
                  ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: animeList.length,
                    itemBuilder: (context, index) {
                      return AnimeListItem(anime: animeList[index]);
                    },
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
