import 'dart:ui';
import 'package:OtakuWrdd/common/widgets/design/search_bar.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/feed_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/feed/widgets/news_card.dart';
import 'package:OtakuWrdd/ui/main/screens/feed/widgets/news_filter_chip.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/news_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = Get.put(DiscoverScrollController());
    final feedController = Get.put(FeedController());

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
                sigmaX: 10 * scrollController.opacity.value,
                sigmaY: 10 * scrollController.opacity.value,
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.black.withOpacity(
                  0.2 * scrollController.opacity.value,
                ),
              ),
            ),
          ),
        ),
        titleSpacing: 15,
        toolbarHeight: 100,
        title: Column(
          children: [
            Text(
              'Anime & Manga News',
              style: GoogleFonts.notoSans(
                color: ConstantColors.sixth,
                fontSize: 15.3,
              ),
            ),
            const SizedBox(height: ConstantSizes.spaceBtwItems),
            CustomSearchContainer(
              text: 'Search News',
              showBorder: false,
              onChanged: (query) {},
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background
          SvgPicture.asset(
            ConstantImages.mainBackground,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // News Feed
          RefreshIndicator(
            onRefresh: () => feedController.refreshNews(),
            color: ConstantColors.secondary,
            backgroundColor: Colors.black.withOpacity(0.5),
            displacement: 152,
            child: Obx(() {
              if (feedController.isLoading.value &&
                  feedController.allNews.isEmpty) {
                return ListView.builder(
                  controller: scrollController.scrollController,
                  padding: EdgeInsets.only(
                    top: ConstantSizes.appBarHeight * 2.8,
                    left: 16,
                    right: 16,
                    bottom: 80,
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) => const NewsCardShimmer(),
                );
              }

              if (feedController.error.isNotEmpty &&
                  feedController.allNews.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed To Load News',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => feedController.fetchAllNews(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.secondary,
                        ),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }

              return CustomScrollView(
                controller: scrollController.scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: ConstantSizes.appBarHeight * 2.8,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (feedController.isLoading.value == true)
                            const SizedBox(height: 80),

                          // Filter chips
                          Wrap(
                            spacing: 8,
                            children: [
                              NewsFilterChip(
                                label: 'Anime News',
                                selected: feedController.showAnimeNews.value,
                                onSelected:
                                    (value) =>
                                        feedController.toggleAnimeNews(value),
                              ),
                              NewsFilterChip(
                                label: 'Manga News',
                                selected: feedController.showMangaNews.value,
                                onSelected:
                                    (value) =>
                                        feedController.toggleMangaNews(value),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  // News list
                  feedController.allNews.isEmpty
                      ? SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'No news available',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      )
                      : SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final newsItem = feedController.allNews[index];
                            return NewsCard(
                              title: newsItem.title,
                              description: newsItem.description,
                              imageUrl: newsItem.imageUrl,
                              source: newsItem.source,
                              date: newsItem.publishedAt,
                              onTap: () => _launchUrl(newsItem.url),
                            );
                          }, childCount: feedController.allNews.length),
                        ),
                      ),

                  // Bottom padding
                  const SliverToBoxAdapter(child: SizedBox(height: 80)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      await launchUrlString(url);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open the link',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
