import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class QualitychecklistModel {
  QualitychecklistModel(
      {required this.srNo,
      required this.checklist,
      required this.responsibility,
      required this.reference,
      required this.observation,
      required this.photoNo
      // required this.weightage,
      });

  int srNo;
  String checklist;
  String responsibility;
  String reference;
  String observation;
  int photoNo;

  factory QualitychecklistModel.fromJson(Map<String, dynamic> json) {
    return QualitychecklistModel(
        srNo: json['srNo'],
        checklist: json['checklist'],
        responsibility: json['responsibility'],
        reference: json['reference'],
        observation: json['observation'],
        photoNo: json['photoNo']);
    // weightage: json['Weightage']);
  }

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<int>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'checklist', value: checklist),
      DataGridCell<String>(columnName: 'responsibility', value: responsibility),
      DataGridCell<String>(columnName: 'reference', value: reference),
      DataGridCell<String>(columnName: 'observation', value: observation),
      DataGridCell<int>(columnName: 'photoNo', value: photoNo),
      // DataGridCell<double>(columnName: 'Weightage', value: weightage),
    ]);
  }
}
