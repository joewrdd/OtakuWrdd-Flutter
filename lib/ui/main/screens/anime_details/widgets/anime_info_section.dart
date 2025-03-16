import 'package:OtakuWrdd/ui/main/screens/anime_details/widgets/info_row.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimeInfoSection extends StatelessWidget {
  final AnimeDetailed anime;

  const AnimeInfoSection({super.key, required this.anime});

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
          if (anime.startDate != null) ...[
            InfoRow(label: 'Start Date', value: _formatDate(anime.startDate!)),
          ],
          if (anime.endDate != null) ...[
            InfoRow(label: 'End Date', value: _formatDate(anime.endDate!)),
          ],
          InfoRow(label: 'Status', value: anime.status.toUpperCase()),
          InfoRow(
            label: 'Episodes',
            value: anime.numEpisodes > 0 ? anime.numEpisodes.toString() : 'TBA',
          ),
          if (anime.studios.isNotEmpty)
            InfoRow(
              label: 'Studios',
              value: anime.studios.map((s) => s.name).join(', '),
            ),
          if (anime.genres.isNotEmpty)
            InfoRow(
              label: 'Genres',
              value: anime.genres.map((g) => g.name).join(', '),
            ),
          if (anime.alternativeTitles.en != null ||
              anime.alternativeTitles.ja != null ||
              (anime.alternativeTitles.synonyms?.isNotEmpty ?? false)) ...[
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
                        if (anime.alternativeTitles.en != null &&
                            anime.alternativeTitles.en!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              anime.alternativeTitles.en!,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                color: ConstantColors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (anime.alternativeTitles.ja != null &&
                            anime.alternativeTitles.ja!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              anime.alternativeTitles.ja!,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                color: ConstantColors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (anime.alternativeTitles.synonyms?.isNotEmpty ??
                            false)
                          ...anime.alternativeTitles.synonyms!.map(
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
