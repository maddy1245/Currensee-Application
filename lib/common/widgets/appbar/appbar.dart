import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/device/device_utility.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.action,
    this.leadingOnOPressed,
    this.centerTitle = false
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? action;
  final VoidCallback? leadingOnOPressed;
  final bool centerTitle;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Tsizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Iconsax.arrow_left,
                  color: dark ? TColors.white : TColors.dark,
                ))
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnOPressed, icon: Icon(leadingIcon))
                : null,
        title: title,
        centerTitle: centerTitle,
        actions: action,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TdeviceUtils.getAppbarHeight());
}
