import 'package:get/get.dart';
import 'package:OtakuWrdd/data/services/search_service.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:flutter/material.dart';

class CustomSearchController extends GetxController {
  static CustomSearchController get instance => Get.find();

  final RxList<AnimeBase> animeResults = <AnimeBase>[].obs;
  final RxList<MangaBase> mangaResults = <MangaBase>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;
  final RxBool isFocused = false.obs;
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(_handleFocusChange);
  }

  @override
  void onClose() {
    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void _handleFocusChange() {
    isFocused.value = focusNode.hasFocus;
  }

  void handleCancel() {
    textController.clear();
    clearSearch();
    focusNode.unfocus();
  }

  List<dynamic> get searchResults => [...animeResults, ...mangaResults];

  Future<void> handleSearch(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    isSearching.value = true;
    try {
      isLoading.value = true;
      final results = await Future.wait([
        SearchService.searchAnime(query),
        SearchService.searchManga(query),
      ]);

      final animeData = results[0]['data'] as List;
      final mangaData = results[1]['data'] as List;

      animeResults.value = animeData.map((e) => AnimeBase.fromJson(e)).toList();
      mangaResults.value = mangaData.map((e) => MangaBase.fromJson(e)).toList();
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    isSearching.value = false;
    animeResults.clear();
    mangaResults.clear();
  }
}
