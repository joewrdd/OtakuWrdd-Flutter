import 'package:OtakuWrdd/ui/main/controllers/manga_details_controller.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaActionButtons extends StatelessWidget {
  final MangaDetailed manga;

  const MangaActionButtons({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MangaDetailsController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showReadStatusPicker(context, controller),
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
                  controller.readStatus!.value == 'None'
                      ? 'ADD TO LIST'
                      : controller.readStatus!.value.toUpperCase(),
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
                    () => _showProgressPicker(context, controller, manga),
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
                  _getProgressText(manga, controller),
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

  String _getProgressText(
    MangaDetailed manga,
    MangaDetailsController controller,
  ) {
    if (manga.numChapters > 0) {
      return '${controller.chaptersRead!.value} / ${manga.numChapters} CH';
    } else if (manga.numVolumes > 0) {
      return '${controller.volumesRead!.value} / ${manga.numVolumes} VOL';
    } else {
      return 'NO DATA';
    }
  }

  void _showScorePicker(
    BuildContext context,
    MangaDetailsController controller,
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
                    controller.saveMangaToUserList();
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

  void _showReadStatusPicker(
    BuildContext context,
    MangaDetailsController controller,
  ) {
    final statuses = [
      'None',
      'Reading',
      'Completed',
      'Plan to Read',
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
                      controller.readStatus!.value = status;

                      if (status == 'Completed') {
                        if (manga.numChapters > 0) {
                          controller.chaptersRead!.value = manga.numChapters;
                        }
                        if (manga.numVolumes > 0) {
                          controller.volumesRead!.value = manga.numVolumes;
                        }
                      }

                      controller.saveMangaToUserList();
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  void _showProgressPicker(
    BuildContext context,
    MangaDetailsController controller,
    MangaDetailed manga,
  ) {
    bool showChapters = manga.numChapters > 0;

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
                showChapters ? 'Chapters Read' : 'Volumes Read',
                style: GoogleFonts.lato(
                  color: ConstantColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (showChapters) {
                        if (controller.chaptersRead!.value > 0) {
                          controller.chaptersRead!.value--;
                        }
                      } else {
                        if (controller.volumesRead!.value > 0) {
                          controller.volumesRead!.value--;
                        }
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
                      showChapters
                          ? '${controller.chaptersRead!.value}'
                          : '${controller.volumesRead!.value}',
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
                      if (showChapters) {
                        if (controller.chaptersRead!.value <
                            manga.numChapters) {
                          controller.chaptersRead!.value++;
                        }
                      } else {
                        if (controller.volumesRead!.value < manga.numVolumes) {
                          controller.volumesRead!.value++;
                        }
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
                    // Auto-update read status based on progress
                    if (showChapters &&
                        controller.chaptersRead!.value == manga.numChapters) {
                      controller.readStatus!.value = 'Completed';
                    } else if (!showChapters &&
                        controller.volumesRead!.value == manga.numVolumes) {
                      controller.readStatus!.value = 'Completed';
                    } else if ((showChapters &&
                            controller.chaptersRead!.value > 0) ||
                        (!showChapters && controller.volumesRead!.value > 0)) {
                      if (controller.readStatus!.value == 'Plan to Read') {
                        controller.readStatus!.value = 'Reading';
                      }
                    }

                    controller.saveMangaToUserList();
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
