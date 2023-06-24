import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MaterialProcurementModel {
  String? cityName;
  String? details;
  String? olaNo;
  String? vendorName;
  String? oemApproval;
  String? oemClearence;
  String? engApproval;
  String? oemClearance;
  String? croPlacement;
  String? croVendor;
  String? croNumber;
  String? unit;
  int? qty;
  String? materialSite;

  // String? scope;
  // String? requirement;
  // String? peCreated;
  // // String? prEngApproval;
  // String? prFinalApproval;
  // String? tenderFloated;
  // String? vendorSubmission;
  // String? terEvaluation;
  // String? safetyBidEvaluation;
  // String? bidOpening;
  // String? tmlApproval;
  // String? oafApproval;
  // String? olaVendor;
  // String? oemdrawing;
  // String? oemApproval;
  // String? oemClearance;
  // String? poPlaced;
  // String? materialReceived;

  MaterialProcurementModel({
    required this.cityName,
    required this.details,
    required this.olaNo,
    required this.vendorName,
    required this.oemApproval,
    required this.oemClearance,
    required this.croPlacement,
    required this.croVendor,
    required this.croNumber,
    required this.unit,
    required this.qty,
    required this.materialSite,
  });

  factory MaterialProcurementModel.fromjsaon(Map<String, dynamic> json) {
    return MaterialProcurementModel(
        cityName: json['cityName'],
        details: json['details'],
        olaNo: json['olaNo'],
        vendorName: json['vendorName'],
        oemApproval: json['oemApproval'],
        oemClearance: json['oemClearance'],
        croPlacement: json['croPlacement'],
        croVendor: json['croVendor'],
        croNumber: json['croNumber'],
        unit: json['unit'],
        qty: json['qty'],
        materialSite: json['materialSite']);
  }

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<dynamic>(columnName: 'cityName', value: cityName),
      DataGridCell<String>(columnName: 'details', value: details),
      DataGridCell<String>(columnName: 'olaNo', value: olaNo),
      DataGridCell<String>(columnName: 'vendorName', value: vendorName),
      DataGridCell<String>(columnName: 'oemApproval', value: oemApproval),
      DataGridCell<String>(columnName: 'oemClearance', value: oemClearance),
      // DataGridCell<String>(columnName: 'prEngApproval', value: prEngApproval),
      DataGridCell<String>(columnName: 'croPlacement', value: croPlacement),
      DataGridCell<String>(columnName: 'croVendor', value: croVendor),
      DataGridCell<String>(columnName: 'croNumber', value: croNumber),
      DataGridCell<String>(columnName: 'unit', value: unit),
      DataGridCell<int>(columnName: 'qty', value: qty),
      DataGridCell<String>(columnName: 'materialSite', value: materialSite),
    ]);
  }
}
