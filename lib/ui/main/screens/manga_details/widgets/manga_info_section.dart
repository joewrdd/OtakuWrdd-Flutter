import 'package:OtakuWrdd/ui/main/screens/manga_details/widgets/manga_info_row.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MangaInfoSection extends StatelessWidget {
  final MangaDetailed manga;

  const MangaInfoSection({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SERIES INFO',
            style: GoogleFonts.lato(
              color: ConstantColors.white.withOpacity(0.6),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          if (manga.startDate != null) ...[
            InfoRow(label: 'Start Date', value: _formatDate(manga.startDate!)),
          ],
          if (manga.endDate != null) ...[
            InfoRow(label: 'End Date', value: _formatDate(manga.endDate!)),
          ],
          InfoRow(label: 'Status', value: manga.status.toUpperCase()),
          InfoRow(
            label: 'Chapters',
            value: manga.numChapters > 0 ? manga.numChapters.toString() : 'TBA',
          ),
          if (manga.authors.isNotEmpty)
            InfoRow(
              label: 'Authors',
              value: manga.authors.map((s) => s.fullName).join(', '),
            ),
          if (manga.genres.isNotEmpty)
            InfoRow(
              label: 'Genres',
              value: manga.genres.map((g) => g.name).join(', '),
            ),
          if (manga.alternativeTitles.en != null ||
              manga.alternativeTitles.ja != null ||
              (manga.alternativeTitles.synonyms?.isNotEmpty ?? false)) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Other Names',
                      style: GoogleFonts.lato(
                        color: ConstantColors.white.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (manga.alternativeTitles.en != null &&
                            manga.alternativeTitles.en!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              manga.alternativeTitles.en!,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                color: ConstantColors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (manga.alternativeTitles.ja != null &&
                            manga.alternativeTitles.ja!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              manga.alternativeTitles.ja!,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                color: ConstantColors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (manga.alternativeTitles.synonyms?.isNotEmpty ??
                            false)
                          ...manga.alternativeTitles.synonyms!.map(
                            (synonym) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                synonym,
                                overflow: TextOverflow.ellipsis,
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
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
