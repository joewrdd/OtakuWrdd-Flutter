import 'package:OtakuWrdd/ui/main/controllers/anime_details_controller.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimeActionButtons extends StatelessWidget {
  final AnimeDetailed anime;

  const AnimeActionButtons({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeDetailsController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showWatchStatusPicker(context, controller),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800]?.withOpacity(0.7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: BorderSide(
                      color: ConstantColors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  controller.watchStatus!.value == 'None'
                      ? 'ADD TO LIST'
                      : controller.watchStatus!.value.toUpperCase(),
                  style: GoogleFonts.lato(
                    color: ConstantColors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed:
                    () => _showEpisodesPicker(context, controller, anime),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800]?.withOpacity(0.7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: BorderSide(
                      color: ConstantColors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  '${controller.episodesWatched!.value} / ${anime.numEpisodes} EP',
                  style: GoogleFonts.lato(
                    color: ConstantColors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showScorePicker(context, controller),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800]?.withOpacity(0.7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: BorderSide(
                      color: ConstantColors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  controller.userScore!.value > 0
                      ? '${controller.userScore!.value}/5'
                      : 'NOT SCORED',
                  style: GoogleFonts.lato(
                    color: ConstantColors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showScorePicker(
    BuildContext context,
    AnimeDetailsController controller,
  ) {
    int selectedScore = controller.userScore!.value;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Score',
                style: GoogleFonts.lato(
                  color: ConstantColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          controller.userScore!.value = index + 1;
                          selectedScore = index + 1;
                        },
                        child: Icon(
                          index < controller.userScore!.value
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.userScore!.value = selectedScore;
                    controller.saveAnimeToUserList();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800]?.withOpacity(0.7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: BorderSide(
                        color: ConstantColors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: GoogleFonts.lato(
                      color: ConstantColors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showWatchStatusPicker(
    BuildContext context,
    AnimeDetailsController controller,
  ) {
    final statuses = [
      'None',
      'Watching',
      'Completed',
      'Plan to Watch',
      'On Hold',
      'Dropped',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                statuses.map((status) {
                  return ListTile(
                    title: Text(
                      status,
                      style: GoogleFonts.lato(color: ConstantColors.white),
                    ),
                    onTap: () {
                      controller.watchStatus!.value = status;

                      if (status == 'Completed') {
                        controller.episodesWatched!.value = anime.numEpisodes;
                      }

                      controller.saveAnimeToUserList();
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  void _showEpisodesPicker(
    BuildContext context,
    AnimeDetailsController controller,
    AnimeDetailed anime,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.episodesWatched!.value > 0) {
                        controller.episodesWatched!.value--;
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[800]?.withOpacity(0.7),
                      radius: 24,
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Obx(
                    () => Text(
                      '${controller.episodesWatched!.value}',
                      style: GoogleFonts.lato(
                        color: ConstantColors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      if (controller.episodesWatched!.value <
                          anime.numEpisodes) {
                        controller.episodesWatched!.value++;
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[800]?.withOpacity(0.7),
                      radius: 24,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Auto-update watch status based on episode count
                    if (controller.episodesWatched!.value ==
                        anime.numEpisodes) {
                      controller.watchStatus!.value = 'Completed';
                    } else if (controller.episodesWatched!.value > 0 &&
                        controller.watchStatus!.value == 'Plan to Watch') {
                      controller.watchStatus!.value = 'Watching';
                    }

                    controller.saveAnimeToUserList();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800]?.withOpacity(0.7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: BorderSide(
                        color: ConstantColors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: GoogleFonts.lato(
                      color: ConstantColors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
