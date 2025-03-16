import 'package:OtakuWrdd/utils/client/http_client.dart';
import 'package:OtakuWrdd/utils/client/model_client.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharacterDetailsController extends GetxController {
  static CharacterDetailsController get instance => Get.find();

  final Rx<Character> characterDetails =
      Character(
        id: 0,
        name: '',
        summary: '',
        image: MainPicture(medium: '', large: ''),
        role: '',
        voiceActors: [],
      ).obs;

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxInt currentCharacterId = 0.obs;

  final RxList<RelatedMedia> animeAppearances = <RelatedMedia>[].obs;
  final RxList<RelatedMedia> mangaAppearances = <RelatedMedia>[].obs;
  final RxBool isLoadingAppearances = false.obs;

  @override
  void onInit() {
    super.onInit();

    final characterId = Get.arguments as int?;
    if (characterId != null) {
      getCharacterDetails(characterId);

      Future.delayed(Duration(seconds: 2), () {
        testDirectApiCall(characterId);
      });
    }
  }

  Future<void> getCharacterDetails(int characterId) async {
    if (isLoading.value && currentCharacterId.value == characterId) return;

    if (characterDetails.value.id == characterId && !isLoading.value) return;

    try {
      isLoading.value = true;
      error.value = '';
      currentCharacterId.value = characterId;

      final currentDetails = characterDetails.value;

      final details = await MALApiClient.getCharacterDetails(characterId);

      final updatedDetails = Character(
        id: details.id,
        name: details.name,
        summary: details.summary,
        image: details.image,
        role: details.role.isEmpty ? currentDetails.role : details.role,
        voiceActors: details.voiceActors,
      );
      characterDetails.value = updatedDetails;

      await getCharacterAppearances(characterId);
      if (characterDetails.value.summary.isEmpty) {
        final currentChar = characterDetails.value;
        characterDetails.value = Character(
          id: currentChar.id,
          name: currentChar.name,
          image: currentChar.image,
          role: currentChar.role,
          voiceActors: currentChar.voiceActors,
          summary:
              "This is a hardcoded summary for testing. The character appears in the anime and plays an important role in the story.",
        );
      }
    } catch (e) {
      error.value = e.toString();
      Loaders.errorSnackBar(
        title: 'Error Loading Character Details',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCharacterAppearances(int characterId) async {
    try {
      isLoadingAppearances.value = true;

      try {
        final response = await MALApiClient.getCharacterAnimeAppearances(
          characterId,
        );
        animeAppearances.value = response;
      } catch (e) {
        Loaders.errorSnackBar(title: 'Error fetching anime appearances');
      }

      try {
        final response = await MALApiClient.getCharacterMangaAppearances(
          characterId,
        );
        mangaAppearances.value = response;
      } catch (e) {
        Loaders.errorSnackBar(title: 'Error fetching manga appearances');
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error in getCharacterAppearances');
    } finally {
      isLoadingAppearances.value = false;
    }
  }

  void navigateToAnimeDetails(int animeId) {
    Get.toNamed('/anime-details', arguments: animeId);
  }

  void navigateToMangaDetails(int mangaId) {
    Get.toNamed('/manga-details', arguments: mangaId);
  }

  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Loaders.errorSnackBar(title: 'Could not launch $url');
    }
  }

  Future<void> testDirectApiCall(int characterId) async {
    try {
      final jikanUrl = 'https://api.jikan.moe/v4/characters/$characterId';

      final response = await http.get(Uri.parse(jikanUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        final summary = data['about'] ?? '';

        if (summary.isNotEmpty) {
          final currentChar = characterDetails.value;
          characterDetails.value = Character(
            id: currentChar.id,
            name: currentChar.name,
            image: currentChar.image,
            role: currentChar.role,
            voiceActors: currentChar.voiceActors,
            summary: summary,
          );
        } else {
          final currentChar = characterDetails.value;
          characterDetails.value = Character(
            id: currentChar.id,
            name: currentChar.name,
            image: currentChar.image,
            role: currentChar.role,
            voiceActors: currentChar.voiceActors,
            summary:
                "This character appears in the anime/manga series. Due to API limitations, detailed information could not be loaded.",
          );
        }
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error in Direct API Call');
    }
  }
}
