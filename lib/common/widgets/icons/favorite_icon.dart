import 'package:OtakuWrdd/ui/main/controllers/favorites_controller.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    super.key,
    required this.animeId,
    required this.mangaId,
    required this.isAnime,
  });

  final String animeId;
  final String mangaId;
  final bool isAnime;

  @override
  Widget build(BuildContext context) {
    final favoritesController = Get.put(FavoritesController());
    return Obx(() {
      final String idToCheck = isAnime ? animeId : mangaId;
      final isFavorite =
          isAnime
              ? favoritesController.isFavoriteAnime(idToCheck)
              : favoritesController.isFavoriteManga(idToCheck);

      return IconButton(
        onPressed: () {
          if (isAnime) {
            favoritesController.toggleFavoriteAnime(idToCheck);
          } else {
            favoritesController.toggleFavoriteManga(idToCheck);
          }
        },
        icon:
            isFavorite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
        color: isFavorite ? ConstantColors.secondary : Colors.white,
      );
    });
  }
}
