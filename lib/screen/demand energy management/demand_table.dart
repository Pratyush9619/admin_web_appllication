import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/components/loading_page.dart';
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

class _DemandTableState extends State<DemandTable> {
  List<String> citiesList = [];
  List<dynamic> searchedList = [];
  List<dynamic> searchedDepoList = [];
  TextEditingController cityController = TextEditingController();
  TextEditingController selectedDepo = TextEditingController();
  final tableHeadingColor = Colors.blue;
  final tableRowColor = Colors.white;

  @override
  void initState() {
    super.initState();
    getCityList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DemandEnergyProvider>(context, listen: false);
    return Material(
      child: Container(
        margin: const EdgeInsets.only(left: 30, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40, top: 70),
              child: const Text(
                'Depot Demand Energy Management Table',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              children: [
                //Type head for city name
                Container(
                  margin: const EdgeInsets.all(5),
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
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 15),
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
                      cityController.text = suggestion.toString();
                      provider.setCityName(suggestion.toString());
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
                  width: 300,
                  child: TypeAheadField(
                    hideOnLoading: true,
                    animationDuration: Duration(milliseconds: 1000),
                    animationStart: 0,
                    textFieldConfiguration: TextFieldConfiguration(
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      controller: selectedDepo,
                      decoration: const InputDecoration(
                        labelText: 'Select a Depot',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 15),
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
                      selectedDepo.text = suggestion.toString();
                      provider.setDepoName(suggestion.toString());
                      await widget.getDailyData();
                      provider.reloadWidget(true);
                      print('Hello World');
                    },
                    suggestionsCallback: (String pattern) async {
                      return await getDepoData(pattern);
                    },
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(
                height: 400,
                child: Consumer<DemandEnergyProvider>(
                  builder: (context, providerValue, child) {
                    return provider.isLoadingBarCandle
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
                            headingRowHeight: 50,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUserdata(String input) async {
    searchedList.clear();

    for (int i = 0; i < citiesList.length; i++) {
      if (citiesList[i].toUpperCase().contains(input.trim().toUpperCase())) {
        searchedList.add(citiesList[i]);
      }
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

    if (cityController.text.isNotEmpty) {
      QuerySnapshot depoSnap = await FirebaseFirestore.instance
          .collection('DepoName')
          .doc(cityController.text)
          .collection('AllDepots')
          .get();

      List<String> depoNameList = depoSnap.docs.map((depo) => depo.id).toList();
      searchedDepoList = depoNameList;
    } else {
      searchedDepoList.add('Please Select a City');
    }

    return searchedDepoList;
  }
}
