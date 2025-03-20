// import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
// import 'package:eproject_currensee/features/shop/screens/alert/alert_page.dart';
// import 'package:eproject_currensee/features/shop/screens/alert/widget/create_alert_page.dart';
// import 'package:eproject_currensee/main.dart';
// import 'package:eproject_currensee/utils/popups/loaders.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:get_storage/get_storage.dart';
// import 'package:iconsax/iconsax.dart';

// class AllAlertsPage extends StatefulWidget {
//   final String latestPrice;
//   final List<FlSpot> priceData;
//   final Map<String, String> fromCurrency;
//   final Map<String, String> toCurrency;

//   const AllAlertsPage({
//     super.key,
//     required this.latestPrice,
//     required this.priceData,
//     required this.fromCurrency,
//     required this.toCurrency,
//   });

//   @override
//   _AllAlertsPageState createState() => _AllAlertsPageState();
// }

// class _AllAlertsPageState extends State<AllAlertsPage> {
//   final box = GetStorage();
//   List<dynamic> alerts = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadAlerts();
//   }

//   void _loadAlerts() {
//     List<dynamic> storedAlerts = box.read<List>('alerts') ?? [];
//     setState(() {
//       alerts = storedAlerts;
//     });

//     if (alerts.isEmpty) {
//       Get.off(() => AlertPage(
//             toCurrency: {},
//             latestPrice: '',
//             priceData: [],
//             fromCurrency: {},
//           ));
//     }
//   }

// void _checkPriceAndNotify() async {
//   // 1️⃣ Get Latest Price from API
//   final response = await http.get(Uri.parse('https://your-api-url.com/latest-price'));

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     String latestPrice = data["price"]; // API ka response handle karo

//     // 2️⃣ Check If Any Alert Matches This Price
//     for (var alert in alerts) {
//       if (latestPrice == alert["rate"]) {
//         _showNotification(alert);
//       }
//     }
//   }
// }

// // 3️⃣ Show Notification If Price Matches
// Future<void> _showNotification(Map<String, String> alert) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'currency_alerts', // Unique ID
//     'Currency Alerts', // Channel Name
//     importance: Importance.high,
//     priority: Priority.high,
//     playSound: true,
//   );

//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);

//   await flutterLocalNotificationsPlugin.show(
//     0, // Notification ID
//     'Currency Alert Hit! 🚀', // Title
//     'Your alert for 1 ${alert["from"]} = ${alert["rate"]} ${alert["to"]} has been hit!', // Body
//     platformChannelSpecifics,
//   );
// }

//   void _deleteAlert(int index) {
//     setState(() {
//       alerts.removeAt(index);
//       box.write('alerts', alerts);
//     });

//     if (alerts.isEmpty) {
//       // Snackbar show karne ke baad Create Alert Page pe redirect
//       // Get.snackbar(
//       //   "No Alerts Left",
//       //   "All alerts have been deleted. Redirecting to Create Alert...",
//       //   snackPosition: SnackPosition.BOTTOM,
//       //   backgroundColor: Colors.redAccent,
//       //   colorText: Colors.white,
//       //   duration: Duration(seconds: 2),
//       // );
//       Tloaders.errorSnackBar(
//           title: 'No Alerts Left',
//           message:
//               'All alerts have been deleted. Redirecting to Create Alert...');

//       Future.delayed(Duration(seconds: 2), () {
//         Get.off(() => CreateAlertScreen(
//               latestPrice: widget.latestPrice,
//               priceData: widget.priceData,
//               fromCurrency: widget.fromCurrency,
//               toCurrency: widget.toCurrency,
//             ));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TAppBar(
//         title: const Text('Rate Alerts'),
//         centerTitle: true,
//         showBackArrow: true,
//         action: [
//           IconButton(
//               onPressed: () => Get.to(() => CreateAlertScreen(
//                   latestPrice: widget.latestPrice,
//                   priceData: widget.priceData,
//                   fromCurrency: widget.fromCurrency,
//                   toCurrency: widget.toCurrency)),
//               icon: Icon(Iconsax.add_circle4))
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: alerts.length,
//         itemBuilder: (context, index) {
//           return AlertTile(
//             fromCurrency: alerts[index]["from"],
//             toCurrency: alerts[index]["to"],
//             rate: alerts[index]["rate"],
//             onDelete: () => _deleteAlert(index),
//           );
//         },
//       ),
//     );
//   }
// }

// class AlertTile extends StatelessWidget {
//   final String fromCurrency;
//   final String toCurrency;
//   final String rate;
//   final VoidCallback onDelete;

