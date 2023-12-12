import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KeyProvider extends ChangeNotifier {
  double totalvalue = 0.0;
  int totaldelay = 0;
  int totalduration = 0;
  String start_Date = '22-10-2024';
  String end_Date = '22-10-2024';
  String actual_end = '22-10-2024';

  double get perProgress => totalvalue;

  // int get delay => totaldelay;

  // int get duration => totalduration;

  String get startdate => start_Date;
  String get endDate => end_Date;
  String get actualDate => actual_end;

  saveProgressValue(double value) {
    totalvalue = value;
    notifyListeners();
  }

  fetchDelayData(String depoName, dynamic userId) {
    // List<String> delayData = [];
    // List<String> durationData = [];
    start_Date = '22-10-2024';
    end_Date = '22-10-2024';
    actual_end = '22-10-2024';
    List<String> startDate = [];
    List<String> endDate = [];
    List<String> actualDate = [];
    totaldelay = 0;
    totalduration = 0;
    List<int> indicesToSkip = [0, 2, 6, 13, 18, 28, 32, 38, 64, 76];
    FirebaseFirestore.instance
        .collection('KeyEventsTable')
        .doc(depoName)
        .collection('KeyDataTable')
        .doc(userId)
        .collection('KeyAllEvents')
        .doc('keyEvents')
        .get()
        .then((value) {
      var alldata = value.data();
      for (int i = 0; i < value.data()!['data'].length; i++) {
        if (!indicesToSkip.contains(i)) {
          // int delay = value.data()!['data'][i]['Delay'];
          // int duration = value.data()!['data'][i]['OriginalDuration'];
          startDate.add(value.data()!['data'][i]['StartDate']);
          endDate.add(value.data()!['data'][i]['EndDate']);
          actualDate.add(value.data()!['data'][i]['ActualEnd']);
          // print('delay $i ${delay}');
          // print('duration $i ${duration}');
          // delayData = delayData ;
          // durationData = durationData;
        }
      }
      List<DateTime> startDates = startDate
          .map((dateString) => DateFormat('dd-MM-yyyy').parse(dateString))
          .toList();
      List<DateTime> endDates = endDate
          .map((dateString) => DateFormat('dd-MM-yyyy').parse(dateString))
          .toList();
      List<DateTime> actualDates = actualDate
          .map((dateString) => DateFormat('dd-MM-yyyy').parse(dateString))
          .toList();
      startDates.sort();
      endDates.sort();
      actualDates.sort();
      start_Date = startDate.first;
      end_Date = endDate.last;
      actual_end = actualDate.last;
      // totaldelay = delayData;
      // totalduration = durationData;
      notifyListeners();
    });
  }
}
