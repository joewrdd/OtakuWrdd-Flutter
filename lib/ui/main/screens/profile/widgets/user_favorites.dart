import 'package:OtakuWrdd/ui/main/controllers/favorites_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/anime_details.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/cover_image_text.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/discovery_headers.dart';
import 'package:OtakuWrdd/ui/main/screens/manga_details/manga_details.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/vertical_cover_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserFavorites extends StatelessWidget {
  const UserFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesController = Get.put(FavoritesController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DiscoveryHeaders(text: 'FAVORITE ANIMES'),
        SizedBox(
          height: 250,
          child: Obx(() {
            final animeList = favoritesController.cachedAnimeDetails;

            if (favoritesController.isLoadingAnime.value) {
              return const VerticalCoverShimmer(
                scrollDirection: Axis.horizontal,
              );
            }

            if (animeList.isEmpty) {
              return Center(
                child: Text(
                  'No Favorite Anime Found',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.separated(
              itemCount: animeList.length,
              separatorBuilder:
                  (context, index) =>
                      const SizedBox(width: ConstantSizes.spaceBtwItems / 2),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final anime = animeList[index];
                return CoverImageText(
                  text: anime.title,
                  imageUrl: anime.mainPicture.medium,
                  onTap:
                      () => Get.to(
                        () => const AnimeDetailsScreen(),
                        arguments: anime.id,
                      ),
                );
              },
            );
          }),
        ),

        DiscoveryHeaders(text: 'FAVORITE MANGAS'),
        SizedBox(
          height: 250,
          child: Obx(() {
            final mangaList = favoritesController.cachedMangaDetails;

            if (favoritesController.isLoadingManga.value) {
              return const VerticalCoverShimmer(
                scrollDirection: Axis.horizontal,
              );
            }

            if (mangaList.isEmpty) {
              return Center(
                child: Text(
                  'No Favorite Manga Found',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.separated(
              itemCount: mangaList.length,
              separatorBuilder:
                  (context, index) =>
                      const SizedBox(width: ConstantSizes.spaceBtwItems / 2),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final manga = mangaList[index];
                return CoverImageText(
                  text: manga.title,
                  imageUrl: manga.mainPicture.medium,
                  onTap:
                      () => Get.to(
                        () => const MangaDetailsScreen(),
                        arguments: manga.id,
                      ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
