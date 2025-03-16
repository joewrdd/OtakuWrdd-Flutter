import 'package:OtakuWrdd/data/repos/manga/user_manga_repository.dart';
import 'package:OtakuWrdd/ui/main/controllers/manga_list_controller.dart';
import 'package:OtakuWrdd/ui/main/models/user_manga_model.dart';
import 'package:OtakuWrdd/ui/main/screens/manga_details/manga_details.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaListItem extends StatelessWidget {
  final UserMangaModel manga;

  const MangaListItem({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MangaListController>();
    final userMangaRepository = Get.find<UserMangaRepository>();
    return Dismissible(
      key: Key('manga_${manga.mangaId}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) async {
        await userMangaRepository.removeUserManga(manga.mangaId);
        controller.fetchUserMangaList();
      },
      child: GestureDetector(
        onTap:
            () => Get.to(
              () => const MangaDetailsScreen(),
              arguments: manga.mangaId,
            ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
          decoration: BoxDecoration(color: Colors.transparent),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  manga.imageUrl,
                  width: 100,
                  height: 135,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 85,
                      height: 120,
                      color: Colors.grey[800],
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),

              // Anime details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      manga.title,
                      style: GoogleFonts.lato(
                        color: ConstantColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Episodes progress
                    Text(
                      '${manga.chaptersRead} / ${manga.totalChapters} chapters',
                      style: GoogleFonts.lato(
                        color: ConstantColors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),

                    // // Next episode info if available
                    // if (anime.nextEpisode != null) ...[
                    //   const SizedBox(height: 12),
                    //   Row(
                    //     children: [
                    //       Icon(
                    //         Icons.volume_up,
                    //         color: Colors.yellow[700],
                    //         size: 16,
                    //       ),
                    //       const SizedBox(width: 4),
                    //       Text(
                    //         anime.nextEpisode!,
                    //         style: GoogleFonts.lato(
                    //           color: Colors.yellow[700],
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
