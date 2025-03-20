import 'package:eproject_currensee/common/widgets/loaders/animation_loader.dart';
import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TfullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunction.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 250),
              TAnimationLoaderWidget(
                text: text,
                animation: animation,
              )
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
