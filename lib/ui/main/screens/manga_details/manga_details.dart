import 'package:OtakuWrdd/common/widgets/appbar/appbar.dart';
import 'package:OtakuWrdd/common/widgets/design/rounded_image.dart';
import 'package:OtakuWrdd/common/widgets/icons/favorite_icon.dart';
import 'package:OtakuWrdd/ui/main/controllers/manga_details_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/manga_details/widgets/manga_action_buttons.dart';
import 'package:OtakuWrdd/ui/main/screens/manga_details/widgets/manga_characters.dart';
import 'package:OtakuWrdd/ui/main/screens/manga_details/widgets/manga_info_section.dart';
import 'package:OtakuWrdd/ui/main/screens/manga_details/widgets/manga_relations.dart';
import 'package:OtakuWrdd/ui/main/screens/manga_details/widgets/manga_stats_row.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaDetailsScreen extends StatelessWidget {
  const MangaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mangaDetailsController = Get.put(MangaDetailsController());
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        showBackArrow: true,
        actions: [
          Obx(() {
            if (mangaDetailsController.isLoading.value ||
                mangaDetailsController.mangaDetails.value.id <= 0) {
              return const SizedBox.shrink();
            }

            return FavoriteIcon(
              animeId: "0",
              mangaId: mangaDetailsController.mangaDetails.value.id.toString(),
              isAnime: false,
            );
          }),
        ],
      ),
      body: Obx(() {
        final manga = mangaDetailsController.mangaDetails.value;
        //----- Loader -----
        if (mangaDetailsController.isLoading.value) {
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
                  manga.mainPicture.large.isNotEmpty
                      ? manga.mainPicture.large
                      : manga.mainPicture.medium,
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
                                  manga.mainPicture.large.isNotEmpty
                                      ? manga.mainPicture.large
                                      : manga.mainPicture.medium,
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
                                manga.title,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  color: ConstantColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25,
                                  height: 1.2,
                                ),
                              ),
                            ),

                            if (manga.authors.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                manga.authors.map((s) => s.fullName).join(', '),
                                style: GoogleFonts.lato(
                                  color: ConstantColors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                            //----- Stats Section -----
                            const SizedBox(height: 24),
                            MangaStatsRow(manga: manga),

                            //----- Action Buttons -----
                            const SizedBox(height: 24),
                            MangaActionButtons(manga: manga),

                            //----- Synopsis Section -----
                            if (manga.synopsis.isNotEmpty) ...[
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
                                      manga.synopsis,
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
                            MangaInfoSection(manga: manga),
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
                                  MangaRelations(
                                    mangaDetailsController:
                                        mangaDetailsController,
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
                                  MangaCharacters(
                                    mangaDetailsController:
                                        mangaDetailsController,
                                  ),
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
