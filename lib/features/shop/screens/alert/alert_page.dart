import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:eproject_currensee/common/widgets/success_screen/success_screen.dart';
import 'package:eproject_currensee/features/shop/screens/alert/widget/create_alert_page.dart';
import 'package:eproject_currensee/utils/constants/image_string.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({
    super.key,
    required this.latestPrice,
    required this.priceData,
    required this.fromCurrency,
    required this.toCurrency,
  });

  final String latestPrice;
  final List<FlSpot> priceData;
  final Map<String, String> fromCurrency;
  final Map<String, String> toCurrency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Rate Alerts'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: SuccessScreen(
        image: TImage.alertAnimation,
        title: 'Get Your Desired Rate',
        subTitle:
            'Currency markets are always moving. Set an alert so you never miss out on your desired rate.',
        onPressed: () => Get.to(() => CreateAlertScreen(
              latestPrice: latestPrice,
              fromCurrency: fromCurrency,
              toCurrency: toCurrency,
              priceData: priceData,   
            )),
      ),
    );
  }
}
