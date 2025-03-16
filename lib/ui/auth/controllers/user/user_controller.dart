import 'package:OtakuWrdd/data/repos/authentication/auth.dart';
import 'package:OtakuWrdd/data/repos/user/user.dart';
import 'package:OtakuWrdd/ui/auth/models/user_model.dart';
import 'package:OtakuWrdd/ui/auth/screens/login/login.dart';
import 'package:OtakuWrdd/ui/main/screens/settings/widgets/re_auth_login_form.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/helpers/network_manager.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:OtakuWrdd/utils/loaders/full_screen_loader.dart';
import 'package:OtakuWrdd/utils/tools/device_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final isProfileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final hidePassword = false.obs;
  final imageUploading = false.obs;

  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //----- Fetch User Record -----
  Future<void> fetchUserRecord() async {
    try {
      isProfileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      isProfileLoading.value = false;
    }
  }

  //----- Save User Record From Any Registration Provider -----
  Future<bool> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        // Convert Name To First & Last Name
        final nameParts = UserModel.nameParts(
          userCredentials.user!.displayName ?? '',
        );
        final username = UserModel.generateUsername(
          userCredentials.user!.displayName ?? '',
        );

        // Map Data
        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNb: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );

        // Save User Data
        await userRepository.saveUserRecord(user);
        return true;
      }
      return false;
    } catch (e) {
      Loaders.warningSnackBar(
        title: "Data Not Saved.",
        message:
            'Something Went Wrong With Saving Your Info. Re-Save Data In Profile',
      );
      return false;
    }
  }

  //----- Delete Account Warning -----
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ConstantSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to permanently delete your account? This cannot be undone, and all your data will be lost.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.redAccent),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: ConstantSizes.lg - 1),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: Text('Cancel'),
      ),
    );
  }

  //----- Delete User Account -----
  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Processing...',
        ConstantImages.signInLoader,
      );

      // Re-Authenticate User
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Ite-te-te!', message: e.toString());
    }
  }

  //----- RE-AUTH Before Deleting -----
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Processing...',
        ConstantImages.signInLoader,
      );

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );
      await AuthenticationRepository.instance.deleteAccount();
      FullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Ite-te-te!', message: e.toString());
    }
  }

  //----- Upload Profile Images -----
  uploadUserProfilePicture() async {
    try {
      // Show Dialog To Select Source
      final source = await DeviceUtils.selectImageSource(Get.context!);

      if (source == null) return; // If No Source => Exit

      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        // Crop The Image
        final CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(minimumAspectRatio: 1.0),
          ],
        );

        if (croppedFile != null) {
          imageUploading.value = true;

          // Upload Image
          final imageUrl = await userRepository.uploadImage(
            'Users/Images/Profile/',
            XFile(croppedFile.path),
          );

          // Update User Image Record
          Map<String, dynamic> json = {'ProfilePicture': imageUrl};
          await userRepository.updateSingleField(json);

          // Trigger Obx & Instantly Redraw State
          user.value.profilePicture = imageUrl;
          user.refresh();

          // Success Message
          Loaders.successSnackBar(
            title: 'Congrats!!!',
            message: 'Profile Image has been updated successfully.',
          );
        }
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Ite-te-te!',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }
}
