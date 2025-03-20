
import 'package:eproject_currensee/data/repositories/authentication/authentication_repository.dart';
import 'package:eproject_currensee/features/authentications/screens/passwrod_configuration/reset_password.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/network_manager/netword_manager.dart';
import 'package:eproject_currensee/utils/popups/full_screen_loader.dart';
import 'package:eproject_currensee/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  sendPasswordResetEmail() async {
    try {
      TfullScreenLoader.openLoadingDialog(
          'Processing your request...', TImage.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TfullScreenLoader.stopLoading();
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        TfullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      TfullScreenLoader.stopLoading();

      Tloaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link sent to Reset your password'.tr);

      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      TfullScreenLoader.stopLoading();
      Tloaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
        try {
      TfullScreenLoader.openLoadingDialog(
          'Processing your request...', TImage.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TfullScreenLoader.stopLoading();
        return;
      }

      
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email);

      TfullScreenLoader.stopLoading();

      Tloaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link sent to Reset your password'.tr);
       
          
    } catch (e) {
      TfullScreenLoader.stopLoading();
      Tloaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
