import 'package:eproject_currensee/data/repositories/authentication/authentication_repository.dart';
import 'package:eproject_currensee/features/authentications/controllers/signup/verify_email_controller.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/constants/text_string.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({
    super.key,
    this.email,
  });
  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: Icon(CupertinoIcons.clear))
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
              Text(Ttext.confirmEmailTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: Tsizes.spacebtwitem),
              Text(email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              SizedBox(height: Tsizes.spacebtwitem),
              Text(Ttext.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: Tsizes.spacebtwsections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: ()=>controller.checkEmailVerificationStatus(),
                    child: Text('Continue')),
              ),
              SizedBox(height: Tsizes.spacebtwitem),
              SizedBox(
                width: double.infinity,
                child:
                    TextButton(onPressed: () => controller.sendEmailVerification(), child: Text('Resend Email')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
