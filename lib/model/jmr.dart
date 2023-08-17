import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class JMRModel {
  JMRModel({
    required this.srNo,
    required this.Description,
    required this.Activity,
    required this.RefNo,
    required this.JmrAbstract,
    required this.Uom,
    required this.rate,
    required this.TotalQty,
    required this.TotalAmount,
  });

  dynamic srNo;
  String? Description;
  dynamic Activity;
  dynamic RefNo;
  dynamic JmrAbstract;
  String? Uom;
  dynamic rate;
  dynamic TotalQty;
  dynamic TotalAmount;

  factory JMRModel.fromjson(Map<String, dynamic> json) {
    return JMRModel(
        srNo: json['srNo'],
        Description: json['Description'],
        Activity: json['Activity'],
        RefNo: json['RefNo'],
        JmrAbstract: json['Abstract'],
        Uom: json['Uom'],
        rate: json['Rate'],
        TotalQty: json['TotalQty'],
        TotalAmount: json['TotalAmount']);
  }

  DataGridRow dataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<dynamic>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'Description', value: Description),
      DataGridCell<dynamic>(columnName: 'Activity', value: Activity),
      DataGridCell<dynamic>(columnName: 'RefNo', value: RefNo),
      DataGridCell<dynamic>(columnName: 'Abstract', value: JmrAbstract),
      DataGridCell<dynamic>(columnName: 'Uom', value: Uom),
      DataGridCell<dynamic>(columnName: 'Rate', value: rate),
      DataGridCell<dynamic>(columnName: 'TotalQty', value: TotalQty),
      DataGridCell<dynamic>(columnName: 'TotalAmount', value: TotalAmount),
      DataGridCell(columnName: 'Delete', value: null)
    ]);
  }
}
