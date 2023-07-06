import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../model/monthly_projectModel.dart';
import '../style.dart';

class MonthlyDataSource extends DataGridSource {
  // String cityName;
  // String depoName;
  BuildContext mainContext;
  MonthlyDataSource(
    this._montlyproject,
    this.mainContext,
  ) {
    buildDataGridRows();
  }
  void buildDataGridRows() {
    dataGridRows = _montlyproject
        .map<DataGridRow>((dataGridRow) => dataGridRow.dataGridRow())
        .toList();
  }

  @override
  List<MonthlyProjectModel> _montlyproject = [];

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
    DateTime? rangeStartDate = DateTime.now();
    DateTime? rangeEndDate = DateTime.now();
    DateTime? date;
    DateTime? endDate;
    DateTime? rangeStartDate1 = DateTime.now();
    DateTime? rangeEndDate1 = DateTime.now();
    DateTime? date1;
    DateTime? endDate1;
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      Color? columnbackgroundcolor;

      if (dataGridCell.columnName == 'User ID') {
        columnbackgroundcolor = blue;
      }
      return Container(
          color: columnbackgroundcolor,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: dataGridCell.columnName == 'User ID'
              ? Text(
                  dataGridCell.value.toString(),
                  style: TextStyle(color: white),
                )
              // dataGridCell.columnName == 'StartDate'
              //     ? Row(
              //         children: [
              //           IconButton(
              //             onPressed: () {
              //               showDialog(
              //                 context: mainContext,
              //                 builder: (context) => AlertDialog(
              //                     title: const Text('All Date'),
              //                     content: Container(
              //                       height: 400,
              //                       width: 500,
              //                       child: SfDateRangePicker(
              //                         view: DateRangePickerView.month,
              //                         showTodayButton: true,
              //                         onSelectionChanged:
              //                             (DateRangePickerSelectionChangedArgs
              //                                 args) {
              //                           if (args.value is PickerDateRange) {
              //                             rangeStartDate = args.value.startDate;
              //                             rangeEndDate = args.value.endDate;
              //                           } else {
              //                             final List<PickerDateRange>
              //                                 selectedRanges = args.value;
              //                           }
              //                         },
              //                         selectionMode:
              //                             DateRangePickerSelectionMode.range,
              //                         showActionButtons: true,
              //                         onSubmit: ((value) {
              //                           date = DateTime.parse(
              //                               rangeStartDate.toString());

              //                           endDate =
              //                               DateTime.parse(rangeEndDate.toString());

              //                           Duration diff = endDate!.difference(date!);

              //                           print(
              //                               'Difference' + diff.inDays.toString());

              //                           final int dataRowIndex =
              //                               dataGridRows.indexOf(row);
              //                           if (dataRowIndex != null) {
              //                             _montlyproject[dataRowIndex].startDate =
              //                                 DateFormat('dd-MM-yyyy')
              //                                     .format(date!);

              //                             dataGridRows[dataRowIndex] =
              //                                 DataGridRow(cells: [
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .activityNo,
              //                                   columnName: 'ActivityNo'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .activityDetails,
              //                                   columnName: 'ActivityDetails'),
              //                               // DataGridCell(
              //                               //     value: _montlyproject[dataRowIndex]
              //                               //         .duration,
              //                               //     columnName: 'Duration'),
              //                               // DataGridCell(
              //                               //     value: _montlyproject[dataRowIndex]
              //                               //         .startDate,
              //                               //     columnName: 'StartDate'),
              //                               // DataGridCell(
              //                               //     value: _montlyproject[dataRowIndex]
              //                               //         .endDate,
              //                               //     columnName: 'EndDate'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .progress,
              //                                   columnName: 'Progress'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .status,
              //                                   columnName: 'Status'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .action,
              //                                   columnName: 'Action'),
              //                             ]);

              //                             updateDataGrid(
              //                                 rowColumnIndex:
              //                                     RowColumnIndex(dataRowIndex, 3));
              //                             notifyListeners();
              //                             print('state$date');
              //                             print('valuedata$value');

              //                             print('start $rangeStartDate');
              //                             print('End $rangeEndDate');
              //                             // date = rangeStartDate;
              //                             print('object$date');
              //                           }
              //                           if (dataRowIndex != null) {
              //                             _montlyproject[dataRowIndex].endDate =
              //                                 DateFormat('dd-MM-yyyy')
              //                                     .format(endDate!);

              //                             dataGridRows[dataRowIndex] =
              //                                 DataGridRow(cells: [
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .activityNo,
              //                                   columnName: 'ActivityNo'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .activityDetails,
              //                                   columnName: 'ActivityDetails'),
              //                               // DataGridCell(
              //                               //     value: _montlyproject[dataRowIndex]
              //                               //         .duration,
              //                               //     columnName: 'Duration'),
              //                               // DataGridCell(
              //                               //     value: _montlyproject[dataRowIndex]
              //                               //         .startDate,
              //                               //     columnName: 'StartDate'),
              //                               // DataGridCell(
              //                               //     value: _montlyproject[dataRowIndex]
              //                               //         .endDate,
              //                               //     columnName: 'EndDate'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .progress,
              //                                   columnName: 'Progress'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .status,
              //                                   columnName: 'Status'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .action,
              //                                   columnName: 'Action'),
              //                             ]);

              //                             updateDataGrid(
              //                                 rowColumnIndex:
              //                                     RowColumnIndex(dataRowIndex, 4));
              //                             notifyListeners();
              //                           }
              //                           if (dataRowIndex != null) {
              //                             _montlyproject[dataRowIndex].duration =
              //                                 int.parse(diff.inDays.toString());

              //                             dataGridRows[dataRowIndex] =
              //                                 DataGridRow(cells: [
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .activityNo,
              //                                   columnName: 'ActivityNo'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .activityDetails,
              //                                   columnName: 'ActivityDetails'),
              //                               // DataGridCell(
              //                               //     value: _montlyproject[dataRowIndex]
              //                               //         .duration,
              //                               //     columnName: 'Duration'),
              //                               // DataGridCell(
              //                               //     value: _montlyproject[dataRowIndex]
              //                               //         .startDate,
              //                               //     columnName: 'StartDate'),
              //                               // DataGridCell(
              //                               //     value: _montlyproject[dataRowIndex]
              //                               //         .endDate,
              //                               //     columnName: 'EndDate'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .progress,
              //                                   columnName: 'Progress'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .status,
              //                                   columnName: 'Status'),
              //                               DataGridCell(
              //                                   value: _montlyproject[dataRowIndex]
              //                                       .action,
              //                                   columnName: 'Action'),
              //                             ]);

              //                             updateDataGrid(
              //                                 rowColumnIndex:
              //                                     RowColumnIndex(dataRowIndex, 2));
              //                             notifyListeners();
              //                             Navigator.pop(context);
              //                           }
              //                         }),
              //                         onCancel: () {
              //                           _controller.selectedRanges = null;
              //                         },
              //                       ),
              //                     )),
              //               );
              //             },
              //             icon: const Icon(Icons.calendar_today),
              //           ),
              //           Text(dataGridCell.value.toString()),
              //         ],
              //       )
              //     :
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
    // if (column.columnName == 'User ID') {
    //   dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<int>(columnName: 'User ID', value: newCellValue);
    //   _montlyproject[dataRowIndex].tbluserid = newCellValue;
    // }
    if (column.columnName == 'activityNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'activityNo', value: newCellValue);
      _montlyproject[dataRowIndex].activityNo = newCellValue as int;
    } else if (column.columnName == 'ActivityDetails') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: 'ActivityDetails', value: newCellValue);
      _montlyproject[dataRowIndex].activityDetails = newCellValue.toString();
    }
    //  else if (column.columnName == 'Duration') {
    //   dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<int>(columnName: 'Duration', value: newCellValue as int);
    //   _montlyproject[dataRowIndex].duration = newCellValue;
    // } else if (column.columnName == 'StartDate') {
    //   dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<String>(columnName: 'StartDate', value: newCellValue);
    //   _montlyproject[dataRowIndex].startDate = newCellValue;
    // } else if (column.columnName == 'EndDate') {
    //   dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<String>(columnName: 'EndDate', value: newCellValue);
    //   _montlyproject[dataRowIndex].endDate = newCellValue;
    // }
    else if (column.columnName == 'Progress') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Progress', value: newCellValue);
      _montlyproject[dataRowIndex].progress = newCellValue;
    } else if (column.columnName == 'Status') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Status', value: newCellValue);
      _montlyproject[dataRowIndex].status = newCellValue;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Action', value: newCellValue);
      _montlyproject[dataRowIndex].action = newCellValue;
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

    final bool isNumericType = column.columnName == 'OriginalDuration';
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
            : RegExp('[a-zA-Z ]');
  }
}
