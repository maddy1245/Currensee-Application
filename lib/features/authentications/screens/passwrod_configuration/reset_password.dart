import 'package:eproject_currensee/features/authentications/controllers/forget_password/forget_password_controller.dart';
import 'package:eproject_currensee/features/authentications/screens/login/login.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/constants/text_string.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(), icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Tsizes.defaultspace),
          child: Column(
            children: [
              Image(
                  image: AssetImage(TImage.deliveredEmailIllustration),
                  width: THelperFunction.screenWidth() * 0.6),
              SizedBox(height: Tsizes.spacebtwsections),
              Text(email,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: Tsizes.spacebtwitem),
              Text(Ttext.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: Tsizes.spacebtwitem),
              Text(Ttext.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: Tsizes.spacebtwsections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.offAll(() => LoginScreen()),
                    child: Text('Done')),
              ),
              SizedBox(height: Tsizes.spacebtwitem),
              SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: ()=>ForgetPasswordController.instance.resendPasswordResetEmail(email), child: Text('Resend Email')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
