import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/provider/All_Depo_Select_Provider.dart';
import 'package:web_appllication/provider/demandEnergyProvider.dart';
import 'package:web_appllication/screen/demand%20energy%20management/bar_graph.dart';
import 'package:web_appllication/screen/demand%20energy%20management/demand_table.dart';

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
  List<double> allDepoDailyEnergyConsumedList = [];
  double totalEnergyConsumedQuaterly = 0;
  int serialNumber = 0;

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
  final currentDay = DateFormat.yMMMMd().format(
    DateTime.now(),
  );
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
    final checkboxProvider =
        Provider.of<AllDepoSelectProvider>(context, listen: false);

    //Set Callback Function in provider
    provider.setCurrentDayFunction(getCurrentDayData);
    provider.setCurrentMonthFunction(getCurrentMonthData);
    provider.setQuaterlyFunction(getQuaterlyData);
    provider.setYearlyFunction(getYearlyData);
    provider.setAllDepoDailyData(getAllDepoDailyData);
    provider.setAllDepoMonthlyData(getAllDepoMonthlyData);
    provider.setAllDepoQuaterlyData(getAllDepoQuarterData);
    provider.setAllDepoYearlyData(getAllDepoYearlyData);

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
            flex: 1,
            child: BarGraphScreen(
              monthList: monthList,
              timeIntervalList: timeIntervalList,
            ),
          )
        ],
      ),
    );
  }

  Future<void> getAllDepoDailyData() async {
    try {
      int srNo = 0;
      rows.clear();

      timeIntervalList.clear();

      energyConsumedList.clear();

      dateList.clear();

      double maximumEnergyConsumed = 0.0;

      final provider = Provider.of<DemandEnergyProvider>(
        context,
        listen: false,
      );

      // final selectedDepoName = provider.selectedDepo;

      final selectedCityName = Provider.of<DemandEnergyProvider>(
        context,
        listen: false,
      ).selectedCity;

      for (int k = 0; k < provider.depoList!.length; k++) {
        double totalEnergyConsumedInEachDepo = 0.0;
        CollectionReference collectionReference = FirebaseFirestore.instance
            .collection('EnergyManagementTable')
            .doc(selectedCityName)
            .collection('Depots')
            .doc(provider.depoList![k])
            .collection('Year')
            .doc(currentYear.toString())
            .collection('Months')
            .doc(currentMonth)
            .collection('Date')
            .doc(currentDay)
            .collection('UserId');

        dateList.add(currentDay);

        QuerySnapshot querySnapshot = await collectionReference.get();

        List<dynamic> allUsers = querySnapshot.docs
            .map(
              (userid) => userid.id,
            )
            .toList();

        print('All Users - $allUsers');

        if (allUsers.isNotEmpty) {
          DocumentSnapshot daySnap =
              await collectionReference.doc(allUsers[0]).get();
          Map<String, dynamic> mapData = daySnap.data() as Map<String, dynamic>;
          List<dynamic> userData = mapData['data'];

          for (int j = 0; j < userData.length; j++) {
            srNo = srNo + 1;
            List<dynamic> row = [];
            totalEnergyConsumedInEachDepo = totalEnergyConsumedInEachDepo +
                double.parse(userData[j]['energyConsumed'].toString());
            timeIntervalList
                .add(userData[j]['timeInterval']); // Adding Time interval
            allDepoDailyEnergyConsumedList
                .add(userData[j]['energyConsumed']); // Adding Energy Consumed
            row.add(srNo); // Adding Serial Numbers for table
            row.add(selectedCityName);
            row.add(provider.depoList![k]);
            row.add(userData[j]['energyConsumed']); //Adding energy consumed
            rows.add(row);
          }
        }

        maximumEnergyConsumed =
            maximumEnergyConsumed + totalEnergyConsumedInEachDepo;

        energyConsumedList.add(totalEnergyConsumedInEachDepo);
        // print('aaa ${totalEnergyConsumedInEachDepo}');
      }

      provider.setAllDepoDailyConsumedList(energyConsumedList);
      provider.setMaxEnergyConsumed(maximumEnergyConsumed);

      // provider.setMaxEnergyConsumed(maxEnergyConsumed);

      // print('Rows - $rows');
      //Sets Start and End Date for provider
      getStartEndDate();
    } catch (e) {
      print('Error Occured in Fetching All Depo Daily Data - $e');
    }
  }

  Future<void> getAllDepoMonthlyData() async {
    try {
      rows.clear();

      timeIntervalList.clear();

      energyConsumedList.clear();

      dateList.clear();

      int srNo = 0;

      double energyConsumedInEachDepo = 0.0;

      final provider = Provider.of<DemandEnergyProvider>(
        context,
        listen: false,
      );

      // final selectedDepoName = provider.selectedDepo;

      final selectedCityName = Provider.of<DemandEnergyProvider>(
        context,
        listen: false,
      ).selectedCity;

      for (int k = 0; k < provider.depoList!.length; k++) {
        print(k);
        CollectionReference collectionReference = FirebaseFirestore.instance
            .collection('EnergyManagementTable')
            .doc(selectedCityName)
            .collection('Depots')
            .doc(provider.depoList![k])
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

        dateList = dateList + monthlyDateList;

        // print('All Depo Monthly Data List - $monthlyDateList');

        for (int i = 0; i < monthlyDateList.length; i++) {
          double totalEnergyConsumedInEachDepo = 0.0;

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

            Map<String, dynamic> mapData =
                daySnap.data() as Map<String, dynamic>;
            List<dynamic> userData = mapData['data'];
            // print('mapData - $userData');

            for (int j = 0; j < userData.length; j++) {
              srNo = srNo + 1;
              List<dynamic> row = [];
              timeIntervalList
                  .add(userData[j]['timeInterval']); // Adding Time interval
              // energyConsumedList
              //     .add(userData[j]['energyConsumed']); // Adding Energy Consumed
              row.add(srNo); // Adding Serial Numbers for table
              row.add(selectedCityName);
              row.add(provider.depoList![k]);
              row.add(userData[j]['energyConsumed']); //Adding energy consumed
              totalEnergyConsumedInEachDepo = totalEnergyConsumedInEachDepo +
                  double.parse(userData[j]['energyConsumed'].toString());
              rows.add(row);
            }
          }

          energyConsumedInEachDepo =
              energyConsumedInEachDepo + totalEnergyConsumedInEachDepo;
          energyConsumedList.add(totalEnergyConsumedInEachDepo);
        }
      }
      // print('MaxEnergyConsumed - $energyConsumedInEachDepo');

      provider.setAllDepoMonthlyConsumedList(energyConsumedList);
      provider.setMaxEnergyConsumed(energyConsumedInEachDepo);

      // provider.setMaxEnergyConsumed(maxEnergyConsumed);

      // print('Rows - $rows');
      //Sets Start and End Date for provider
      getStartEndDate();
    } catch (e) {
      print('Error Occured in Fetching All Depo Momthly Data - $e');
    }
  }

  Future<void> getAllDepoQuarterData() async {
    try {
      serialNumber = 0;
      List<String> firstQuarter = ['January', 'February', 'March'];
      List<String> secondQuarter = ['April', 'May', 'June'];
      List<String> thirdQuarter = ['July', 'August', 'September'];
      List<String> fourthQuarter = ['October', 'November', 'December'];

      rows.clear();
      monthList.clear();
      timeIntervalList.clear();
      energyConsumedList.clear();
      dateList.clear();
      final provider =
          Provider.of<DemandEnergyProvider>(context, listen: false);

      final selectedCityName = provider.selectedCity;

      double totalEnergyConsumedInJanToMarch = 0.0;
      double totalEnergyConsumedInAprToJune = 0.0;
      double totalEnergyConsumedInJulToSeptember = 0.0;
      double totalEnergyConsumedInOctToDecember = 0.0;

      for (int m = 0; m < provider.depoList!.length; m++) {
        CollectionReference collectionReference = FirebaseFirestore.instance
            .collection('EnergyManagementTable')
            .doc(selectedCityName)
            .collection('Depots')
            .doc(provider.depoList![m])
            .collection('Year')
            .doc(currentYear.toString())
            .collection('Months');

        double energyConsumedInJanToMarchInEachDepo = 0;
        double energyConsumedInAprToJuneInEachDepo = 0;
        double energyConsumedInJulToSeptemberInEachDepo = 0;
        double energyConsumedInOctToDecemberInEachDepo = 0;

        List<dynamic> marchDates = [],
            juneDates = [],
            septemberDates = [],
            decemberDates = [];

        //March Month Data//

        for (int i = 0; i < firstQuarter.length; i++) {
          QuerySnapshot marchQuerySnap = await collectionReference
              .doc(firstQuarter[i])
              .collection('Date')
              .get();

          marchDates = marchQuerySnap.docs.map((data) => data.id).toList();

          dateList = dateList + marchDates;

          if (marchDates.isNotEmpty) {
            energyConsumedInJanToMarchInEachDepo =
                energyConsumedInJanToMarchInEachDepo +
                    await fetchMonthlyData(
                        collectionReference,
                        marchDates,
                        energyConsumedInJanToMarchInEachDepo,
                        firstQuarter[i],
                        provider.depoList![m]);
          }
        }

        //June Month Data//

        for (int j = 0; j < secondQuarter.length; j++) {
          QuerySnapshot juneQuerySnap = await collectionReference
              .doc(secondQuarter[j])
              .collection('Date')
              .get();

          juneDates = juneQuerySnap.docs.map((data) => data.id).toList();

          dateList = dateList + juneDates;

          if (juneDates.isNotEmpty) {
            energyConsumedInAprToJuneInEachDepo = await fetchMonthlyData(
                collectionReference,
                juneDates,
                energyConsumedInAprToJuneInEachDepo,
                secondQuarter[j],
                provider.depoList![m]);
          }
        }

        //September Month Data

        for (int k = 0; k < thirdQuarter.length; k++) {
          QuerySnapshot septemberQuerySnap = await collectionReference
              .doc(thirdQuarter[k])
              .collection('Date')
              .get();

          septemberDates =
              septemberQuerySnap.docs.map((data) => data.id).toList();

          dateList = dateList + septemberDates;

          if (septemberDates.isNotEmpty) {
            energyConsumedInJulToSeptemberInEachDepo = await fetchMonthlyData(
                collectionReference,
                septemberDates,
                energyConsumedInJulToSeptemberInEachDepo,
                thirdQuarter[k],
                provider.depoList![m]);
          }
        }

        //December Month Data

        for (int z = 0; z < fourthQuarter.length; z++) {
          QuerySnapshot decemberQuerySnap = await collectionReference
              .doc(fourthQuarter[z])
              .collection('Date')
              .get();

          decemberDates =
              decemberQuerySnap.docs.map((data) => data.id).toList();

          dateList = dateList + decemberDates;

          if (decemberDates.isNotEmpty) {
            energyConsumedInOctToDecemberInEachDepo = await fetchMonthlyData(
                collectionReference,
                decemberDates,
                energyConsumedInOctToDecemberInEachDepo,
                fourthQuarter[z],
                provider.depoList![m]);
          }
        }

        totalEnergyConsumedInJanToMarch = totalEnergyConsumedInJanToMarch +
            energyConsumedInJanToMarchInEachDepo;

        totalEnergyConsumedInAprToJune = totalEnergyConsumedInAprToJune +
            energyConsumedInAprToJuneInEachDepo;

        totalEnergyConsumedInJulToSeptember =
            totalEnergyConsumedInJulToSeptember +
                energyConsumedInJulToSeptemberInEachDepo;

        totalEnergyConsumedInOctToDecember =
            totalEnergyConsumedInOctToDecember +
                energyConsumedInOctToDecemberInEachDepo;

        totalEnergyConsumedQuaterly = totalEnergyConsumedQuaterly +
            energyConsumedInJanToMarchInEachDepo +
            energyConsumedInAprToJuneInEachDepo +
            energyConsumedInJulToSeptemberInEachDepo +
            energyConsumedInOctToDecemberInEachDepo;
      }

      quaterlyEnergyConsumedList.add(
          totalEnergyConsumedInJanToMarch); // Total consumed energy in march
      quaterlyEnergyConsumedList
          .add(totalEnergyConsumedInAprToJune); // Total consumed energy in june
      quaterlyEnergyConsumedList.add(
          totalEnergyConsumedInJulToSeptember); // Total consumed energy in sept
      quaterlyEnergyConsumedList.add(
          totalEnergyConsumedInOctToDecember); // Total consumed energy in dec

      provider.setAllDepoQuaterlyConsumedList(quaterlyEnergyConsumedList);

//Setting Maximum energy consumed quaterly
      provider.setMaxEnergyConsumed(totalEnergyConsumedQuaterly);
      getStartEndDate();
    } catch (error) {
      print('Error Occured in Fetching All Depo Quaterly Data - $error');
    }
  }

  Future<void> getAllDepoYearlyData() async {
    try {
      serialNumber = 0;
      rows.clear();
      monthList.clear();
      timeIntervalList.clear();
      energyConsumedList.clear();
      yearlyEnergyConsumedList.clear();
      dateList.clear();
      final provider =
          Provider.of<DemandEnergyProvider>(context, listen: false);

      final selectedCityName = provider.selectedCity;

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

      double totalEnergyConsumed = 0.0;

      for (int i = 0; i < yearlyMonths.length; i++) {
        double totalEnergyConsumedYearlyInEachDepo = 0;

        for (int k = 0; k < provider.depoList!.length; k++) {
          CollectionReference collectionReference = FirebaseFirestore.instance
              .collection('EnergyManagementTable')
              .doc(selectedCityName)
              .collection('Depots')
              .doc(provider.depoList![k])
              .collection('Year')
              .doc(currentYear.toString())
              .collection('Months');

          QuerySnapshot marchQuerySnap = await collectionReference
              .doc(yearlyMonths[i])
              .collection('Date')
              .get();

          List<dynamic> marchDates =
              marchQuerySnap.docs.map((data) => data.id).toList();

          dateList = dateList + marchDates;

          double energyConsumed = 0.0;

          energyConsumed = await fetchMonthlyData(
              collectionReference,
              marchDates,
              energyConsumed,
              yearlyMonths[i],
              provider.depoList![k]);

          totalEnergyConsumedYearlyInEachDepo =
              totalEnergyConsumedYearlyInEachDepo + energyConsumed;
        }

        yearlyEnergyConsumedList.add(totalEnergyConsumedYearlyInEachDepo);
        totalEnergyConsumed =
            totalEnergyConsumed + totalEnergyConsumedYearlyInEachDepo;
      }

      provider.setAllDepoYearlyConsumedList(yearlyEnergyConsumedList);
      provider.setMaxEnergyConsumed(totalEnergyConsumed);
      getStartEndDate();
    } catch (error) {
      print('Error Occured in Fetching All Depo Yearly Data - $error');
    }
  }

  Future<void> getCurrentDayData() async {
    try {
      rows.clear();

      timeIntervalList.clear();

      energyConsumedList.clear();

      dateList.clear();

      print('Callback Called');

      double maxEnergyConsumed = 0;

      final provider = Provider.of<DemandEnergyProvider>(
        context,
        listen: false,
      );

      final selectedDepoName = provider.selectedDepo;

      final selectedCityName = Provider.of<DemandEnergyProvider>(
        context,
        listen: false,
      ).selectedCity;

      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(selectedCityName)
          .collection('Depots')
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

      List<dynamic> allUsers = querySnapshot.docs
          .map(
            (userid) => userid.id,
          )
          .toList();

      print('All Users - $allUsers');

      // for (int i = 0; i < allUsers.length; i++) {
      if (allUsers.isNotEmpty) {
        DocumentSnapshot daySnap =
            await collectionReference.doc(allUsers[0]).get();
        Map<String, dynamic> mapData = daySnap.data() as Map<String, dynamic>;
        List<dynamic> userData = mapData['data'];

        for (int j = 0; j < userData.length; j++) {
          List<dynamic> row = [];
          timeIntervalList
              .add(userData[j]['timeInterval']); // Adding Time interval
          energyConsumedList
              .add(userData[j]['energyConsumed']); // Adding Energy Consumed
          maxEnergyConsumed = maxEnergyConsumed +
              double.parse(userData[j]['energyConsumed'].toString());
          row.add(userData[j]['srNo']); // Adding Serial Numbers for table
          row.add(selectedCityName);
          row.add(selectedDepoName);
          row.add(userData[j]['energyConsumed']); //Adding energy consumed
          rows.add(row);
        }
      }

      // }

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

      int srNo = 0;

      final provider =
          Provider.of<DemandEnergyProvider>(context, listen: false);

      double totalConsumedEnergyMonthly = 0;

      final selectedDepoName = provider.selectedDepo;

      final selectedCityName = provider.selectedCity;

      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(selectedCityName)
          .collection('Depots')
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
            srNo = srNo + 1;
            List<dynamic> row = [];
            timeIntervalList
                .add(userData[j]['timeInterval']); // Adding Time interval
            energyConsumedList
                .add(userData[j]['energyConsumed']); // Adding Energy Consumed
            row.add(srNo); // Adding Serial Numbers for table
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

          provider.setMaxEnergyConsumed(totalConsumedEnergyMonthly);

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
      serialNumber = 0;
      List<String> firstQuarter = ['January', 'February', 'March'];
      List<String> secondQuarter = ['April', 'May', 'June'];
      List<String> thirdQuarter = ['July', 'August', 'September'];
      List<String> fourthQuarter = ['October', 'November', 'December'];

      rows.clear();
      monthList.clear();
      timeIntervalList.clear();
      energyConsumedList.clear();
      dateList.clear();

      final provider =
          Provider.of<DemandEnergyProvider>(context, listen: false);

      final selectedDepoName = provider.selectedDepo;
      final selectedCityName = provider.selectedCity;

      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(selectedCityName)
          .collection('Depots')
          .doc(selectedDepoName)
          .collection('Year')
          .doc(currentYear.toString())
          .collection('Months');

      double energyConsumedInJanToMarch = 0;
      double energyConsumedInAprToJune = 0;
      double energyConsumedInJulToSeptember = 0;
      double energyConsumedInOctToDecember = 0;

      List<dynamic> marchDates = [],
          juneDates = [],
          septemberDates = [],
          decemberDates = [];

      //March Month Data//

      for (int i = 0; i < firstQuarter.length; i++) {
        QuerySnapshot marchQuerySnap = await collectionReference
            .doc(firstQuarter[i])
            .collection('Date')
            .get();

        marchDates = marchQuerySnap.docs.map((data) => data.id).toList();

        dateList = dateList + marchDates;

        if (marchDates.isNotEmpty) {
          energyConsumedInJanToMarch = energyConsumedInJanToMarch +
              await fetchMonthlyData(
                  collectionReference,
                  marchDates,
                  energyConsumedInJanToMarch,
                  firstQuarter[i],
                  selectedDepoName);
        }
      }

      //June Month Data//

      for (int j = 0; j < secondQuarter.length; j++) {
        QuerySnapshot juneQuerySnap = await collectionReference
            .doc(secondQuarter[j])
            .collection('Date')
            .get();

        juneDates = juneQuerySnap.docs.map((data) => data.id).toList();

        dateList = dateList + juneDates;

        if (juneDates.isNotEmpty) {
          energyConsumedInAprToJune = await fetchMonthlyData(
              collectionReference,
              juneDates,
              energyConsumedInAprToJune,
              secondQuarter[j],
              selectedDepoName);
        }
      }

      //September Month Data

      for (int k = 0; k < thirdQuarter.length; k++) {
        QuerySnapshot septemberQuerySnap = await collectionReference
            .doc(thirdQuarter[k])
            .collection('Date')
            .get();

        septemberDates =
            septemberQuerySnap.docs.map((data) => data.id).toList();

        dateList = dateList + septemberDates;

        if (septemberDates.isNotEmpty) {
          energyConsumedInJulToSeptember = await fetchMonthlyData(
              collectionReference,
              septemberDates,
              energyConsumedInJulToSeptember,
              thirdQuarter[k],
              selectedDepoName);
        }
      }

      //December Month Data

      for (int z = 0; z < fourthQuarter.length; z++) {
        QuerySnapshot decemberQuerySnap = await collectionReference
            .doc(fourthQuarter[z])
            .collection('Date')
            .get();

        decemberDates = decemberQuerySnap.docs.map((data) => data.id).toList();

        dateList = dateList + decemberDates;

        if (decemberDates.isNotEmpty) {
          energyConsumedInOctToDecember = await fetchMonthlyData(
              collectionReference,
              decemberDates,
              energyConsumedInOctToDecember,
              fourthQuarter[z],
              selectedDepoName);
        }
      }

      quaterlyEnergyConsumedList
          .add(energyConsumedInJanToMarch); // Total consumed energy in march
      quaterlyEnergyConsumedList
          .add(energyConsumedInAprToJune); // Total consumed energy in june
      quaterlyEnergyConsumedList
          .add(energyConsumedInJulToSeptember); // Total consumed energy in sept
      quaterlyEnergyConsumedList
          .add(energyConsumedInOctToDecember); // Total consumed energy in dec

      provider.setQuaterlyConsumedList(quaterlyEnergyConsumedList);

      totalEnergyConsumedQuaterly = energyConsumedInJanToMarch +
          energyConsumedInAprToJune +
          energyConsumedInJulToSeptember +
          energyConsumedInOctToDecember;

//Setting Maximum energy consumed quaterly
      provider.setMaxEnergyConsumed(totalEnergyConsumedQuaterly);
      getStartEndDate();
    } catch (error) {
      print('Error Occured in Fetching Quaterly Data - $error');
    }
  }

  Future<double> fetchMonthlyData(
      CollectionReference collectionReference,
      List<dynamic> dates,
      double totalEnergyConsumed,
      String month,
      String currentDepoName) async {
    for (int i = 0; i < dates.length; i++) {
      final provider =
          Provider.of<DemandEnergyProvider>(context, listen: false);
      final selectedCityName = provider.selectedCity;
      // final selectedDepoName = provider.selectedDepo;
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

        for (int z = 0; z < userData.length; z++) {
          serialNumber = serialNumber + 1;

          totalEnergyConsumed = totalEnergyConsumed +
              double.parse(userData[z]['energyConsumed'].toString());

          List<dynamic> row = [];

          timeIntervalList
              .add(userData[z]['timeInterval']); // Adding Time interval
          row.add(serialNumber); // Adding Serial Numbers for table
          row.add(selectedCityName);
          row.add(currentDepoName);
          row.add(userData[z]['energyConsumed']); //Adding energy consumed
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
      final selectedCityName = provider.selectedCity;

      double totalEnergyConsumedYearly = 0;

      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(selectedCityName)
          .collection('Depots')
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

        dateList = dateList + marchDates;

        double energyConsumed = 0.0;

        energyConsumed = await fetchMonthlyData(collectionReference, marchDates,
            energyConsumed, yearlyMonths[i], selectedDepoName);

        totalEnergyConsumedYearly = totalEnergyConsumedYearly + energyConsumed;

        yearlyEnergyConsumedList.add(energyConsumed);
      }

      provider.setYearlyConsumedList(yearlyEnergyConsumedList);
      provider.setMaxEnergyConsumed(totalEnergyConsumedYearly);
      getStartEndDate();
    } catch (error) {
      print('Error Occured in Fetching Yearly Data - $error');
    }
  }

  void getStartEndDate() {
    serialNumber = 0;
    dateList.sort();
    final provider = Provider.of<DemandEnergyProvider>(context, listen: false);
    final startDate = dateList.first;
    provider.setStartDate(startDate);
    final endDate = dateList.last;
    provider.setEndDate(endDate);
  }
}
