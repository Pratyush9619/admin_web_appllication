import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../model/material_vendor.dart';

class MaterialDatasource extends DataGridSource {
  BuildContext mainContext;
  String? cityName;
  String? depoName;

  MaterialDatasource(
      this._material, this.mainContext, this.cityName, this.depoName) {
    buildDataGridRows();
  }
  void buildDataGridRows() {
    dataGridRows = _material
        .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
        .toList();
  }

  @override
  List<MaterialProcurementModel> _material = [];

  List<DataGridRow> dataGridRows = [];

  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();
  final DataGridController _dataGridController = DataGridController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  final DateRangePickerController _controller = DateRangePickerController();

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    DateTime? rangeStartDate = DateTime.now();
    DateTime? rangeEndDate = DateTime.now();
    DateTime? date;
    DateTime? endDate;
    DateTime? rangeStartDate1 = DateTime.now();
    DateTime? rangeEndDate1 = DateTime.now();
    DateTime? date1;
    DateTime? endDate1;
    DateRangePickerController _datecontroller = DateRangePickerController();
    int? balnceQtyValue;
    double? percProgress;
    final int dataIndex = dataGridRows.indexOf(row);

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: (dataGridCell.columnName == 'materialSite')
            ? Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: mainContext,
                          builder: (context) => AlertDialog(
                                title: const Text('All Date'),
                                content: Container(
                                    height: 400,
                                    width: 500,
                                    child: SfDateRangePicker(
                                      view: DateRangePickerView.month,
                                      showTodayButton: true,
                                      onSelectionChanged:
                                          (DateRangePickerSelectionChangedArgs
                                              args) {
                                        if (args.value is PickerDateRange) {
                                          rangeStartDate = args.value.startDate;
                                          rangeEndDate = args.value.endDate;
                                        } else {
                                          // final List<PickerDateRange>
                                          //     selectedRanges = args.value;
                                        }
                                      },
                                      selectionMode:
                                          DateRangePickerSelectionMode.single,
                                      showActionButtons: true,
                                      onSubmit: ((value) {
                                        date = DateTime.parse(value.toString());
                                        date1 =
                                            DateTime.parse(value.toString());
                                        // date2 = DateTime.parse(
                                        //     value.toString());

                                        final int dataRowIndex =
                                            dataGridRows.indexOf(row);
                                        if (dataRowIndex != null) {
                                          final int dataRowIndex =
                                              dataGridRows.indexOf(row);
                                          dataGridRows[dataRowIndex]
                                                  .getCells()[11] =
                                              DataGridCell<String>(
                                                  columnName: 'Date',
                                                  value:
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(date!));
                                          _material[dataRowIndex].materialSite =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(date!);

                                          notifyListeners();

                                          Navigator.pop(context);
                                        }
                                      }),
                                    )),
                              ));
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                  Text(dataGridCell.value.toString())
                ],
              )
            : Text(
                dataGridCell.value.toString(),
              ),
      );
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
    if (column.columnName == 'cityName') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'cityName', value: newCellValue);
      _material[dataRowIndex].cityName = newCellValue;
    } else if (column.columnName == 'details') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'details', value: newCellValue);
      _material[dataRowIndex].details = newCellValue.toString();
    } else if (column.columnName == 'olaNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'olaNo', value: newCellValue);
      _material[dataRowIndex].olaNo = newCellValue;
    } else if (column.columnName == 'vendorName') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'vendorName', value: newCellValue);
      _material[dataRowIndex].vendorName = newCellValue;
    } else if (column.columnName == 'oemApproval') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'oemApproval', value: newCellValue);
      _material[dataRowIndex].oemApproval = newCellValue;
    } else if (column.columnName == 'oemClearance') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'oemClearance', value: newCellValue);
      _material[dataRowIndex].oemClearance = newCellValue;
    } else if (column.columnName == 'croPlacement') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'croPlacement', value: newCellValue);
      _material[dataRowIndex].croPlacement = newCellValue;
    } else if (column.columnName == 'croVendor') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'croVendor', value: newCellValue);
      _material[dataRowIndex].croVendor = newCellValue;
    } else if (column.columnName == 'croNumber') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'croNumber', value: newCellValue);
      _material[dataRowIndex].croNumber = newCellValue;
    } else if (column.columnName == 'unit') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'unit', value: newCellValue);
      _material[dataRowIndex].unit = newCellValue;
    } else if (column.columnName == 'qty') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'qty', value: newCellValue);
      _material[dataRowIndex].qty = newCellValue;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'materialSite', value: newCellValue);
      _material[dataRowIndex].materialSite = newCellValue;
    }
    // Future storeData() async {
    //   await FirebaseFirestore.instance.collection('A1').add({
    //     'Weightage':
    //         dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //             DataGridCell<int>(
    //                 columnName: 'Weightage', value: newCellValue as int),
    //   });
    // }
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

    final bool isNumericType =
        // column.columnName == 'OriginalDuration' ||
        column.columnName == 'qty';
    // column.columnName == 'EndDate' ||
    // column.columnName == 'ActualStart' ||
    // column.columnName == 'ActualEnd' ||
    // column.columnName == 'ActualDuration' ||
    // column.columnName == 'Delay' ||
    // column.columnName == 'Unit' ||
    // column.columnName == 'QtyScope' ||
    // column.columnName == 'QtyExecuted' ||
    // column.columnName == 'BalancedQty' ||
    // column.columnName == 'Progress' ||
    // column.columnName == 'Weightage';

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
