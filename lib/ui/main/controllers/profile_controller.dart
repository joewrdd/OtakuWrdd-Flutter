import 'package:OtakuWrdd/data/repos/anime/user_anime_repository.dart';
import 'package:OtakuWrdd/data/repos/manga/user_manga_repository.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final userAnimeRepository = Get.put(UserAnimeRepository());
  final userMangaRepository = Get.put(UserMangaRepository());

  final RxInt totalAnimeCompleted = 0.obs;
  final RxInt totalMangaCompleted = 0.obs;
  final RxInt totalEpisodesWatched = 0.obs;
  final RxInt totalChaptersRead = 0.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserStats();
  }

  Future<void> loadUserStats() async {
    try {
      isLoading.value = true;

      final animeList = await userAnimeRepository.getUserAnimeList();
      final mangaList = await userMangaRepository.getUserMangaList();

      int animeCompleted = 0;
      int episodesWatched = 0;

      for (var anime in animeList) {
        if (anime.status == 'Completed') {
          animeCompleted++;
        }
        episodesWatched += anime.episodesWatched;
      }

      int mangaCompleted = 0;
      int chaptersRead = 0;

      for (var manga in mangaList) {
        if (manga.status == 'Completed') {
          mangaCompleted++;
        }
        chaptersRead += manga.chaptersRead;
      }

      totalAnimeCompleted.value = animeCompleted;
      totalMangaCompleted.value = mangaCompleted;
      totalEpisodesWatched.value = episodesWatched;
      totalChaptersRead.value = chaptersRead;
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error Loading User Stats',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void refreshStats() {
    loadUserStats();
  }
}
