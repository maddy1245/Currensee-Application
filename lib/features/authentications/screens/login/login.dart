import 'package:eproject_currensee/common/style/spacing_styles.dart';
import 'package:eproject_currensee/features/authentications/controllers/login/login_controller.dart';
import 'package:eproject_currensee/features/authentications/screens/passwrod_configuration/forget_password.dart';
import 'package:eproject_currensee/features/authentications/screens/signup/signup.dart';
import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/constants/text_string.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:eproject_currensee/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    final controller = Get.put(LoginController());

    return Scaffold(
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
                // App Logo
                Image(
                  height: 150, // Set a proper height
                  image: AssetImage(
                      dark ? TImage.darkApplogo : TImage.lightApplogo),
                ),

                const SizedBox(height: Tsizes.md),

                // Login Title
                Text(Ttext.loginTitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: Tsizes.sm),
                Text(Ttext.loginsubTitle,
                    style: Theme.of(context).textTheme.bodyMedium),

                const SizedBox(height: Tsizes.spacebtwsections),

                // Login Form
                Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      // Email Field
                      TextFormField(
                        controller: controller.email,
                        validator: (value) => TValidator.validateEmail(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: Ttext.email,
                        ),
                      ),
                      const SizedBox(height: Tsizes.spacebtwinputfield),

                      // Password Field
                      Obx(
                        () => TextFormField(
                          controller: controller.password,
                          validator: (value) =>
                              TValidator.validatePassword(value),
                          obscureText: controller.hidePassword.value,
                          decoration: InputDecoration(
                            labelText: Ttext.password,
                            prefixIcon: Icon(Iconsax.password_check),
                            suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Tsizes.spacebtwinputfield / 2),

                      // Remember Me & Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                    value: controller.remeberMe.value,
                                    onChanged: (value) => controller.remeberMe
                                        .value = !controller.remeberMe.value),
                              ),
                              const Text(Ttext.rememberMe),
                            ],
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => ForgetPassword()),
                            child: Text(Ttext.forgetPassword),
                          ),
                        ],
                      ),

                      const SizedBox(height: Tsizes.spacebtwsections),

                      // Sign In Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.emailandPasswordSignin(),
                          child: Text(Ttext.signIn),
                        ),
                      ),

                      const SizedBox(height: Tsizes.spacebtwitem),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Get.to(() => SignupScreen()),
                          child: Text(Ttext.createaccount),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: Tsizes.spacebtwsections),

                // Divider with "Or Sign In With"
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
