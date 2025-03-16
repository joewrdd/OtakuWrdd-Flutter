import 'package:OtakuWrdd/common/widgets/appbar/appbar.dart';
import 'package:OtakuWrdd/common/widgets/design/rounded_image.dart';
import 'package:OtakuWrdd/ui/main/controllers/character_details_controller.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final characterDetailsController = Get.put(CharacterDetailsController());

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        showBackArrow: true,
        // actions: [
        //   Obx(() {
        //     if (characterDetailsController.isLoading.value ||
        //         characterDetailsController.characterDetails.value.id <= 0) {
        //       return const SizedBox.shrink();
        //     }

        //     return FavoriteIcon(
        //       animeId: "0",
        //       mangaId: "0",
        //       characterId:
        //           characterDetailsController.characterDetails.value.id
        //               .toString(),
        //       isCharacter: true,
        //     );
        //   }),
        // ],
      ),
      body: Obx(() {
        final character = characterDetailsController.characterDetails.value;

        //----- Loader -----
        if (characterDetailsController.isLoading.value) {
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
                  character.image.large.isNotEmpty
                      ? character.image.large
                      : character.image.medium,
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
                                  character.image.large.isNotEmpty
                                      ? character.image.large
                                      : character.image.medium,
                              isNetworkImage: true,
                              height: 200,
                              width: 140,
                              fit: BoxFit.cover,
                              backgroundColor: Colors.black12,
                            ),
                            const SizedBox(height: ConstantSizes.spaceBtwItems),

                            //----- Name -----
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                character.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  color: ConstantColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25,
                                  height: 1.2,
                                ),
                              ),
                            ),

                            if (character.role.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                character.role,
                                style: GoogleFonts.lato(
                                  color: ConstantColors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                            const SizedBox(height: ConstantSizes.spaceBtwItems),
                            Divider(),
                            const SizedBox(height: ConstantSizes.spaceBtwItems),
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
