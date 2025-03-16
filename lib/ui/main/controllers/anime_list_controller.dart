import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:get/get.dart';
import 'package:OtakuWrdd/data/repos/anime/user_anime_repository.dart';

class AnimeListController extends GetxController {
  static AnimeListController get instance => Get.find();

  final RxList<UserAnime> watchingList = <UserAnime>[].obs;
  final RxList<UserAnime> completedList = <UserAnime>[].obs;
  final RxList<UserAnime> planToWatchList = <UserAnime>[].obs;
  final RxList<UserAnime> onHoldList = <UserAnime>[].obs;
  final RxList<UserAnime> droppedList = <UserAnime>[].obs;

  final RxBool isWatchingVisible = true.obs;
  final RxBool isCompletedVisible = true.obs;
  final RxBool isPlanToWatchVisible = true.obs;
  final RxBool isOnHoldVisible = true.obs;
  final RxBool isDroppedVisible = true.obs;

  final Rx<SortMethod> currentSortMethod = SortMethod.alphabetical.obs;

  @override
  void onInit() {
    super.onInit();

    Get.put(UserAnimeRepository());

    Future.delayed(Duration.zero, () {
      fetchUserAnimeList();
    });
  }

  Future<void> fetchUserAnimeList() async {
    try {
      final userAnimeRepository = Get.find<UserAnimeRepository>();
      final allAnime = await userAnimeRepository.getUserAnimeList();

      watchingList.clear();
      completedList.clear();
      planToWatchList.clear();
      onHoldList.clear();
      droppedList.clear();

      for (var anime in allAnime) {
        final userAnime = UserAnime(
          id: anime.animeId,
          title: anime.title,
          episodesWatched: anime.episodesWatched,
          totalEpisodes: anime.totalEpisodes,
          imageUrl: anime.imageUrl,
          rating: anime.rating,
          lastUpdated: anime.lastUpdated,
          status: anime.status,
        );

        switch (anime.status) {
          case 'Watching':
            watchingList.add(userAnime);
            break;
          case 'Completed':
            completedList.add(userAnime);
            break;
          case 'Plan to Watch':
            planToWatchList.add(userAnime);
            break;
          case 'On Hold':
            onHoldList.add(userAnime);
            break;
          case 'Dropped':
            droppedList.add(userAnime);
            break;
        }
      }

      sortAnimeList(currentSortMethod.value);
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch anime list: $e',
      );
    }
  }

  void toggleSectionVisibility(String section) {
    switch (section) {
      case 'watching':
        isWatchingVisible.toggle();
        break;
      case 'completed':
        isCompletedVisible.toggle();
        break;
      case 'planToWatch':
        isPlanToWatchVisible.toggle();
        break;
      case 'onHold':
        isOnHoldVisible.toggle();
        break;
      case 'dropped':
        isDroppedVisible.toggle();
        break;
    }
  }

  void sortAnimeList(SortMethod method) {
    currentSortMethod.value = method;

    void sortList(RxList<UserAnime> list) {
      switch (method) {
        case SortMethod.alphabetical:
          list.sort((a, b) => a.title.compareTo(b.title));
          break;
        case SortMethod.ratingHighest:
          list.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
          break;
        case SortMethod.ratingLowest:
          list.sort((a, b) => (a.rating ?? 0).compareTo(b.rating ?? 0));
          break;
        case SortMethod.lastUpdated:
          list.sort(
            (a, b) => (b.lastUpdated ?? DateTime(1970)).compareTo(
              a.lastUpdated ?? DateTime(1970),
            ),
          );
          break;
      }
    }

    sortList(watchingList);
    sortList(completedList);
    sortList(planToWatchList);
    sortList(onHoldList);
    sortList(droppedList);
  }
}

class UserAnime {
  final int id;
  final String title;
  final int episodesWatched;
  final int totalEpisodes;
  final String imageUrl;
  final double? rating;
  final DateTime? lastUpdated;
  final String status;

  UserAnime({
    required this.id,
    required this.title,
    required this.episodesWatched,
    required this.totalEpisodes,
    required this.imageUrl,
    this.rating,
    this.lastUpdated,
    required this.status,
  });
}

enum SortMethod { alphabetical, ratingHighest, ratingLowest, lastUpdated }
