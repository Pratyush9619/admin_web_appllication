import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/provider/All_Depo_Select_Provider.dart';
import 'package:web_appllication/provider/demandEnergyProvider.dart';
import 'package:web_appllication/style.dart';

class DemandTable extends StatefulWidget {
  final Future<dynamic> Function() getDailyData;
  final Future<dynamic> Function() getMonthlyData;
  final Future<dynamic> Function() getQuaterlyData;
  final Future<dynamic> Function() getYearlyData;
  final List<dynamic> columns;
  final List<dynamic> rows;

  DemandTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.getDailyData,
    required this.getMonthlyData,
    required this.getQuaterlyData,
    required this.getYearlyData,
  });

  @override
  State<DemandTable> createState() => _DemandTableState();
}

class _DemandTableState extends State<DemandTable>
    with SingleTickerProviderStateMixin {
  List<dynamic> depoList = [];
  List<String> citiesList = [];
  List<dynamic> searchedList = [];
  List<dynamic> searchedDepoList = [];
  TextEditingController cityController = TextEditingController();
  TextEditingController selectedDepo = TextEditingController();
  final tableHeadingColor = Colors.blue;
  final tableRowColor = Colors.white;
  bool isDepoSelected = false;
  bool isCitySelected = false;

  @override
  void initState() {
    super.initState();
    getCityList();
  }

  @override
  Widget build(BuildContext context) {
    final demandEnergyProvider =
        Provider.of<DemandEnergyProvider>(context, listen: false);
    final allDepoProvider =
        Provider.of<AllDepoSelectProvider>(context, listen: false);
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 234, 243, 250),
                borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.only(bottom: 15, top: 10),
            child: const Text(
              'Demand Energy Management Table',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              //Type head for city name
              Container(
                margin: const EdgeInsets.only(left: 30),
                height: 40,
                width: 200,
                child: TypeAheadField(
                  hideOnLoading: true,
                  animationDuration: const Duration(milliseconds: 1000),
                  animationStart: 0,
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    controller: cityController,
                    decoration: const InputDecoration(
                      labelText: 'Select a City',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.toString(),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) async {
                    isCitySelected = true;
                    cityController.text = suggestion.toString();
                    demandEnergyProvider.setCityName(suggestion.toString());
                    await getDepoData(suggestion.toString());
                    demandEnergyProvider.setDepoList(depoList);
                  },
                  suggestionsCallback: (String pattern) async {
                    return await getUserdata(pattern);
                  },
                ),
              ),

              //Type head for depo name

              Container(
                margin: const EdgeInsets.all(5),
                height: 40,
                width: 260,
                child: TypeAheadField(
                  hideOnLoading: true,
                  animationDuration: const Duration(milliseconds: 1000),
                  animationStart: 0,
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    controller: selectedDepo,
                    decoration: const InputDecoration(
                      labelText: 'Select a Depot',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.toString(),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) async {
                    isDepoSelected = true;
                    allDepoProvider.setCheckedBool(false);
                    selectedDepo.text = suggestion.toString();
                    demandEnergyProvider.setDepoName(suggestion.toString());
                    await widget.getDailyData();
                    demandEnergyProvider.reloadWidget(true);
                  },
                  suggestionsCallback: (String pattern) async {
                    if (pattern.isEmpty) {
                      isDepoSelected = false;
                      allDepoProvider.reloadCheckbox();
                    }
                    return depoList;
                    // return await getDepoData(pattern);
                  },
                ),
              ),
              Consumer<AllDepoSelectProvider>(
                builder: (context, providerValue, child) {
                  return Container(
                      height: 40,
                      width: 150,
                      child: CheckboxListTile(
                        title: const Text(
                          'All Depots',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        value: providerValue.isChecked,
                        onChanged: isDepoSelected
                            ? null
                            : demandEnergyProvider.isLoadingBarCandle
                                ? null
                                : (value) async {
                                    if (providerValue.isChecked == false &&
                                        isCitySelected == true) {
                                      providerValue
                                          .setCheckedBool(value ?? false);
                                      demandEnergyProvider.setLoadingBarCandle(
                                          true); //Show loading bar
                                      providerValue.reloadCheckbox();
                                      // demandEnergyProvider
                                      //     .setDepoList(depoList);
                                      await demandEnergyProvider
                                          .getAllDepoDailyData!();
                                      demandEnergyProvider.setLoadingBarCandle(
                                          false); //Stop loading bar
                                      providerValue.reloadCheckbox();
                                      demandEnergyProvider.reloadWidget(true);
                                    } else if (isCitySelected == false) {
                                      showCustomAlert();
                                    } else {
                                      providerValue
                                          .setCheckedBool(value ?? false);
                                    }
                                  },
                      ));
                },
              )
            ],
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 30),
              height: 400,
              child: Consumer<AllDepoSelectProvider>(
                builder: (context, value, child) {
                  return Consumer<DemandEnergyProvider>(
                    builder: (context, providerValue, child) {
                      return demandEnergyProvider.isLoadingBarCandle
                          ? LoadingPage()
                          : DataTable2(
                              columnSpacing: 15,
                              headingRowColor:
                                  MaterialStatePropertyAll(tableHeadingColor),
                              dataRowColor:
                                  MaterialStatePropertyAll(tableRowColor),
                              border: TableBorder.all(),
                              dividerThickness: 0,
                              dataRowHeight: 40,
                              headingRowHeight: 45,
                              headingTextStyle: TextStyle(
                                  color: white, fontWeight: FontWeight.bold),
                              dataTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold, color: black),
                              columns: List.generate(
                                widget.columns.length,
                                (index) => DataColumn2(
                                  fixedWidth: index == 0
                                      ? 50
                                      : index == 1
                                          ? 170
                                          : index == 3
                                              ? 140
                                              : null,
                                  label: Text(
                                    widget.columns[index],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              rows: List.generate(
                                widget.rows.length,
                                (rowNo) {
                                  return DataRow2(
                                    cells: List.generate(
                                      widget.rows[0].length,
                                      (cellNo) => DataCell(
                                        Text(
                                          widget.rows[rowNo][cellNo].toString(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  showCustomAlert() async {
    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 120,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber,
                    size: 60,
                    color: blue,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: const Text(
                      'Please select a city first !',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: white),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  getUserdata(String input) async {
    searchedList.clear();
    print(citiesList);

    for (int i = 0; i < citiesList.length; i++) {
      if (citiesList[i].toUpperCase().contains(input.trim().toUpperCase())) {
        searchedList.add(citiesList[i]);
      }
    }
    if (cityController.text.isEmpty) {
      isCitySelected = false;
    }
    // citiesList.clear();
    return searchedList;
  }

  void getCityList() async {
    QuerySnapshot citySnap =
        await FirebaseFirestore.instance.collection('DepoName').get();
    citiesList = citySnap.docs.map((city) => city.id).toList();
  }

  getDepoData(String input) async {
    searchedDepoList.clear();
    depoList.clear();

    final allCheckboxProvider =
        Provider.of<AllDepoSelectProvider>(context, listen: false);

    if (cityController.text.isNotEmpty) {
      QuerySnapshot depoSnap = await FirebaseFirestore.instance
          .collection('DepoName')
          .doc(cityController.text)
          .collection('AllDepots')
          .get();

      List<String> depoNameList = depoSnap.docs.map((depo) => depo.id).toList();
      searchedDepoList = depoNameList;
      depoList = depoNameList;
    } else {
      searchedDepoList.add('Please Select a City');
    }
    if (selectedDepo.text.isEmpty) {
      isDepoSelected = false;
      allCheckboxProvider.reloadCheckbox();
    }

    return searchedDepoList;
  }
}
