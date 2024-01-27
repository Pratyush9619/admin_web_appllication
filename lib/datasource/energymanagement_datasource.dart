import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../model/energy_management.dart';
import '../style.dart';

class EnergyManagementDatasource extends DataGridSource {
  BuildContext mainContext;
  // String userId;
  String? cityName;
  String? depoName;

  EnergyManagementDatasource(this._energyManagement, this.mainContext,
      this.cityName, this.depoName) {
    buildDataGridRows();
  }
  void buildDataGridRows() {
    dataGridRows = _energyManagement
        .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
        .toList();
  }

  @override
  List<EnergyManagementModel> _energyManagement = [];

  List<DataGridRow> dataGridRows = [];

  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();
  final DataGridController _dataGridController = DataGridController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  final DateRangePickerController _controller = DateRangePickerController();
  int? balnceQtyValue;
  double? perc;
  // String? startformattedTime = '12:30';
  // String? endformattedTime = '15:45';

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    void addRowAtIndex(int index, EnergyManagementModel rowData) {
      _energyManagement.insert(index, rowData);
      buildDataGridRows();
      notifyListeners();
      // notifyListeners(DataGridSourceChangeKind.rowAdd, rowIndexes: [index]);
    }

    void removeRowAtIndex(int index) {
      _energyManagement.removeAt(index);
      buildDataGridRows();
      notifyListeners();
    }

    DateTime? rangeStartDate = DateTime.now();
    DateTime? date;
    Duration difference;

    DateTime selectedDateTime = DateTime.now();

