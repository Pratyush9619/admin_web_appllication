import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/provider/demandEnergyProvider.dart';
import 'package:web_appllication/screen/demand%20energy%20management/demand%20energy%20management/bar_graph.dart';
import 'package:web_appllication/screen/demand%20energy%20management/demand%20energy%20management/demand_table.dart';

class DemandEnergyScreen extends StatefulWidget {
  const DemandEnergyScreen({super.key});

  @override
  State<DemandEnergyScreen> createState() => _DemandEnergyScreenState();
}

class _DemandEnergyScreenState extends State<DemandEnergyScreen> {
  List<dynamic> energyConsumedList = [];
  List<dynamic> timeIntervalList = [];
  List<dynamic> dateList = [];
  //Data table columns & rows
  List<String> columns = [
    'Sr.No.',
    'CityName',
    'Depot',
    'Energy Consumed\n(in kW)'
  ];

  List<List<dynamic>> rows = [];

  List<String> quaterlyMonths = ['Mar', 'Jun', 'Sep', 'Dec'];

  final currentDate = DateTime.now();
  final currentDay = DateFormat.yMMMMd().format(DateTime.now());
  final currentYear = DateTime.now().year;

  dynamic currentMonth;

  @override
  void initState() {
    super.initState();
    //Load Daily Data for Tables and Graphs
  }

  @override
  Widget build(BuildContext context) {
    currentMonth = DateFormat('MMMM').format(currentDate);

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: DemandTable(
              getMonthlyData: getCurrentMonthData,
              getDailyData: getCurrentDayData,
              columns: columns,
              rows: rows,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: BarGraphScreen(
              energyConsumedList: energyConsumedList,
              timeIntervalList: timeIntervalList,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(Provider.of<DemandEnergyProvider>(context, listen: false)
              .selectedDepo);
        },
        child: const Icon(Icons.ad_units),
      ),
    );
  }

  Future<void> getCurrentDayData() async {
    try {
      rows.clear();
      timeIntervalList.clear();
      energyConsumedList.clear();
      print('Callback Called');
      final selectedDepoName =
          Provider.of<DemandEnergyProvider>(context, listen: false)
              .selectedDepo;

      final selectedCityName =
          Provider.of<DemandEnergyProvider>(context, listen: false)
              .selectedCity;

      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(selectedDepoName)
          .collection('Year')
          .doc(currentYear.toString())
          .collection('Months')
          .doc(currentMonth)
          .collection('Date')
          .doc(currentDay)
          .collection('UserId');

      dateList.add(currentDay);

      QuerySnapshot querySnapshot = await collectionReference.get();

      List<dynamic> allUsers =
          querySnapshot.docs.map((userid) => userid.id).toList();
      print('All Users - $allUsers');
      for (int i = 0; i < allUsers.length; i++) {
        DocumentSnapshot daySnap =
            await collectionReference.doc(allUsers[i]).get();
        Map<String, dynamic> mapData = daySnap.data() as Map<String, dynamic>;
        List<dynamic> userData = mapData['data'];

        for (var user in userData) {
          List<dynamic> row = [];
          timeIntervalList.add(user['timeInterval']);
          energyConsumedList.add(user['enrgyConsumed']);
          row.add(user['srNo']);
          row.add(selectedCityName);
          row.add(selectedDepoName);
          row.add(user['enrgyConsumed']);
          rows.add(row);
        }
      }
      print('Rows - $rows');

      //Sets Start and End Date for provider
      getStartEndDate();
    } catch (e) {
      print('Error Occured - $e');
    }
  }

  Future<void> getCurrentMonthData() async {
    try {
      rows.clear();
      timeIntervalList.clear();
      energyConsumedList.clear();
      print('Callback Called');
      final selectedDepoName =
          Provider.of<DemandEnergyProvider>(context, listen: false)
              .selectedDepo;

      final selectedCityName =
          Provider.of<DemandEnergyProvider>(context, listen: false)
              .selectedCity;

      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(selectedDepoName)
          .collection('Year')
          .doc(currentYear.toString())
          .collection('Months')
          .doc(currentMonth)
          .collection('Date');

      // dateList.add(currentDay);

      QuerySnapshot monthlyQuerySnap = await collectionReference.get();
      List<dynamic> monthlyDateList =
          monthlyQuerySnap.docs.map((e) => e.id).toList();

      for (int i = 0; i < monthlyDateList.length; i++) {
        List<dynamic> allUsers =
            querySnapshot.docs.map((userid) => userid.id).toList();
        print('All Users - $allUsers');
        for (int i = 0; i < allUsers.length; i++) {
          DocumentSnapshot daySnap =
              await collectionReference.doc(allUsers[i]).get();
          Map<String, dynamic> mapData = daySnap.data() as Map<String, dynamic>;
          List<dynamic> userData = mapData['data'];

          for (var user in userData) {
            List<dynamic> row = [];
            timeIntervalList.add(user['timeInterval']);
            energyConsumedList.add(user['enrgyConsumed']);
            row.add(user['srNo']);
            row.add(selectedCityName);
            row.add(selectedDepoName);
            row.add(user['enrgyConsumed']);
            rows.add(row);
          }
        }
        print('Rows - $rows');
      }

      //Sets Start and End Date for provider
      getStartEndDate();
    } catch (e) {
      print('Error Occured - $e');
    }
  }

  void getStartEndDate() {
    dateList.sort();
    final provider = Provider.of<DemandEnergyProvider>(context, listen: false);
    final startDate = dateList.first;
    provider.setStartDate(startDate);
    final endDate = dateList.last;
    provider.setEndDate(endDate);
  }
}
