import 'package:get/get.dart';
import '../../../utils/client/http_client.dart';
import '../../../utils/client/model_client.dart';

class DiscoverController extends GetxController {
  static DiscoverController get instance => Get.find();

  final Rx<List<AnimeBase>> trendingAnime = Rx<List<AnimeBase>>([]);
  final Rx<List<AnimeBase>> currentSeasonAnime = Rx<List<AnimeBase>>([]);
  final Rx<List<AnimeBase>> upcomingAnime = Rx<List<AnimeBase>>([]);
  final Rx<List<AnimeBase>> topRankedAnime = Rx<List<AnimeBase>>([]);
  final Rx<List<AnimeBase>> topRankedMovies = Rx<List<AnimeBase>>([]);
  final Rx<List<AnimeBase>> popularAnime = Rx<List<AnimeBase>>([]);
  final Rx<AnimeDetailed> animeDetails = AnimeDetailed.empty().obs;

  final Rx<List<MangaBase>> trendingManga = Rx<List<MangaBase>>([]);
  final Rx<List<MangaBase>> topRankedManga = Rx<List<MangaBase>>([]);
  final Rx<List<MangaBase>> popularManga = Rx<List<MangaBase>>([]);
  final Rx<List<MangaBase>> popularManhwa = Rx<List<MangaBase>>([]);

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<List<AnimeBase>> fetchTrendingAnime({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getTrendingAnime(limit: limit);
      final animeList = AnimeListResponse.fromJson(response);
      trendingAnime.value = animeList.data;
      return animeList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<AnimeBase>> fetchCurrentSeasonAnime({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getCurrentSeasonAnime(limit: limit);
      final animeList = AnimeListResponse.fromJson(response);
      currentSeasonAnime.value = animeList.data;
      return animeList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<AnimeBase>> fetchUpcomingAnime({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getUpcomingSeasonAnime(limit: limit);
      final animeList = AnimeListResponse.fromJson(response);
      upcomingAnime.value = animeList.data;
      return animeList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<AnimeBase>> fetchTopRankedAnime({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getTopRankedAnime(limit: limit);
      final animeList = AnimeListResponse.fromJson(response);
      topRankedAnime.value = animeList.data;
      return animeList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<AnimeBase>> fetchTopRankedMovies({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getTopRankedAnimeMovies(limit: limit);
      final animeList = AnimeListResponse.fromJson(response);
      topRankedMovies.value = animeList.data;
      return animeList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<AnimeBase>> fetchPopularAnime({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getPopularAnime(limit: limit);
      final animeList = AnimeListResponse.fromJson(response);
      popularAnime.value = animeList.data;
      return animeList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<MangaBase>> fetchTrendingManga({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getTrendingManga(limit: limit);
      final mangaList = MangaListResponse.fromJson(response);
      trendingManga.value = mangaList.data;
      return mangaList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<MangaBase>> fetchTopRankedManga({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getTopRankedManga(limit: limit);
      final mangaList = MangaListResponse.fromJson(response);
      topRankedManga.value = mangaList.data;
      return mangaList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<MangaBase>> fetchPopularManga({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getPopularManga(limit: limit);
      final mangaList = MangaListResponse.fromJson(response);
      popularManga.value = mangaList.data;
      return mangaList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<MangaBase>> fetchPopularManhwa({int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getPopularManhwa(limit: limit);
      final mangaList = MangaListResponse.fromJson(response);
      popularManhwa.value = mangaList.data;
      return mangaList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<AnimeDetailed> getAnimeDetails(int animeId) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getAnimeDetails(animeId);
      final detailsList = AnimeDetailed.fromJson(response);
      animeDetails.value = detailsList;
      return detailsList;
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<MangaDetailed> getMangaDetails(int mangaId) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.getMangaDetails(mangaId);
      return MangaDetailed.fromJson(response);
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<AnimeBase>> searchAnime(String query, {int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.searchAnime(query, limit: limit);
      final animeList = AnimeListResponse.fromJson(response);
      return animeList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<MangaBase>> searchManga(String query, {int limit = 10}) async {
    try {
      isLoading.value = true;
      final response = await MALApiClient.searchManga(query, limit: limit);
      final mangaList = MangaListResponse.fromJson(response);
      return mangaList.data;
    } catch (e) {
      error.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }
}
