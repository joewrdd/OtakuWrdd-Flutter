import 'dart:convert';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsItem {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String source;
  final DateTime publishedAt;

  NewsItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.source,
    required this.publishedAt,
  });
}

class FeedController extends GetxController {
  static FeedController get instance => Get.find();

  final RxList<NewsItem> animeNews = <NewsItem>[].obs;
  final RxList<NewsItem> mangaNews = <NewsItem>[].obs;
  final RxList<NewsItem> allNews = <NewsItem>[].obs;

  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;
  final RxBool showAnimeNews = true.obs;
  final RxBool showMangaNews = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllNews();
  }

  Future<void> fetchAllNews() async {
    try {
      isLoading.value = true;
      error.value = '';

      animeNews.clear();
      mangaNews.clear();

      await fetchAniListNews();

      _sortNewsByDate();

      updateAllNews();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAniListNews() async {
    try {
      final url = Uri.parse('https://graphql.anilist.co');

      final query = '''
      query {
        # Get trending anime
        trendingAnime: Page(page: 1, perPage: 50) {
          media(sort: TRENDING_DESC, type: ANIME) {
            id
            title {
              romaji
              english
            }
            description
            coverImage {
              large
              extraLarge
            }
            siteUrl
            averageScore
            popularity
            trending
            status
            startDate {
              year
              month
              day
            }
          }
        }
        
        # Get trending manga
        trendingManga: Page(page: 1, perPage: 50) {
          media(sort: TRENDING_DESC, type: MANGA) {
            id
            title {
              romaji
              english
            }
            description
            coverImage {
              large
              extraLarge
            }
            siteUrl
            averageScore
            popularity
            trending
            status
            startDate {
              year
              month
              day
            }
          }
        }
      }
      ''';

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'query': query}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final animeItems = data['data']['trendingAnime']['media'] as List;
        for (var item in animeItems) {
          try {
            final title =
                item['title']['english'] ??
                item['title']['romaji'] ??
                'New Anime';
            final description = _cleanDescription(
              item['description'] ?? 'No description available',
            );
            final imageUrl =
                item['coverImage']['extraLarge'] ??
                item['coverImage']['large'] ??
                '';
            final url = item['siteUrl'] ?? '';
            final score = item['averageScore']?.toString() ?? 'N/A';
            final status = item['status'] ?? 'Unknown';
            final trending = item['trending'] ?? 0;

            final newsItem = NewsItem(
              title: title,
              description:
                  'Score: $score | Status: $status | Trending: $trending\n\n$description',
              imageUrl: imageUrl,
              url: url,
              source: 'AniList',
              publishedAt: _parseDate(item['startDate']),
            );

            animeNews.add(newsItem);
          } catch (e) {
            Loaders.errorSnackBar(title: 'Error fetching anime news');
          }
        }

        final mangaItems = data['data']['trendingManga']['media'] as List;
        for (var item in mangaItems) {
          try {
            final title =
                item['title']['english'] ??
                item['title']['romaji'] ??
                'New Manga';
            final description = _cleanDescription(
              item['description'] ?? 'No description available',
            );
            final imageUrl =
                item['coverImage']['extraLarge'] ??
                item['coverImage']['large'] ??
                '';
            final url = item['siteUrl'] ?? '';
            final score = item['averageScore']?.toString() ?? 'N/A';
            final status = item['status'] ?? 'Unknown';
            final trending = item['trending'] ?? 0;

            final newsItem = NewsItem(
              title: title,
              description:
                  'Score: $score | Status: $status | Trending: $trending\n\n$description',
              imageUrl: imageUrl,
              url: url,
              source: 'AniList',
              publishedAt: _parseDate(item['startDate']),
            );

            mangaNews.add(newsItem);
          } catch (e) {
            Loaders.errorSnackBar(title: 'Error fetching manga news');
          }
        }
      } else {
        Loaders.errorSnackBar(title: 'Failed to load AniList data');
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error fetching AniList news');
    }
  }

  DateTime _parseDate(Map<String, dynamic>? dateMap) {
    final now = DateTime.now();

    if (dateMap == null || dateMap['year'] == null) {
      final randomDays = (DateTime.now().millisecondsSinceEpoch % 30).toInt();
      return now.subtract(Duration(days: randomDays));
    }

    try {
      final date = DateTime(
        dateMap['year'] ?? now.year,
        dateMap['month'] ?? now.month,
        dateMap['day'] ?? now.day,
      );

      if (date.isAfter(now)) {
        return now.subtract(const Duration(days: 1)); // Yesterday
      }

      return date;
    } catch (e) {
      return now.subtract(Duration(days: now.weekday));
    }
  }

  String _cleanDescription(String description) {
    description = description.replaceAll(RegExp(r'<[^>]*>'), '');
    description = description
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&nbsp;', ' ');
    return description;
  }

  void updateAllNews() {
    final List<NewsItem> combined = [];

    if (showAnimeNews.value) {
      combined.addAll(animeNews);
    }

    if (showMangaNews.value) {
      combined.addAll(mangaNews);
    }

    combined.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    allNews.value = combined;
  }

  void toggleAnimeNews(bool value) {
    showAnimeNews.value = value;
    updateAllNews();
  }

  void toggleMangaNews(bool value) {
    showMangaNews.value = value;
    updateAllNews();
  }

  void _sortNewsByDate() {
    animeNews.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    mangaNews.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  Future<void> refreshNews() async {
    await fetchAllNews();
  }
}
