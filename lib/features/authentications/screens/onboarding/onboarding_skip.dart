import 'package:eproject_currensee/features/authentications/controllers/onboarding/onboarding_controller.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TdeviceUtils.getAppbarHeight(),
        right: Tsizes.defaultspace,
        child: TextButton(
          onPressed: () => OnboardingController.instance.skipPage(),
          child: Text('Skip'),
        ));
  }
}