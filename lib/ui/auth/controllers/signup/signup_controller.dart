import 'package:OtakuWrdd/data/repos/authentication/auth.dart';
import 'package:OtakuWrdd/data/repos/user/user.dart';
import 'package:OtakuWrdd/ui/auth/models/user_model.dart';
import 'package:OtakuWrdd/ui/auth/screens/signup/verify_email.dart';
import 'package:OtakuWrdd/utils/constants/images.dart';
import 'package:OtakuWrdd/utils/helpers/network_manager.dart';
import 'package:OtakuWrdd/utils/loaders/custom_loader.dart';
import 'package:OtakuWrdd/utils/loaders/full_screen_loader.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs; // Observable For Hiding/Showing Password
  final firstName = TextEditingController();
  final phoneNb = TextEditingController();
  final privacyPolicy = true.obs; // Observable For Checking/UnChecking TOS
  final networkManager = Get.put(NetworkManager());
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // SignUp
  void signup() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
        'Hold on, we are processing your information...',
        ConstantImages.signInLoader,
      );

      // Check Internet Connection
      final isConnected = await networkManager.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        Loaders.warningSnackBar(
          title: 'Accept Privacy Policy!',
          message:
              'In order to successfully create your account, you must accept the Privacy Policy & Terms Of Use.',
        );
        return;
      }

      // Register User In The Firebase Auth & Save User Data
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      // Save Authenticated User Data In The Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNb: phoneNb.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(
        title: 'Congrats',
        message:
            'Your Account Has Been Created! Verify Your Email To Continue.',
      );

      // Move To Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Some Generic Error To User
      Loaders.errorSnackBar(
        title: 'Ite-te-te... An Error Has Occured!',
        message: e.toString(),
      );
    }
  }
}
