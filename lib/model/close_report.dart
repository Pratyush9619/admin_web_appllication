import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CloseReportModel {
  double? siNo;
  String? content;
  // String? attachment;

  CloseReportModel({
    required this.siNo,
    required this.content,
    // required this.attachment,
  });

  factory CloseReportModel.fromjson(Map<String, dynamic> json) {
    return CloseReportModel(
      siNo: json['SiNo'],
      content: json['Content'],
      // attachment: json['Attachment'],
    );
  }

  DataGridRow dataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell(columnName: 'SiNo', value: siNo),
      DataGridCell(columnName: 'Content', value: content),
      const DataGridCell(columnName: 'Upload', value: null),
      const DataGridCell(columnName: 'View', value: null)
      // DataGridCell(columnName: 'Attachment', value: attachment),

      // const DataGridCell(columnName: 'Delete', value: null)
    ]);
  }
}
