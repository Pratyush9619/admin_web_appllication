import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class JMRModel {
  JMRModel({
    required this.srNo,
    required this.description,
    required this.activity,
    required this.refNo,
    required this.jmrAbstract,
    required this.uom,
    required this.rate,
    required this.totalQty,
    required this.totalAmount,
  });

  dynamic srNo;
  String? description;
  dynamic activity;
  dynamic refNo;
  dynamic jmrAbstract;
  String? uom;
  dynamic rate;
  dynamic totalQty;
  dynamic totalAmount;

  factory JMRModel.fromjson(Map<String, dynamic> json) {
    return JMRModel(
        srNo: json['srNo'],
        description: json['description'],
        activity: json['activity'],
        refNo: json['RefNo'],
        jmrAbstract: json['Abstract'],
        uom: json['Uom'],
        rate: json['Rate'],
        totalQty: json['TotalQty'],
        totalAmount: json['TotalAmount']);
  }

  DataGridRow dataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<dynamic>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'description', value: description),
      DataGridCell<dynamic>(columnName: 'activity', value: activity),
      DataGridCell<dynamic>(columnName: 'RefNo', value: refNo),
      DataGridCell<dynamic>(columnName: 'Abstract', value: jmrAbstract),
      DataGridCell<dynamic>(columnName: 'Uom', value: uom),
      DataGridCell<dynamic>(columnName: 'Rate', value: rate),
      DataGridCell<dynamic>(columnName: 'TotalQty', value: totalQty),
      DataGridCell<dynamic>(columnName: 'TotalAmount', value: totalAmount),
      const DataGridCell(columnName: 'Delete', value: null)
    ]);
  }
}
