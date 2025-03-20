import 'dart:io' show File;
import 'package:eproject_currensee/data/repositories/authentication/authentication_repository.dart';
import 'package:eproject_currensee/data/repositories/user/user_repository.dart';
import 'package:eproject_currensee/features/authentications/models/user_model.dart';
import 'package:eproject_currensee/features/authentications/screens/login/login.dart';
import 'package:eproject_currensee/features/personalization/screens/profile/widget/re_authenticate_user_login_form.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/network_manager/netword_manager.dart';
import 'package:eproject_currensee/utils/popups/full_screen_loader.dart';
import 'package:eproject_currensee/utils/popups/loaders.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
   var isLoading = true.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  // ignore: override_on_non_overriding_member
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Future<void> fetchUserRecord() async {
  //   try {
  //     profileLoading.value = true;
  //     final user = await userRepository.fetchUserDetails();
  //     this.user(user);
  //   } catch (e) {
  //     user(UserModel.empty());
  //   } finally {
  //     profileLoading.value = false;
  //   }
  // }
  Future<void> fetchUserRecord() async {
    try {
      isLoading.value = true; // ✅ Loader start
      user.value = await userRepository.fetchUserDetails();
    } catch (e) {
      print("Error loading user data: $e");
    } finally {
      isLoading.value = false; // ✅ Loader stop after data fetch
    }
  }
  Future<void> saveUserRecord(UserCredential? usercredentials) async {
    try {
      if (usercredentials != null) {
        final nameParts =
            UserModel.nameParts(usercredentials.user!.displayName ?? '');
        final username =
            UserModel.generateUsername(usercredentials.user!.displayName ?? '');

        final user = UserModel(
          id: usercredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: usercredentials.user!.email ?? '',
          phoneNumber: usercredentials.user!.phoneNumber ?? '',
          profilePicture: usercredentials.user!.photoURL ?? '',
        );

        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      Tloaders.warningSnackBar(
          title: 'Data Not Saved',
          message:
              'Something went wrong while saving your information .You can re-save your data in your Profile.');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(Tsizes.md),
      title: 'Delete Account ',
      middleText:
          'Are You Sure you want to delete your Account permanently? This Action is not reversible and of all your data will be removed permanently .',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Tsizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: Text('Cancel'),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      TfullScreenLoader.openLoadingDialog('Processing', TImage.docerAnimation);
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.sendInWithGoogle();
          await auth.deleteAccount();
          TfullScreenLoader.stopLoading();
          Get.offAll(() => LoginScreen());
        } else if (provider == 'password') {
          TfullScreenLoader.stopLoading();
          Get.to(() => ReAuthLoginForm());
        }
      }
    } catch (e) {
      TfullScreenLoader.stopLoading();
      Tloaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticationEmailAndPasswordUser() async {
    try {
      TfullScreenLoader.openLoadingDialog('Processing', TImage.docerAnimation);
      final isconnected = await NetworkManager.instance.isConnected();
      if (!isconnected) {
        TfullScreenLoader.stopLoading();
        return;
      }
      if (!reAuthFormKey.currentState!.validate()) {
        TfullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticationEmailAndPasswordUser(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TfullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      e;
    }
  }

    Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        final fileBytes =
            await File(image.path).readAsBytes(); // Convert image to bytes
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${image.name}';

        // Upload image to Supabase bucket "Users"
        final response =
            await Supabase.instance.client.storage.from('Users').uploadBinary(
                  'Images/Profile/$fileName',
                  fileBytes,
                  fileOptions: const FileOptions(contentType: 'image/jpeg'),
                );

        if (response.isEmpty) throw 'Upload failed';

        // Get Public URL of uploaded image
        final imageUrl = Supabase.instance.client.storage
            .from('Users')
            .getPublicUrl('Images/Profile/$fileName');

        // Update user record in Supabase database
        await Supabase.instance.client
            .from('users')
            .update({'ProfilePicture': imageUrl}).eq(
                'id', Supabase.instance.client.auth.currentUser!.id);

        // Update local user object
        user.value.profilePicture = imageUrl;

        // Show success message
        Tloaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your Profile Photo has been updated!');
      }
    } catch (e) {
      Tloaders.errorSnackBar(
          title: 'Oh Snap!', message: 'Something went wrong: $e');
    }
  }

}
