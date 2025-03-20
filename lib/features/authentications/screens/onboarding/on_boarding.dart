import 'package:eproject_currensee/features/authentications/controllers/onboarding/onboarding_controller.dart';
import 'package:eproject_currensee/features/authentications/screens/onboarding/onboarding_dot_navigation.dart';
import 'package:eproject_currensee/features/authentications/screens/onboarding/onboarding_next_button.dart';
import 'package:eproject_currensee/features/authentications/screens/onboarding/onboarding_page.dart';
import 'package:eproject_currensee/features/authentications/screens/onboarding/onboarding_skip.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: TImage.onBoardingImage1,
                title: Ttext.onBoardingTitle1,
                subTitle: Ttext.onBoardingsubTitle1,
              ),
              OnBoardingPage(
                image: TImage.onBoardingImage2,
                title: Ttext.onBoardingTitle2,
                subTitle: Ttext.onBoardingsubTitle2,
              ),
              OnBoardingPage(
                image: TImage.onBoardingImage3,
                title: Ttext.onBoardingTitle3,
                subTitle: Ttext.onBoardingsubTitle3,
              ),
            ],
          ),
          OnBoardingSkip(),
          OnBoardingDotNavigation(),
          onBoardingNextButton(),
        ],
      ),
    );
  }
}
