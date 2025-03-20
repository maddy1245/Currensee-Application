// import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
// import 'package:eproject_currensee/features/shop/screens/alert/all_alerts_page.dart';
// import 'package:eproject_currensee/features/shop/screens/currencies/all_currencies_page.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class CreateAlertScreen extends StatefulWidget {
//   final String latestPrice;
//   final List<FlSpot> priceData;
//   final Map<String, String> fromCurrency;
//   final Map<String, String> toCurrency;

//   const CreateAlertScreen({
//     super.key,
//     required this.latestPrice,
//     required this.priceData,
//     required this.fromCurrency,
//     required this.toCurrency,
//   });

//   @override
//   _CreateAlertScreenState createState() => _CreateAlertScreenState();
// }

// class _CreateAlertScreenState extends State<CreateAlertScreen> {
//   final TextEditingController _desiredRateController1 = TextEditingController();
//   final TextEditingController _desiredRateController2 = TextEditingController();

//   late Map<String, String> selectedFromCurrency;
//   late Map<String, String> selectedToCurrency;
//   final box = GetStorage(); // 🔹 GetStorage instance

//   @override
//   void initState() {
//     super.initState();
//     selectedFromCurrency = widget.fromCurrency;
//     selectedToCurrency = widget.toCurrency;
//   }

// void _saveUpdatedAlert() {
//   Map<String, dynamic> updatedAlert = {
//     "from": selectedFromCurrency,
//     "to": selectedToCurrency,
//     "rate": updatedRate
//   };

//   Get.back(result: updatedAlert); // Return new data to previous screen
// }
//   void _selectCurrency(bool isFromCurrency) async {
//     final selectedCurrency = await Get.to(() => CurrencyListScreen());
//     if (selectedCurrency != null && selectedCurrency is Map<String, String>) {
//       setState(() {
//         if (isFromCurrency) {
//           selectedFromCurrency = selectedCurrency;
//         } else {
//           selectedToCurrency = selectedCurrency;
//         }
//       });
//     }
//   }

//   void _createAlert() {
//     String fromCode = selectedFromCurrency['code']!;
//     String toCode = selectedToCurrency['code']!;
//     String rate = _desiredRateController2.text;

//     if (rate.isEmpty) {
//       Get.snackbar('Error', 'Please enter a valid rate!');
//       return;
//     }

//     // **Get previous alerts list**
//     List<dynamic> existingAlerts = box.read<List>('alerts') ?? [];

//     // **Add new alert**
//     existingAlerts.add({
//       "from": fromCode,
//       "to": toCode,
//       "rate": rate,
//     });

//     // **Save updated alerts list in storage**
//     box.write('alerts', existingAlerts);

//     // **Navigate to alerts page**
//     Get.to(() => AllAlertsPage(latestPrice: '', priceData: [], fromCurrency: {}, toCurrency: {},));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TAppBar(
//         title: const Text('Create Alert'),
//         centerTitle: true,
//         showBackArrow: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('When', style: TextStyle(fontSize: 20)),
//             AlertTextField(
//               flagUrl: selectedFromCurrency['flag']!,
//               currencyCode: selectedFromCurrency['code']!,
//               isEditable: true,
//               controller: _desiredRateController1,
//               onCurrencyTap: () => _selectCurrency(true),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Text('Equals', style: TextStyle(fontSize: 20)),
//             ),
//             AlertTextField(
//               flagUrl: selectedToCurrency['flag']!,
//               currencyCode: selectedToCurrency['code']!,
//               isEditable: true,
//               controller: _desiredRateController2,
//               onCurrencyTap: () => _selectCurrency(false),
//             ),
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _createAlert,
//                 child: const Text('Create Alert'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AlertTextField extends StatelessWidget {
//   final String flagUrl;
//   final String currencyCode;
//   final bool isEditable;
//   final TextEditingController controller;
//   final VoidCallback onCurrencyTap;

