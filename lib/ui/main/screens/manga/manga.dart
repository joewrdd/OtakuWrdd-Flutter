import 'dart:ui';
import 'package:OtakuWrdd/common/widgets/design/search_bar.dart';
import 'package:OtakuWrdd/ui/main/controllers/discover_scroll_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/manga_list_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/search_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/anime/widgets/sorting.dart';
import 'package:OtakuWrdd/ui/main/screens/manga/widgets/manga_list_section.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class MangaScreen extends StatelessWidget {
  const MangaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = Get.put(DiscoverScrollController());
    final searchController = Get.put(CustomSearchController());
    final mangaListController = Get.put(MangaListController());
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
                    'Manga',
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
                MangaListSection(
                  title: 'Reading',
                  sectionKey: 'reading',
                  mangaList: mangaListController.readingList,
                  isVisible: mangaListController.isReadingVisible,
                  count: mangaListController.readingList.length,
                ),

                // Completed section
                MangaListSection(
                  title: 'Completed',
                  sectionKey: 'completed',
                  mangaList: mangaListController.completedList,
                  isVisible: mangaListController.isCompletedVisible,
                  count: mangaListController.completedList.length,
                ),

                // Plan to Watch section
                MangaListSection(
                  title: 'Plan To Read',
                  sectionKey: 'planToRead',
                  mangaList: mangaListController.planToReadList,
                  isVisible: mangaListController.isPlanToReadVisible,
                  count: mangaListController.planToReadList.length,
                ),

                // On Hold section (if not empty)
                if (mangaListController.onHoldList.isNotEmpty)
                  MangaListSection(
                    title: 'On Hold',
                    sectionKey: 'onHold',
                    mangaList: mangaListController.onHoldList,
                    isVisible: mangaListController.isOnHoldVisible,
                    count: mangaListController.onHoldList.length,
                  ),

                // Dropped section (if not empty)
                if (mangaListController.droppedList.isNotEmpty)
                  MangaListSection(
                    title: 'Dropped',
                    sectionKey: 'dropped',
                    mangaList: mangaListController.droppedList,
                    isVisible: mangaListController.isDroppedVisible,
                    count: mangaListController.droppedList.length,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
