import 'package:eproject_currensee/features/shop/screens/alert/alert_page.dart';
import 'package:eproject_currensee/features/shop/screens/alert/all_alerts_page.dart';
import 'package:eproject_currensee/features/shop/screens/alert/widget/create_alert_page.dart';
import 'package:eproject_currensee/features/shop/screens/currencies/all_currencies_page.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FlSpot> priceData = [];
  Timer? _timer;
  String latestPrice = "Loading...";  
  //String apiKey = "012bad8521fc97af1f6d9696";
   String apiKey = "012bad821fc97af1f6d9696";

  // Default currencies
  Map<String, String> fromCurrency = {
    "code": "USD",
    "name": "United States Dollar",
    "flag": "https://flagcdn.com/w80/us.png"
  };

  Map<String, String> toCurrency = {
    "code": "PKR",
    "name": "Pakistani Rupee",
    "flag": "https://flagcdn.com/w80/pk.png"
  };

  @override
  void initState() {
    super.initState();
    fetchPriceData();
    // Auto-refresh after 10 sec to avoid frequent API calls
    _timer = Timer.periodic(Duration(seconds: 10), (timer) => fetchPriceData());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Fetch Latest Exchange Rate
  Future<void> fetchPriceData() async {
    String url =
        "https://v6.exchangerate-api.com/v6/$apiKey/latest/${fromCurrency['code']}";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        double price = data["conversion_rates"][toCurrency['code']] ?? 0.0;

        setState(() {
          latestPrice = "$price ${toCurrency['code']}";
          if (priceData.length > 50) priceData.removeAt(0);
          priceData.add(FlSpot(priceData.length.toDouble(), price));
        });
      } else {
        setState(() {
          latestPrice = "Error fetching price";
        });
      }
    } catch (e) {
      print("Error fetching price: $e");
      setState(() {
        latestPrice = "Error fetching price";
      });
    }
  }

  /// Select Currency from List
  Future<void> selectCurrency(bool isFromCurrency) async {
    final selectedCurrency = await Get.to(() => CurrencyListScreen());

    if (selectedCurrency != null) {
      setState(() {
        if (isFromCurrency) {
          fromCurrency = selectedCurrency;
        } else {
          toCurrency = selectedCurrency;
        }
        priceData.clear(); // Reset graph for new currency
        fetchPriceData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Welcome",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      final box = GetStorage();
                      List<dynamic> alerts =
                          box.read<List>('alerts') ?? []; // Read saved alerts

                      if (alerts.isNotEmpty) {
                        Get.to(() => AllAlertsPage(
                              latestPrice: latestPrice,
                              priceData: priceData,
                              fromCurrency: fromCurrency,
                              toCurrency: toCurrency,
                            ));
                      } else {
                        Get.to(() => AlertPage(
                              latestPrice: latestPrice,
                              priceData: priceData,
                              fromCurrency: fromCurrency,
                              toCurrency: toCurrency,
                            ));
                      }
                    },
                    icon: const Icon(Iconsax.notification),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Currency Selector Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => selectCurrency(true),
                          child: Row(
                            children: [
                              Image.network(fromCurrency['flag']!,
                                  height: 24,
                                  width: 40,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.flag)),
                              const SizedBox(width: 8),
                              Text(fromCurrency['code']!,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            ],
                          ),
                        ),
                        const Icon(Icons.swap_horiz),
                        GestureDetector(
                          onTap: () => selectCurrency(false),
                          child: Row(
                            children: [
                              Image.network(toCurrency['flag']!,
                                  height: 24,
                                  width: 40,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.flag)),
                              const SizedBox(width: 8),
                              Text(toCurrency['code']!,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text("1 ${fromCurrency['code']} = $latestPrice",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text("Live Price",
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 20),

                    // Graph Display
                    SizedBox(
                      height: 200,
                      child: priceData.isNotEmpty
                          ? LineChart(
                              LineChartData(
                                gridData: FlGridData(show: false),
                                titlesData: FlTitlesData(show: false),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: priceData,
                                    isCurved: true,
                                    color: Colors.blue,
                                    barWidth: 3,
                                    isStrokeCapRound: true,
                                    belowBarData: BarAreaData(show: false),
                                  ),
                                ],
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(height: 20),

                    // Create Alert Button
                    ElevatedButton(
                      onPressed: () => Get.to(() => CreateAlertScreen(
                            latestPrice: latestPrice,
                            priceData: priceData,
                            fromCurrency: fromCurrency,
                            toCurrency: toCurrency,
                          )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Center(
                        child: Text("Create Alert",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Transfers Section
           
          ],
        ),
      ),
    );
  }
}
