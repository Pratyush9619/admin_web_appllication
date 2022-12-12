import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/KeyEvents/datasource/employee_datasouce.dart';
import 'package:web_appllication/MenuPage/KeyEvents/model/employee.dart';
import 'package:web_appllication/style.dart';

void main() {
  runApp(StatutoryAprovalA8());
}

/// The application that contains datagrid on it.

/// The home page of the application which hosts the datagrid.
class StatutoryAprovalA8 extends StatefulWidget {
  /// Creates the home page.
  String? depoName;
  StatutoryAprovalA8({Key? key, this.depoName}) : super(key: key);

  @override
  _StatutoryAprovalA8State createState() => _StatutoryAprovalA8State();
}

class _StatutoryAprovalA8State extends State<StatutoryAprovalA8> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];
  late DataGridController _dataGridController;
  //  List<DataGridRow> dataGridRows = [];
  DataGridRow? dataGridRow;
  RowColumnIndex? rowColumnIndex;
  GridColumn? column;

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
    _dataGridController = DataGridController();
  }

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('A1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Key Events / ' + widget.depoName! + ' /A8'),
        backgroundColor: blue,
      ),
      body: Column(
        children: [
          Flexible(
            child: SfDataGrid(
              source: _employeeDataSource,
              allowEditing: true,
              frozenColumnsCount: 2,
              gridLinesVisibility: GridLinesVisibility.both,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              columnWidthMode: ColumnWidthMode.auto,
              controller: _dataGridController,
              // onQueryRowHeight: (details) {
              //   return details.rowIndex == 0 ? 60.0 : 49.0;
              // },
              columns: [
                GridColumn(
                  columnName: 'srNo',
                  autoFitPadding: EdgeInsets.symmetric(horizontal: 16),
                  allowEditing: false,
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Sr No',
                      overflow: TextOverflow.values.first,
                      //    textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Activity',
                  allowEditing: true,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Activity',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'OriginalDuration',
                  allowEditing: true,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Original Duration',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'StartDate',
                  allowEditing: true,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Start Date',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'EndDate',
                  allowEditing: true,
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'End Date',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'ActualStart',
                  allowEditing: true,
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Actual Start',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'ActualEnd',
                  allowEditing: true,
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Actual End',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'ActualDuration',
                  allowEditing: true,
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Actual Duration',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Delay',
                  allowEditing: true,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Delay',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Unit',
                  allowEditing: true,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Unit',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'QtyScope',
                  allowEditing: true,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Oty as per scope',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'QtyExecuted',
                  allowEditing: true,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Qty executed',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'BalancedQty',
                  allowEditing: true,
                  label: Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Balanced Qty',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Progress',
                  allowEditing: true,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      '% of Progress',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Weightage',
                  allowEditing: true,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Weightage',
                      overflow: TextOverflow.values.first,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () async {
                  // print(
                  //     'munib${DataGridCell<int>(columnName: 'srNo', value: _employeeDataSource.newCellValue)}');

                  // collectionReference
                  //     .doc()
                  //     .set({'Wightage': _employeeDataSource.newCellValue});
                },
                child: const Text('Upload Data')),
          )
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
          srNo: 1,
          activity: 'Concrete breaking ',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 2,
          activity: 'Manual Excavation',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 3,
          activity: 'Soling',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 4,
          activity: 'PCC & Curing',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 5,
          activity: 'Reinforcement tying of Raft (charger Foundation)',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 6,
          activity: 'Shuttering of Raft (charger Foundation)',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 7,
          activity: 'Concreting of Raft (charger Foundation) and Curing',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 8,
          activity: 'Reinforcement tying of pedestal (PSS)',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 9,
          activity: 'Shuttering of pedestal (PSS Foundation) ',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 10,
          activity: 'Concreting of pedestal (PSS Foundation) ',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 11,
          activity: 'Reinforcement tying of Raft (shed)',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 12,
          activity: 'Shuttering of Raft (shed)',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 13,
          activity: 'Concreting of Raft (shed) and Curing',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 14,
          activity: 'Backfilling',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 15,
          activity: 'Erection of shed structure',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 16,
          activity: 'Roof sheeting',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 17,
          activity: 'Concreting around excavated area',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 18,
          activity: 'Thermoplastic paint',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 19,
          activity: 'Crash barrier ',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 20,
          activity: '5S activity',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 21,
          activity: 'Cable Trenching (for burried cable)',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 22,
          activity: 'Compressor foundation and room',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 23,
          activity: 'DTB Room',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 24,
          activity: 'Road leveling and resurfacing',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
      Employee(
          srNo: 25,
          activity: 'Painiting ',
          originalDuration: 1,
          startDate: DateFormat().add_yMd().format(DateTime.now()),
          endDate: DateFormat().add_yMd().format(DateTime.now()),
          actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
          actualendDate: DateFormat().add_yMd().format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.5),
    ];
  }
}
