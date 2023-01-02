import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/KeyEvents/model/employee.dart';

import '../model/employee_statutory.dart';
import '../viewFIle.dart';

class EmployeeDataStatutory extends DataGridSource {
  EmployeeDataStatutory(this._employees) {
    dataGridRows = _employees
        .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
        .toList();
  }

  @override
  List<EmployeeStatutory> _employees = [];

  List<DataGridRow> dataGridRows = [];

  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
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
           
           : Text(
                dataGridCell.value.toString(),
              ),
      );
    }).toList());
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
      _employees[dataRowIndex].srNo = newCellValue as int;
    } else if (column.columnName == 'Approval') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Approval', value: newCellValue);
      _employees[dataRowIndex].approval = newCellValue.toString();
    } else if (column.columnName == 'Weightage') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(
              columnName: 'Weightage', value: newCellValue as int);
      _employees[dataRowIndex].weightage = newCellValue;
    } else if (column.columnName == 'Applicability') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: 'Applicability', value: newCellValue);
      _employees[dataRowIndex].applicability = newCellValue;
    } else if (column.columnName == 'ApprovingAuthority') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: 'ApprovingAuthority', value: newCellValue);
      _employees[dataRowIndex].approvingAuthority = newCellValue;
    } else if (column.columnName == 'CurrentStatusPerc') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(
              columnName: 'CurrentStatusPerc', value: newCellValue);
      _employees[dataRowIndex].currentStatusPerc = newCellValue;
    } else if (column.columnName == 'OverallWeightage') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(
              columnName: 'OverallWeightage', value: newCellValue);
      _employees[dataRowIndex].overallWeightage = newCellValue;
    } else if (column.columnName == 'CurrentStatus') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: 'CurrentStatus', value: newCellValue);
      _employees[dataRowIndex].overallWeightage = newCellValue;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'ListDocument', value: newCellValue);
      _employees[dataRowIndex].listDocument = newCellValue;
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

    final bool isNumericType = column.columnName == 'Weightage' ||
        // column.columnName == 'StartDate' ||
        // column.columnName == 'EndDate' ||
        // column.columnName == 'ActualStart' ||
        column.columnName == 'OverallWeightage' ||
        column.columnName == 'CurrentStatusPerc';

    // column.columnName == 'Unit' ||
    // column.columnName == 'QtyScope' ||
    // column.columnName == 'QtyExecuted' ||
    // column.columnName == 'BalancedQty' ||
    // column.columnName == 'Progress' ||
    // column.columnName == 'Weightage';

    // final bool isDateTimeType = column.columnName == 'StartDate' ||
    //     column.columnName == 'EndDate' ||
    //     column.columnName == 'ActualStart' ||
    //     column.columnName == 'ActualEnd';
    // Holds regular expression pattern based on the column type.
    final RegExp regExp = _getRegExp(isNumericType, column.columnName);

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
            // : isDateTimeType
            //     ? TextInputType.datetime
            : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);
            }
            //  else if (isDateTimeType) {
            //   newCellValue = value;
            // }
            else {
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

  RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
    return isNumericKeyBoard
        ? RegExp('[0-9]')
        // : isDateTimeBoard
        //     ? RegExp('[0-9/]')
        : RegExp('[a-zA-Z ]');
  }
}
