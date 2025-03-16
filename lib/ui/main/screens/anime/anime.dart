import 'dart:ui';

import 'package:OtakuWrdd/common/widgets/design/search_bar.dart';
import 'package:OtakuWrdd/ui/main/controllers/anime_list_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/search_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/anime/widgets/anime_list_section.dart';
import 'package:OtakuWrdd/ui/main/screens/anime/widgets/sorting.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AnimeScreen extends StatelessWidget {
  const AnimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = Get.put(DiscoverScrollController());
    final searchController = Get.put(CustomSearchController());
    final animeListController = Get.put(AnimeListController());
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
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    'Anime',
                    style: GoogleFonts.notoSans(
                      color: ConstantColors.sixth,
                      fontSize: 15.3,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(
                      Iconsax.filter,
                      color: ConstantColors.sixth,
                      size: 20,
                    ),
                    onPressed: () {
                      showSortingOptions(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: ConstantSizes.spaceBtwItems),
            CustomSearchContainer(
              text: 'Filter By Name',
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
          // Background
          SvgPicture.asset(
            ConstantImages.mainBackground,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Anime lists
          Obx(
            () => ListView(
              controller: scrollController.scrollController,
              padding: EdgeInsets.only(
                top: ConstantSizes.appBarHeight * 2.8,
                bottom: 7,
              ),
              children: [
                // Watching section
                AnimeListSection(
                  title: 'Watching',
                  sectionKey: 'watching',
                  animeList: animeListController.watchingList,
                  isVisible: animeListController.isWatchingVisible,
                  count: animeListController.watchingList.length,
                ),

                // Completed section
                AnimeListSection(
                  title: 'Completed',
                  sectionKey: 'completed',
                  animeList: animeListController.completedList,
                  isVisible: animeListController.isCompletedVisible,
                  count: animeListController.completedList.length,
                ),

                // Plan to Watch section
                AnimeListSection(
                  title: 'Plan To Watch',
                  sectionKey: 'planToWatch',
                  animeList: animeListController.planToWatchList,
                  isVisible: animeListController.isPlanToWatchVisible,
                  count: animeListController.planToWatchList.length,
                ),

                // On Hold section (if not empty)
                if (animeListController.onHoldList.isNotEmpty)
                  AnimeListSection(
                    title: 'On Hold',
                    sectionKey: 'onHold',
                    animeList: animeListController.onHoldList,
                    isVisible: animeListController.isOnHoldVisible,
                    count: animeListController.onHoldList.length,
                  ),

                // Dropped section (if not empty)
                if (animeListController.droppedList.isNotEmpty)
                  AnimeListSection(
                    title: 'Dropped',
                    sectionKey: 'dropped',
                    animeList: animeListController.droppedList,
                    isVisible: animeListController.isDroppedVisible,
                    count: animeListController.droppedList.length,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
