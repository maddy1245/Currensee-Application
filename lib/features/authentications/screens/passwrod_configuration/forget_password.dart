import 'package:eproject_currensee/features/authentications/controllers/forget_password/forget_password_controller.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/constants/text_string.dart';
import 'package:eproject_currensee/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(Tsizes.defaultspace),
        child: Column(
          children: [
            Text(Ttext.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: Tsizes.spacebtwitem), 
            Text(Ttext.forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: Tsizes.spacebtwsections * 2), 

            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail, 
                decoration: InputDecoration(
                  labelText: Ttext.email,prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            SizedBox(height: Tsizes.spacebtwsections),

            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> controller.sendPasswordResetEmail(), child:Text('Submit'))) 
          ],
        ),
      ),
    );
  }
}
