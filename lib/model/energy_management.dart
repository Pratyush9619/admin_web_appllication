import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EnergyManagementModel {
  EnergyManagementModel(
      {required this.srNo,
      required this.depotName,
      required this.vehicleNo,
      required this.pssNo,
      required this.chargerId,
      required this.startSoc,
      required this.endSoc,
      required this.startDate,
      required this.endDate,
      required this.totalTime,
      // this.dependency,
      required this.energyConsumed,
      required this.timeInterval});

  dynamic srNo;
  String depotName;
  dynamic vehicleNo;
  int pssNo;
  dynamic chargerId;
  int startSoc;
  int endSoc;
  String startDate;
  String endDate;
  String totalTime;
  double energyConsumed;
  dynamic timeInterval;

  factory EnergyManagementModel.fromJson(Map<String, dynamic> json) {
    return EnergyManagementModel(
        srNo: json['srNo'],
        depotName: json['DepotName'],
        vehicleNo: json['VehicleNo'],
        pssNo: json['pssNo'],
        chargerId: json['chargerId'],
        startSoc: json['startSoc'],
        endSoc: json['endSoc'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        totalTime: json['totalTime'],
        energyConsumed: json['energyConsumed'],
        timeInterval: json['timeInterval']);
  }

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<dynamic>(columnName: 'srNo', value: srNo),
      DataGridCell<String>(columnName: 'DepotName', value: depotName),
      DataGridCell<dynamic>(columnName: 'VehicleNo', value: vehicleNo),
      DataGridCell<int>(columnName: 'pssNo', value: pssNo),
      DataGridCell<int>(columnName: 'chargerId', value: chargerId),
      DataGridCell<int>(columnName: 'startSoc', value: startSoc),
      DataGridCell<int>(columnName: 'endSoc', value: endSoc),
      DataGridCell<String>(columnName: 'startDate', value: startDate),
      DataGridCell<String>(columnName: 'endDate', value: endDate),
      DataGridCell<String>(columnName: 'totalTime', value: totalTime),
      DataGridCell<double>(columnName: 'energyConsumed', value: energyConsumed),
      DataGridCell<dynamic>(columnName: 'timeInterval', value: timeInterval),
       const DataGridCell(columnName: 'Add', value: null),
      const DataGridCell(columnName: 'Delete', value: null)
    ]);
  }
}