//   const AlertTextField({
//     super.key,
//     required this.flagUrl,
//     required this.currencyCode,
//     required this.isEditable,
//     required this.controller,
//     required this.onCurrencyTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: controller,
//               keyboardType: TextInputType.number,
//               enabled: isEditable,
//               decoration: const InputDecoration(
//                 contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: onCurrencyTap,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               decoration: BoxDecoration(
//                 border: Border(left: BorderSide(color: Colors.grey.shade300)),
//               ),
//               child: Row(
//                 children: [
//                   Image.network(flagUrl, width: 24, height: 24),
//                   const SizedBox(width: 6),
//                   Text(currencyCode, style: Theme.of(context).textTheme.bodyMedium),
//                   if (isEditable) const Icon(Icons.arrow_drop_down, size: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:eproject_currensee/features/shop/screens/alert/all_alerts_page.dart';
import 'package:eproject_currensee/features/shop/screens/currencies/all_currencies_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreateAlertScreen extends StatefulWidget {
  final String latestPrice;
  final List<FlSpot> priceData;
  final Map<String, String> fromCurrency;
  final Map<String, String> toCurrency;

  const CreateAlertScreen({
    super.key,
    required this.latestPrice,
    required this.priceData,
    required this.fromCurrency,
    required this.toCurrency,
  });

  @override
  _CreateAlertScreenState createState() => _CreateAlertScreenState();
}

class _CreateAlertScreenState extends State<CreateAlertScreen> {
  final TextEditingController _desiredRateController1 = TextEditingController();
  final TextEditingController _desiredRateController2 = TextEditingController();

  late Map<String, String> selectedFromCurrency;
  late Map<String, String> selectedToCurrency;
  final box = GetStorage(); // 🔹 GetStorage instance

  @override
  void initState() {
    super.initState();
    selectedFromCurrency = widget.fromCurrency;
    selectedToCurrency = widget.toCurrency;
  }

  void _selectCurrency(bool isFromCurrency) async {
    final selectedCurrency = await Get.to(() => CurrencyListScreen());
    if (selectedCurrency != null && selectedCurrency is Map<String, String>) {
      setState(() {
        if (isFromCurrency) {
          selectedFromCurrency = selectedCurrency;
        } else {
          selectedToCurrency = selectedCurrency;
        }
      });
    }
  }

  void _createAlert() {
    String fromCode = selectedFromCurrency['code']!;
    String toCode = selectedToCurrency['code']!;
    String rate = _desiredRateController2.text;

    if (rate.isEmpty) {
      Get.snackbar('Error', 'Please enter a valid rate!');
      return;
    }

    // **Get previous alerts list**
    List<dynamic> existingAlerts = box.read<List>('alerts') ?? [];

    // **Add new alert**
    existingAlerts.add({
      "from": fromCode,
      "to": toCode,
      "rate": rate,
    });

    // **Save updated alerts list in storage**
    box.write('alerts', existingAlerts);

    // **Navigate to alerts page**
    Get.to(() => AllAlertsPage(
          latestPrice: '',
          priceData: [],
          fromCurrency: {},
          toCurrency: {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Create Alert'),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('When', style: TextStyle(fontSize: 20)),
            AlertTextField(
              flagUrl: selectedFromCurrency['flag']!,
              currencyCode: selectedFromCurrency['code']!,
              isEditable: true,
              controller: _desiredRateController1,
              onCurrencyTap: () => _selectCurrency(true),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('Equals', style: TextStyle(fontSize: 20)),
            ),
            AlertTextField(
              flagUrl: selectedToCurrency['flag']!,
              currencyCode: selectedToCurrency['code']!,
              isEditable: true,
              controller: _desiredRateController2,
              onCurrencyTap: () => _selectCurrency(false),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createAlert,
                child: const Text('Create Alert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertTextField extends StatelessWidget {
  final String flagUrl;
  final String currencyCode;
  final bool isEditable;
  final TextEditingController controller;
  final VoidCallback onCurrencyTap;

  const AlertTextField({
    super.key,
    required this.flagUrl,
    required this.currencyCode,
    required this.isEditable,
    required this.controller,
    required this.onCurrencyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              enabled: isEditable,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: onCurrencyTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Image.network(flagUrl, width: 24, height: 24),
                  const SizedBox(width: 6),
                  Text(currencyCode,
                      style: Theme.of(context).textTheme.bodyMedium),
                  if (isEditable) const Icon(Icons.arrow_drop_down, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
