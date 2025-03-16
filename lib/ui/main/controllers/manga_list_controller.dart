import 'package:OtakuWrdd/data/repos/manga/user_manga_repository.dart';
import 'package:OtakuWrdd/ui/main/models/user_manga_model.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:get/get.dart';

class MangaListController extends GetxController {
  static MangaListController get instance => Get.find();

  final RxList<UserMangaModel> readingList = <UserMangaModel>[].obs;
  final RxList<UserMangaModel> completedList = <UserMangaModel>[].obs;
  final RxList<UserMangaModel> planToReadList = <UserMangaModel>[].obs;
  final RxList<UserMangaModel> onHoldList = <UserMangaModel>[].obs;
  final RxList<UserMangaModel> droppedList = <UserMangaModel>[].obs;

  final RxBool isReadingVisible = true.obs;
  final RxBool isCompletedVisible = true.obs;
  final RxBool isPlanToReadVisible = true.obs;
  final RxBool isOnHoldVisible = true.obs;
  final RxBool isDroppedVisible = true.obs;

  final Rx<SortMethod> currentSortMethod = SortMethod.alphabetical.obs;

  @override
  void onInit() {
    super.onInit();

    Get.put(UserMangaRepository());

    Future.delayed(Duration.zero, () {
      fetchUserMangaList();
    });
  }

  Future<void> fetchUserMangaList() async {
    try {
      final userMangaRepository = Get.find<UserMangaRepository>();
      final allManga = await userMangaRepository.getUserMangaList();

      readingList.clear();
      completedList.clear();
      planToReadList.clear();
      onHoldList.clear();
      droppedList.clear();

      for (var manga in allManga) {
        final userManga = UserMangaModel(
          mangaId: manga.mangaId,
          title: manga.title,
          chaptersRead: manga.chaptersRead,
          totalChapters: manga.totalChapters,
          imageUrl: manga.imageUrl,
          rating: manga.rating,
          lastUpdated: manga.lastUpdated,
          status: manga.status,
        );

        switch (manga.status) {
          case 'Reading':
            readingList.add(userManga);
            break;
          case 'Completed':
            completedList.add(userManga);
            break;
          case 'Plan to Read':
            planToReadList.add(userManga);
            break;
          case 'On Hold':
            onHoldList.add(userManga);
            break;
          case 'Dropped':
            droppedList.add(userManga);
            break;
        }
      }

      sortMangaList(currentSortMethod.value);
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch manga list: $e',
      );
    }
  }

  void toggleSectionVisibility(String section) {
    switch (section) {
      case 'reading':
        isReadingVisible.toggle();
        break;
      case 'completed':
        isCompletedVisible.toggle();
        break;
      case 'planToRead':
        isPlanToReadVisible.toggle();
        break;
      case 'onHold':
        isOnHoldVisible.toggle();
        break;
      case 'dropped':
        isDroppedVisible.toggle();
        break;
    }
  }

  void sortMangaList(SortMethod method) {
    currentSortMethod.value = method;

    void sortList(RxList<UserMangaModel> list) {
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
          list.sort((a, b) => (b.lastUpdated).compareTo(a.lastUpdated));
          break;
      }
    }

    sortList(readingList);
    sortList(completedList);
    sortList(planToReadList);
    sortList(onHoldList);
    sortList(droppedList);
  }
}

enum SortMethod { alphabetical, ratingHighest, ratingLowest, lastUpdated }
