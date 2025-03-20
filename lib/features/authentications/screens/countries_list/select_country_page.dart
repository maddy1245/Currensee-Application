import 'package:eproject_currensee/features/authentications/screens/countries_list/all_countries.dart';
import 'package:eproject_currensee/features/authentications/screens/login/login.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountrySelectionScreen extends StatefulWidget {
  const CountrySelectionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountrySelectionScreenState createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  String selectedCountry = "United States";
  String selectedLanguage = "English";
  String selectedFlag = "https://flagcdn.com/w320/us.png";
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                  height: 150, 
                  image: AssetImage(
                      dark ? TImage.darkApplogo : TImage.lightApplogo),
                ),
            Text(
              "Select Country",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final result = await Get.to(() => CountryListScreen());

                if (result != null) {
                  setState(() {
                    selectedCountry = result['name'];
                    selectedFlag = result['flag'];
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: dark ? Colors.black : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Image.network(
                      selectedFlag,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(selectedCountry,
                            style: TextStyle(fontSize: 16))),
                    Icon(Icons.arrow_drop_down, size: 30),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Text(
            //   "Select Language",
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 8),
            // GestureDetector(
            //   onTap: () async {
            //   final result = await Get.to(() => LanguageListScreen());

            //     if (result != null) {
            //       setState(() {
            //         selectedLanguage = result;
            //       });
            //     }
            //   },
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            //     decoration: BoxDecoration(
            //       color: dark ? Colors.black : Colors.grey.shade200,
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(color: Colors.grey.shade300),
            //     ),
            //     child: Row(
            //       children: [
            //         Expanded(
            //             child: Text(selectedLanguage,
            //                 style: TextStyle(fontSize: 16))),
            //         Icon(Icons.arrow_drop_down, size: 30),
            //       ],
            //     ),
            //   ),
            // ),
            Spacer(),
            ElevatedButton(
              onPressed: () => Get.to(()=>LoginScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Continue",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
