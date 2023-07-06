import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DailyProjectModel {
  DailyProjectModel({
    required this.siNo,
    required this.date,
    // required this.state,
    // required this.depotName,
    required this.typeOfActivity,
    required this.activityDetails,
    required this.progress,
    required this.status,
  });
  int? siNo;
  String? date;
  // String? state;
  // String? depotName;
  String? typeOfActivity;
  String? activityDetails;
  String? progress;
  String? status;

  factory DailyProjectModel.fromjson(Map<String, dynamic> json) {
    return DailyProjectModel(
        siNo: json['SiNo'],
        date: json['Date'],
        // state: json['state'],
        // depotName: json['depotName'],
        typeOfActivity: json['TypeOfActivity'],
        activityDetails: json['ActivityDetails'],
        progress: json['Progress'],
        status: json['Status']);
  }

  DataGridRow dataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell(columnName: 'Date', value: date),
      DataGridCell(columnName: 'SiNo', value: siNo),
      // DataGridCell(columnName: 'State', value: state),
      // DataGridCell(columnName: 'DepotName', value: depotName),
      DataGridCell(columnName: 'TypeOfActivity', value: typeOfActivity),
      DataGridCell(columnName: 'ActivityDetails', value: activityDetails),
      DataGridCell(columnName: 'Progress', value: progress),
      DataGridCell(columnName: 'Status', value: status)
    ]);
  }
}
