import 'package:OtakuWrdd/ui/main/controllers/anime_details_controller.dart';
import 'package:OtakuWrdd/ui/main/controllers/character_details_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/character_details/character_details.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/cover_image_text.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/vertical_cover_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimeCharacters extends StatelessWidget {
  const AnimeCharacters({super.key, required this.animeDetailsController});

  final AnimeDetailsController animeDetailsController;

  @override
  Widget build(BuildContext context) {
    final characterDetailsController = Get.put(CharacterDetailsController());
    return SizedBox(
      height: 250,
      child: Obx(() {
        if (animeDetailsController.isLoadingCharacters.value) {
          return const VerticalCoverShimmer(scrollDirection: Axis.horizontal);
        }

        final charactersList = animeDetailsController.characters;
        final filteredCharacters =
            charactersList.where((character) {
              return !character.image.medium.contains('questionmark_23.gif');
            }).toList();

        if (filteredCharacters.isEmpty) {
          return const Center(
            child: Text(
              "No Character Found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.separated(
          itemCount: filteredCharacters.length,
          separatorBuilder:
              (context, index) =>
                  const SizedBox(width: ConstantSizes.spaceBtwItems / 2),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final character = filteredCharacters[index];
            return CoverImageText(
              text: character.name,
              imageUrl:
                  character.image.medium.isNotEmpty
                      ? character.image.medium
                      : ConstantImages.errorCover,
              onTap: () {
                characterDetailsController.characterDetails.value = character;
                Get.to(
                  () => const CharacterDetailsScreen(),
                  arguments: character.id,
                );
              },
              subtitle: character.role,
            );
          },
        );
      }),
    );
  }
}
