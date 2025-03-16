import 'package:OtakuWrdd/ui/main/screens/manga_details/widgets/manga_stat_item.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:flutter/material.dart';

class MangaStatsRow extends StatelessWidget {
  final MangaDetailed manga;

  const MangaStatsRow({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const SizedBox(height: 2),
            StatItem(
              label: 'AVERAGE SCORE',
              value: '${(manga.mean * 10).toInt()}%',
              subtitle: '',
            ),
          ],
        ),
        StatItem(
          label: 'HIGHEST RATED',
          value: '#${manga.rank > 0 ? manga.rank.toString() : "N/A"}',
          subtitle: 'All Time',
        ),
        StatItem(
          label: 'MOST POPULAR',
          value:
              '#${manga.popularity > 0 ? manga.popularity.toString() : "N/A"}',
          subtitle: 'All Time',
        ),
      ],
    );
  }
}
