import 'package:eproject_currensee/features/personalization/controllers/user_controller.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/constants/text_string.dart';
import 'package:eproject_currensee/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Tsizes.defaultspace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: TValidator.validateEmail,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: Ttext.email),
                ),
                SizedBox(height: Tsizes.spacebtwinputfield),
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        TValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                      labelText: Ttext.password,
                      prefixIcon: Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(Iconsax.eye_slash),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Tsizes.spacebtwsections),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: ()=>controller.reAuthenticationEmailAndPasswordUser(), child: Text('Verify')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
