// import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
// import 'package:eproject_currensee/common/widgets/images/t_circular_image.dart';
// import 'package:eproject_currensee/data/repositories/authentication/authentication_repository.dart';
// import 'package:eproject_currensee/features/personalization/controllers/user_controller.dart';
// import 'package:eproject_currensee/features/personalization/screens/profile/widget/change_name.dart';
// import 'package:eproject_currensee/features/personalization/screens/profile/widget/profile_menu.dart';
// import 'package:eproject_currensee/utils/constants/image_string.dart';
// import 'package:eproject_currensee/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = UserController.instance;
//     return Scaffold(
//       appBar: TAppBar(title: Text('Profile')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(Tsizes.defaultspace),
//         child: Column(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               child: Column(
//                 children: [
//                   Obx(
//                     () {
//                       final networkImage = controller.user.value.profilePicture;
//                       final image =
//                           networkImage.isNotEmpty ? networkImage : TImage.user;
//                       return TCircularImage(
//                         image: image,
//                         width: 80,
//                         height: 80,
//                         isNetworkImage: networkImage.isNotEmpty,
//                       );
//                     },
//                   ),
//                   // TextButton(
//                   //     onPressed: () => controller.uploadUserProfilePicture(),
//                   //     child: Text('Change Profile Picture')),
//                 ],
//               ),
//             ),
//             SizedBox(height: Tsizes.spacebtwitem / 2),
//             Divider(),
            
//             // TSectionHeading(
//             //     title: 'Profile Information', showActionButton: false),
//             SizedBox(height: Tsizes.spacebtwitem),
//             Profilemenu(
//                 title: 'Name',
//                 value: controller.user.value.fullName,
//                 onPressed: () => Get.to(() => ChangeName())),
//             Profilemenu(
//                 title: 'Username',
//                 value: controller.user.value.username,
//                 onPressed: () {}),
//             SizedBox(height: Tsizes.spacebtwitem / 2),
//             Divider(),
//             // TSectionHeading(
//             //     title: 'Personal Information', showActionButton: false),
//             SizedBox(height: Tsizes.spacebtwitem),
//             Profilemenu(
//                 title: 'User ID',
//                 value: controller.user.value.id,
//                 icon: Iconsax.copy,
//                 onPressed: () {}),
//             Profilemenu(
//                 title: 'E-Mail',
//                 value: controller.user.value.email,
//                 onPressed: () {}),
//             Profilemenu(
//                 title: 'Phone Number',
//                 value: controller.user.value.phoneNumber,
//                 onPressed: () {}),
//             Profilemenu(title: 'Gender', value: 'Male', onPressed: () {}),
           
//             Divider(),
//             SizedBox(height: Tsizes.spacebtwitem),
//             Center(
//             child: SizedBox(
//                     width: double.infinity,
//                     child: OutlinedButton(
//                       onPressed: () async {
//                         await AuthenticationRepository.instance.logout();
//                       },
//                       child: const Text('Logout'),
//                     ),
//                   ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:eproject_currensee/common/widgets/images/t_circular_image.dart';
import 'package:eproject_currensee/data/repositories/authentication/authentication_repository.dart';
import 'package:eproject_currensee/features/personalization/controllers/user_controller.dart';
import 'package:eproject_currensee/features/personalization/screens/profile/widget/change_name.dart';
import 'package:eproject_currensee/features/personalization/screens/profile/widget/profile_menu.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: TAppBar(title: Text('Profile')),
      body: Obx(() {
        // ✅ Jab tak data load ho raha hai, tab tak loader show karega
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Loading profile...", style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        }

        // ✅ Jab data load ho jaye, to profile details dikhao
        return SingleChildScrollView(
          padding: EdgeInsets.all(Tsizes.defaultspace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : TImage.user;
                      return TCircularImage(
                        image: image,
                        width: 80,
                        height: 80,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: Tsizes.spacebtwitem / 2),
              Divider(),
              SizedBox(height: Tsizes.spacebtwitem),
              Profilemenu(
                  title: 'Name',
                  value: controller.user.value.fullName,
                  onPressed: () => Get.to(() => ChangeName())),
              Profilemenu(
                  title: 'Username',
                  value: controller.user.value.username,
                  onPressed: () {}),
              SizedBox(height: Tsizes.spacebtwitem / 2),
              Divider(),
              SizedBox(height: Tsizes.spacebtwitem),
              Profilemenu(
                  title: 'User ID',
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                  onPressed: () {}),
              Profilemenu(
                  title: 'E-Mail',
                  value: controller.user.value.email,
                  onPressed: () {}),
              Profilemenu(
                  title: 'Phone Number',
                  value: controller.user.value.phoneNumber,
                  onPressed: () {}),
              Profilemenu(title: 'Gender', value: 'Male', onPressed: () {}),
              Divider(),
              SizedBox(height: Tsizes.spacebtwitem),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      await AuthenticationRepository.instance.logout();
                    },
                    child: const Text('Logout'),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
