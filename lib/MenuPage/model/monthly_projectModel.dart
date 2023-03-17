import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MonthlyProjectModel {
  MonthlyProjectModel({
    required this.activityNo,
    required this.activityDetails,
    // required this.duration,
    // required this.startDate,
    // required this.endDate,
    required this.progress,
    required this.status,
    required this.action,
  });
  dynamic activityNo;
  String? activityDetails;
  // int? duration;
  // String? startDate;
  // String? endDate;
  String? progress;
  String? status;
  String? action;

  DataGridRow dataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell(columnName: 'ActivityNo', value: activityNo),
      DataGridCell(columnName: 'ActivityDetails', value: activityDetails),
      // DataGridCell(columnName: 'Duration', value: duration),
      // DataGridCell(columnName: 'StartDate', value: startDate),
      // DataGridCell(columnName: 'EndDate', value: endDate),
      DataGridCell(columnName: 'Progress', value: progress),
      DataGridCell(columnName: 'Status', value: status),
      DataGridCell(columnName: 'Action', value: action)
    ]);
  }

  factory MonthlyProjectModel.fromjson(Map<String, dynamic> json) {
    return MonthlyProjectModel(
        activityNo: json['ActivityNo'],
        activityDetails: json['ActivityDetails'],
        // duration: json['Duration'],
        // startDate: json['StartDate'],
        // endDate: json['EndDate'],
        progress: json['Progress'],
        status: json['Status'],
        action: json['Action']);
  }
}
