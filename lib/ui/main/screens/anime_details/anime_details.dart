import 'package:OtakuWrdd/common/widgets/appbar/appbar.dart';
import 'package:OtakuWrdd/common/widgets/design/rounded_image.dart';
import 'package:OtakuWrdd/common/widgets/icons/favorite_icon.dart';
import 'package:OtakuWrdd/ui/main/controllers/anime_details_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/widgets/anime_action_buttons.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/widgets/anime_characters.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/widgets/anime_info_section.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/widgets/anime_relations.dart';
import 'package:OtakuWrdd/ui/main/screens/anime_details/widgets/anime_stats_row.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OtakuWrdd/utils/shimmers/horizontal_episode_shimmer.dart';

class AnimeDetailsScreen extends StatelessWidget {
  const AnimeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final animeDetailsController = Get.put(AnimeDetailsController());
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        showBackArrow: true,
        actions: [
          Obx(() {
            if (animeDetailsController.isLoading.value ||
                animeDetailsController.animeDetails.value.id <= 0) {
              return const SizedBox.shrink();
            }

            return FavoriteIcon(
              animeId: animeDetailsController.animeDetails.value.id.toString(),
              mangaId: "0",
              isAnime: true,
            );
          }),
        ],
      ),
      body: Obx(() {
        final anime = animeDetailsController.animeDetails.value;
        //----- Loader -----
        if (animeDetailsController.isLoading.value) {
          return Stack(
            children: [
              SvgPicture.asset(
                ConstantImages.mainBackground,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.5),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.darken,
                child: Image.network(
                  anime.mainPicture.large.isNotEmpty
                      ? anime.mainPicture.large
                      : anime.mainPicture.medium,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey[900]);
                  },
                ),
              ),
            ),
            CustomScrollView(
              controller: ScrollController(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: ConstantSizes.appBarHeight * 2),
                      Center(
                        child: Column(
                          children: [
                            CustomRoundedImage(
                              imageUrl:
                                  anime.mainPicture.large.isNotEmpty
                                      ? anime.mainPicture.large
                                      : anime.mainPicture.medium,
                              isNetworkImage: true,
                              height: 200,
                              width: 140,
                              fit: BoxFit.cover,
                              backgroundColor: Colors.black12,
                            ),
                            const SizedBox(height: ConstantSizes.spaceBtwItems),

                            //----- Title -----
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                anime.title,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  color: ConstantColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25,
                                  height: 1.2,
                                ),
                              ),
                            ),

                            if (anime.studios.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                anime.studios.map((s) => s.name).join(', '),
                                style: GoogleFonts.lato(
                                  color: ConstantColors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                            //----- Stats Section -----
                            const SizedBox(height: 24),
                            AnimeStatsRow(anime: anime),

                            //----- Action Buttons -----
                            const SizedBox(height: 24),
                            AnimeActionButtons(anime: anime),

                            //----- Synopsis Section -----
                            if (anime.synopsis.isNotEmpty) ...[
                              const SizedBox(
                                height: ConstantSizes.spaceBtwSections,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SUMMARY',
                                      style: GoogleFonts.lato(
                                        color: ConstantColors.white.withOpacity(
                                          0.6,
                                        ),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      anime.synopsis,
                                      style: GoogleFonts.lato(
                                        color: ConstantColors.white,
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(
                              height: ConstantSizes.spaceBtwSections,
                            ),
                            Divider(endIndent: 20, indent: 20),
                            //----- Information Section ------
                            const SizedBox(
                              height: ConstantSizes.spaceBtwSections,
                            ),
                            AnimeInfoSection(anime: anime),
                            const SizedBox(
                              height: ConstantSizes.spaceBtwSections,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RELATIONS',
                                    style: GoogleFonts.lato(
                                      color: ConstantColors.white.withOpacity(
                                        0.6,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  AnimeRelations(
                                    animeDetailsController:
                                        animeDetailsController,
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwSections,
                                  ),
                                  Text(
                                    'CHARACTERS',
                                    style: GoogleFonts.lato(
                                      color: ConstantColors.white.withOpacity(
                                        0.6,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  AnimeCharacters(
                                    animeDetailsController:
                                        animeDetailsController,
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwSections,
                                  ),
                                  Text(
                                    'TRAILER',
                                    style: GoogleFonts.lato(
                                      color: ConstantColors.white.withOpacity(
                                        0.6,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwSections / 2,
                                  ),
                                  GestureDetector(
                                    onTap:
                                        () => animeDetailsController.launchURL(
                                          animeDetailsController
                                              .getTrailerUrl(),
                                        ),
                                    child: Stack(
                                      children: [
                                        CustomRoundedImage(
                                          width: 400,
                                          height: 220,
                                          imageUrl:
                                              animeDetailsController
                                                  .getYouTubeThumbnail(),
                                          isNetworkImage: true,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          width: 400,
                                          height: 220,
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                        Positioned.fill(
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(
                                                  0.5,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: ConstantColors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwSections,
                                  ),
                                  Obx(() {
                                    if (animeDetailsController
                                        .isLoadingEpisodes
                                        .value) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'EPISODES (AVAILABLE ON CRUNCHYROLL)',
                                            style: GoogleFonts.lato(
                                              color: ConstantColors.white
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height:
                                                ConstantSizes.spaceBtwSections /
                                                2,
                                          ),
                                          const HorizontalEpisodeShimmer(),
                                        ],
                                      );
                                    }

                                    if (animeDetailsController
                                        .episodes
                                        .isNotEmpty) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'EPISODES (AVAILABLE ON CRUNCHYROLL)',
                                            style: GoogleFonts.lato(
                                              color: ConstantColors.white
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height:
                                                ConstantSizes.spaceBtwSections /
                                                2,
                                          ),
                                          SizedBox(
                                            height: 155,
                                            child: ListView.separated(
                                              padding: EdgeInsets.zero,
                                              itemCount:
                                                  animeDetailsController
                                                      .episodes
                                                      .length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                        width:
                                                            ConstantSizes
                                                                .spaceBtwItems,
                                                      ),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                final episode =
                                                    animeDetailsController
                                                        .episodes[index];
                                                return GestureDetector(
                                                  onTap:
                                                      () =>
                                                          animeDetailsController
                                                              .launchURL(
                                                                episode.url,
                                                              ),
                                                  child: Stack(
                                                    children: [
                                                      CustomRoundedImage(
                                                        width: 275,
                                                        height: 155,
                                                        imageUrl:
                                                            episode.imageUrl,
                                                        isNetworkImage: true,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Container(
                                                        width: 275,
                                                        height: 155,
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin:
                                                                Alignment
                                                                    .topCenter,
                                                            end:
                                                                Alignment
                                                                    .bottomCenter,
                                                            colors: [
                                                              Colors
                                                                  .transparent,
                                                              Colors.black
                                                                  .withOpacity(
                                                                    0.8,
                                                                  ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 8,
                                                        left: 8,
                                                        child: Text(
                                                          'Episode ${episode.number}',
                                                          style:
                                                              GoogleFonts.lato(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwSections,
                                  ),
                                  Text(
                                    'EXTERNAL LINKS',
                                    style: GoogleFonts.lato(
                                      color: ConstantColors.white.withOpacity(
                                        0.6,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwSections / 2,
                                  ),
                                  Row(
                                    children: [
                                      CustomRoundedImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl: ConstantImages.githubIcon,
                                      ),
                                      const SizedBox(width: 10),
                                      CustomRoundedImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl: ConstantImages.crunchyroll,
                                        backgroundColor: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      CustomRoundedImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl: ConstantImages.bilibili,
                                        backgroundColor: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      CustomRoundedImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl: ConstantImages.twitterIcon,
                                        backgroundColor: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      CustomRoundedImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl: ConstantImages.discordIcon,
                                        backgroundColor: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      CustomRoundedImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl: ConstantImages.tiktok,
                                        backgroundColor: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: ConstantSizes.spaceBtwSections,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
