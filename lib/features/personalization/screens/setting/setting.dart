import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:eproject_currensee/common/widgets/listtiles/settings_menu_tile.dart';
import 'package:eproject_currensee/common/widgets/listtiles/user_profile_tile.dart';
import 'package:eproject_currensee/data/repositories/authentication/authentication_repository.dart';
import 'package:eproject_currensee/features/personalization/screens/profile/profile.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            // TPrimaryHeaderContainer(
            //   child:
               Column(
                children: [
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  TuserProfileTile(onpressed: () => Get.to(()=>ProfileScreen())),
                  SizedBox(height: Tsizes.spacebtwsections),
                ],
              ),
            //),
            //body
            Padding(
              padding: EdgeInsets.all(Tsizes.defaultspace),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TSectionHeading(
                  //   title: 'Account Setting',
                  //   showActionButton: false,
                  // ),
                  SizedBox(height: Tsizes.spacebtwitem),
                  TSettingMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set Shopping Delivery Address',
                   
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My cart',
                    subtitle: 'Add, remove products move to checkout',
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My orders',
                    subtitle: 'In-progress and Completed Orders',
                    //ontap: () => Get.to(()=>OrderScreen()),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subtitle: 'Withdraw balance to registered bank account',
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subtitle: 'List Of All the Discounted Coupons',
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: 'Set any Kind of notification message',
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                  ),
                  SizedBox(
                    height: Tsizes.spacebtwsections,
                  ),
                  // TSectionHeading(
                  //     title: 'App Setting', showActionButton: false),
                  SizedBox(
                    height: Tsizes.spacebtwitem,
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subtitle: 'Uplaod Data to your Cloud Firebase',
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.image,
                    title: 'HD image Quality',
                    subtitle: 'Set image Quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SizedBox(height: Tsizes.spacebtwsections),
                   SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        await AuthenticationRepository.instance.logout();
                      },
                      child: const Text('Logout'),
                    ),
                  ),


                  SizedBox(height: Tsizes.spacebtwsections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