//   const AlertTile({
//     required this.fromCurrency,
//     required this.toCurrency,
//     required this.rate,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0.5,
//       margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Icon(Icons.notifications_active_rounded,
//             color: Colors.amber, size: 28),
//         title: Text("You'll get an alert",
//             style: TextStyle(fontSize: 14, color: Colors.grey)),
//         subtitle: Text("1 $fromCurrency = $rate $toCurrency",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//         trailing: IconButton(
//             icon: Icon(Iconsax.trash, color: Colors.red), onPressed: onDelete),
//       ),
//     );
//   }
// }

import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:eproject_currensee/features/shop/screens/alert/alert_page.dart';
import 'package:eproject_currensee/navigation_menu.dart';
import 'package:eproject_currensee/utils/popups/loaders.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

// 🔔 Local Notifications Plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AllAlertsPage extends StatefulWidget {
  final String latestPrice;
  final List<FlSpot> priceData;
  final Map<String, String> fromCurrency;
  final Map<String, String> toCurrency;

  const AllAlertsPage({
    super.key,
    required this.latestPrice,
    required this.priceData,
    required this.fromCurrency,
    required this.toCurrency,
  });

  @override
  _AllAlertsPageState createState() => _AllAlertsPageState();
}

class _AllAlertsPageState extends State<AllAlertsPage> {
  final box = GetStorage();
  List<dynamic> alerts = [];

//String apiKey = "012bad8521fc97af1f6d9696";
  String apiKey = "012bad821fc97af1f6d9696";
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadAlerts();
  }

  // 🔔 Local Notifications Initialization
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // 📥 Load Alerts from Storage
  void _loadAlerts() {
    List<dynamic> storedAlerts = box.read<List>('alerts') ?? [];
    setState(() {
      alerts = storedAlerts;
    });

    if (alerts.isEmpty) {
      Get.off(() => AlertPage(
            toCurrency: {},
            latestPrice: '',
            priceData: [],
            fromCurrency: {},
          ));
    }
  }

  // 🔍 Check Price and Notify
  void checkPriceAndNotify() async {
    try {
      final response = await http.get(Uri.parse(
          'https://v6.exchangerate-api.com/v6/$apiKey/latest/${widget.fromCurrency["code"]}'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String latestPrice =
            data["conversion_rates"][widget.toCurrency["code"]].toString();

        for (var alert in alerts) {
          if (latestPrice == alert["rate"]) {
            _showNotification(alert);
          }
        }
      } else {
        debugPrint("⚠️ API Response Failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Error Fetching Price: $e");
    }
  }

  // 🔔 Show Notification
  Future<void> _showNotification(Map<String, String> alert) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'currency_alerts',
      'Currency Alerts',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Currency Alert Hit! 🚀',
      'Your alert for 1 ${alert["from"]} = ${alert["rate"]} ${alert["to"]} has been hit!',
      platformChannelSpecifics,
    );
  }

  // 🗑️ Delete Alert
  void _deleteAlert(int index) {
    setState(() {
      alerts.removeAt(index);
      box.write('alerts', alerts);
    });

    if (alerts.isEmpty) {
      Tloaders.errorSnackBar(
          title: 'No Alerts Left',
          message:
              'All alerts have been deleted.');

      Future.delayed(const Duration(seconds: 2), () {
        Get.to(() => NavigationMenu());

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Rate Alerts'),
        centerTitle: true,
        // action: [
        //   IconButton(
        //       onPressed: () => Get.to(() => CreateAlertScreen(
        //             latestPrice: widget.latestPrice ?? '0.0', // Default price
        //             priceData: widget.priceData.isNotEmpty
        //                 ? widget.priceData
        //                 : [FlSpot(0, 0)], // Default List
        //             fromCurrency: widget.fromCurrency.isNotEmpty
        //                 ? widget.fromCurrency
        //                 : {"code": "USD", "name": "US Dollar"},
        //             toCurrency: widget.toCurrency.isNotEmpty
        //                 ? widget.toCurrency
        //                 : {"code": "EUR", "name": "Euro"},
        //           )),
        //       icon: const Icon(Iconsax.add_circle4))
        // ],
      ),
      body: alerts.isEmpty
          ? const Center(
              child: Text("No alerts set. Tap + to create one!",
                  style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                return AlertTile(
                  fromCurrency: alerts[index]["from"],
                  toCurrency: alerts[index]["to"],
                  rate: alerts[index]["rate"],
                  onDelete: () => _deleteAlert(index),
                );
              },
            ),
    );
  }
}

class AlertTile extends StatelessWidget {
  final String fromCurrency;
  final String toCurrency;
  final String rate;
  final VoidCallback onDelete;

  const AlertTile({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.notifications_active_rounded,
            color: Colors.amber, size: 28),
        title: const Text("You'll get an alert",
            style: TextStyle(fontSize: 14, color: Colors.grey)),
        subtitle: Text("1 $fromCurrency = $rate $toCurrency",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: IconButton(
            icon: const Icon(Iconsax.trash, color: Colors.red),
            onPressed: onDelete),
      ),
    );
  }
}
