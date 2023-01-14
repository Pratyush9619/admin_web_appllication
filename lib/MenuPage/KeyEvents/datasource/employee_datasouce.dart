import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:web_appllication/MenuPage/KeyEvents/model/employee.dart';
import 'package:web_appllication/MenuPage/KeyEvents/viewFIle.dart';

class EmployeeDataSource extends DataGridSource {
  BuildContext mainContext;

  EmployeeDataSource(this._employees, this.mainContext) {
    buildDataGridRows();
  }
  void buildDataGridRows() {
    dataGridRows = _employees
        .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
        .toList();
  }

  @override
  List<Employee> _employees = [];

  List<DataGridRow> dataGridRows = [];

  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  final DateRangePickerController _controller = DateRangePickerController();

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final DataGridController _dataGridController = DataGridController();
    DateTime? rangeStartDate = DateTime.now();
    DateTime? rangeEndDate = DateTime.now();
    DateTime? date;
    DateTime? endDate;
    DateTime? rangeStartDate1 = DateTime.now();
    DateTime? rangeEndDate1 = DateTime.now();
    DateTime? date1;
    DateTime? endDate1;
    DateRangePickerController _datecontroller = DateRangePickerController();

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
        child: dataGridCell.columnName == 'button'
            ? LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).push(MaterialPageRoute(
                        builder: (context) => ViewFile(),
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
            : (dataGridCell.columnName == 'ActualStart')
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
                                        final List<PickerDateRange>
                                            selectedRanges = args.value;
                                      }
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                    showActionButtons: true,
                                    onSubmit: ((value) {
                                      date = DateTime.parse(
                                          rangeStartDate.toString());

                                      endDate = DateTime.parse(
                                          rangeEndDate.toString());

                                      Duration diff =
                                          endDate!.difference(date!);

                                      print('Difference' +
                                          diff.inDays.toString());

                                      final int dataRowIndex =
                                          dataGridRows.indexOf(row);
                                      if (dataRowIndex != null) {
                                        _employees[dataRowIndex]
                                                .actualstartDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(date!);

                                        dataGridRows[dataRowIndex] =
                                            DataGridRow(cells: [
                                          DataGridCell(
                                              value:
                                                  _employees[dataRowIndex].srNo,
                                              columnName: 'srNo'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .activity,
                                              columnName: 'Activity'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex],
                                              columnName: 'button'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .originalDuration,
                                              columnName: 'OriginalDuration'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .startDate,
                                              columnName: 'StartDate'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .endDate,
                                              columnName: 'EndDate'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .actualstartDate,
                                              columnName: 'ActualStart'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .actualendDate,
                                              columnName: 'ActualEnd'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .actualDuration,
                                              columnName: 'ActualDuration'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .delay,
                                              columnName: 'Delay'),
                                          DataGridCell(
                                              value:
                                                  _employees[dataRowIndex].unit,
                                              columnName: 'Unit'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .scope,
                                              columnName: 'QtyScope'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .qtyExecuted,
                                              columnName: 'QtyExecuted'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .balanceQty,
                                              columnName: 'BalancedQty'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .percProgress,
                                              columnName: 'Progress'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .weightage,
                                              columnName: 'Weightage'),
                                        ]);

                                        updateDataGrid(
                                            rowColumnIndex: RowColumnIndex(
                                                dataRowIndex, 6));

                                        print('state$date');
                                        print('valuedata$value');

                                        print('start $rangeStartDate');
                                        print('End $rangeEndDate');
                                        // date = rangeStartDate;
                                        print('object$date');

                                        Navigator.pop(context);
                                      }
                                      if (dataRowIndex != null) {
                                        _employees[dataRowIndex].actualendDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(endDate!);

                                        dataGridRows[dataRowIndex] =
                                            DataGridRow(cells: [
                                          DataGridCell(
                                              value:
                                                  _employees[dataRowIndex].srNo,
                                              columnName: 'srNo'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .activity,
                                              columnName: 'Activity'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex],
                                              columnName: 'button'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .originalDuration,
                                              columnName: 'OriginalDuration'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .startDate,
                                              columnName: 'StartDate'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .endDate,
                                              columnName: 'EndDate'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .actualstartDate,
                                              columnName: 'ActualStart'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .actualendDate,
                                              columnName: 'ActualEnd'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .actualDuration,
                                              columnName: 'ActualDuration'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .delay,
                                              columnName: 'Delay'),
                                          DataGridCell(
                                              value:
                                                  _employees[dataRowIndex].unit,
                                              columnName: 'Unit'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .scope,
                                              columnName: 'QtyScope'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .qtyExecuted,
                                              columnName: 'QtyExecuted'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .balanceQty,
                                              columnName: 'BalancedQty'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .percProgress,
                                              columnName: 'Progress'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .weightage,
                                              columnName: 'Weightage'),
                                        ]);

                                        updateDataGrid(
                                            rowColumnIndex: RowColumnIndex(
                                                dataRowIndex, 7));
                                      }
                                      if (dataRowIndex != null) {
                                        _employees[dataRowIndex]
                                                .actualDuration =
                                            int.parse(diff.inDays.toString());

                                        dataGridRows[dataRowIndex] =
                                            DataGridRow(cells: [
                                          DataGridCell(
                                              value:
                                                  _employees[dataRowIndex].srNo,
                                              columnName: 'srNo'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .activity,
                                              columnName: 'Activity'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex],
                                              columnName: 'button'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .originalDuration,
                                              columnName: 'OriginalDuration'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .startDate,
                                              columnName: 'StartDate'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .endDate,
                                              columnName: 'EndDate'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .actualstartDate,
                                              columnName: 'ActualStart'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .actualendDate,
                                              columnName: 'ActualEnd'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .actualDuration,
                                              columnName: 'ActualDuration'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .delay,
                                              columnName: 'Delay'),
                                          DataGridCell(
                                              value:
                                                  _employees[dataRowIndex].unit,
                                              columnName: 'Unit'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .scope,
                                              columnName: 'QtyScope'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .qtyExecuted,
                                              columnName: 'QtyExecuted'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .balanceQty,
                                              columnName: 'BalancedQty'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .percProgress,
                                              columnName: 'Progress'),
                                          DataGridCell(
                                              value: _employees[dataRowIndex]
                                                  .weightage,
                                              columnName: 'Weightage'),
                                        ]);

                                        updateDataGrid(
                                            rowColumnIndex: RowColumnIndex(
                                                dataRowIndex, 8));
                                      }
                                    }),
                                    onCancel: () {
                                      _controller.selectedRanges = null;
                                    },
                                  ),
                                )),
                          );
                        },
                        icon: const Icon(Icons.calendar_today),
                      ),
                      Text(dataGridCell.value.toString()),
                    ],
                  )
                : (dataGridCell.columnName == 'StartDate'
                    // ||
                    // dataGridCell.columnName == 'EndDate' ||
                    //    dataGridCell.columnName == 'ActualStart'
                    // ||
                    // dataGridCell.columnName == 'ActualEnd'
                    )
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
                                        controller : _datecontroller,
                                        onSelectionChanged:
                                            (DateRangePickerSelectionChangedArgs
                                                args) {
                                          if (args.value is PickerDateRange) {
                                            rangeStartDate1 =
                                                args.value.startDate;
                                            rangeEndDate1 = args.value.endDate;
                                          } else {
                                            final List<PickerDateRange>
                                                selectedRanges = args.value;
                                          }
                                        },
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                        showActionButtons: true,
                                        onSubmit: ((value) {
                                          date1 = DateTime.parse(
                                              rangeStartDate1.toString());

                                          endDate1 = DateTime.parse(
                                              rangeEndDate1.toString());

                                          Duration diff1 =
                                              endDate1!.difference(date1!);

                                          final int dataRowIndex =
                                              dataGridRows.indexOf(row);

                                          if (dataRowIndex != null) {
                                            _employees[dataRowIndex].startDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(date1!);

                                            dataGridRows[dataRowIndex] =
                                                DataGridRow(cells: [
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .srNo,
                                                  columnName: 'srNo'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .activity,
                                                  columnName: 'Activity'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex],
                                                  columnName: 'button'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .originalDuration,
                                                  columnName:
                                                      'OriginalDuration'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .startDate,
                                                  columnName: 'StartDate'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .endDate,
                                                  columnName: 'EndDate'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .actualstartDate,
                                                  columnName: 'ActualStart'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .actualendDate,
                                                  columnName: 'ActualEnd'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .actualDuration,
                                                  columnName: 'ActualDuration'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .delay,
                                                  columnName: 'Delay'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .unit,
                                                  columnName: 'Unit'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .scope,
                                                  columnName: 'QtyScope'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .qtyExecuted,
                                                  columnName: 'QtyExecuted'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .balanceQty,
                                                  columnName: 'BalancedQty'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .percProgress,
                                                  columnName: 'Progress'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .weightage,
                                                  columnName: 'Weightage'),
                                            ]);

                                            updateDataGrid(
                                                rowColumnIndex: RowColumnIndex(
                                                    dataRowIndex, 4));

                                            print('state$date');
                                            print('valuedata$value');

                                            print('start $rangeStartDate');
                                            print('End $rangeEndDate');
                                            // date = rangeStartDate;
                                            print('object$date');

                                            Navigator.pop(context);
                                          }
                                          if (dataRowIndex != null) {
                                            _employees[dataRowIndex].endDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(endDate1!);

                                            dataGridRows[dataRowIndex] =
                                                DataGridRow(cells: [
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .srNo,
                                                  columnName: 'srNo'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .activity,
                                                  columnName: 'Activity'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex],
                                                  columnName: 'button'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .originalDuration,
                                                  columnName:
                                                      'OriginalDuration'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .startDate,
                                                  columnName: 'StartDate'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .endDate,
                                                  columnName: 'EndDate'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .actualstartDate,
                                                  columnName: 'ActualStart'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .actualendDate,
                                                  columnName: 'ActualEnd'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .actualDuration,
                                                  columnName: 'ActualDuration'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .delay,
                                                  columnName: 'Delay'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .unit,
                                                  columnName: 'Unit'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .scope,
                                                  columnName: 'QtyScope'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .qtyExecuted,
                                                  columnName: 'QtyExecuted'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .balanceQty,
                                                  columnName: 'BalancedQty'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .percProgress,
                                                  columnName: 'Progress'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .weightage,
                                                  columnName: 'Weightage'),
                                            ]);

                                            updateDataGrid(
                                                rowColumnIndex: RowColumnIndex(
                                                    dataRowIndex, 5));
                                          }
                                          if (dataRowIndex != null) {
                                            _employees[dataRowIndex]
                                                    .originalDuration =
                                                int.parse(
                                                    diff1.inDays.toString());

                                            dataGridRows[dataRowIndex] =
                                                DataGridRow(cells: [
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .srNo,
                                                  columnName: 'srNo'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .activity,
                                                  columnName: 'Activity'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex],
                                                  columnName: 'button'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .originalDuration,
                                                  columnName:
                                                      'OriginalDuration'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .startDate,
                                                  columnName: 'StartDate'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .endDate,
                                                  columnName: 'EndDate'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .actualstartDate,
                                                  columnName: 'ActualStart'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .actualendDate,
                                                  columnName: 'ActualEnd'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .actualDuration,
                                                  columnName: 'ActualDuration'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .delay,
                                                  columnName: 'Delay'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .unit,
                                                  columnName: 'Unit'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .scope,
                                                  columnName: 'QtyScope'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .qtyExecuted,
                                                  columnName: 'QtyExecuted'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .balanceQty,
                                                  columnName: 'BalancedQty'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .percProgress,
                                                  columnName: 'Progress'),
                                              DataGridCell(
                                                  value:
                                                      _employees[dataRowIndex]
                                                          .weightage,
                                                  columnName: 'Weightage'),
                                            ]);

                                            updateDataGrid(
                                                rowColumnIndex: RowColumnIndex(
                                                    dataRowIndex, 3));
                                          }
                                        }),
                                        onCancel: () {
                                          _controller.selectedRanges = null;
                                        },
                                      ),
                                    )),
                              );
                            },
                            icon: const Icon(Icons.calendar_today),
                          ),
                          Text(dataGridCell.value.toString()),
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
    if (column.columnName == 'srNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'srNo', value: newCellValue);
      _employees[dataRowIndex].srNo = newCellValue;
    } else if (column.columnName == 'Activity') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Activity', value: newCellValue);
      _employees[dataRowIndex].activity = newCellValue.toString();
    } else if (column.columnName == 'OriginalDuration') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(
              columnName: 'OriginalDuration', value: newCellValue as int);
      _employees[dataRowIndex].originalDuration = newCellValue;
    } else if (column.columnName == 'StartDate') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'StartDate', value: newCellValue);
      _employees[dataRowIndex].startDate = newCellValue;
    } else if (column.columnName == 'EndDate') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'EndDate', value: newCellValue);
      _employees[dataRowIndex].endDate = newCellValue;
    } else if (column.columnName == 'ActualStart') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'ActualStart', value: newCellValue);
      _employees[dataRowIndex].actualstartDate = newCellValue;
    } else if (column.columnName == 'ActualEnd') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'ActualEnd', value: newCellValue);
      _employees[dataRowIndex].actualendDate = newCellValue;
    } else if (column.columnName == 'ActualDuration') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(
              columnName: 'ActualDuration', value: newCellValue as int);
      _employees[dataRowIndex].actualDuration = newCellValue;
    } else if (column.columnName == 'Delay') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'Delay', value: newCellValue as int);
      _employees[dataRowIndex].delay = newCellValue;
    } else if (column.columnName == 'Unit') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'Unit', value: newCellValue as int);
      _employees[dataRowIndex].unit = newCellValue;
    } else if (column.columnName == 'QtyScope') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'QtyScope', value: newCellValue as int);
      _employees[dataRowIndex].scope = newCellValue;
    } else if (column.columnName == 'QtyExecuted') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(
              columnName: 'QtyExecuted', value: newCellValue as int);
      _employees[dataRowIndex].qtyExecuted = newCellValue;
    } else if (column.columnName == 'BalancedQty') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(
              columnName: 'BalancedQty', value: newCellValue as int);
      _employees[dataRowIndex].balanceQty = newCellValue;
    } else if (column.columnName == 'Progress') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'Progress', value: newCellValue as int);
      _employees[dataRowIndex].percProgress = newCellValue;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'Weightage', value: newCellValue);
      _employees[dataRowIndex].weightage = newCellValue;
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

    final bool isNumericType = column.columnName == 'OriginalDuration' ||
        column.columnName == 'srNo' ||
        // column.columnName == 'EndDate' ||
        // column.columnName == 'ActualStart' ||
        // column.columnName == 'ActualEnd' ||
        column.columnName == 'ActualDuration' ||
        column.columnName == 'Delay' ||
        column.columnName == 'Unit' ||
        column.columnName == 'QtyScope' ||
        column.columnName == 'QtyExecuted' ||
        column.columnName == 'BalancedQty' ||
        column.columnName == 'Progress' ||
        column.columnName == 'Weightage';

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
            : RegExp('[a-zA-Z ]');
  }
}
