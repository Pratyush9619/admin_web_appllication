import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../MenuPage/model/employee.dart';

class KeyProvider with ChangeNotifier {
  List<Employee> _employees = <Employee>[];
  String? startdate;
  String? enddate;
  String? actualstartdate;
  String? actualenddate;
  double totalweightage = 0;
  var alldata;

  Future<void> getFirestoreData(collectionName) async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference tabledata = instance.collection('${collectionName}A2');

    DocumentSnapshot snapshot = await tabledata.doc(collectionName).get();
    var data = snapshot.data() as Map;
    alldata = data['data'] as List<dynamic>;

    // _employees = [];
    alldata.forEach((element) {
      _employees.add(Employee.fromJson(element));
      // print(element);
    });
    for (int i = 0; i < alldata.length; i++) {
      double allWeightage = data['data'][i]['Weightage'];
      totalweightage = totalweightage + allWeightage;
      startdate = data['data'][0]['StartDate'];
      enddate = data['data'][alldata.length - 1]['EndDate'];
      actualstartdate = data['data'][0]['ActualStart'];
      actualenddate = data['data'][alldata.length - 1]['ActualEnd'];
    }
    notifyListeners();
  }

  List<Employee> get getTableData {
    return _employees;
  }

  double get weigtage => totalweightage;
}
