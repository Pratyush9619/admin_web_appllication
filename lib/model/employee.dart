import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    required this.reasonDelay,
    this.dependency,
    required this.unit,
    required this.scope,
    required this.qtyExecuted,
    required this.balanceQty,
    required this.percProgress,
    required this.weightage,
  });

  dynamic srNo;
  String activity;
  int originalDuration;
  String? startDate;
  String? endDate;
  String? actualstartDate;
  String? actualendDate;
  int actualDuration;
  String? reasonDelay;
  int delay;
  String? dependency;
  int unit;
  int scope;
  int qtyExecuted;
  int balanceQty;
  int percProgress;
  double weightage;

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        srNo: json['srNo'],
        activity: json['Activity'],
        originalDuration: json['OriginalDuration'],
        startDate: json['StartDate'],
        endDate: json['EndDate'],
        actualstartDate: json['ActualStart'],
        actualendDate: json['ActualEnd'],
        actualDuration: json['ActualDuration'],
        delay: json['Delay'],
        reasonDelay: json['ReasonDelay'],
        unit: json['Unit'],
        scope: json['QtyScope'],
        qtyExecuted: json['QtyExecuted'],
        balanceQty: json['BalancedQty'],
        percProgress: json['Progress'],
        weightage: json['Weightage']);
  }

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<dynamic>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'Activity', value: activity),
      // const DataGridCell<Widget>(columnName: 'button', value: null),
      DataGridCell<int>(
          columnName: 'OriginalDuration', value: originalDuration),
      DataGridCell<String>(columnName: 'StartDate', value: startDate),
      DataGridCell<String>(columnName: 'EndDate', value: endDate),
      DataGridCell<String>(columnName: 'ActualStart', value: actualstartDate),
      DataGridCell<String>(columnName: 'ActualEnd', value: actualendDate),
      DataGridCell<int>(columnName: 'ActualDuration', value: actualDuration),
      DataGridCell<int>(columnName: 'Delay', value: delay),
      DataGridCell<String>(columnName: 'ReasonDelay', value: reasonDelay),
      DataGridCell<int>(columnName: 'Unit', value: unit),
      DataGridCell<int>(columnName: 'QtyScope', value: scope),
      DataGridCell<int>(columnName: 'QtyExecuted', value: qtyExecuted),
      DataGridCell<int>(columnName: 'BalancedQty', value: balanceQty),
      DataGridCell<int>(columnName: 'Progress', value: percProgress),
      DataGridCell<double>(columnName: 'Weightage', value: weightage),
    ]);
  }

  DataGridRow getKeyDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<dynamic>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'Activity', value: activity),
      // const DataGridCell<Widget>(columnName: 'button', value: null),
      DataGridCell<int>(
          columnName: 'OriginalDuration', value: originalDuration),
      DataGridCell<String>(columnName: 'StartDate', value: startDate),
      DataGridCell<String>(columnName: 'EndDate', value: endDate),
      DataGridCell<String>(columnName: 'ActualStart', value: actualstartDate),
      DataGridCell<String>(columnName: 'ActualEnd', value: actualendDate),
      DataGridCell<int>(columnName: 'ActuaslDuration', value: actualDuration),
      DataGridCell<int>(columnName: 'Delay', value: delay),
      // DataGridCell<String>(columnName: 'Dependency', value: dependency),
      // DataGridCell<int>(columnName: 'Unit', value: unit),
      // DataGridCell<int>(columnName: 'QtyScope', value: scope),
      // DataGridCell<int>(columnName: 'QtyExecuted', value: qtyExecuted),
      // DataGridCell<int>(columnName: 'BalancedQty', value: balanceQty),
      DataGridCell<int>(columnName: 'Progress', value: percProgress),
      DataGridCell<double>(columnName: 'Weightage', value: weightage),
    ]);
  }
}
