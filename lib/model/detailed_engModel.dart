import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DetailedEngModel {
  DetailedEngModel({
    required this.siNo,
    required this.title,
    required this.number,
    required this.preparationDate,
    required this.submissionDate,
    required this.approveDate,
    required this.releaseDate,
  });

  int? siNo;
  String? title;
  int? number;
  String? preparationDate;
  String? submissionDate;
  String? approveDate;
  String? releaseDate;

  factory DetailedEngModel.fromjsaon(Map<String, dynamic> json) {
    return DetailedEngModel(
        siNo: json['SiNo'],
        title: json['Title'],
        number: json['Number'],
        preparationDate: json['PreparationDate'],
        submissionDate: json['SubmissionDate'],
        approveDate: json['ApproveDate'],
        releaseDate: json['ReleaseDate']);
  }

  DataGridRow dataGridRow() {
    return DataGridRow(cells: [
      DataGridCell(columnName: 'SiNo', value: siNo),
      const DataGridCell<Widget>(columnName: 'button', value: null),
      const DataGridCell<Widget>(columnName: 'ViewDrawing', value: null),
      DataGridCell(columnName: 'Title', value: title),
      DataGridCell(columnName: 'Number', value: number),
      DataGridCell(columnName: 'PreparationDate', value: preparationDate),
      DataGridCell(columnName: 'SubmissionDate', value: submissionDate),
      DataGridCell(columnName: 'ApproveDate', value: approveDate),
      DataGridCell(columnName: 'ReleaseDate', value: releaseDate),
      const DataGridCell<Widget>(columnName: 'Delete', value: null),
    ]);
  }
}
