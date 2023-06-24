import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class QualitychecklistModel {
  QualitychecklistModel({
    required this.srNo,
    required this.checklist,
    required this.responsibility,
    required this.reference,
    required this.observation,
    // required this.photoNo
    // required this.weightage,
  });

  int srNo;
  String checklist;
  String responsibility;
  String reference;
  String observation;
  // int photoNo;

  factory QualitychecklistModel.fromJson(Map<String, dynamic> json) {
    return QualitychecklistModel(
      srNo: json['srNo'],
      checklist: json['checklist'],
      responsibility: json['responsibility'],
      reference: json['Reference'],
      observation: json['observation'],
      // photoNo: json['photoNo']
    );
    // weightage: json['Weightage']);
  }

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<int>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'checklist', value: checklist),
      DataGridCell<String>(columnName: 'responsibility', value: responsibility),
      DataGridCell<dynamic>(columnName: 'Reference', value: reference),
      DataGridCell<String>(columnName: 'observation', value: observation),
      // DataGridCell<int>(columnName: 'photoNo', value: photoNo),
      const DataGridCell<Widget>(columnName: 'Upload', value: null),
      const DataGridCell<Widget>(columnName: 'View', value: null),
      // const DataGridCell(columnName: 'Delete', value: null)
    ]);
  }
}