    Future<void> _selectDateTime(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          selectedDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
              pickedTime.minute % 60);
        }
      }
    }

    final int dataRowIndex = dataGridRows.indexOf(row);
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      DateTime startDate = DateFormat('dd-MM-yyyy HH:mm:ss')
          .parse(_energyManagement[dataRowIndex].startDate);
      DateTime endDate = DateFormat('dd-MM-yyyy HH:mm:ss')
          .parse(_energyManagement[dataRowIndex].endDate);

      difference = endDate.difference(startDate);

      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: (dataGridCell.columnName == 'startDate')
              ? Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        _selectDateTime(mainContext).whenComplete(() {
                          _energyManagement[dataRowIndex].startDate =
                              DateFormat('dd-MM-yyyy HH:mm:ss')
                                  .format(selectedDateTime);
                          //   // print(startformattedTime); //output 14:59:00
                          // print(selectedDateTime);
                          _energyManagement[dataRowIndex].timeInterval =
                              '${selectedDateTime.hour}:${selectedDateTime.minute} - ${selectedDateTime.add(const Duration(hours: 6)).hour}:${selectedDateTime.add(const Duration(hours: 6)).minute}';

                          buildDataGridRows();
                          notifyListeners();
                        });

                        // }
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                    Text(dataGridCell.value.toString()),
                  ],
                )
              : (dataGridCell.columnName == 'endDate')
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            _selectDateTime(mainContext).whenComplete(() {
                              _energyManagement[dataRowIndex].endDate =
                                  DateFormat('dd-MM-yyyy HH:mm:ss')
                                      .format(selectedDateTime);
                              //   // print(startformattedTime); //output 14:59:00
                              // print(selectedDateTime);

                              buildDataGridRows();
                              notifyListeners();
                            });
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                        Text(dataGridCell.value.toString()),
                      ],
                    )
                  : (dataGridCell.columnName == 'totalTime')
                      ? Text(
                          '${difference.inHours}:${difference.inMinutes % 60}:${difference.inSeconds % 60}')
                      : (dataGridCell.columnName == 'Add')
                          ? ElevatedButton(
                              onPressed: () {
                                addRowAtIndex(
                                    dataRowIndex + 1,
                                    EnergyManagementModel(
                                        srNo: dataRowIndex + 2,
                                        depotName: depoName!,
                                        vehicleNo: 'vehicleNo',
                                        pssNo: 1,
                                        chargerId: 1,
                                        startSoc: 1,
                                        endSoc: 1,
                                        startDate:
                                            DateFormat('dd-MM-yyyy HH:mm:ss')
                                                .format(DateTime.now()),
                                        endDate:
                                            DateFormat('dd-MM-yyyy HH:mm:ss')
                                                .format(DateTime.now()),
                                        totalTime:
                                            DateFormat('dd-MM-yyyy HH:mm:ss')
                                                .format(DateTime.now()),
                                        energyConsumed: 1500,
                                        timeInterval:
                                            '${DateTime.now().hour}:${DateTime.now().minute} - ${DateTime.now().add(const Duration(hours: 6)).hour}:${DateTime.now().add(const Duration(hours: 6)).minute}'));
                              },
                              child: const Text('Add'))
                          : (dataGridCell.columnName == 'Delete')
                              ? IconButton(
                                  onPressed: () {
                                    removeRowAtIndex(dataRowIndex);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: red,
                                  ))
                              : Text(
                                  dataGridCell.value.toString(),
                                  textAlign: TextAlign.center,
                                ));
    }).toList());
  }

  void updateDatagridSource() {
    notifyListeners();
  }

  void updateDataGrid({required RowColumnIndex rowColumnIndex}) {
    notifyDataSourceListeners(rowColumnIndex: rowColumnIndex);
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    if (column.columnName == 'srNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'srNo', value: newCellValue);
      _energyManagement[dataRowIndex].srNo = newCellValue;
    } else if (column.columnName == 'DepotName') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'DepotName', value: newCellValue);
      _energyManagement[dataRowIndex].depotName = newCellValue.toString();
    } else if (column.columnName == 'VehicleNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'VehicleNo', value: newCellValue);
      _energyManagement[dataRowIndex].vehicleNo = newCellValue;
    } else if (column.columnName == 'pssNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'pssNo', value: newCellValue);
      _energyManagement[dataRowIndex].pssNo = newCellValue;
    } else if (column.columnName == 'chargerId') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'chargerId', value: newCellValue);
      _energyManagement[dataRowIndex].chargerId = newCellValue;
    } else if (column.columnName == 'StartSoc') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'StartSoc', value: newCellValue as int);
      _energyManagement[dataRowIndex].startSoc = newCellValue;
    } else if (column.columnName == 'endSoc') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'endSoc', value: newCellValue);
      _energyManagement[dataRowIndex].endSoc = newCellValue;
    } else if (column.columnName == 'SatrtDate') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<DateTime>(columnName: 'SatrtDate', value: newCellValue);
      _energyManagement[dataRowIndex].startDate = newCellValue;
    } else if (column.columnName == 'EndDate') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'EndDate', value: newCellValue);
      _energyManagement[dataRowIndex].endDate = newCellValue;
    } else if (column.columnName == 'totalTime') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<DateTime>(columnName: 'totalTime', value: newCellValue);
      _energyManagement[dataRowIndex].totalTime = newCellValue;
    } else if (column.columnName == 'energyConsumed') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(
              columnName: 'energyConsumed', value: newCellValue);
      _energyManagement[dataRowIndex].energyConsumed = newCellValue as double;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(
              columnName: 'timeInterval', value: newCellValue);
      _energyManagement[dataRowIndex].timeInterval = newCellValue;
    }
  }

  @override
  bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    // Return false, to retain in edit mode.
    return true; // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    final bool isNumericType = column.columnName == 'pssNo' ||
        column.columnName == 'chargerId' ||
        // column.columnName == 'EndDate' ||
        column.columnName == 'energyConsumed' ||
        column.columnName == 'endSoc' ||
        column.columnName == 'startSoc';

    final bool isDateTimeType = column.columnName == 'StartDate' ||
        column.columnName == 'EndDate' ||
        column.columnName == 'ActualStart' ||
        column.columnName == 'ActualEnd';
    // Holds regular expression pattern based on the column type.
    final RegExp regExp =
        _getRegExp(isNumericType, isDateTimeType, column.columnName);

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        autocorrect: false,
        decoration: const InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(regExp),
        ],
        keyboardType: isNumericType
            ? TextInputType.number
            : isDateTimeType
                ? TextInputType.datetime
                : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = double.parse(value);
            } else if (isDateTimeType) {
              newCellValue = value;
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          /// Call [CellSubmit] callback to fire the canSubmitCell and
          /// onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  RegExp _getRegExp(
      bool isNumericKeyBoard, bool isDateTimeBoard, String columnName) {
    return isNumericKeyBoard
        ? RegExp('[0-9.]')
        : isDateTimeBoard
            ? RegExp('[0-9-]')
            : RegExp('[a-zA-Z0-9.@!#^&*(){+-}%|<>?_=+,/ )]');
  }
}
