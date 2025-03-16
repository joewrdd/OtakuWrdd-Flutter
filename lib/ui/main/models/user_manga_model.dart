import 'package:cloud_firestore/cloud_firestore.dart';

class UserMangaModel {
  final int mangaId;
  final String title;
  final String imageUrl;
  final String status;
  final int chaptersRead;
  final int totalChapters;
  final double? rating;
  final DateTime lastUpdated;
  final String? notes;

  UserMangaModel({
    required this.mangaId,
    required this.title,
    required this.imageUrl,
    required this.status,
    required this.chaptersRead,
    required this.totalChapters,
    this.rating,
    required this.lastUpdated,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'mangaId': mangaId,
      'title': title,
      'imageUrl': imageUrl,
      'status': status,
      'chaptersRead': chaptersRead,
      'totalChapters': totalChapters,
      'rating': rating,
      'lastUpdated': lastUpdated,
      'notes': notes,
    };
  }

  factory UserMangaModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return UserMangaModel(
      mangaId: data['mangaId'],
      title: data['title'],
      imageUrl: data['imageUrl'],
      status: data['status'],
      chaptersRead: data['chaptersRead'],
      totalChapters: data['totalChapters'],
      rating: data['rating'],
      lastUpdated: (data['lastUpdated'] as Timestamp).toDate(),
      notes: data['notes'],
    );
  }
}
