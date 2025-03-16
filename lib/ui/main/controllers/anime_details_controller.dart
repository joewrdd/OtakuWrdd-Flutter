// ignore_for_file: unused_field

import 'package:OtakuWrdd/ui/main/controllers/anime_list_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/anime_details.dart';
import 'package:OtakuWrdd/utils/client/http_client.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:OtakuWrdd/utils/client/crunchyroll_client.dart';
import 'package:OtakuWrdd/ui/main/models/user_anime_model.dart';
import 'package:OtakuWrdd/data/repos/anime/user_anime_repository.dart';
import 'package:flutter/material.dart';

class AnimeDetailsController extends GetxController {
  static const String _baseUrl = 'https://www.crunchyroll.com';
  static AnimeDetailsController get instance => Get.find();

  final Rx<AnimeDetailed> animeDetails = AnimeDetailed.empty().obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  final RxInt currentAnimeId = 0.obs;
  final RxList<Character> characters = <Character>[].obs;
  final RxBool isLoadingCharacters = false.obs;

  final RxList<ExternalLink> externalLinks = <ExternalLink>[].obs;

  final RxList<AnimeEpisode> episodes = <AnimeEpisode>[].obs;
  final RxBool isLoadingEpisodes = false.obs;

  RxInt? selectedTabIndex;
  RxInt? userScore;
  RxString? watchStatus;
  RxInt? episodesWatched;

  final userAnimeRepository = Get.put(UserAnimeRepository());
  final RxBool isInUserList = false.obs;
  final Rx<UserAnimeModel?> userAnimeData = Rx<UserAnimeModel?>(null);

  final RxBool isLoadingUserData = true.obs;

  @override
  void onInit() {
    super.onInit();

    selectedTabIndex = 0.obs;
    userScore = 0.obs;
    watchStatus = 'None'.obs;
    episodesWatched = 0.obs;

    final animeId = Get.arguments as int?;
    if (animeId != null) {
      loadAllData(animeId);
    }
  }

