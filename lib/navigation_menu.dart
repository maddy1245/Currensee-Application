import 'package:eproject_currensee/features/personalization/screens/profile/profile.dart';
import 'package:eproject_currensee/features/shop/screens/Home/home.dart';
import 'package:eproject_currensee/features/shop/screens/converter/currency_converter.dart';
import 'package:eproject_currensee/features/shop/screens/history/conversion_history.dart';
import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunction.isDarkMode(context);

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          height: 70,
          decoration: BoxDecoration(
            color: darkMode ? Colors.black87 : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: darkMode ? Colors.black45 : Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Iconsax.home, 0, "Home"),
              _buildNavItem(Iconsax.dollar_circle, 1, "Convert"),
              _buildNavItem(Iconsax.clock, 2, "History"),
              _buildNavItem(Iconsax.user, 3, "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    bool isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () {
        controller.selectedIndex.value = index;
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
            vertical: 10, horizontal: isSelected ? 20 : 12),
        decoration: BoxDecoration(
          color: isSelected
              ? THelperFunction.isDarkMode(context)
                  ? TColors.white
                  : Colors.black
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: isSelected ? 28 : 24,
              color: isSelected
                  ? THelperFunction.isDarkMode(context)
                      ? Colors.black
                      : TColors.white
                  : THelperFunction.isDarkMode(context)
                      ? TColors.white
                      : Colors.black,
            ),
            SizedBox(width: isSelected ? 8 : 0),
            AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: Duration(milliseconds: 300),
              child: Text(
                isSelected ? label : "",
                style: TextStyle(
                    color: isSelected
                        ? THelperFunction.isDarkMode(context)
                            ? Colors.black
                            : TColors.white
                        : THelperFunction.isDarkMode(context)
                            ? TColors.white
                            : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    HomeScreen(),
    ConvertScreen(),
    ConversionHistory(),
    ProfileScreen(),
  ];
}
