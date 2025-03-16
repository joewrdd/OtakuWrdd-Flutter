import 'package:OtakuWrdd/data/repos/authentication/auth.dart';
import 'package:OtakuWrdd/ui/auth/controllers/user/user_controller.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/helpers/network_manager.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:OtakuWrdd/utils/loaders/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final isLoading = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());
  final networkManager = Get.put(NetworkManager());

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? '';
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? '';
  }

  // -- Email & Password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
        'Logging You In....',
        ConstantImages.signInLoader,
      );

      // Check Internet Connectivity
      final isConnected = await networkManager.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Data If RememberMe Is Selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login User Using Email & Pass Authentication
      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      FullScreenLoader.stopLoading();

      // ReDirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Ite-te-te!', message: e.toString());
    }
  }

  // -- Google Sign In
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
        'Google Login Loading...',
        ConstantImages.googleSignInLoader,
      );

      // Check Internet Connectivity
      final isConnected = await networkManager.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // If Null, User Cancelled The SignIn
      if (userCredentials == null) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save User Record Call
      final userSaved = await userController.saveUserRecord(userCredentials);

      // Remove Loader
      FullScreenLoader.stopLoading();

      if (userSaved) {
        // Only Redirect If User Data Was Saved Successfully
        await AuthenticationRepository.instance.screenRedirect();
      } else {
        // Handle The Case Where User Data Wasn't Saved
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to save user data. Please try again.',
        );
        // Optionally Logout The User If Data Saving Failed
        await AuthenticationRepository.instance.logout();
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Ite-te-te!', message: e.toString());
    }
  }
}
