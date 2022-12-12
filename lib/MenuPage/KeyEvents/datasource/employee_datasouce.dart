import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/KeyEvents/model/employee.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(this._employees) {
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
        child: Text(
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
    } else if (column.columnName == 'Activity') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'Activity', value: newCellValue);
      _employees[dataRowIndex].activity = newCellValue.toString();
    } else if (column.columnName == 'OriginalDuration') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(
              columnName: 'OriginalDuration', value: newCellValue as int);
      _employees[dataRowIndex].weightage = newCellValue;
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
          DataGridCell<int>(
              columnName: 'Weightage', value: newCellValue as int);
      _employees[dataRowIndex].weightage = newCellValue;
    }
    Future storeData() async {
      await FirebaseFirestore.instance.collection('A1').add({
        'Weightage':
            dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
                DataGridCell<int>(
                    columnName: 'Weightage', value: newCellValue as int),
      });
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

    final bool isNumericType = column.columnName == 'OriginalDuration' ||
        // column.columnName == 'StartDate' ||
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
