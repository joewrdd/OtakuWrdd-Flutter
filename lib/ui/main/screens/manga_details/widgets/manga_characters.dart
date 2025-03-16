import 'package:OtakuWrdd/ui/main/controllers/manga_details_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/cover_image_text.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/vertical_cover_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MangaCharacters extends StatelessWidget {
  const MangaCharacters({super.key, required this.mangaDetailsController});

  final MangaDetailsController mangaDetailsController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Obx(() {
        if (mangaDetailsController.isLoadingCharacters.value) {
          return const VerticalCoverShimmer(scrollDirection: Axis.horizontal);
        }

        final charactersList = mangaDetailsController.characters;
        final filteredCharacters =
            charactersList.where((character) {
              return !character.image.medium.contains('questionmark_23.gif');
            }).toList();

        if (filteredCharacters.isEmpty) {
          return const Center(
            child: Text(
              "No Characters Available",
              style: TextStyle(color: Colors.white70, fontSize: 14),
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
              onTap: () {},
              subtitle: character.role,
            );
          },
        );
      }),
    );
  }
}
