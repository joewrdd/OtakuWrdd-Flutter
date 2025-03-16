import 'package:OtakuWrdd/common/widgets/design/search_bar.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/search_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/anime_details.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/cover_image_text.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/discovery_headers.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/manga_details/manga_details.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/helpers/cloud.dart';
import 'package:OtakuWrdd/utils/shimmers/vertical_cover_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:get/get.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiscoverScrollController());
    final discoverController = Get.put(DiscoverController());
    final searchController = Get.put(CustomSearchController());

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Obx(
          () => ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10 * controller.opacity.value,
                sigmaY: 10 * controller.opacity.value,
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.black.withOpacity(0.2 * controller.opacity.value),
              ),
            ),
          ),
        ),
        titleSpacing: 15,
        toolbarHeight: 100,
        title: Column(
          children: [
            Text(
              'Discover',
              style: GoogleFonts.notoSans(
                color: ConstantColors.sixth,
                fontSize: 15.3,
              ),
            ),
            const SizedBox(height: ConstantSizes.spaceBtwItems),
            CustomSearchContainer(
              text: 'Search anime, manga and more',
              showBorder: false,
              onChanged: (query) {
                if (query.isEmpty) {
                  searchController.clearSearch();
                } else {
                  searchController.handleSearch(query);
                }
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            ConstantImages.mainBackground,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Obx(() {
            //----- SEARCH CONTENT -----
            if (searchController.isSearching.value) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (searchController.animeResults.isNotEmpty) ...[
                            const DiscoveryHeaders(text: 'ANIME'),
                            SizedBox(
                              height: 250,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: searchController.animeResults.length,
                                separatorBuilder:
                                    (_, __) => const SizedBox(
                                      width: ConstantSizes.spaceBtwItems / 2,
                                    ),
                                itemBuilder: (context, index) {
                                  final anime =
                                      searchController.animeResults[index];
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
                              ),
                            ),
                          ],
                          if (searchController.mangaResults.isNotEmpty) ...[
                            const SizedBox(
                              height: ConstantSizes.spaceBtwSections,
                            ),
                            const DiscoveryHeaders(text: 'MANGA'),
                            SizedBox(
                              height: 250,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: searchController.mangaResults.length,
                                separatorBuilder:
                                    (_, __) => const SizedBox(
                                      width: ConstantSizes.spaceBtwItems / 2,
                                    ),
                                itemBuilder: (context, index) {
                                  final manga =
                                      searchController.mangaResults[index];
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
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            //----- REGULAR CONTENT
            return CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 5.0,
                      right: 16.0,
                      top: ConstantSizes.appBarHeight * 3.3,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DiscoveryHeaders(text: 'CURRENTLY TRENDING ANIME'),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<AnimeBase>>(
                            future: discoverController.fetchTrendingAnime(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .trendingAnime
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final anime =
                                        discoverController
                                            .trendingAnime
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        DiscoveryHeaders(text: 'CURRENT SEASON - SPRING 2025'),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<AnimeBase>>(
                            future:
                                discoverController.fetchCurrentSeasonAnime(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .currentSeasonAnime
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final anime =
                                        discoverController
                                            .currentSeasonAnime
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        DiscoveryHeaders(
                          text: 'UPCOMING SEASON - ${_getUpcomingSeasonText()}',
                        ),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<AnimeBase>>(
                            future: discoverController.fetchUpcomingAnime(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .upcomingAnime
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final anime =
                                        discoverController
                                            .upcomingAnime
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        DiscoveryHeaders(text: 'TOP RANKED ANIME'),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<AnimeBase>>(
                            future: discoverController.fetchTopRankedAnime(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .topRankedAnime
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final anime =
                                        discoverController
                                            .topRankedAnime
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        DiscoveryHeaders(text: 'TOP RANKED ANIME MOVIES'),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<AnimeBase>>(
                            future: discoverController.fetchTopRankedMovies(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .topRankedMovies
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final anime =
                                        discoverController
                                            .topRankedMovies
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        DiscoveryHeaders(text: 'POPULAR ANIME'),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<AnimeBase>>(
                            future: discoverController.fetchPopularAnime(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .popularAnime
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final anime =
                                        discoverController
                                            .popularAnime
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        DiscoveryHeaders(text: 'CURRENTLY TRENDING MANGA'),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<MangaBase>>(
                            future: discoverController.fetchTrendingManga(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .trendingManga
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final manga =
                                        discoverController
                                            .trendingManga
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        DiscoveryHeaders(text: 'TOP RANKED MANGA'),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<MangaBase>>(
                            future: discoverController.fetchTopRankedManga(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .topRankedManga
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final manga =
                                        discoverController
                                            .topRankedManga
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        DiscoveryHeaders(text: 'POPULAR MANGA'),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<MangaBase>>(
                            future: discoverController.fetchPopularManga(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .popularManga
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final manga =
                                        discoverController
                                            .popularManga
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                        DiscoveryHeaders(text: 'POPULAR MANHWA'),
                        SizedBox(
                          height: 250,
                          child: FutureBuilder<List<MangaBase>>(
                            future: discoverController.fetchPopularManhwa(),
                            builder: (context, snapshot) {
                              const loader = VerticalCoverShimmer(
                                scrollDirection: Axis.horizontal,
                              );
                              final widget =
                                  CloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                  );
                              if (widget != null) return widget;

                              return Obx(
                                () => ListView.separated(
                                  itemCount:
                                      discoverController
                                          .popularManhwa
                                          .value
                                          .length,
                                  separatorBuilder:
                                      (context, index) => const SizedBox(
                                        width: ConstantSizes.spaceBtwItems / 2,
                                      ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final manga =
                                        discoverController
                                            .popularManhwa
                                            .value[index];
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
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: ConstantSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  String _getUpcomingSeasonText() {
    final now = DateTime.now();
    final month = now.month;
    final year = now.year;

    if (month >= 1 && month <= 3) return 'SUMMER $year';
    if (month >= 4 && month <= 6) return 'SUMMER $year';
    if (month >= 7 && month <= 9) return 'FALL $year';
    return 'WINTER ${year + 1}';
  }
}
