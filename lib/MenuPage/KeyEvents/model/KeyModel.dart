import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class KeyModel {
  KeyModel({
    required this.startDate,
    required this.endDate,
    required this.actualstartDate,
    required this.actualendDate,
    required this.weightage,
  });

  String? startDate;
  String? endDate;
  String? actualstartDate;
  String? actualendDate;
  double weightage;

  factory KeyModel.fromJson(Map<String, dynamic> json) {
    return KeyModel(
        startDate: json['StartDate'],
        endDate: json['EndDate'],
        actualstartDate: json['ActualStart'],
        actualendDate: json['ActualEnd'],
        weightage: json['Weightage']);
  }

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<String>(columnName: 'StartDate', value: startDate),
      DataGridCell<String>(columnName: 'EndDate', value: endDate),
      DataGridCell<String>(columnName: 'ActualStart', value: actualstartDate),
      DataGridCell<String>(columnName: 'ActualEnd', value: actualendDate),
      DataGridCell<double>(columnName: 'Weightage', value: weightage),
    ]);
  }
}
