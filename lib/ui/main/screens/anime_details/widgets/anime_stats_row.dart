import 'package:OtakuWrdd/ui/main/screens/anime_details/widgets/stat_item.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:flutter/material.dart';

class AnimeStatsRow extends StatelessWidget {
  final AnimeDetailed anime;

  const AnimeStatsRow({super.key, required this.anime});

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
              value: '${(anime.mean * 10).toInt()}%',
              subtitle: '',
            ),
          ],
        ),
        StatItem(
          label: 'HIGHEST RATED',
          value: '#${anime.rank > 0 ? anime.rank.toString() : "N/A"}',
          subtitle: 'All Time',
        ),
        StatItem(
          label: 'MOST POPULAR',
          value:
              '#${anime.popularity > 0 ? anime.popularity.toString() : "N/A"}',
          subtitle: 'All Time',
        ),
      ],
    );
  }
}
