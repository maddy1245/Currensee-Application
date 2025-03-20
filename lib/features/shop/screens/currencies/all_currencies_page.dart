import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyListScreen extends StatefulWidget {
  const CurrencyListScreen({super.key});

  @override
  _CurrencyListScreenState createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  List<Map<String, String>> currencyList = [];
  List<Map<String, String>> filteredCurrencyList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCurrencyData();
  }

  Future<void> fetchCurrencyData() async {
    final currencyResponse = await http
        .get(Uri.parse('https://openexchangerates.org/api/currencies.json'));
    if (currencyResponse.statusCode == 200) {
      Map<String, dynamic> currencies = json.decode(currencyResponse.body);

      List<Map<String, String>> tempList = [];
      for (var code in currencies.keys) {
        String flagUrl =
            'https://flagcdn.com/w80/${code.substring(0, 2).toLowerCase()}.png';

        tempList.add({
          'code': code,
          'name': currencies[code],
          'flag': flagUrl,
        });
      }

      setState(() {
        currencyList = tempList;
        filteredCurrencyList = tempList;
      });
    } else {
      // Handle error
      print('Failed to load currencies');
    }
  }

  void filterSearch(String query) {
    List<Map<String, String>> filteredList = currencyList
        .where((currency) =>
            currency['code']!.toLowerCase().contains(query.toLowerCase()) ||
            currency['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredCurrencyList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Select Currency'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) => filterSearch(value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCurrencyList.length,
              itemBuilder: (context, index) {
                return ListTile(
                   leading: Image.network(
                    filteredCurrencyList[index]['flag']!,
                    width: 40,
                    height: 30,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.flag);
                    },
                  ),
                  title: Text(filteredCurrencyList[index]['code']!),
                  subtitle: Text(filteredCurrencyList[index]['name']!),
                  onTap: () {
                    Navigator.pop(context, filteredCurrencyList[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
