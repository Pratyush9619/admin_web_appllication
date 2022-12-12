// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Employee {
  Employee({
    required this.srNo,
    required this.activity,
    required this.originalDuration,
    required this.startDate,
    required this.endDate,
    required this.actualstartDate,
    required this.actualendDate,
    required this.actualDuration,
    required this.delay,
    required this.unit,
    required this.scope,
    required this.qtyExecuted,
    required this.balanceQty,
    required this.percProgress,
    required this.weightage,
  });

  int srNo;
  String activity;
  int originalDuration;
  String? startDate;
  String? endDate;
  String? actualstartDate;
  String? actualendDate;
  int actualDuration;
  int delay;
  int unit;
  int scope;
  int qtyExecuted;
  int balanceQty;
  int percProgress;
  double weightage;

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<int>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'Activity', value: activity),
      DataGridCell<int>(
          columnName: 'OriginalDuration', value: originalDuration),
      DataGridCell<String>(columnName: 'StartDate', value: startDate),
      DataGridCell<String>(columnName: 'EndDate', value: endDate),
      DataGridCell<String>(columnName: 'ActualStart', value: actualstartDate),
      DataGridCell<String>(columnName: 'ActualEnd', value: actualendDate),
      DataGridCell<int>(columnName: 'ActuaslDuration', value: actualDuration),
      DataGridCell<int>(columnName: 'Delay', value: delay),
      DataGridCell<int>(columnName: 'Unit', value: unit),
      DataGridCell<int>(columnName: 'QtyScope', value: scope),
      DataGridCell<int>(columnName: 'QtyExecuted', value: qtyExecuted),
      DataGridCell<int>(columnName: 'BalancedQty', value: balanceQty),
      DataGridCell<int>(columnName: 'Progress', value: percProgress),
      DataGridCell<double>(columnName: 'Weightage', value: weightage),
    ]);
  }

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('A2');

  // Future uploadData() async {
  //   await collectionReference.add({
  //     'srNo': srNo,
  //     'Approval': approval,
  //     'weightage': weightage,
  //     'appllicability': applicability,
  //     'authority': authority,
  //     'currentStatusPerc': currentStatusPerc,
  //     'Overallweightage': overallweightage,
  //     'currentStatus': currentStatus,
  //     'listDocument': listDocument
  //   });
  // }
}
