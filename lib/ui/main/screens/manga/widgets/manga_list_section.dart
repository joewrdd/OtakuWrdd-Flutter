import 'package:OtakuWrdd/ui/main/controllers/manga_list_controller.dart';
import 'package:OtakuWrdd/ui/main/models/user_manga_model.dart';
import 'package:OtakuWrdd/ui/main/screens/manga/widgets/manga_list_item.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaListSection extends StatelessWidget {
  final String title;
  final String sectionKey;
  final RxList<UserMangaModel> mangaList;
  final RxBool isVisible;
  final int count;

  const MangaListSection({
    super.key,
    required this.title,
    required this.sectionKey,
    required this.mangaList,
    required this.isVisible,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MangaListController>();
    return Column(
      children: [
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
                    itemCount: mangaList.length,
                    itemBuilder: (context, index) {
                      return MangaListItem(manga: mangaList[index]);
                    },
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
