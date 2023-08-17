import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../model/jmr.dart';
import '../style.dart';

class JmrDataSource extends DataGridSource {
  // BuildContext mainContext;
  JmrDataSource(this._JMRModels) {
    buildDataGridRows();
  }
  void buildDataGridRows() {
    dataGridRows =
        _JMRModels.map<DataGridRow>((dataGridRow) => dataGridRow.dataGridRow())
            .toList();
  }

  @override
  List<JMRModel> _JMRModels = [];

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
      return Container(
          alignment:
              //  (dataGridCell.columnName == 'srNo' ||
              //         dataGridCell.columnName == 'Activity' ||
              //         dataGridCell.columnName == 'OriginalDuration' ||
              // dataGridCell.columnName == 'StartDate' ||
              //         dataGridCell.columnName == 'EndDate' ||
              //         dataGridCell.columnName == 'ActualStart' ||
              //         dataGridCell.columnName == 'ActualEnd' ||
              //         dataGridCell.columnName == 'ActualDuration' ||
              //         dataGridCell.columnName == 'Delay' ||
              //         dataGridCell.columnName == 'Unit' ||
              //         dataGridCell.columnName == 'QtyScope' ||
              //         dataGridCell.columnName == 'QtyExecuted' ||
              //         dataGridCell.columnName == 'BalancedQty' ||
              //         dataGridCell.columnName == 'Progress' ||
              //         dataGridCell.columnName == 'Weightage')
              Alignment.center,
          // : Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: (dataGridCell.columnName == 'Delete')
              ? IconButton(
                  onPressed: () {
                    dataGridRows.remove(row);
                    notifyListeners();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: red,
                  ))
              // dataGridCell.columnName == 'button'
              //     ? LayoutBuilder(
              //         builder: (BuildContext context, BoxConstraints constraints) {
              //         return ElevatedButton(
              //             onPressed: () {
              //               Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) => UploadDocument(
              //                     activity:
              //                         '${row.getCells()[1].value.toString()}'),
              //               ));
              //               // showDialog(
              //               //     context: context,
              //               //     builder: (context) => AlertDialog(
              //               //         content: SizedBox(
              //               //             height: 100,
              //               //             child: Column(
              //               //               mainAxisAlignment:
              //               //                   MainAxisAlignment.spaceBetween,
              //               //               children: [
              //               //                 Text(
              //               //                     'JMRModel ID: ${row.getCells()[0].value.toString()}'),
              //               //                 Text(
              //               //                     'JMRModel Name: ${row.getCells()[1].value.toString()}'),
              //               //                 Text(
              //               //                     'JMRModel Designation: ${row.getCells()[2].value.toString()}'),
              //               //               ],
              //               //             ))));
              //             },
              //             child: const Text('Upload'));
              //       })
              //     : dataGridCell.columnName == 'ActualStart' ||
              //             dataGridCell.columnName == 'ActualEnd'
              //         ? Row(
              //             children: [
              //               IconButton(
              //                 onPressed: () {
              //                   showDialog(
              //                     context: mainContext,
              //                     builder: (context) => AlertDialog(
              //                         title: const Text('All Date'),
              //                         content: Container(
              //                           height: 400,
              //                           width: 500,
              //                           child: SfDateRangePicker(
              //                             view: DateRangePickerView.month,
              //                             showTodayButton: true,
              //                             onSelectionChanged:
              //                                 (DateRangePickerSelectionChangedArgs
              //                                     args) {
              //                               if (args.value is PickerDateRange) {
              //                                 rangeStartDate = args.value.startDate;
              //                                 rangeEndDate = args.value.endDate;
              //                               } else {
              //                                 final List<PickerDateRange>
              //                                     selectedRanges = args.value;
              //                               }
              //                             },
              //                             selectionMode:
              //                                 DateRangePickerSelectionMode.range,
              //                             showActionButtons: true,
              //                             onSubmit: ((value) {
              //                               date = DateTime.parse(
              //                                   rangeStartDate.toString());

              //                               endDate = DateTime.parse(
              //                                   rangeEndDate.toString());

              //                               Duration diff =
              //                                   endDate!.difference(date!);

              //                               print('Difference' +
              //                                   diff.inDays.toString());

              //                               final int dataRowIndex =
              //                                   dataGridRows.indexOf(row);
              //                               if (dataRowIndex != null) {
              //                                 _JMRModels[dataRowIndex]
              //                                         .actualstartDate =
              //                                     DateFormat('dd-MM-yyyy')
              //                                         .format(date!);

              //                                 dataGridRows[dataRowIndex] =
              //                                     DataGridRow(cells: [
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .srNo,
              //                                       columnName: 'srNo'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .activity,
              //                                       columnName: 'Activity'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex],
              //                                       columnName: 'button'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .originalDuration,
              //                                       columnName: 'OriginalDuration'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .startDate,
              //                                       columnName: 'StartDate'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .endDate,
              //                                       columnName: 'EndDate'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .actualstartDate,
              //                                       columnName: 'ActualStart'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .actualendDate,
              //                                       columnName: 'ActualEnd'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .actualDuration,
              //                                       columnName: 'ActualDuration'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .delay,
              //                                       columnName: 'Delay'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .unit,
              //                                       columnName: 'Unit'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .scope,
              //                                       columnName: 'QtyScope'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .qtyExecuted,
              //                                       columnName: 'QtyExecuted'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .balanceQty,
              //                                       columnName: 'BalancedQty'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .percProgress,
              //                                       columnName: 'Progress'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .weightage,
              //                                       columnName: 'Weightage'),
              //                                 ]);

              //                                 updateDataGrid(
              //                                     rowColumnIndex: RowColumnIndex(
              //                                         dataRowIndex, 6));
              //                                 notifyListeners();
              //                                 print('state$date');
              //                                 print('valuedata$value');

              //                                 print('start $rangeStartDate');
              //                                 print('End $rangeEndDate');
              //                                 // date = rangeStartDate;
              //                                 print('object$date');

              //                                 Navigator.pop(context);
              //                               }
              //                               if (dataRowIndex != null) {
              //                                 _JMRModels[dataRowIndex]
              //                                         .actualendDate =
              //                                     DateFormat('dd-MM-yyyy')
              //                                         .format(endDate!);

              //                                 dataGridRows[dataRowIndex] =
              //                                     DataGridRow(cells: [
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .srNo,
              //                                       columnName: 'srNo'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .activity,
              //                                       columnName: 'Activity'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex],
              //                                       columnName: 'button'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .originalDuration,
              //                                       columnName: 'OriginalDuration'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .startDate,
              //                                       columnName: 'StartDate'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .endDate,
              //                                       columnName: 'EndDate'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .actualstartDate,
              //                                       columnName: 'ActualStart'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .actualendDate,
              //                                       columnName: 'ActualEnd'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .actualDuration,
              //                                       columnName: 'ActualDuration'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .delay,
              //                                       columnName: 'Delay'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .unit,
              //                                       columnName: 'Unit'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .scope,
              //                                       columnName: 'QtyScope'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .qtyExecuted,
              //                                       columnName: 'QtyExecuted'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .balanceQty,
              //                                       columnName: 'BalancedQty'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .percProgress,
              //                                       columnName: 'Progress'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .weightage,
              //                                       columnName: 'Weightage'),
              //                                 ]);

              //                                 updateDataGrid(
              //                                     rowColumnIndex: RowColumnIndex(
              //                                         dataRowIndex, 7));

              //                                 notifyListeners();
              //                               }
              //                               if (dataRowIndex != null) {
              //                                 _JMRModels[dataRowIndex]
              //                                         .actualDuration =
              //                                     int.parse(diff.inDays.toString());

              //                                 dataGridRows[dataRowIndex] =
              //                                     DataGridRow(cells: [
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .srNo,
              //                                       columnName: 'srNo'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .activity,
              //                                       columnName: 'Activity'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex],
              //                                       columnName: 'button'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .originalDuration,
              //                                       columnName: 'OriginalDuration'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .startDate,
              //                                       columnName: 'StartDate'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .endDate,
              //                                       columnName: 'EndDate'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .actualstartDate,
              //                                       columnName: 'ActualStart'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .actualendDate,
              //                                       columnName: 'ActualEnd'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .actualDuration,
              //                                       columnName: 'ActualDuration'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .delay,
              //                                       columnName: 'Delay'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .unit,
              //                                       columnName: 'Unit'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .scope,
              //                                       columnName: 'QtyScope'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .qtyExecuted,
              //                                       columnName: 'QtyExecuted'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .balanceQty,
              //                                       columnName: 'BalancedQty'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .percProgress,
              //                                       columnName: 'Progress'),
              //                                   DataGridCell(
              //                                       value: _JMRModels[dataRowIndex]
              //                                           .weightage,
              //                                       columnName: 'Weightage'),
              //                                 ]);

              //                                 updateDataGrid(
              //                                     rowColumnIndex: RowColumnIndex(
              //                                         dataRowIndex, 8));
              //                                 notifyListeners();
              //                               }
              //                             }),
              //                             onCancel: () {
              //                               _controller.selectedRanges = null;
              //                             },
              //                           ),
              //                         )),
              //                   );
              //                 },
              //                 icon: const Icon(Icons.calendar_today),
              //               ),
              //               Text(dataGridCell.value.toString()),
              //             ],
              //           )
              //         :
              : Text(
                  dataGridCell.value.toString(),
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
          DataGridCell<int>(columnName: 'srNo', value: newCellValue);
      _JMRModels[dataRowIndex].srNo = newCellValue as int;
    } else if (column.columnName == 'Description') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Description', value: newCellValue);
      _JMRModels[dataRowIndex].Description = newCellValue.toString();
    } else if (column.columnName == 'Activity') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Activity', value: newCellValue);
      _JMRModels[dataRowIndex].Activity = newCellValue.toString();
    } else if (column.columnName == 'RefNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(
              columnName: 'RefNo', value: newCellValue as int);
      _JMRModels[dataRowIndex].RefNo = newCellValue as dynamic;
    } else if (column.columnName == 'Abstract') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Abstract', value: newCellValue);
      _JMRModels[dataRowIndex].JmrAbstract = newCellValue;
    } else if (column.columnName == 'UOM') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'UOM', value: newCellValue);
      _JMRModels[dataRowIndex].Uom = newCellValue;
    } else if (column.columnName == 'Rate') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'Rate', value: newCellValue);
      _JMRModels[dataRowIndex].rate = newCellValue;
    } else if (column.columnName == 'TotalQty') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'TotalQty', value: newCellValue);
      _JMRModels[dataRowIndex].TotalQty = newCellValue;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'TotalAmount', value: newCellValue);
      _JMRModels[dataRowIndex].TotalAmount = newCellValue;
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

    final bool isNumericType = column.columnName == 'srNo' ||
        column.columnName == 'Rate' ||
        column.columnName == 'TotalQty' ||
        column.columnName == 'TotalAmount' ||
        column.columnName == 'RefNo';

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
            : RegExp('[a-zA-Z0-9.@!#^&*(){+-}%|<>?_=+,/ )]');
  }
}
