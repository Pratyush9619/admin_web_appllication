import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../KeyEvents/upload.dart';
import '../KeyEvents/viewFIle.dart';
import '../model/close_report.dart';
import '../model/daily_projectModel.dart';
import '../style.dart';

class CloseReportDataSource extends DataGridSource {
  String cityName;
  String depoName;
  BuildContext mainContext;

  List data = [];
  CloseReportDataSource(
    this._montlyproject,
    this.mainContext,
    this.depoName,
    this.cityName,
  ) {
    buildDataGridRows();
  }
  void buildDataGridRows() {
    dataGridRows = _montlyproject
        .map<DataGridRow>((dataGridRow) => dataGridRow.dataGridRow())
        .toList();
  }

  @override
  List<CloseReportModel> _montlyproject = [];

  List<DataGridRow> dataGridRows = [];
  final _dateFormatter = DateFormat.yMd();

  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    DateTime? rangeEndDate = DateTime.now();
    DateTime? date;
    DateTime? endDate;
    DateTime? rangeStartDate1 = DateTime.now();
    DateTime? rangeEndDate1 = DateTime.now();
    DateTime? date1;
    DateTime? endDate1;
    final int dataRowIndex = dataGridRows.indexOf(row);

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: dataGridCell.columnName == 'Upload'
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: blue),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UploadDocument(
                              title: 'DetailedEngRFC',
                              cityName: cityName,
                              depoName: depoName,
                              activity: row.getCells()[3].value.toString()),
                        ));
                        // showDialog(
                        //     context: context,
                        //     builder: (context) => AlertDialog(
                        //         content: SizedBox(
                        //             height: 100,
                        //             child: Column(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 Text(
                        //                     'Employee ID: ${row.getCells()[0].value.toString()}'),
                        //                 Text(
                        //                     'Employee Name: ${row.getCells()[1].value.toString()}'),
                        //                 Text(
                        //                     'Employee Designation: ${row.getCells()[2].value.toString()}'),
                        //               ],
                        //             ))));
                      },
                      child: const Text('Upload'));
                })
              : dataGridCell.columnName == 'View'
                  ? LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                      return ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(backgroundColor: blue),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewFile()
                                // UploadDocument(
                                //     title: 'DetailedEngRFC',
                                //     cityName: cityName,
                                //     depoName: depoName,
                                //     activity: '${row.getCells()[1].value.toString()}'),
                                ));
                            // showDialog(
                            //     context: context,
                            //     builder: (context) => AlertDialog(
                            //         content: SizedBox(
                            //             height: 100,
                            //             child: Column(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Text(
                            //                     'Employee ID: ${row.getCells()[0].value.toString()}'),
                            //                 Text(
                            //                     'Employee Name: ${row.getCells()[1].value.toString()}'),
                            //                 Text(
                            //                     'Employee Designation: ${row.getCells()[2].value.toString()}'),
                            //               ],
                            //             ))));
                          },
                          child: const Text('View'));
                    })
                  // : (dataGridCell.columnName == 'Date')
                  //     ? Row(
                  //         children: [
                  //           IconButton(
                  //             onPressed: () {
                  //               showDialog(
                  //                   context: mainContext,
                  //                   builder: (context) => AlertDialog(
                  //                         title: const Text('All Date'),
                  //                         content: SizedBox(
                  //                             height: 400,
                  //                             width: 500,
                  //                             child: SfDateRangePicker(
                  //                               view: DateRangePickerView.month,
                  //                               showTodayButton: true,
                  //                               onSelectionChanged:
                  //                                   (DateRangePickerSelectionChangedArgs
                  //                                       args) {
                  //                                 if (args.value
                  //                                     is PickerDateRange) {
                  //                                   rangeEndDate =
                  //                                       args.value.endDate;
                  //                                 } else {
                  //                                   final List<PickerDateRange>
                  //                                       selectedRanges = args.value;
                  //                                 }
                  //                               },
                  //                               selectionMode:
                  //                                   DateRangePickerSelectionMode
                  //                                       .single,
                  //                               showActionButtons: true,
                  //                               onSubmit: ((value) {
                  //                                 date = DateTime.parse(
                  //                                     value.toString());

                  //                                 final int dataRowIndex =
                  //                                     dataGridRows.indexOf(row);
                  //                                 if (dataRowIndex != null) {
                  //                                   final int dataRowIndex =
                  //                                       dataGridRows.indexOf(row);
                  //                                   dataGridRows[dataRowIndex]
                  //                                           .getCells()[1] =
                  //                                       DataGridCell<String>(
                  //                                           columnName: 'Date',
                  //                                           value: DateFormat(
                  //                                                   'dd-MM-yyyy')
                  //                                               .format(date!));
                  //                                   _montlyproject[dataRowIndex]
                  //                                           .date =
                  //                                       DateFormat('dd-MM-yyyy')
                  //                                           .format(date!);
                  //                                   notifyListeners();

                  //                                   Navigator.pop(context);
                  //                                 }
                  //                               }),
                  //                             )),
                  //                       ));
                  //             },
                  //             icon: const Icon(Icons.calendar_today),
                  //           ),
                  //           Text(dataGridCell.value.toString()),
                  //         ],
                  //       )
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
    if (column.columnName == 'SiNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'SiNo', value: newCellValue);
      _montlyproject[dataRowIndex].siNo = newCellValue;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'content', value: newCellValue);
      _montlyproject[dataRowIndex].content = newCellValue;
    }
    // else {
    //   dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<String>(columnName: 'Attachment', value: newCellValue);
    //   _montlyproject[dataRowIndex].attachment = newCellValue;
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

    final bool isNumericType = column.columnName == 'SiNo';
    //  ||
    // column.columnName == 'StartDate' ||
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
              newCellValue = int.parse(value);
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
        ? RegExp('[0-9]')
        : isDateTimeBoard
            ? RegExp('[0-9/]')
            : RegExp('[a-zA-Z0-9 ]');
  }
}
