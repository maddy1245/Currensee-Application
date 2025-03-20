import 'package:eproject_currensee/features/authentications/controllers/onboarding/onboarding_controller.dart';
import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/device/device_utility.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// ignore: camel_case_types
class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Positioned(
      right: Tsizes.defaultspace,
      bottom: TdeviceUtils.getBottomNavigationbarHeight(),
      child: ElevatedButton(
        onPressed: () => OnboardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: dark ? TColors.primary : Colors.black),
        child: Icon(
          Iconsax.arrow_right_3,
          color: Colors.white,
        ),
      ),
    );
  }
}
