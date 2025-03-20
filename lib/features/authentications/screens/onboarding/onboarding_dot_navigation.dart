import 'package:eproject_currensee/features/authentications/controllers/onboarding/onboarding_controller.dart';
import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/device/device_utility.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;  
    final dark = THelperFunction.isDarkMode(context);
    return Positioned(
        bottom: TdeviceUtils.getBottomNavigationbarHeight() + 25,
        left: Tsizes.defaultspace,
        child: SmoothPageIndicator(
        
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect:
              ExpandingDotsEffect(activeDotColor:dark? TColors.light:TColors.dark, dotHeight: 6),
        ));
  }
}
