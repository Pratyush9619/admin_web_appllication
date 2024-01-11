import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../OverviewPages/energy_management.dart';
import '../model/energy_management.dart';

class EnergyProvider extends ChangeNotifier {
  List<EnergyManagementModel> _energydata = [];
  List<dynamic> intervalListData = [];
  List<dynamic> energyListData = [];
  List energyUserId = [];

  List<dynamic> get intervalData => intervalListData;
  List<dynamic> get energyData => energyListData;

  fetchEnergyUsedId(
      String cityName, String depoName, DateTime date, DateTime endDate) async {
    List id = [];
    id.clear();
    print(date);
    print(endDate);

    for (DateTime initialdate = date;
        initialdate.isBefore(endDate.add(const Duration(days: 1)));
        initialdate = initialdate.add(const Duration(days: 1))) {
      String monthName =
          DateFormat('MMMM').format(DateTime.parse(initialdate.toString()));
      String yearName =
          DateFormat('yyyy').format(DateTime.parse(initialdate.toString()));
      // print(
      //     'month${DateFormat('MMMM').format(DateTime.parse(initialdate.toString()))}');
      // print(
      //     'year${DateFormat('yyyy').format(DateTime.parse(initialdate.toString()))}');
      await FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(cityName)
          .collection('Depots')
          .doc(depoName)
          .collection('Year')
          .doc(yearName)
          .collection('Months')
          .doc(monthName)
          .collection('Date')
          .doc(DateFormat.yMMMMd().format(initialdate))
          .collection('UserId')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          String documentId = element.id;
          id.add(documentId);
          print('userId - $id');
        });
        energyUserId = id;
        notifyListeners();
      });
    }
  }

  fetchEnergyData(
      String cityName, String depoName, DateTime date, DateTime endDate) async {
    final List<dynamic> timeIntervalList = [];
    final List<dynamic> energyConsumedList = [];

    // int currentMonth = DateTime.now().month;
    // String monthName = DateFormat('MMMM').format(DateTime.now());
    final List<EnergyManagementModel> fetchedData = [];
    _energydata.clear();
    timeIntervalList.clear();
    energyConsumedList.clear();
    for (DateTime initialdate = endDate;
        initialdate.isAfter(date.subtract(const Duration(days: 1)));
        initialdate = initialdate.subtract(const Duration(days: 1))) {
      String monthName =
          DateFormat('MMMM').format(DateTime.parse(initialdate.toString()));
      String yearName =
          DateFormat('yyyy').format(DateTime.parse(initialdate.toString()));
      for (int i = 0; i < energyUserId.length; i++) {
        FirebaseFirestore.instance
            .collection('EnergyManagementTable')
            .doc(cityName)
            .collection('Depots')
            .doc(depoName)
            .collection('Year')
            .doc(yearName)
            .collection('Months')
            .doc(monthName)
            .collection('Date')
            .doc(DateFormat.yMMMMd().format(initialdate))
            .collection('UserId')
            .doc(energyUserId[i])
            .get()
            .then((value) {
          if (value.data() != null) {
            for (int i = 0; i < value.data()!['data'].length; i++) {
              var data = value.data()!['data'][i];
              fetchedData.add(EnergyManagementModel.fromJson(data));
              timeIntervalList.add(value.data()!['data'][i]['timeInterval']);
              energyConsumedList
                  .add(value.data()!['data'][i]['energyConsumed']);
            }
            _energydata = fetchedData;
            intervalListData = timeIntervalList;
            energyListData = energyConsumedList;
            notifyListeners();
          } else {
            intervalListData = timeIntervalList;
            energyListData = energyConsumedList;

            notifyListeners();
          }
        });
      }
    }
  }
}