  Future<void> loadAllData(int animeId) async {
    try {
      isLoadingUserData.value = true;

      await Future.wait([
        getAnimeDetails(animeId),
        getAnimeCharacters(animeId),
        getAnimeEpisodes(animeId),
      ]);

      await checkUserAnimeStatus(animeId);
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error Loading Anime Details',
        message: e.toString(),
      );
    } finally {
      isLoadingUserData.value = false;
    }
  }

  Future<void> getAnimeDetails(int animeId) async {
    if (isLoading.value && currentAnimeId.value == animeId) return;

    if (animeDetails.value.id == animeId && !isLoading.value) return;

    try {
      isLoading.value = true;
      error.value = '';
      currentAnimeId.value = animeId;

      final response = await MALApiClient.getAnimeDetails(animeId);
      final details = AnimeDetailed.fromJson(response);
      animeDetails.value = details;

      if (details.trailer == null ||
          !details.trailer!.url.contains('youtube.com/watch')) {
        await fetchYouTubeTrailer(details.title);
      }

      final links = await MALApiClient.getAnimeExternalLinks(animeId);
      externalLinks.value = links;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAnimeCharacters(int animeId) async {
    if (isLoadingCharacters.value) return;

    try {
      isLoadingCharacters.value = true;

      final basicCharacters = await MALApiClient.getAnimeCharacters(animeId);
      characters.value = basicCharacters;

      final detailedCharacters =
          await MALApiClient.getAnimeCharactersWithDetails(animeId);
      characters.value = detailedCharacters;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Cannot Load Characters');
    } finally {
      isLoadingCharacters.value = false;
    }
  }

  Future<void> getAnimeEpisodes(int animeId) async {
    if (isLoadingEpisodes.value) return;

    try {
      isLoadingEpisodes.value = true;

      final slug = CrunchyrollClient.getSeriesSlug(animeDetails.value.title);
      final crEpisodes = await CrunchyrollClient.getEpisodes(slug);

      if (crEpisodes.isNotEmpty) {
        episodes.value =
            crEpisodes.take(4).map((e) {
              String imageUrl = e['screenshot_image']?['large_url'] ?? '';
              if (imageUrl.isEmpty ||
                  !Uri.parse(imageUrl).isAbsolute ||
                  imageUrl == "file:///" ||
                  !imageUrl.startsWith('http')) {
                imageUrl = animeDetails.value.mainPicture.large;
              }
              return AnimeEpisode(
                title: e['title'] ?? '',
                url: e['episode_url'] ?? 'https://www.crunchyroll.com',
                imageUrl: imageUrl,
                number: e['episode_number'] ?? 0,
              );
            }).toList();
        return;
      }

      final malResponse = await http.get(
        Uri.parse('${MALApiClient.jikanBaseUrl}/anime/$animeId/episodes'),
      );

      if (malResponse.statusCode == 200) {
        final malData = json.decode(malResponse.body)['data'] as List;

        try {
          final tmdbResponse = await http.get(
            Uri.parse(
              'https://api.themoviedb.org/3/search/tv?api_key=YOUR_TMDB_API_KEY&query=${Uri.encodeComponent(animeDetails.value.title)}',
            ),
          );

          if (tmdbResponse.statusCode == 200) {
            final tmdbData = json.decode(tmdbResponse.body);
            final results = tmdbData['results'] as List;

            if (results.isNotEmpty) {
              final showId = results[0]['id'];
              final seasonResponse = await http.get(
                Uri.parse(
                  'https://api.themoviedb.org/3/tv/$showId/season/1?api_key=YOUR_TMDB_API_KEY',
                ),
              );

              if (seasonResponse.statusCode == 200) {
                final seasonData = json.decode(seasonResponse.body);
                final episodeData = seasonData['episodes'] as List;

                episodes.value =
                    malData.take(8).map((e) {
                      int epNumber = int.tryParse(e['mal_id'].toString()) ?? 0;
                      String imageUrl = animeDetails.value.mainPicture.large;
                      String mediumImageUrl =
                          animeDetails.value.mainPicture.medium;

                      if (epNumber > 0 && epNumber <= episodeData.length) {
                        final tmdbEp = episodeData[epNumber - 1];
                        if (tmdbEp['still_path'] != null &&
                            tmdbEp['still_path'].toString().isNotEmpty) {
                          String tmdbImageUrl =
                              'https://image.tmdb.org/t/p/w500${tmdbEp['still_path']}';
                          if (tmdbImageUrl.isNotEmpty &&
                              Uri.parse(tmdbImageUrl).isAbsolute &&
                              tmdbImageUrl.startsWith('http')) {
                            return AnimeEpisode(
                              title: e['title'] ?? '',
                              url: 'https://www.crunchyroll.com',
                              imageUrl:
                                  tmdbImageUrl.isNotEmpty
                                      ? tmdbImageUrl
                                      : (imageUrl.isNotEmpty
                                          ? imageUrl
                                          : mediumImageUrl),
                              number: epNumber,
                            );
                          }
                        }
                      }

                      return AnimeEpisode(
                        title: e['title'] ?? '',
                        url: 'https://www.crunchyroll.com',
                        imageUrl:
                            animeDetails.value.mainPicture.large.isNotEmpty
                                ? animeDetails.value.mainPicture.large
                                : 'https://via.placeholder.com/500x281?text=No+Image',
                        number: epNumber,
                      );
                    }).toList();
                return;
              }
            }
          }
        } catch (tmdbError) {
          Loaders.errorSnackBar(title: 'Error Fetching Episodes');
        }

        episodes.value =
            malData.take(8).map((e) {
              return AnimeEpisode(
                title: e['title'] ?? '',
                url: 'https://www.crunchyroll.com',
                imageUrl: animeDetails.value.mainPicture.large,
                number: int.tryParse(e['mal_id'].toString()) ?? 0,
              );
            }).toList();
      }
    } catch (e) {
      if (episodes.isEmpty && animeDetails.value.id > 0) {
        episodes.value = List.generate(
          4,
          (index) => AnimeEpisode(
            title: 'Episode ${index + 1}',
            url: 'https://www.crunchyroll.com',
            imageUrl: animeDetails.value.mainPicture.large,
            number: index + 1,
          ),
        );
      }
    } finally {
      isLoadingEpisodes.value = false;
    }
  }

  Future<void> checkUserAnimeStatus(int animeId) async {
    try {
      final userAnime = await userAnimeRepository.getUserAnime(animeId);

      if (userAnime != null) {
        isInUserList.value = true;
        userAnimeData.value = userAnime;

        watchStatus!.value = userAnime.status;
        episodesWatched!.value = userAnime.episodesWatched;
        userScore!.value = userAnime.rating?.toInt() ?? 0;
      } else {
        isInUserList.value = false;
        watchStatus!.value = 'None';
        episodesWatched!.value = 0;
        userScore!.value = 0;
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error Checking Anime Status',
        message: e.toString(),
      );
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Error',
          'Failed to check anime status: $e',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });
    }
  }

  Future<void> saveAnimeToUserList() async {
    try {
      if (animeDetails.value.id == 0) return;

      final anime = UserAnimeModel(
        animeId: animeDetails.value.id,
        title: animeDetails.value.title,
        imageUrl: animeDetails.value.mainPicture.medium,
        status: watchStatus!.value,
        episodesWatched: episodesWatched!.value,
        totalEpisodes: animeDetails.value.numEpisodes,
        rating: userScore!.value.toDouble(),
        lastUpdated: DateTime.now(),
      );

      await userAnimeRepository.saveUserAnime(anime);
      isInUserList.value = true;
      userAnimeData.value = anime;

      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Success',
          'Anime added to your ${watchStatus!.value} list',
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });

      if (Get.isRegistered<AnimeListController>()) {
        Get.find<AnimeListController>().fetchUserAnimeList();
      }
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Error',
          'Failed to save anime: $e',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });
    }
  }

  Future<void> removeAnimeFromUserList() async {
    try {
      await userAnimeRepository.removeUserAnime(animeDetails.value.id);
      isInUserList.value = false;
      userAnimeData.value = null;

      watchStatus!.value = 'Plan to Watch';
      episodesWatched!.value = 0;
      userScore!.value = 0;

      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Success',
          'Anime removed from your list',
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });

      if (Get.isRegistered<AnimeListController>()) {
        Get.find<AnimeListController>().fetchUserAnimeList();
      }
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      Future.microtask(() {
        Get.snackbar(
          'Error',
          'Failed to remove anime: $e',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });
    }
  }

  List<RelatedMedia> getRelatedMedia() {
    final result = animeDetails.value.relatedAnime;
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
    final isAnime = animeDetails.value.relatedAnime.any(
      (a) => a.id == media.id,
    );
    if (isAnime) {
      Get.delete<AnimeDetailsController>();
      Get.to(
        () => const AnimeDetailsScreen(),
        arguments: media.id,
        preventDuplicates: false,
      );
    } else {
      Get.toNamed('/manga-details', arguments: media.id);
    }
  }

  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Loaders.errorSnackBar(title: 'Could not launch $url');
    }
  }

  String getTrailerUrl() {
    final anime = animeDetails.value;

    if (anime.trailer != null &&
        anime.trailer!.url.isNotEmpty &&
        (anime.trailer!.url.contains('youtube.com/watch') ||
            anime.trailer!.url.contains('youtu.be/'))) {
      return anime.trailer!.url;
    }

    // Otherwise create a search URL
    return 'https://www.youtube.com/results?search_query=${Uri.encodeComponent(anime.title + " official trailer")}';
  }

  String getYouTubeThumbnail() {
    final anime = animeDetails.value;

    if (anime.trailer != null && anime.trailer!.url.isNotEmpty) {
      if (anime.trailer!.images.largeImageUrl.isNotEmpty) {
        return anime.trailer!.images.largeImageUrl;
      }

      final url = anime.trailer!.url;
      String? videoId;

      if (url.contains('youtube.com/watch')) {
        final uri = Uri.parse(url);
        videoId = uri.queryParameters['v'];
      } else if (url.contains('youtu.be/')) {
        videoId = url.split('youtu.be/')[1].split('?')[0];
      }

      if (videoId != null && videoId.isNotEmpty) {
        return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
      }
    }

    return anime.mainPicture.medium;
  }

  Future<void> fetchYouTubeTrailer(String animeTitle) async {
    try {
      final apiKey = dotenv.env['YOUTUBE_API_KEY'] ?? '';

      final query = Uri.encodeComponent('$animeTitle official anime trailer');
      final response = await http.get(
        Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&maxResults=1&key=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['items'] != null && data['items'].isNotEmpty) {
          final item = data['items'][0];
          final videoId = item['id']['videoId'];
          final thumbnailUrl = item['snippet']['thumbnails']['high']['url'];

          final trailer = AnimeTrailer(
            url: 'https://www.youtube.com/watch?v=$videoId',
            embedUrl: 'https://www.youtube.com/embed/$videoId',
            images: TrailerImages(
              maximumImageUrl: thumbnailUrl,
              largeImageUrl: thumbnailUrl,
              mediumImageUrl: thumbnailUrl,
              smallImageUrl: thumbnailUrl,
            ),
          );

          final anime = animeDetails.value;
          final updatedAnime = AnimeDetailed(
            id: anime.id,
            title: anime.title,
            mainPicture: anime.mainPicture,
            mean: anime.mean,
            rank: anime.rank,
            popularity: anime.popularity,
            mediaType: anime.mediaType,
            status: anime.status,
            alternativeTitles: anime.alternativeTitles,
            synopsis: anime.synopsis,
            startDate: anime.startDate,
            endDate: anime.endDate,
            numEpisodes: anime.numEpisodes,
            rating: anime.rating,
            genres: anime.genres,
            studios: anime.studios,
            statistics: anime.statistics,
            relatedAnime: anime.relatedAnime,
            trailer: trailer,
          );

          animeDetails.value = updatedAnime;
        }
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error Fetching YouTube Trailer');
    }
  }
}
