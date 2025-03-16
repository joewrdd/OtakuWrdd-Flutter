import 'package:OtakuWrdd/data/repos/manga/user_manga_repository.dart';
import 'package:OtakuWrdd/ui/main/controllers/anime_details_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/manga_list_controller.dart';
import 'package:OtakuWrdd/ui/main/models/user_manga_model.dart';
import 'package:OtakuWrdd/ui/main/screens/manga_details/manga_details.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/anime_details.dart';
import 'package:OtakuWrdd/utils/client/http_client.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MangaDetailsController extends GetxController {
  static MangaDetailsController get instance => Get.find();

  final Rx<MangaDetailed> mangaDetails = MangaDetailed.empty().obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  final RxInt currentMangaId = 0.obs;
  final RxList<MangaCharacter> characters = <MangaCharacter>[].obs;
  final RxBool isLoadingCharacters = false.obs;

  final RxList<ExternalLink> externalLinks = <ExternalLink>[].obs;

  RxInt? selectedTabIndex;
  RxInt? userScore;
  RxString? readStatus;
  RxInt? chaptersRead;
  RxInt? volumesRead;

  final userMangaRepository = Get.put(UserMangaRepository());
  final RxBool isInUserList = false.obs;
  final Rx<UserMangaModel?> userMangaData = Rx<UserMangaModel?>(null);

  final RxBool isLoadingUserData = true.obs;

  @override
  void onInit() {
    super.onInit();

    selectedTabIndex = 0.obs;
    userScore = 0.obs;
    readStatus = 'None'.obs;
    chaptersRead = 0.obs;
    volumesRead = 0.obs;

    final mangaId = Get.arguments as int?;
    if (mangaId != null) {
      loadAllData(mangaId);
    }
  }

  Future<void> loadAllData(int mangaId) async {
    try {
      isLoadingUserData.value = true;

      await Future.wait([
        getMangaDetails(mangaId),
        getMangaCharacters(mangaId),
      ]);

      await checkUserMangaStatus(mangaId);
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error Loading Manga Details',
        message: e.toString(),
      );
    } finally {
      isLoadingUserData.value = false;
    }
  }

  Future<void> getMangaDetails(int mangaId) async {
    if (isLoading.value && currentMangaId.value == mangaId) return;

    if (mangaDetails.value.id == mangaId && !isLoading.value) return;

    try {
      isLoading.value = true;
      error.value = '';
      currentMangaId.value = mangaId;

      final response = await MALApiClient.getMangaDetails(mangaId);
      final details = MangaDetailed.fromJson(response);
      mangaDetails.value = details;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getMangaCharacters(int mangaId) async {
    if (isLoadingCharacters.value) return;

    try {
      isLoadingCharacters.value = true;

      try {
        final detailedCharacters =
            await MALApiClient.getMangaCharactersWithDetails(mangaId);
        if (detailedCharacters.isNotEmpty) {
          characters.value = detailedCharacters;
          return;
        }
      } catch (e) {
        Loaders.errorSnackBar(title: 'Error Fetching Characters');
      }

      final basicCharacters = await MALApiClient.getMangaCharacters(mangaId);
      if (basicCharacters.isNotEmpty) {
        characters.value = basicCharacters;
      }
    } catch (e) {
      characters.value = [];
    } finally {
      isLoadingCharacters.value = false;
    }
  }

  Future<void> checkUserMangaStatus(int mangaId) async {
    try {
      final userManga = await userMangaRepository.getUserManga(mangaId);

      if (userManga != null) {
        isInUserList.value = true;
        userMangaData.value = userManga;

        readStatus!.value = userManga.status;
        chaptersRead!.value = userManga.chaptersRead;
        volumesRead!.value = userManga.totalChapters;
        userScore!.value = userManga.rating?.toInt() ?? 0;
      } else {
        isInUserList.value = false;
        readStatus!.value = 'None';
        chaptersRead!.value = 0;
        volumesRead!.value = 0;
        userScore!.value = 0;
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error Checking Manga Status',
        message: e.toString(),
      );
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Error',
          'Failed to check manga status: $e',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });
    }
  }

  Future<void> saveMangaToUserList() async {
    try {
      if (mangaDetails.value.id == 0) return;

      final manga = UserMangaModel(
        mangaId: mangaDetails.value.id,
        title: mangaDetails.value.title,
        imageUrl: mangaDetails.value.mainPicture.medium,
        status: readStatus!.value,
        chaptersRead: chaptersRead!.value,
        totalChapters: mangaDetails.value.numChapters,
        rating: userScore!.value.toDouble(),
        lastUpdated: DateTime.now(),
      );

      await userMangaRepository.saveUserManga(manga);
      isInUserList.value = true;
      userMangaData.value = manga;

      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Success',
          'Manga added to your ${readStatus!.value} list',
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });

      if (Get.isRegistered<MangaListController>()) {
        Get.find<MangaListController>().fetchUserMangaList();
      }
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Error',
          'Failed to save manga: $e',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });
    }
  }

  Future<void> removeMangaFromUserList() async {
    try {
      await userMangaRepository.removeUserManga(mangaDetails.value.id);
      isInUserList.value = false;
      userMangaData.value = null;

      readStatus!.value = 'Plan to Read';
      chaptersRead!.value = 0;
      volumesRead!.value = 0;
      userScore!.value = 0;

      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Success',
          'Manga removed from your list',
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });

      if (Get.isRegistered<MangaListController>()) {
        Get.find<MangaListController>().fetchUserMangaList();
      }
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Error',
          'Failed to remove manga: $e',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });
    }
  }

  List<RelatedMedia> getMangaRelatedMedia() {
    final result = mangaDetails.value.relatedManga;
    if (result.isEmpty) {
      return [
        RelatedMedia(
          id: 1,
          title: "",
          relationType: "",
          relationTypeFormatted: "",
          mainPicture: MainPicture(
            medium: ConstantImages.errorCover,
            large: "",
          ),
        ),
        RelatedMedia(
          id: 2,
          title: "",
          relationType: "",
          relationTypeFormatted: "",
          mainPicture: MainPicture(
            medium: ConstantImages.errorCover,
            large: "",
          ),
        ),
      ];
    }

    return result;
  }

  void navigateToRelatedMedia(RelatedMedia media) {
    final isManga = mangaDetails.value.relatedManga.any(
      (m) => m.id == media.id,
    );

    if (isManga) {
      Get.delete<MangaDetailsController>();

      Get.to(
        () => const MangaDetailsScreen(),
        arguments: media.id,
        preventDuplicates: false,
      );
    } else {
      Get.delete<AnimeDetailsController>();
      Get.to(
        () => const AnimeDetailsScreen(),
        arguments: media.id,
        preventDuplicates: false,
      );
    }
  }

  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Loaders.errorSnackBar(title: 'Could not launch $url');
    }
  }
}
