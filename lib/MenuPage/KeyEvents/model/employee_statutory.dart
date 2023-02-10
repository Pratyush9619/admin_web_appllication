import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeStatutory {
  EmployeeStatutory({
    required this.srNo,
    required this.approval,
    required this.startDate,
    required this.endDate,
    required this.actualstartDate,
    required this.actualendDate,
    required this.weightage,
    required this.applicability,
    required this.approvingAuthority,
    required this.currentStatusPerc,
    required this.overallWeightage,
    required this.currentStatus,
    required this.listDocument,
  });

  int srNo;
  String approval;
  String? startDate;
  String? endDate;
  String? actualstartDate;
  String? actualendDate;
  double weightage;
  String? applicability;
  String? approvingAuthority;
  int? currentStatusPerc;
  int? overallWeightage;
  String? currentStatus;
  String? listDocument;

  factory EmployeeStatutory.fromJson(Map<String, dynamic> json) {
    return EmployeeStatutory(
        srNo: json['srNo'],
        approval: json['Approval'],
        startDate: json['StartDate'],
        endDate: json['EndDate'],
        actualstartDate: json['ActualStart'],
        actualendDate: json['ActualEnd'],
        weightage: json['Weightage'],
        applicability: json['Applicability'],
        approvingAuthority: json['ApprovingAuthority'],
        currentStatusPerc: json['CurrentStatusPerc'],
        overallWeightage: json['OverallWeightage'],
        currentStatus: json['CurrentStatus'],
        listDocument: json['ListDocument']);
  }

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<int>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'Approval', value: approval),
      const DataGridCell<Widget>(columnName: 'button', value: null),
      DataGridCell<String>(columnName: 'StartDate', value: startDate),
      DataGridCell<String>(columnName: 'EndDate', value: endDate),
      DataGridCell<String>(columnName: 'ActualStart', value: actualstartDate),
      DataGridCell<String>(columnName: 'ActualEnd', value: actualendDate),
      DataGridCell<double>(columnName: 'Weightage', value: weightage),
      DataGridCell<String>(columnName: 'Applicability', value: applicability),
      DataGridCell<String>(
          columnName: 'ApprovingAuthority', value: approvingAuthority),
      DataGridCell<int>(
          columnName: 'CurrentStatusPerc', value: currentStatusPerc),
      DataGridCell<int>(
          columnName: 'OverallWeightage', value: overallWeightage),
      DataGridCell<String>(columnName: 'CurrentStatus', value: currentStatus),
      DataGridCell<String>(columnName: 'ListDocument', value: listDocument),
    ]);
  }
}
