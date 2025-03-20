// import 'package:eproject_currensee/features/shop/screens/currencies/all_currencies_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ConvertScreen extends StatefulWidget {
//   const ConvertScreen({super.key});

//   @override
//   _ConvertScreenState createState() => _ConvertScreenState();
// }

// class _ConvertScreenState extends State<ConvertScreen> {
//   final TextEditingController amountController =
//       TextEditingController(text: "1.00");

//   String latestPrice = "Loading...";
//   double conversionRate = 1.0;

//   List<Map<String, dynamic>> selectedCurrencies = [
//     {
//       "code": "USD",
//       "name": "United States Dollar",
//       "flag": "https://flagcdn.com/w80/us.png",
//       "controller": TextEditingController(text: "1.00"),
//     },
//     {
//       "code": "PKR",
//       "name": "Pakistani Rupee",
//       "flag": "https://flagcdn.com/w80/pk.png",
//       "controller": TextEditingController(text: "0.00"),
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchPriceData();
//   }

//   Future<void> fetchPriceData() async {
//     String apiKey = "012bad8521fc97af1f6d9696"; // Replace with your API key
//     String url =
//         "https://v6.exchangerate-api.com/v6/$apiKey/latest/${selectedCurrencies[0]['code']}";

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         conversionRate =
//             data["conversion_rates"][selectedCurrencies[1]['code']] ?? 0.0;

//         setState(() {
//           latestPrice = "$conversionRate ${selectedCurrencies[1]['code']}";
//           updateConversion(); // Update second field based on new conversion rate
//         });
//       } else {
//         setState(() {
//           latestPrice = "Error fetching price";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         latestPrice = "Error fetching price";
//       });
//     }
//   }

//   Future<void> selectCurrency(int index) async {
//     final selectedCurrency = await Get.to(() => CurrencyListScreen());

//     if (selectedCurrency != null) {
//       setState(() {
//         selectedCurrencies[index] = {
//           "code": selectedCurrency["code"],
//           "name": selectedCurrency["name"],
//           "flag": selectedCurrency["flag"],
//           "controller": TextEditingController(
//               text: index == 1 ? "0.00" : selectedCurrencies[index]['controller'].text),
//         };
//         fetchPriceData();
//       });
//     }
//   }

//   void updateConversion() {
//     double inputAmount = double.tryParse(selectedCurrencies[0]['controller'].text) ?? 1.0;
//     double convertedAmount = inputAmount * conversionRate;

//     setState(() {
//       selectedCurrencies[1]['controller'].text = convertedAmount.toStringAsFixed(2);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 30),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Convert",
//                     style:
//                         TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

//               ],
//             ),
//             const SizedBox(height: 10),
//             Text("1 ${selectedCurrencies[0]['code']} = $latestPrice",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),

//             // Currency List Tiles with Updated UI
//             Column(
//               children: List.generate(selectedCurrencies.length, (index) {
//                 return currencyTile(selectedCurrencies[index], index);
//               }),
//             ),

//             const SizedBox(height: 16),

//             Center(
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => updateConversion(),
//                   child: const Text('Convert'),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ));
//   }

