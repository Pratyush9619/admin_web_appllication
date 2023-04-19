import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SafetyChecklistModel {
  SafetyChecklistModel({
    required this.srNo,
    required this.details,
    required this.status,
    required this.remark,
    required this.photo,

    // required this.weightage,
  });

  double srNo;
  String details;
  String status;
  String remark;
  String photo;

  factory SafetyChecklistModel.fromJson(Map<String, dynamic> json) {
    return SafetyChecklistModel(
      srNo: json['srNo'],
      details: json['Details'],
      remark: json['Remark'],
      status: json['Status'],
      photo: json['Photo'],
    );
    // weightage: json['Weightage']);
  }

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<double>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'Details', value: details),

      DataGridCell<String>(columnName: 'Status', value: status),
      DataGridCell<String>(columnName: 'Remark', value: remark),
      DataGridCell<String>(columnName: 'Photo', value: photo),
      DataGridCell<String>(columnName: 'ViewPhoto', value: null),

      // DataGridCell<double>(columnName: 'Weightage', value: weightage),
    ]);
  }
}
