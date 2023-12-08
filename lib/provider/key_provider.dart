import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KeyProvider extends ChangeNotifier {
  double totalvalue = 0.0;
  int totaldelay = 0;
  int totalduration = 0;

  double get perProgress => totalvalue;

  int get delay => totaldelay;

  int get duration => totalduration;

  saveProgressValue(double value) {
    totalvalue = value;
    notifyListeners();
  }

  fetchDelayData(String depoName, dynamic userId) {
    int delayData = 0;
    int durationData = 0;
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
        if (indicesToSkip.contains(i)) {
          int delay = value.data()!['data'][i]['Delay'];
          int duration = value.data()!['data'][i]['OriginalDuration'];

          print('delay $i ${delay}');
          print('duration $i ${duration}');
          delayData = delayData + delay;
          durationData = durationData + duration;
        }
      }

      totaldelay = delayData;
      totalduration = durationData;
      notifyListeners();
    });
  }
}
