import 'dart:convert';
import 'package:OtakuWrdd/data/repos/anime/user_anime_repository.dart';
import 'package:OtakuWrdd/data/repos/manga/user_manga_repository.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:OtakuWrdd/utils/storage/storage.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  final favoriteAnime = <String, bool>{}.obs;
  final favoriteManga = <String, bool>{}.obs;

  final RxBool isLoadingAnime = false.obs;
  final RxBool isLoadingManga = false.obs;

  final RxList<AnimeDetailed> cachedAnimeDetails = <AnimeDetailed>[].obs;
  final RxList<MangaDetailed> cachedMangaDetails = <MangaDetailed>[].obs;

  final mangaRepository = Get.put(UserMangaRepository());
  final animeRepository = Get.put(UserAnimeRepository());

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    try {
      final savedAnime = LocalStorage.instance().readData('anime-favorites');
      if (savedAnime != null && savedAnime.isNotEmpty) {
        try {
          final Map<String, dynamic> decodedAnime = json.decode(savedAnime);
          favoriteAnime.clear();
          decodedAnime.forEach((key, value) {
            if (key.isNotEmpty &&
                key != "0" &&
                int.tryParse(key) != null &&
                int.parse(key) > 0) {
              favoriteAnime[key] = value;
            }
          });
        } catch (e) {
          favoriteAnime.clear();
          saveFavoriteAnime();
        }
      }

      final savedManga = LocalStorage.instance().readData('manga-favorites');
      if (savedManga != null && savedManga.isNotEmpty) {
        try {
          final Map<String, dynamic> decodedManga = json.decode(savedManga);
          favoriteManga.clear();
          decodedManga.forEach((key, value) {
            if (key.isNotEmpty &&
                key != "0" &&
                int.tryParse(key) != null &&
                int.parse(key) > 0) {
              favoriteManga[key] = value;
            }
          });
        } catch (e) {
          favoriteManga.clear();
          saveFavoriteManga();
        }
      }
      refreshFavoriteData();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error Loading Favorites');
    }
  }

  Future<void> refreshFavoriteData() async {
    getFavoriteAnime();
    getFavoriteManga();
  }

  bool isFavoriteAnime(String id) {
    final strId = id.toString();
    final result = favoriteAnime[strId] ?? false;
    return result;
  }

  bool isFavoriteManga(String id) {
    final strId = id.toString();
    final result = favoriteManga[strId] ?? false;
    return result;
  }

  void toggleFavoriteAnime(String id) {
    final String strId = id.toString();
    if (strId.isEmpty || int.tryParse(strId) == null || int.parse(strId) <= 0) {
      Loaders.errorSnackBar(title: 'Invalid Anime ID');
      return;
    }

    if (!favoriteAnime.containsKey(strId)) {
      favoriteAnime[strId] = true;
      saveFavoriteAnime();
      Loaders.customToast(message: 'Anime Added To Favorites');

      getFavoriteAnime();
    } else {
      favoriteAnime.remove(strId);
      favoriteAnime.refresh();
      saveFavoriteAnime();
      Loaders.customToast(message: 'Anime Removed From Favorites');

      cachedAnimeDetails.removeWhere((anime) => anime.id.toString() == strId);
    }
  }

  void toggleFavoriteManga(String id) {
    final String strId = id.toString();

    if (strId.isEmpty || int.tryParse(strId) == null || int.parse(strId) <= 0) {
      Loaders.errorSnackBar(title: 'Invalid Manga ID');
      return;
    }

    if (!favoriteManga.containsKey(strId)) {
      favoriteManga[strId] = true;
      saveFavoriteManga();
      Loaders.customToast(message: 'Manga Added To Favorites');

      getFavoriteManga();
    } else {
      favoriteManga.remove(strId);
      favoriteManga.refresh();
      saveFavoriteManga();
      Loaders.customToast(message: 'Manga Removed From Favorites');

      cachedMangaDetails.removeWhere((manga) => manga.id.toString() == strId);
    }
  }

  void saveFavoriteAnime() {
    final encodedJsonFavAnime = json.encode(favoriteAnime);
    LocalStorage.instance().saveData('anime-favorites', encodedJsonFavAnime);
  }

  void saveFavoriteManga() {
    final encodedJsonFavManga = json.encode(favoriteManga);
    LocalStorage.instance().saveData('manga-favorites', encodedJsonFavManga);
  }

  Future<List<AnimeDetailed>> getFavoriteAnime() async {
    try {
      if (favoriteAnime.isEmpty) {
        cachedAnimeDetails.clear();
        return [];
      }

      isLoadingAnime.value = true;

      final validIds =
          favoriteAnime.keys
              .where(
                (id) =>
                    id.isNotEmpty &&
                    id != "0" &&
                    int.tryParse(id) != null &&
                    int.parse(id) > 0,
              )
              .toList();

      if (validIds.isEmpty) {
        cachedAnimeDetails.clear();
        return [];
      }

      final animeList = await UserAnimeRepository.instance.getFavoriteAnime(
        validIds,
      );
      cachedAnimeDetails.value = animeList;
      return animeList;
    } catch (e) {
      return cachedAnimeDetails;
    } finally {
      isLoadingAnime.value = false;
    }
  }

  Future<List<MangaDetailed>> getFavoriteManga() async {
    try {
      if (favoriteManga.isEmpty) {
        cachedMangaDetails.clear();
        return [];
      }

      isLoadingManga.value = true;

      final validIds =
          favoriteManga.keys
              .where(
                (id) =>
                    id.isNotEmpty &&
                    id != "0" &&
                    int.tryParse(id) != null &&
                    int.parse(id) > 0,
              )
              .toList();

      if (validIds.isEmpty) {
        cachedMangaDetails.clear();
        return [];
      }

      final mangaList = await mangaRepository.getFavoriteManga(validIds);
      cachedMangaDetails.value = mangaList;
      return mangaList;
    } catch (e) {
      return cachedMangaDetails;
    } finally {
      isLoadingManga.value = false;
    }
  }
}
