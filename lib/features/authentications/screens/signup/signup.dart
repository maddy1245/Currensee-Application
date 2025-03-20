import 'package:eproject_currensee/common/style/spacing_styles.dart';
import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:eproject_currensee/features/authentications/controllers/signup/signup_controller.dart';
import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/constants/text_string.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:eproject_currensee/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    final controller = Get.put(SignupController());
    final termscontroller = SignupController.instance;
    return Scaffold(
      appBar: TAppBar(showBackArrow: true),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height / 2,
          ),
          child: Padding(
            padding: TSpacingStyles.paddingWithAppBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Ttext.signUpTitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: Tsizes.spacebtwsections),
                Form(
                  key: controller.singupFormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.firstname,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      'First Name', value),
                              expands: false,
                              decoration: InputDecoration(
                                  labelText: Ttext.firstName,
                                  prefixIcon: Icon(Iconsax.user)),
                            ),
                          ),
                          SizedBox(width: Tsizes.spacebtwinputfield),
                          Expanded(
                            child: TextFormField(
                              controller: controller.lastname,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      'Last Name', value),
                              expands: false,
                              decoration: InputDecoration(
                                  labelText: Ttext.lastName,
                                  prefixIcon: Icon(Iconsax.user)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Tsizes.spacebtwinputfield,
                      ),
                      TextFormField(
                        controller: controller.username,
                        validator: (value) =>
                            TValidator.validateEmptyText('Username', value),
                        decoration: InputDecoration(
                            labelText: Ttext.userName,
                            prefixIcon: Icon(Iconsax.user_edit)),
                      ),
                      SizedBox(
                        height: Tsizes.spacebtwinputfield,
                      ),
                      TextFormField(
                        controller: controller.email,
                        validator: (value) => TValidator.validateEmail(value),
                        decoration: InputDecoration(
                            labelText: Ttext.email,
                            prefixIcon: Icon(Iconsax.direct)),
                      ),
                      SizedBox(
                        height: Tsizes.spacebtwinputfield,
                      ),
                      TextFormField(
                        controller: controller.phoneNumber,
                        validator: (value) =>
                            TValidator.validatePhoneNumber(value),
                        decoration: InputDecoration(
                            labelText: Ttext.phoneNo,
                            prefixIcon: Icon(Iconsax.call)),
                      ),
                      SizedBox(
                        height: Tsizes.spacebtwinputfield,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: controller.password,
                          validator: (value) =>
                              TValidator.validatePassword(value),
                          obscureText: controller.hidepassword.value,
                          decoration: InputDecoration(
                            labelText: Ttext.password,
                            prefixIcon: Icon(Iconsax.password_check),
                            suffixIcon: IconButton(
                              onPressed: () => controller.hidepassword.value =
                                  !controller.hidepassword.value,
                              icon: Icon(controller.hidepassword.value? Iconsax.eye_slash : Iconsax.eye),

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Tsizes.spacebtwsections),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Obx(
                              ()=> Checkbox(
                                value: termscontroller.privacyPolicy.value,
                                onChanged: (value) => controller.privacyPolicy.value =! controller.privacyPolicy.value,
                              ),
                            ),
                          ),
                          SizedBox(width: Tsizes.spacebtwitem),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: '${Ttext.iAgreeTo} ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                TextSpan(
                                  text: '${Ttext.privacyPolicy} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: dark
                                            ? TColors.white
                                            : TColors.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: dark
                                            ? TColors.white
                                            : TColors.primary,
                                      ),
                                ),
                                TextSpan(
                                    text: 'and ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                TextSpan(
                                  text: '${Ttext.termsOfUse} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: dark
                                            ? TColors.white
                                            : TColors.primary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: dark
                                            ? TColors.white
                                            : TColors.primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Tsizes.spacebtwsections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.signup(),
                          child: const Text(Ttext.createaccount),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Tsizes.spacebtwsections),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: dark ? TColors.darkgrey : TColors.grey,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5,
                      ),
                    ),
                    Text(
                      Ttext.orSignInWith.capitalize!,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Expanded(
                      child: Divider(
                        color: dark ? TColors.darkgrey : TColors.grey,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Tsizes.spacebtwsections),

                // Social Media Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Sign In
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image(
                          height: Tsizes.iconmd,
                          width: Tsizes.iconmd,
                          image: AssetImage(TImage.google),
                        ),
                      ),
                    ),

                    const SizedBox(width: Tsizes.spacebtwitem),

                    // Facebook Sign In
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image(
                          height: Tsizes.iconmd,
                          width: Tsizes.iconmd,
                          image: AssetImage(TImage.facebook),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
