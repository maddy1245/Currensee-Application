import 'package:eproject_currensee/data/repositories/user/user_repository.dart';
import 'package:eproject_currensee/features/personalization/controllers/user_controller.dart';
import 'package:eproject_currensee/features/personalization/screens/profile/profile.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/network_manager/netword_manager.dart';
import 'package:eproject_currensee/utils/popups/full_screen_loader.dart';
import 'package:eproject_currensee/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      TfullScreenLoader.openLoadingDialog(
          'We are updating your information...', TImage.docerAnimation);

      final isconnected = await NetworkManager.instance.isConnected();
      if (!isconnected) {
        TfullScreenLoader.stopLoading();
        return;
      }
      if (!updateUserNameFormKey.currentState!.validate()) {
        TfullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        'firstName': firstName.text.trim(),
        'lastName': firstName.text.trim(),
      };
      await userRepository.updateSingleField(name);
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      TfullScreenLoader.stopLoading();
      Tloaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated.');

      Get.off(() => ProfileScreen());
    } catch (e) {
      TfullScreenLoader.stopLoading();
      Tloaders.errorSnackBar(title: 'Oh Snap!',message:e.toString());
    }
  }
}
