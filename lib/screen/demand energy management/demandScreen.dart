import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/provider/demandEnergyProvider.dart';
import 'package:web_appllication/screen/demand%20energy%20management/bar_graph.dart';
import 'package:web_appllication/screen/demand%20energy%20management/demand_table.dart';
import 'package:web_appllication/style.dart';

class DemandEnergyScreen extends StatefulWidget {
  bool showStartEndDatePanel;
  DemandEnergyScreen({super.key, this.showStartEndDatePanel = false});

  @override
  State<DemandEnergyScreen> createState() => _DemandEnergyScreenState();
}

class _DemandEnergyScreenState extends State<DemandEnergyScreen> {
  List<double> energyConsumedList = [];
  List<dynamic> timeIntervalList = [];
  List<dynamic> monthList = [];
  List<dynamic> dateList = [];
  List<double> quaterlyEnergyConsumedList = [];
  List<double> yearlyEnergyConsumedList = [];
  double totalEnergyConsumedQuaterly = 0;

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

    final provider = Provider.of<DemandEnergyProvider>(context, listen: false);

    //Set Callback Function in provider
    provider.setCurrentDayFunction(getCurrentDayData);
    provider.setCurrentMonthFunction(getCurrentMonthData);
    provider.setQuaterlyFunction(getQuaterlyData);
    provider.setYearlyFunction(getYearlyData);

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: DemandTable(
              getQuaterlyData: getQuaterlyData,
              getYearlyData: getYearlyData,
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
              // energyConsumedQuaterlyList: quaterlyEnergyConsumedList,
              monthList: monthList,
              // energyConsumedList: energyConsumedList,
              timeIntervalList: timeIntervalList,
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //   },
      //   child: const Icon(Icons.ad_units),
      // ),
    );
  }

  Future<void> getCurrentDayData() async {
    try {
      rows.clear();
      timeIntervalList.clear();
      energyConsumedList.clear();
      dateList.clear();
      print('Callback Called');

      double maxEnergyConsumed = 0;

      final provider =
          Provider.of<DemandEnergyProvider>(context, listen: false);
      final selectedDepoName = provider.selectedDepo;

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
          energyConsumedList.add(user['energyConsumed']);
          maxEnergyConsumed = maxEnergyConsumed +
              double.parse(user['energyConsumed'].toString());
          row.add(user['srNo']);
          row.add(selectedCityName);
          row.add(selectedDepoName);
          row.add(user['energyConsumed']);
          rows.add(row);
        }
      }

      provider.setDailyConsumedList(energyConsumedList);
      provider.setMaxEnergyConsumed(maxEnergyConsumed);

      print('Rows - $rows');

      //Sets Start and End Date for provider
      getStartEndDate();
    } catch (e) {
      print('Error Occured in Fetching Daily Data - $e');
    }
  }

  Future<void> getCurrentMonthData() async {
    try {
      rows.clear();
      monthList.clear();
      timeIntervalList.clear();
      energyConsumedList.clear();
      dateList.clear();

      double totalConsumedEnergyMonthly = 0;

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
      monthList.add(currentMonth);

      QuerySnapshot monthlyQuerySnap = await collectionReference.get();
      List<dynamic> monthlyDateList =
          monthlyQuerySnap.docs.map((data) => data.id).toList();
      dateList = monthlyDateList;
      print('Monthly Data List - $monthlyDateList');

      for (int i = 0; i < monthlyDateList.length; i++) {
        QuerySnapshot querySnapshot = await collectionReference
            .doc(monthlyDateList[i])
            .collection('UserId')
            .get();

        List<dynamic> allUsers =
            querySnapshot.docs.map((userid) => userid.id).toList();

        if (allUsers.isNotEmpty) {
          DocumentSnapshot daySnap = await collectionReference
              .doc(monthlyDateList[i])
              .collection('UserId')
              .doc(allUsers[0])
              .get();
          Map<String, dynamic> mapData = daySnap.data() as Map<String, dynamic>;
          List<dynamic> userData = mapData['data'];
          print('mapData - $userData');

          for (int j = 0; j < userData.length; j++) {
            List<dynamic> row = [];
            timeIntervalList
                .add(userData[j]['timeInterval']); // Adding Time interval
            energyConsumedList
                .add(userData[j]['energyConsumed']); // Adding Energy Consumed
            row.add(userData[j]['srNo']); // Adding Serial Numbers for table
            row.add(selectedCityName);
            row.add(selectedDepoName);
            row.add(userData[j]['energyConsumed']); //Adding energy consumed
            totalConsumedEnergyMonthly = totalConsumedEnergyMonthly +
                double.parse(userData[j]['energyConsumed'].toString());
            rows.add(row);
          }

          // ignore: use_build_context_synchronously
          Provider.of<DemandEnergyProvider>(context, listen: false)
              .setMonthlyEnergyConsumed(totalConsumedEnergyMonthly);

          // print('monthly rows - $rows');
          // for (var user in userData) {
          //   List<dynamic> row = [];
          //   timeIntervalList.add(user['timeInterval']);
          //   energyConsumedList.add(user['energyConsumed']);
          //   row.add(user['srNo']);
          //   row.add(selectedCityName);
          //   row.add(selectedDepoName);
          //   row.add(user['energyConsumed']);
          //   rows.add(row);
          // }
        }
        // print('TimeIntervalList - $timeIntervalList');
      }

      //Sets Start and End Date for provider
      getStartEndDate();
    } catch (e) {
      print('Error Occured in Fetching Monthly Data - $e');
    }
  }

  Future<void> getQuaterlyData() async {
    try {
      rows.clear();
      monthList.clear();
      timeIntervalList.clear();
      energyConsumedList.clear();
      dateList.clear();
      final provider =
          Provider.of<DemandEnergyProvider>(context, listen: false);

      final selectedDepoName = provider.selectedDepo;

      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(selectedDepoName)
          .collection('Year')
          .doc(currentYear.toString())
          .collection('Months');

      //March Month Data//

      QuerySnapshot marchQuerySnap =
          await collectionReference.doc('March').collection('Date').get();

      List<dynamic> marchDates =
          marchQuerySnap.docs.map((data) => data.id).toList();

      double energyConsumedInMarch = 0;

      energyConsumedInMarch = await fetchMonthlyData(
          collectionReference, marchDates, energyConsumedInMarch, 'March');

      //June Month Data//

      QuerySnapshot juneQuerySnap =
          await collectionReference.doc('June').collection('Date').get();

      List<dynamic> juneDates =
          juneQuerySnap.docs.map((data) => data.id).toList();

      double energyConsumedInJune = 0;

      energyConsumedInJune = await fetchMonthlyData(
          collectionReference, juneDates, energyConsumedInJune, 'June');

      //September Month Data

      QuerySnapshot septemberQuerySnap =
          await collectionReference.doc('September').collection('Date').get();

      List<dynamic> septemberDates =
          septemberQuerySnap.docs.map((data) => data.id).toList();

      double energyConsumedInSeptember = 0;

      energyConsumedInSeptember = await fetchMonthlyData(collectionReference,
          septemberDates, energyConsumedInSeptember, 'September');

      //December Month Data

      QuerySnapshot decemberQuerySnap =
          await collectionReference.doc('December').collection('Date').get();

      List<dynamic> decemberDates =
          decemberQuerySnap.docs.map((data) => data.id).toList();

      double energyConsumedInDecember = 0;

      energyConsumedInDecember = await fetchMonthlyData(collectionReference,
          decemberDates, energyConsumedInDecember, 'December');

      dateList = marchDates + juneDates + septemberDates + decemberDates;

      quaterlyEnergyConsumedList.add(energyConsumedInMarch);
      quaterlyEnergyConsumedList.add(energyConsumedInJune);
      quaterlyEnergyConsumedList.add(energyConsumedInSeptember);
      quaterlyEnergyConsumedList.add(energyConsumedInDecember);

      provider.setQuaterlyConsumedList(quaterlyEnergyConsumedList);

      totalEnergyConsumedQuaterly = energyConsumedInMarch +
          energyConsumedInJune +
          energyConsumedInSeptember +
          energyConsumedInDecember;

//Setting Maximum energy consumed quaterly
      provider.setMaxEnergyConsumed(totalEnergyConsumedQuaterly);

      print(
          'QuaterlyData - $energyConsumedInMarch, $energyConsumedInJune, $energyConsumedInSeptember, $energyConsumedInDecember');
    } catch (error) {
      print('Error Occured in Fetching Quaterly Data - $error');
    }
  }

  Future<double> fetchMonthlyData(CollectionReference collectionReference,
      List<dynamic> dates, double totalEnergyConsumed, String month) async {
    for (int i = 0; i < dates.length; i++) {
      final provider =
          Provider.of<DemandEnergyProvider>(context, listen: false);
      final selectedCityName = provider.selectedCity;
      final selectedDepoName = provider.selectedDepo;
      QuerySnapshot querySnapshot = await collectionReference
          .doc(month)
          .collection('Date')
          .doc(dates[i])
          .collection('UserId')
          .get();

      // dateList.add(dates[i]);

      List<dynamic> userIdList =
          querySnapshot.docs.map((data) => data.id).toList();

      print('SM UserId - $userIdList');

      if (userIdList.isNotEmpty) {
        DocumentSnapshot documentSnapshot = await collectionReference
            .doc(month)
            .collection('Date')
            .doc(dates[i])
            .collection('UserId')
            .doc(userIdList[0])
            .get();

        Map<String, dynamic> mapData =
            documentSnapshot.data() as Map<String, dynamic>;

        List<dynamic> userData = mapData['data'];

        for (var map in userData) {
          totalEnergyConsumed = totalEnergyConsumed +
              double.parse(map['energyConsumed'].toString());

          List<dynamic> row = [];

          timeIntervalList.add(map['timeInterval']); // Adding Time interval
          row.add(map['srNo']); // Adding Serial Numbers for table
          row.add(selectedCityName);
          row.add(selectedDepoName);
          row.add(map['energyConsumed']); //Adding energy consumed
          rows.add(row);
        }
      }
    }
    return totalEnergyConsumed;
  }

  Future<void> getYearlyData() async {
    try {
      rows.clear();
      monthList.clear();
      timeIntervalList.clear();
      energyConsumedList.clear();
      dateList.clear();
      final provider =
          Provider.of<DemandEnergyProvider>(context, listen: false);

      final selectedDepoName = provider.selectedDepo;

      double totalEnergyConsumedYearly = 0;

      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(selectedDepoName)
          .collection('Year')
          .doc(currentYear.toString())
          .collection('Months');

      List<String> yearlyMonths = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];

      for (int i = 0; i < yearlyMonths.length; i++) {
        QuerySnapshot marchQuerySnap = await collectionReference
            .doc(yearlyMonths[i])
            .collection('Date')
            .get();

        List<dynamic> marchDates =
            marchQuerySnap.docs.map((data) => data.id).toList();

        double energyConsumed = 0.0;

        energyConsumed = await fetchMonthlyData(
            collectionReference, marchDates, energyConsumed, yearlyMonths[i]);

        totalEnergyConsumedYearly = totalEnergyConsumedYearly + energyConsumed;

        yearlyEnergyConsumedList.add(energyConsumed);
      }

      provider.setYearlyConsumedList(yearlyEnergyConsumedList);
      provider.setMaxEnergyConsumed(totalEnergyConsumedYearly);
    } catch (error) {
      print('Error Occured in Fetching Yearly Data - $error');
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
