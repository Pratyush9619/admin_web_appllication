import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Employee {
  Employee(
    this.srNo,
    this.approval,
    this.weightage,
    this.applicability,
    this.authority,
    this.currentStatusPerc,
    this.overallweightage,
    this.currentStatus,
    this.listDocument,
  );

  int srNo;
  String approval;
  int weightage;
  String applicability;
  String authority;
  String currentStatusPerc;
  int overallweightage;
  String currentStatus;
  String listDocument;

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<int>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'approval', value: approval),
      DataGridCell<int>(columnName: 'weightage', value: weightage),
      DataGridCell<String>(columnName: 'applicability', value: applicability),
      DataGridCell<String>(columnName: 'authority', value: authority),
      DataGridCell<String>(
          columnName: 'currentStatusPerc', value: currentStatusPerc),
      DataGridCell<int>(
          columnName: 'Overallweightage', value: overallweightage),
      DataGridCell<String>(columnName: 'currentStatus', value: currentStatus),
      DataGridCell<String>(columnName: 'listDocument', value: listDocument),
    ]);
  }
}
