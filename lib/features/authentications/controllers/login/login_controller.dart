import 'package:eproject_currensee/data/repositories/authentication/authentication_repository.dart';
import 'package:eproject_currensee/features/personalization/controllers/user_controller.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/network_manager/netword_manager.dart';
import 'package:eproject_currensee/utils/popups/full_screen_loader.dart';
import 'package:eproject_currensee/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final remeberMe = false.obs;
  final hidePassword = true.obs;
  final localstorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  Future<void> emailandPasswordSignin() async {
    try {
      TfullScreenLoader.openLoadingDialog(
          'Logging you in...', TImage.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TfullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TfullScreenLoader.stopLoading();
        return;
      }

      if (remeberMe.value) {
        localstorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localstorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      TfullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TfullScreenLoader.stopLoading();
      Tloaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> googleSignin() async {
    try {
      TfullScreenLoader.openLoadingDialog(
          'Logging you in.....', TImage.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TfullScreenLoader.stopLoading();
        return;
      }

      //Google Authentication

      final userCredentials =
          await AuthenticationRepository.instance.sendInWithGoogle();

      await userController.saveUserRecord(userCredentials);

      TfullScreenLoader.stopLoading();
    } catch (e) {
      TfullScreenLoader.stopLoading();
      Tloaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
