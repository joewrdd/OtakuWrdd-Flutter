import 'package:cloud_firestore/cloud_firestore.dart';

class UserAnimeModel {
  final int animeId;
  final String title;
  final String imageUrl;
  final String status;
  final int episodesWatched;
  final int totalEpisodes;
  final double? rating;
  final DateTime lastUpdated;
  final String? notes;

  UserAnimeModel({
    required this.animeId,
    required this.title,
    required this.imageUrl,
    required this.status,
    required this.episodesWatched,
    required this.totalEpisodes,
    this.rating,
    required this.lastUpdated,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'animeId': animeId,
      'title': title,
      'imageUrl': imageUrl,
      'status': status,
      'episodesWatched': episodesWatched,
      'totalEpisodes': totalEpisodes,
      'rating': rating,
      'lastUpdated': lastUpdated,
      'notes': notes,
    };
  }

  factory UserAnimeModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return UserAnimeModel(
      animeId: data['animeId'],
      title: data['title'],
      imageUrl: data['imageUrl'],
      status: data['status'],
      episodesWatched: data['episodesWatched'],
      totalEpisodes: data['totalEpisodes'],
      rating: data['rating'],
      lastUpdated: (data['lastUpdated'] as Timestamp).toDate(),
      notes: data['notes'],
    );
  }
}
