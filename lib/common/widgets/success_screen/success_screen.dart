import 'package:eproject_currensee/common/style/spacing_styles.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});
  
  final String image, title, subTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
            Lottie.asset(image,width: MediaQuery.of(context).size.width *0.6),

              SizedBox(height: Tsizes.spacebtwsections),
              
              Text(title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              
              SizedBox(height: Tsizes.spacebtwitem),
              
              Text(subTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),

              SizedBox(height: Tsizes.spacebtwsections),


            SizedBox(width: double.infinity,child: ElevatedButton(onPressed: onPressed, child:Text('Continue')),),
            
            ],
          ),
        ),
      ),
    );
  }
}
