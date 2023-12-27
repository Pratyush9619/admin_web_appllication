import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../model/employee.dart';
import '../style.dart';

class KeyDataSourceKeyEvents extends DataGridSource {
  BuildContext mainContext;

  KeyDataSourceKeyEvents(this._employees, this.mainContext) {
    buildDataGridRows();
  }
  void buildDataGridRows() {
    dataGridRows = _employees
        .map<DataGridRow>((dataGridRow) => dataGridRow.getKeyDataGridRow())
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
    DateTime date;
    DateTime endDate;
    DateTime? getStartDate;
    DateTime? getActualStartDate;
    DateTime? getActualEnddate;
    DateTime? getEndDate;
    Duration? calculateDelay;
    Duration? originalDuration;
    Duration? actualDuration;
    int? balnceQtyValue;
    double? perc;
    dynamic totalperc;
    List<int> indicesToSkip = [0, 2, 6, 13, 18, 28, 32, 38, 64, 76];
    //[0, 2, 8, 12, 16, 27, 33, 39, 65, 76];

    final int dataIndex = dataGridRows.indexOf(row);
    if (dataIndex != null) {
      balnceQtyValue = _employees[dataIndex].balanceQty;
      _employees[dataIndex].balanceQty =
          _employees[dataIndex].scope - _employees[dataIndex].qtyExecuted;

      perc =
          ((_employees[dataIndex].qtyExecuted / _employees[dataIndex].scope) *
              _employees[dataIndex].weightage);
      totalperc =
          _employees[dataIndex].qtyExecuted / _employees[dataIndex].scope * 100;
      getStartDate = DateFormat("dd-MM-yyyy")
          .parse(_employees[dataIndex].startDate.toString());
      getActualStartDate = DateFormat("dd-MM-yyyy")
          .parse(_employees[dataIndex].actualstartDate.toString());

      getActualEnddate = DateFormat("dd-MM-yyyy")
          .parse(_employees[dataIndex].actualendDate.toString());
      getEndDate = DateFormat("dd-MM-yyyy")
          .parse(_employees[dataIndex].endDate.toString());
      calculateDelay = getActualEnddate.difference(getEndDate);
      print(calculateDelay.inDays);
      originalDuration =
          getEndDate.add(Duration(days: 1)).difference(getStartDate);
      actualDuration = getActualEnddate
          .add(const Duration(days: 1))
          .difference(getActualStartDate);
    }
    return DataGridRowAdapter(
        color: white,
        cells: row.getCells().map<Widget>((dataGridCell) {
          Color? columnbackgroundcolor;

          if (dataGridCell.columnName == 'Activity' &&
                  dataGridCell.value == 'TML contract Award' ||
              dataGridCell.value ==
                  'Site Survey, Job scope finalization and Proposed layout submission' ||
              dataGridCell.value ==
                  'Detailed Engineering for Approval of Civil & Electrical Layout, GA Drawing from TML' ||
              dataGridCell.value ==
                  'Initial Approval of statutory clearances for EV Bus Depot' ||
              dataGridCell.value == 'Tender & L1 Vendor Finalisation' ||
              dataGridCell.value == 'Resource Mobalization activity' ||
              dataGridCell.value == 'Receipt of all Materials at Site' ||
              dataGridCell.value ==
                  'Civil Active Infra Development completed at Bus Depot' ||
              dataGridCell.value ==
                  'Electrical Infra Development completed at Bus Depot' ||
              dataGridCell.value == 'Bus Depot Active Infra work Completed') {
            columnbackgroundcolor = blue;
          }
          if (indicesToSkip.contains(dataIndex)) {
            columnbackgroundcolor = blue;
          }

          return Container(
              alignment: (dataGridCell.columnName == 'srNo' ||
                      dataGridCell.columnName == 'Activity' ||
                      dataGridCell.columnName == 'OriginalDuration' ||
                      dataGridCell.columnName == 'StartDate' ||
                      dataGridCell.columnName == 'EndDate' ||
                      dataGridCell.columnName == 'ActualStart' ||
                      dataGridCell.columnName == 'ActualEnd' ||
                      dataGridCell.columnName == 'ActualDuration' ||
                      dataGridCell.columnName == 'Delay' ||
                      dataGridCell.columnName == 'Dependency' ||
                      // dataGridCell.columnName == 'QtyScope' ||
                      // dataGridCell.columnName == 'QtyExecuted' ||
                      // dataGridCell.columnName == 'BalancedQty' ||
                      dataGridCell.columnName == 'Progress' ||
                      dataGridCell.columnName == 'Weightage')
                  ? Alignment.center
                  : Alignment.center,
              color: columnbackgroundcolor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: dataGridCell.columnName == 'Activity' &&
                          dataGridCell.value == 'TML contract Award' ||
                      dataGridCell.value ==
                          'Site Survey, Job scope finalization and Proposed layout submission' ||
                      dataGridCell.value ==
                          'Detailed Engineering for Approval of Civil & Electrical Layout, GA Drawing from TML' ||
                      dataGridCell.value ==
                          'Initial Approval of statutory clearances for EV Bus Depot' ||
                      dataGridCell.value == 'Tender & L1 Vendor Finalisation' ||
                      dataGridCell.value == 'Resource Mobalization activity' ||
                      dataGridCell.value ==
                          'Receipt of all Materials at Site' ||
                      dataGridCell.value ==
                          'Civil Active Infra Development completed at Bus Depot' ||
                      dataGridCell.value ==
                          'Electrical Infra Development completed at Bus Depot' ||
                      dataGridCell.value ==
                          'Bus Depot Active Infra work Completed'
                  ? Text(
                      textAlign: TextAlign.center,
                      dataGridCell.value.toString(),
                      style: TextStyle(color: white, fontSize: 12),
                    )
                  : dataGridCell.columnName == 'Activity'
                      ? Text(
                          textAlign: TextAlign.center,
                          dataGridCell.value.toString(),
                          style: const TextStyle(fontSize: 12),
                          // style: TextStyle(color: white),
                        )
                      // (dataGridCell.columnName == 'ActualStart' ||
                      //         dataGridCell.columnName == 'ActualEnd')
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
                      //                             (DateRangePickerSelectionChangedArgs args) {
                      //                           if (args.value is PickerDateRange) {
                      //                             rangeStartDate = args.value.startDate;
                      //                             rangeEndDate = args.value.endDate;
                      //                           } else {
                      //                             final List<PickerDateRange> selectedRanges =
                      //                                 args.value;
                      //                           }
                      //                         },
                      //                         selectionMode:
                      //                             DateRangePickerSelectionMode.range,
                      //                         showActionButtons: true,
                      //                         onSubmit: ((value) {
                      //                           date =
                      //                               DateTime.parse(rangeStartDate.toString());

                      //                           endDate =
                      //                               DateTime.parse(rangeEndDate.toString());
                      //                           rangeEndDate;
                      //                           DataGridRow? dataGridRow;

                      //                           RowColumnIndex rowColumnIndex;

                      //                           Duration diff = endDate.difference(date);

                      //                           print('Difference' + diff.inDays.toString());
                      //                           final int dataRowIndex =
                      //                               dataGridRows.indexOf(row);

                      //                           if (dataRowIndex != null) {
                      //                             _employees[dataRowIndex].actualstartDate =
                      //                                 DateFormat('dd-MM-yyyy').format(date);

                      //                             dataGridRows[dataRowIndex] =
                      //                                 DataGridRow(cells: [
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].srNo,
                      //                                   columnName: 'srNo'),
                      //                               DataGridCell(
                      //                                   value:
                      //                                       _employees[dataRowIndex].activity,
                      //                                   columnName: 'Activity'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex],
                      //                                   columnName: 'button'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .originalDuration,
                      //                                   columnName: 'OriginalDuration'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .startDate,
                      //                                   columnName: 'StartDate'),
                      //                               DataGridCell(
                      //                                   value:
                      //                                       _employees[dataRowIndex].endDate,
                      //                                   columnName: 'EndDate'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .actualstartDate,
                      //                                   columnName: 'ActualStart'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .actualendDate,
                      //                                   columnName: 'ActualEnd'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .actualDuration,
                      //                                   columnName: 'ActualDuration'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].delay,
                      //                                   columnName: 'Delay'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].unit,
                      //                                   columnName: 'Unit'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].scope,
                      //                                   columnName: 'QtyScope'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .qtyExecuted,
                      //                                   columnName: 'QtyExecuted'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .balanceQty,
                      //                                   columnName: 'BalancedQty'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .percProgress,
                      //                                   columnName: 'Progress'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .weightage,
                      //                                   columnName: 'Weightage'),
                      //                             ]);

                      //                             updateDataGrid(
                      //                                 rowColumnIndex:
                      //                                     RowColumnIndex(dataRowIndex, 6));

                      //                              nt('state$date');
                      //                             print('valuedata$value');

                      //                             print('start $rangeStartDate');
                      //                             print('End $rangeEndDate');
                      //                             // date = rangeStartDate;
                      //                             print('object$date');

                      //                             Navigator.pop(context);
                      //                           }
                      //                           if (dataRowIndex != null) {
                      //                             _employees[dataRowIndex].actualendDate =
                      //                                 DateFormat('dd-MM-yyyy')
                      //                                     .format(endDate);

                      //                             dataGridRows[dataRowIndex] =
                      //                                 DataGridRow(cells: [
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].srNo,
                      //                                   columnName: 'srNo'),
                      //                               DataGridCell(
                      //                                   value:
                      //                                       _employees[dataRowIndex].activity,
                      //                                   columnName: 'Activity'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex],
                      //                                   columnName: 'button'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .originalDuration,
                      //                                   columnName: 'OriginalDuration'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .startDate,
                      //                                   columnName: 'StartDate'),
                      //                               DataGridCell(
                      //                                   value:
                      //                                       _employees[dataRowIndex].endDate,
                      //                                   columnName: 'EndDate'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .actualstartDate,
                      //                                   columnName: 'ActualStart'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .actualendDate,
                      //                                   columnName: 'ActualEnd'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .actualDuration,
                      //                                   columnName: 'ActualDuration'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].delay,
                      //                                   columnName: 'Delay'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].unit,
                      //                                   columnName: 'Unit'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].scope,
                      //                                   columnName: 'QtyScope'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .qtyExecuted,
                      //                                   columnName: 'QtyExecuted'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .balanceQty,
                      //                                   columnName: 'BalancedQty'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .percProgress,
                      //                                   columnName: 'Progress'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .weightage,
                      //                                   columnName: 'Weightage'),
                      //                             ]);

                      //                             updateDataGrid(
                      //                                 rowColumnIndex:
                      //                                     RowColumnIndex(dataRowIndex, 7));
                      //                           }
                      //                           if (dataRowIndex != null) {
                      //                             _employees[dataRowIndex].actualDuration =
                      //                                 int.parse(diff.toString());

                      //                             dataGridRows[dataRowIndex] =
                      //                                 DataGridRow(cells: [
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].srNo,
                      //                                   columnName: 'srNo'),
                      //                               DataGridCell(
                      //                                   value:
                      //                                       _employees[dataRowIndex].activity,
                      //                                   columnName: 'Activity'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex],
                      //                                   columnName: 'button'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .originalDuration,
                      //                                   columnName: 'OriginalDuration'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .startDate,
                      //                                   columnName: 'StartDate'),
                      //                               DataGridCell(
                      //                                   value:
                      //                                       _employees[dataRowIndex].endDate,
                      //                                   columnName: 'EndDate'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .actualstartDate,
                      //                                   columnName: 'ActualStart'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .actualendDate,
                      //                                   columnName: 'ActualEnd'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .actualDuration,
                      //                                   columnName: 'ActualDuration'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].delay,
                      //                                   columnName: 'Delay'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].unit,
                      //                                   columnName: 'Unit'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex].scope,
                      //                                   columnName: 'QtyScope'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .qtyExecuted,
                      //                                   columnName: 'QtyExecuted'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .balanceQty,
                      //                                   columnName: 'BalancedQty'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .percProgress,
                      //                                   columnName: 'Progress'),
                      //                               DataGridCell(
                      //                                   value: _employees[dataRowIndex]
                      //                                       .weightage,
                      //                                   columnName: 'Weightage'),
                      //                             ]);

                      //                             updateDataGrid(
                      //                                 rowColumnIndex:
                      //                                     RowColumnIndex(dataRowIndex, 8));
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
                      : dataGridCell.columnName == 'ActualDuration'
                          ? Text(
                              actualDuration!.inDays.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: indicesToSkip.contains(dataIndex)
                                      ? white
                                      : black),
                            )
                          : dataGridCell.columnName == 'OriginalDuration'
                              ? Text(
                                  originalDuration!.inDays.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: indicesToSkip.contains(dataIndex)
                                          ? white
                                          : black),
                                )
                              : dataGridCell.columnName == 'Progress'
                                  ? Text(
                                      !indicesToSkip.contains(dataIndex)
                                          ? totalperc!.isNaN
                                              ? '0.0%'
                                              : '${totalperc.toStringAsFixed(2)}%'
                                          :
                                          // dataGridCell.value!.isNaN
                                          //     ? '0.0 %'
                                          '${dataGridCell.value.toStringAsFixed(2)}%',
                                      style: indicesToSkip.contains(dataIndex)
                                          ? TextStyle(
                                              fontSize: 12, color: white)
                                          : const TextStyle(
                                              fontSize: 12,
                                            ))
                                  : dataGridCell.columnName == 'QtyExecuted'
                                      ? Text(
                                          indicesToSkip.contains(dataIndex)
                                              ? ' '
                                              : dataGridCell.value.toString(),
                                          style:
                                              indicesToSkip.contains(dataIndex)
                                                  ? TextStyle(
                                                      fontSize: 12,
                                                      color: white)
                                                  : const TextStyle(
                                                      fontSize: 12,
                                                    ))
                                      : dataGridCell.columnName == 'QtyScope'
                                          ? Text(
                                              indicesToSkip.contains(dataIndex)
                                                  ? ' '
                                                  : dataGridCell.value
                                                      .toString(),
                                              style: indicesToSkip
                                                      .contains(dataIndex)
                                                  ? TextStyle(
                                                      fontSize: 12,
                                                      color: white)
                                                  : const TextStyle(
                                                      fontSize: 12,
                                                    ))
                                          : dataGridCell.columnName ==
                                                  'Weightage'
                                              ? Text(
                                                  '${dataGridCell.value.toStringAsFixed(2)}%',
                                                  style: indicesToSkip
                                                          .contains(dataIndex)
                                                      ? TextStyle(
                                                          fontSize: 12,
                                                          color: white)
                                                      : const TextStyle(
                                                          fontSize: 12,
                                                        ))
                                              : dataGridCell.columnName ==
                                                      'BalancedQty'
                                                  ? Text(
                                                      indicesToSkip.contains(dataIndex)
                                                          ? ' '
                                                          : '${balnceQtyValue}',
                                                      style: indicesToSkip.contains(dataIndex)
                                                          ? TextStyle(fontSize: 12, color: white)
                                                          : const TextStyle(
                                                              fontSize: 12,
                                                            ))
                                                  : dataGridCell.columnName == 'Delay'
                                                      ? Text(calculateDelay!.inDays.toString(), style: TextStyle(fontSize: 12, color: indicesToSkip.contains(dataIndex) ? white : black))
                                                      : (dataGridCell.columnName == 'StartDate' && (dataIndex != 0 && dataIndex != 2 && dataIndex != 6 && dataIndex != 13 && dataIndex != 18 && dataIndex != 28 && dataIndex != 32 && dataIndex != 38 && dataIndex != 64 && dataIndex != 76))
                                                          ? Row(
                                                              children: [
                                                                IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await showDialog(
                                                                      context:
                                                                          mainContext,
                                                                      builder: (context) => AlertDialog(
                                                                          title: const Text('All Date'),
                                                                          content: Container(
                                                                            height:
                                                                                400,
                                                                            width:
                                                                                500,
                                                                            child:
                                                                                SfDateRangePicker(
                                                                              view: DateRangePickerView.month,
                                                                              showTodayButton: true,
                                                                              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                                                                if (args.value is PickerDateRange) {
                                                                                  rangeStartDate = args.value.startDate;
                                                                                  rangeEndDate = args.value.endDate;
                                                                                }
                                                                                // else {
                                                                                //   final List<PickerDateRange>
                                                                                //       selectedRanges = args.value;
                                                                                // }
                                                                              },
                                                                              selectionMode: DateRangePickerSelectionMode.range,
                                                                              showActionButtons: true,
                                                                              onSubmit: ((value) {
                                                                                date = DateTime.parse(rangeStartDate.toString());

                                                                                endDate = DateTime.parse(rangeEndDate.toString());

                                                                                Duration diff = endDate.add(const Duration(days: 1)).difference(date);

                                                                                Duration calcDelay = endDate.difference(getEndDate!);
                                                                                print(endDate);
                                                                                print(getEndDate);

                                                                                print(calcDelay.inDays);
                                                                                final int dataRowIndex = dataGridRows.indexOf(row);
                                                                                if (dataRowIndex != null) {
                                                                                  _employees[dataRowIndex].startDate = DateFormat('dd-MM-yyyy').format(date);

                                                                                  // _employees[dataRowIndex]
                                                                                  //         .delay =
                                                                                  //     int.parse(diff
                                                                                  //         .inDays
                                                                                  //         .toString());

                                                                                  dataGridRows[dataRowIndex] = DataGridRow(cells: [
                                                                                    DataGridCell(value: _employees[dataRowIndex].srNo, columnName: 'srNo'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].activity, columnName: 'Activity'),
                                                                                    // DataGridCell(
                                                                                    //     value: _employees[
                                                                                    //         dataRowIndex],
                                                                                    //     columnName: 'viewbutton'),
                                                                                    // DataGridCell(
                                                                                    //     value: _employees[
                                                                                    //         dataRowIndex],
                                                                                    //     columnName: 'uploadbutton'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].originalDuration, columnName: 'OriginalDuration'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].startDate, columnName: 'StartDate'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].endDate, columnName: 'EndDate'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualstartDate, columnName: 'ActualStart'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualendDate, columnName: 'ActualEnd'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualDuration, columnName: 'ActualDuration'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].delay, columnName: 'Delay'),
                                                                                    // DataGridCell(
                                                                                    //     value:
                                                                                    //         _employees[dataRowIndex].reasonDelay,
                                                                                    //     columnName: 'ReasonDelay'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].unit, columnName: 'Unit'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].scope, columnName: 'QtyScope'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].qtyExecuted, columnName: 'QtyExecuted'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].balanceQty, columnName: 'BalancedQty'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].percProgress, columnName: 'Progress'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].weightage, columnName: 'Weightage'),
                                                                                  ]);

                                                                                  updateDataGrid(rowColumnIndex: RowColumnIndex(dataRowIndex, 3));
                                                                                  notifyListeners();
                                                                                }
                                                                                if (dataRowIndex != null) {
                                                                                  _employees[dataRowIndex].endDate = DateFormat('dd-MM-yyyy').format(endDate);

                                                                                  dataGridRows[dataRowIndex] = DataGridRow(cells: [
                                                                                    DataGridCell(value: _employees[dataRowIndex].srNo, columnName: 'srNo'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].activity, columnName: 'Activity'),
                                                                                    // DataGridCell(
                                                                                    //     value: _employees[
                                                                                    //         dataRowIndex],
                                                                                    //     columnName: 'viewbutton'),
                                                                                    // DataGridCell(
                                                                                    //     value: _employees[
                                                                                    //         dataRowIndex],
                                                                                    //     columnName: 'uploadbutton'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].originalDuration, columnName: 'OriginalDuration'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].startDate, columnName: 'StartDate'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].endDate, columnName: 'EndDate'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualstartDate, columnName: 'ActualStart'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualendDate, columnName: 'ActualEnd'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualDuration, columnName: 'ActualDuration'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].delay, columnName: 'Delay'),
                                                                                    // DataGridCell(
                                                                                    //     value:
                                                                                    //         _employees[dataRowIndex].reasonDelay,
                                                                                    //     columnName: 'ReasonDelay'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].unit, columnName: 'Unit'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].scope, columnName: 'QtyScope'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].qtyExecuted, columnName: 'QtyExecuted'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].balanceQty, columnName: 'BalancedQty'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].percProgress, columnName: 'Progress'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].weightage, columnName: 'Weightage'),
                                                                                  ]);
                                                                                  updateDataGrid(rowColumnIndex: RowColumnIndex(dataRowIndex, 4));

                                                                                  notifyListeners();
                                                                                }
                                                                                if (dataRowIndex != null) {
                                                                                  _employees[dataRowIndex].originalDuration = int.parse(diff.inDays.toString());

                                                                                  dataGridRows[dataRowIndex] = DataGridRow(cells: [
                                                                                    DataGridCell(value: _employees[dataRowIndex].srNo, columnName: 'srNo'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].activity, columnName: 'Activity'),
                                                                                    // DataGridCell(
                                                                                    //     value: _employees[
                                                                                    //         dataRowIndex],
                                                                                    //     columnName: 'viewbutton'),
                                                                                    // DataGridCell(
                                                                                    //     value: _employees[
                                                                                    //         dataRowIndex],
                                                                                    //     columnName: 'uploadbutton'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].originalDuration, columnName: 'OriginalDuration'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].startDate, columnName: 'StartDate'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].endDate, columnName: 'EndDate'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualstartDate, columnName: 'ActualStart'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualendDate, columnName: 'ActualEnd'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualDuration, columnName: 'ActualDuration'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].delay, columnName: 'Delay'),
                                                                                    // DataGridCell(
                                                                                    //     value:
                                                                                    //         _employees[dataRowIndex].reasonDelay,
                                                                                    //     columnName: 'ReasonDelay'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].unit, columnName: 'Unit'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].scope, columnName: 'QtyScope'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].qtyExecuted, columnName: 'QtyExecuted'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].balanceQty, columnName: 'BalancedQty'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].percProgress, columnName: 'Progress'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].weightage, columnName: 'Weightage'),
                                                                                  ]);

                                                                                  updateDataGrid(rowColumnIndex: RowColumnIndex(dataRowIndex, 2));

                                                                                  notifyListeners();
                                                                                  Navigator.pop(context);
                                                                                }
                                                                                if (dataRowIndex != null) {
                                                                                  _employees[dataRowIndex].delay = int.parse(calcDelay.inDays.toString());

                                                                                  dataGridRows[dataRowIndex] = DataGridRow(cells: [
                                                                                    DataGridCell(value: _employees[dataRowIndex].srNo, columnName: 'srNo'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].activity, columnName: 'Activity'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].originalDuration, columnName: 'OriginalDuration'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].startDate, columnName: 'StartDate'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].endDate, columnName: 'EndDate'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualstartDate, columnName: 'ActualStart'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualendDate, columnName: 'ActualEnd'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].actualDuration, columnName: 'ActualDuration'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].delay, columnName: 'Delay'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].unit, columnName: 'Unit'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].scope, columnName: 'QtyScope'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].qtyExecuted, columnName: 'QtyExecuted'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].balanceQty, columnName: 'BalancedQty'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].percProgress, columnName: 'Progress'),
                                                                                    DataGridCell(value: _employees[dataRowIndex].weightage, columnName: 'Weightage'),
                                                                                  ]);

                                                                                  updateDataGrid(rowColumnIndex: RowColumnIndex(dataRowIndex, 8));

                                                                                  notifyListeners();
                                                                                }
                                                                              }),
                                                                              onCancel: () {
                                                                                _controller.selectedRanges = null;
                                                                              },
                                                                            ),
                                                                          )),
                                                                    );
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .calendar_today,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                                Text(
                                                                    dataGridCell
                                                                        .value
                                                                        .toString(),
                                                                    style: indicesToSkip.contains(
                                                                            dataIndex)
                                                                        ? TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                white)
                                                                        : const TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                              ],
                                                            )
                                                          : Text(dataGridCell.value.toString(),
                                                              style: indicesToSkip.contains(dataIndex)
                                                                  ? TextStyle(fontSize: 12, color: white)
                                                                  : const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    )));
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
    }
    // else if (column.columnName == 'ReasonDelay') {
    //   dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<String>(columnName: 'ReasonDelay', value: newCellValue);
    //   _employees[dataRowIndex].reasonDelay = newCellValue;
    // }
    else if (column.columnName == 'Unit') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'Unit', value: newCellValue);
      _employees[dataRowIndex].unit = newCellValue;
    } else if (column.columnName == 'QtyScope') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'QtyScope', value: newCellValue);
      _employees[dataRowIndex].scope = newCellValue as dynamic;
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
          DataGridCell<dynamic>(columnName: 'Progress', value: newCellValue);
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

  bool onCellBeginEdit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    if (rowColumnIndex.rowIndex == 0 ||
            rowColumnIndex.rowIndex == 1 ||
            rowColumnIndex.rowIndex == 2 ||
            rowColumnIndex.rowIndex == 8 ||
            rowColumnIndex.rowIndex == 12 ||
            rowColumnIndex.rowIndex == 16 ||
            rowColumnIndex.rowIndex == 27 ||
            rowColumnIndex.rowIndex == 33 ||
            rowColumnIndex.rowIndex == 65 ||
            rowColumnIndex.rowIndex == 76
        // column.columnName
        //               dataGridCell.value == 'Letter of Award reveived  from TML' ||
        //           dataGridCell.value ==
        //               'Site Survey, Job scope finalization  and final layout preparation' ||
        //           dataGridCell.value ==
        //               'Detailed Engineering for Approval of  Civil & Electrical  Layout, GA Drawing from TML' ||
        //           dataGridCell.value == 'Site Mobalization activity Completed' ||
        //           dataGridCell.value ==
        //               'Approval of statutory clearances of BUS Depot' ||
        //           dataGridCell.value ==
        //               'Procurement of Order Finalisation Completed' ||
        //           dataGridCell.value == 'Receipt of all Materials at Site' ||
        //           dataGridCell.value ==
        //               'Civil Infra Development completed at Bus Depot' ||
        //           dataGridCell.value ==
        //               'Electrical Infra Development completed at Bus Depot' ||
        //           dataGridCell.value == 'Bus Depot work Completed'
        ) {
      // Return false, to restrict entering into the editing.
      return false;
    } else {
      return true;
    }
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
        // column.columnName == 'StartDate' ||
        // column.columnName == 'EndDate' ||
        // column.columnName == 'ActualStart' ||
        // column.columnName == 'ActualEnd' ||
        column.columnName == 'ActualDuration' ||
        column.columnName == 'Delay' ||
        // column.columnName == 'Unit' ||
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
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
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