//   Widget currencyTile(Map<String, dynamic> currency, int index) {
//     return GestureDetector(
//       onTap: () => selectCurrency(index),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Row(
//           children: [
//             Image.network(currency['flag'],
//                 height: 24,
//                 width: 40,
//                 errorBuilder: (_, __, ___) => const Icon(Icons.flag)),
//             const SizedBox(width: 10),
//             Text(currency['code'], style: const TextStyle(fontSize: 18)),
//             const Spacer(),
//             SizedBox(
//               width: 120,
//               child: TextField(
//                 controller: currency['controller'],
//                 keyboardType: TextInputType.number,
//                 textAlign: TextAlign.end,
//                 onChanged: (value) {
//                   if (index == 0) updateConversion();
//                 },
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   hintText: "0.00",
//                 ),
//                 enabled: index == 0, // 🔹 Disable second field
//               ),
//             ),
//             const Icon(Icons.more_vert_outlined, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:eproject_currensee/features/shop/screens/currencies/all_currencies_page.dart';
import 'package:eproject_currensee/features/shop/screens/history/conversion_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({super.key});

  @override
  _ConvertScreenState createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  final TextEditingController amountController =
      TextEditingController(text: "1.00");

  String latestPrice = "Loading...";
  double conversionRate = 1.0;
  final box = GetStorage(); // GetStorage for local history storage

  List<Map<String, dynamic>> selectedCurrencies = [
    {
      "code": "USD",
      "name": "United States Dollar",
      "flag": "https://flagcdn.com/w80/us.png",
      "controller": TextEditingController(text: "1.00"),
    },
    {
      "code": "PKR",
      "name": "Pakistani Rupee",
      "flag": "https://flagcdn.com/w80/pk.png",
      "controller": TextEditingController(text: "0.00"),
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchPriceData();
  }

  Future<void> fetchPriceData() async {
    String apiKey = "12bad8521fc97af1f6d9696"; // Replace with your API key
    String url =
        "https://v6.exchangerate-api.com/v6/$apiKey/latest/${selectedCurrencies[0]['code']}";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        conversionRate =
            data["conversion_rates"][selectedCurrencies[1]['code']] ?? 0.0;

        setState(() {
          latestPrice = "$conversionRate ${selectedCurrencies[1]['code']}";
          updateConversion(); // Update second field based on new conversion rate
        });
      } else {
        setState(() {
          latestPrice = "Error fetching price";
        });
      }
    } catch (e) {
      setState(() {
        latestPrice = "Error fetching price";
      });
    }
  }

  Future<void> selectCurrency(int index) async {
    final selectedCurrency = await Get.to(() => CurrencyListScreen());

    if (selectedCurrency != null) {
      setState(() {
        selectedCurrencies[index] = {
          "code": selectedCurrency["code"],
          "name": selectedCurrency["name"],
          "flag": selectedCurrency["flag"],
          "controller": TextEditingController(
              text: index == 1
                  ? "0.00"
                  : selectedCurrencies[index]['controller'].text),
        };
        fetchPriceData();
      });
    }
  }

  void updateConversion() {
    double inputAmount =
        double.tryParse(selectedCurrencies[0]['controller'].text) ?? 1.0;
    double convertedAmount = inputAmount * conversionRate;

    setState(() {
      selectedCurrencies[1]['controller'].text =
          convertedAmount.toStringAsFixed(2);
    });
  }

  void saveConversion() {
    double inputAmount =
        double.tryParse(selectedCurrencies[0]['controller'].text) ?? 1.0;
    double convertedAmount = inputAmount * conversionRate;

    Map<String, dynamic> newConversion = {
      "from": selectedCurrencies[0]['code'],
      "to": selectedCurrencies[1]['code'],
      "amount": inputAmount.toStringAsFixed(2),
      "convertedAmount": convertedAmount.toStringAsFixed(2),
      "timestamp": DateTime.now().toString(),
    };

    List<dynamic> history = box.read<List>('conversionHistory') ?? [];
    history.add(newConversion);
    box.write('conversionHistory', history);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Convert"),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const ConversionHistory());
              },
              icon: const Icon(Icons.history, color: Colors.white),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text("1 ${selectedCurrencies[0]['code']} = $latestPrice",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Column(
                  children: List.generate(selectedCurrencies.length, (index) {
                    return currencyTile(selectedCurrencies[index], index);
                  }),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        updateConversion();
                        saveConversion();
                      },
                      child: const Text('Convert'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget currencyTile(Map<String, dynamic> currency, int index) {
    return GestureDetector(
      onTap: () => selectCurrency(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Image.network(currency['flag'],
                height: 24,
                width: 40,
                errorBuilder: (_, __, ___) => const Icon(Icons.flag)),
            const SizedBox(width: 10),
            Text(currency['code'], style: const TextStyle(fontSize: 18)),
            const Spacer(),
            SizedBox(
              width: 120,
              child: TextField(
                controller: currency['controller'],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.end,
                onChanged: (value) {
                  if (index == 0) updateConversion();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "0.00",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                enabled: index == 0, // 🔹 Disable second field
              ),
            ),
            const Icon(Icons.more_vert_outlined, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
