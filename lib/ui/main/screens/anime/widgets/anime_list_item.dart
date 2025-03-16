import 'package:OtakuWrdd/data/repos/anime/user_anime_repository.dart';
import 'package:OtakuWrdd/ui/main/controllers/anime_list_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/anime_details.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimeListItem extends StatelessWidget {
  final UserAnime anime;

  const AnimeListItem({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeListController>();
    final userAnimeRepository = Get.find<UserAnimeRepository>();
    return Dismissible(
      key: Key('anime_${anime.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) async {
        await userAnimeRepository.removeUserAnime(anime.id);

        controller.fetchUserAnimeList();
      },
      child: GestureDetector(
        onTap:
            () => Get.to(() => const AnimeDetailsScreen(), arguments: anime.id),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
          decoration: BoxDecoration(color: Colors.transparent),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  anime.imageUrl,
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

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.title,
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
                      '${anime.episodesWatched} / ${anime.totalEpisodes} episodes',
                      style: GoogleFonts.lato(
                        color: ConstantColors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
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
