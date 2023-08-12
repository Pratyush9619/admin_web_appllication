import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';

class KeyProvider with ChangeNotifier {
  // List<Employee> _employees = <Employee>[];
  List<int> srNo = [];
  List<String> sdate = [];
  List<String> edate = [];
  List<String> acdate = [];
  List<String> aedate = [];

  List<int> get serialNo {
    return srNo;
  }

  List<String> get startdate {
    return sdate;
  }

  List<String> get enddate {
    return edate;
  }

  List<String> get actualdate {
    return acdate;
  }

  List<String> get actualenddate {
    return aedate;
  }

  Future getFirestoreData(userId, events, collectionName) async {
    List docId = [];
    List<int>? srno = [];
    List<String> startdate = [];
    List<String>? enddate = [];
    List<String>? actualstartdate = [];
    List<String>? actualenddate = [];
    // await FirebaseFirestore.instance
    //     .collection('KeyEventsTable')
    //     .doc(collectionName)
    //     .collection('KeyDataTable')
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((element) {
    //     String documentId = element.id;
    //     print('Document ID: $documentId');
    //     docId.add(documentId);
    //   });
    // });

    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference tabledata = instance.collection('KeyEventsTable');

    // for (int i = 0; i < docId.length; i++) {
    DocumentSnapshot snapshot = await tabledata
        .doc(collectionName)
        .collection('KeyDataTable')
        .doc(userId)
        .collection('KeyAllEvents')
        .doc('$collectionName$events')
        .get();
    var data = snapshot.data() as Map;
    alldata = data['data'] as List<dynamic>;

    // alldata.forEach((element) {
    //   _employees.add(Employee.fromJson(element));
    // });
    for (int i = 0; i < alldata.length; i++) {
      // totalweightage = totalweightage + allWeightage;
      srno.add(alldata[i]['srNo']);
      startdate.add(data['data'][i]['StartDate']);
      enddate.add(data['data'][i]['EndDate']);
      actualstartdate.add(data['data'][i]['ActualStart']);
      actualenddate.add(data['data'][i]['ActualEnd']);
    }
    notifyListeners();
    //   }
    sdate = startdate;
    edate = enddate;
    acdate = actualstartdate;
    aedate = actualenddate;
    srNo = srno;
    notifyListeners();
  }
}
