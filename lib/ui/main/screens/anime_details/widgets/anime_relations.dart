import 'package:OtakuWrdd/ui/main/controllers/anime_details_controller.dart';
import 'package:OtakuWrdd/ui/main/screens/discover/widgets/cover_image_text.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/vertical_cover_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimeRelations extends StatelessWidget {
  const AnimeRelations({super.key, required this.animeDetailsController});

  final AnimeDetailsController animeDetailsController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Obx(() {
        if (animeDetailsController.isLoading.value) {
          return const VerticalCoverShimmer(scrollDirection: Axis.horizontal);
        }

        final relatedMedia = animeDetailsController.getRelatedMedia();

        final filteredMedia =
            relatedMedia.where((media) {
              return media.title.isNotEmpty &&
                  media.mainPicture != null &&
                  media.mainPicture!.medium != ConstantImages.errorCover;
            }).toList();

        if (filteredMedia.isEmpty) {
          return const Center(
            child: Text(
              "No Related Media Found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.separated(
          itemCount: filteredMedia.length,
          separatorBuilder:
              (context, index) =>
                  const SizedBox(width: ConstantSizes.spaceBtwItems / 2),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final media = filteredMedia[index];
            return CoverImageText(
              text: media.title,
              imageUrl:
                  media.mainPicture?.medium ??
                  media.mainPicture?.large ??
                  ConstantImages.errorCover,
              onTap: () => animeDetailsController.navigateToRelatedMedia(media),
              subtitle: media.relationTypeFormatted,
            );
          },
        );
      }),
    );
  }
}
