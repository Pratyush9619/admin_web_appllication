import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/KeyEvents/datasource/employee_datasouce.dart';
import 'package:web_appllication/MenuPage/KeyEvents/model/employee.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/style.dart';

void main() {
  runApp(StatutoryAprovalA6());
}

/// The application that contains datagrid on it.

/// The home page of the application which hosts the datagrid.
class StatutoryAprovalA6 extends StatefulWidget {
  /// Creates the home page.
  String? depoName;
  String? cityName;
  StatutoryAprovalA6({Key? key, this.depoName, this.cityName})
      : super(key: key);

  @override
  _StatutoryAprovalA6State createState() => _StatutoryAprovalA6State();
}

class _StatutoryAprovalA6State extends State<StatutoryAprovalA6> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];
  late DataGridController _dataGridController;
  //  List<DataGridRow> dataGridRows = [];
  DataGridRow? dataGridRow;
  RowColumnIndex? rowColumnIndex;
  GridColumn? column;
  List<dynamic> tabledata2 = [];
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      getFirestoreData().whenComplete(() {
        setState(() {
          if (_employees.length == 0 || _employees.isEmpty) {
            _employees = getEmployeeData();
          }
          _isLoading = false;
          _employeeDataSource = EmployeeDataSource(_employees);
          _dataGridController = DataGridController();
        });
        // _employeeDataSource = EmployeeDataSource(_employees);
        // _dataGridController = DataGridController();
      });
      //getFirestoreData() as List<Employee>;
      // getEmployeeData();

    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Key Events / ' + widget.depoName! + ' /A6'),
        backgroundColor: blue,
      ),
      body: _isLoading
          ? LoadingPage()
          : Column(
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
                        StoreData();
                      },
                      child: const Text('Sync Data')),
                )
              ],
            ),
    );
  }

  Future<void> getFirestoreData() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference tabledata = instance.collection('${widget.depoName}A6');

    DocumentSnapshot snapshot = await tabledata.doc(widget.depoName).get();
    var data = snapshot.data() as Map;
    var alldata = data['data'] as List<dynamic>;

    _employees = [];
    alldata.forEach((element) {
      _employees.add(Employee.fromJson(element));
    });
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
          srNo: 1,
          activity: 'PR/PO Generation for  PSS',
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
          activity: 'PR/PO Generation for Charger',
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
          activity: 'PR/PO Generation for SFU Panel',
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
          activity: 'PR/PO Generation for HT Cable',
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
          activity: 'PR/PO Generation for LT Cable',
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
          weightage: 0.5)
    ];
  }

  void StoreData() {
    Map<String, dynamic> table_data = Map();
    for (var i in _employeeDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        table_data[data.columnName] = data.value;
      }
      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection(widget.depoName.toString() + 'A6')
        .doc(widget.depoName)
        .set({'data': tabledata2}).whenComplete(() {
      tabledata2.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Data are synced'),
        backgroundColor: blue,
      ));
    });
  }
}
