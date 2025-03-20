import 'dart:convert';
import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/helpers/helper_function.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  List countries = [];
  List filteredCountries = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCountries();
    searchController.addListener(() {
      filterCountries();
    });
  }

  Future<void> fetchCountries() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      data.sort((a, b) => a["name"]["common"]
          .toString()
          .compareTo(b["name"]["common"].toString())); // Sort alphabetically
      setState(() {
        countries = data;
        filteredCountries = data;
      });
    }
  }

  void filterCountries() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredCountries = countries
          .where((country) => country["name"]["common"]
              .toString()
              .toLowerCase()
              .contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
      ),
      body: Column(
        children: [
          SizedBox(height: Tsizes.spacebtwsections),
          Text('Where Do You Live?',
              style: Theme.of(context).textTheme.headlineLarge),
          SizedBox(height: Tsizes.spacebtwsections),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Tsizes.defaultspace),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: THelperFunction.isDarkMode(context)
                    ? Colors.black
                    : Colors.grey.shade200,
              ),  
            ),
          ),
          SizedBox(height: Tsizes.spacebtwsections),
          Expanded(
            child: filteredCountries.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      var country = filteredCountries[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(country["flags"]["png"] ?? ""),
                          backgroundColor: Colors.grey[300],
                        ),
                        title: Text(
                          country["name"]["common"],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.pop(context, {
                            "name": country["name"]["common"],
                            "flag": country["flags"]["png"],
                          });
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
