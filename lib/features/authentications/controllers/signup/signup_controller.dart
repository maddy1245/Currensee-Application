import 'package:eproject_currensee/data/repositories/authentication/authentication_repository.dart';
import 'package:eproject_currensee/data/repositories/user/user_repository.dart';
import 'package:eproject_currensee/features/authentications/models/user_model.dart';
import 'package:eproject_currensee/features/authentications/screens/signup/widgets/verify_email.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/network_manager/netword_manager.dart';
import 'package:eproject_currensee/utils/popups/full_screen_loader.dart';
import 'package:eproject_currensee/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidepassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> singupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      //Start Loading
      TfullScreenLoader.openLoadingDialog(
          'We are Processing Your Information......', TImage.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TfullScreenLoader.stopLoading();
        return;
      }
      //Form Validation
      if (!singupFormKey.currentState!.validate()) {
        TfullScreenLoader.stopLoading();
        return;

      }
     

      //Privacy policy
      if (!privacyPolicy.value) {
        Tloaders.warningSnackBar(
            title: 'Accept Privacy ',
            message:
                'In order to create account , you must have to read and accept the privacy Policy & Terms of Use.');
        return;
      }

      //Register user in the Firebase Authentication & Save user data int the Firebase

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      //Save Authenticated user data int the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstname.text.trim(),
        lastName: lastname.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);
      //Show Success Message

      TfullScreenLoader.stopLoading();

      Tloaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Account has been Created ! Verify email to continue.');
      //Move To Verify Email Screen

      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      TfullScreenLoader.stopLoading();

      Tloaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
