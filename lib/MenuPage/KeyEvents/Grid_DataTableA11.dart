import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/KeyEvents/datasource/employee_statutory.dart';

import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/style.dart';

import 'model/employee_statutory.dart';

void main() {
  runApp(StatutoryAprovalA11());
}

/// The application that contains datagrid on it.

/// The home page of the application which hosts the datagrid.
class StatutoryAprovalA11 extends StatefulWidget {
  /// Creates the home page.
  String? depoName;
  String? cityName;
  StatutoryAprovalA11({Key? key, this.depoName, this.cityName})
      : super(key: key);

  @override
  _StatutoryAprovalA11State createState() => _StatutoryAprovalA11State();
}

class _StatutoryAprovalA11State extends State<StatutoryAprovalA11> {
  late EmployeeDataStatutory _employeeDataSource;
  List<EmployeeStatutory> _employees = <EmployeeStatutory>[];
  late DataGridController _dataGridController;
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
            _employees = getData();
          }
          _isLoading = false;
          _employeeDataSource = EmployeeDataStatutory(_employees);
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
        title: Text('Key Events / ' + widget.depoName! + ' /A11'),
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
                    editingGestureType: EditingGestureType.tap,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
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
                          alignment: Alignment.center,
                          child: Text('Sr No',
                              overflow: TextOverflow.values.first,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)
                              //    textAlign: TextAlign.center,
                              ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Approval',
                        allowEditing: true,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text('Detail of approval',
                              overflow: TextOverflow.values.first,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'button',
                        width: 130,
                        allowEditing: false,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('View File',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Weightage',
                        allowEditing: true,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text('Weightage',
                              overflow: TextOverflow.values.first,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Applicability',
                        allowEditing: true,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text('Applicability',
                              overflow: TextOverflow.values.first,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'ApprovingAuthority',
                        allowEditing: true,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text('ApprovingAuthority',
                              overflow: TextOverflow.values.first,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'CurrentStatusPerc',
                        allowEditing: true,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text('Current status in % for Approval ',
                              overflow: TextOverflow.values.first,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'OverallWeightage',
                        allowEditing: true,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text('OverallWeightage',
                              overflow: TextOverflow.values.first,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'CurrentStatus',
                        allowEditing: true,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text('Current Status',
                              overflow: TextOverflow.values.first,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'ListDocument',
                        allowEditing: true,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text('List of Document Required',
                              overflow: TextOverflow.values.first,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: blue),
                      onPressed: () async {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => const CupertinoAlertDialog(
                            content: SizedBox(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                        StoreData();
                      },
                      child: const Text('Sync Data',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ))),
                )
              ],
            ),
    );
  }

  Future<void> getFirestoreData() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference tabledata =
        instance.collection('${widget.depoName}A11');

    DocumentSnapshot snapshot = await tabledata.doc(widget.depoName).get();
    var data = snapshot.data() as Map;
    var alldata = data['data'] as List<dynamic>;

    _employees = [];
    alldata.forEach((element) {
      _employees.add(EmployeeStatutory.fromJson(element));
    });
  }

  List<EmployeeStatutory> getData() {
    return [
      EmployeeStatutory(
          srNo: 1,
          approval: 'Environment clearance',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 2,
          approval: 'Consent to Establish under air and water act',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKPCC',
          currentStatusPerc: 20,
          overallWeightage: 10,
          currentStatus: 'completed',
          listDocument: 'Traffic Plan'),
      EmployeeStatutory(
          srNo: 3,
          approval: 'Hazardous Waste Disposal ',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 4,
          approval: 'Forest NOC',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument: 'Fire Map'),
      EmployeeStatutory(
          srNo: 5,
          approval: 'Fire NOC',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 6,
          approval: 'Structural Stability from Government approved consultant',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 7,
          approval: 'PHE NOC (Public Health Engineering )',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 8,
          approval: 'Disaster Management authority',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 9,
          approval: 'Traffic NOC',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 10,
          approval: 'Consent to Operate Air and Water',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 11,
          approval: 'Labour Registration',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 12,
          approval: 'Chief Electrical Inspector Clearance',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
      EmployeeStatutory(
          srNo: 13,
          approval: 'ETP',
          weightage: 10,
          applicability: 'yes',
          approvingAuthority: 'JKEIAA',
          currentStatusPerc: 10,
          overallWeightage: 1,
          currentStatus: 'In progress',
          listDocument:
              'Site plan approved by the Authority (Jammu Smart city, Jammu Municipal Corporation or Jammu Development Authority)'),
    ];
  }

  // List<Employee> getEmployeeData() {
  //   return [
  //     Employee(
  //         srNo: 1,
  //         activity: 'CMS Integration',
  //         originalDuration: 1,
  //         startDate: DateFormat().add_yMd().format(DateTime.now()),
  //         endDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualendDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualDuration: 0,
  //         delay: 0,
  //         unit: 0,
  //         scope: 0,
  //         qtyExecuted: 0,
  //         balanceQty: 0,
  //         percProgress: 0,
  //         weightage: 0.5),
  //     Employee(
  //         srNo: 2,
  //         activity: 'Bus Depot work Completed & Handover to TML',
  //         originalDuration: 1,
  //         startDate: DateFormat().add_yMd().format(DateTime.now()),
  //         endDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualendDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualDuration: 0,
  //         delay: 0,
  //         unit: 0,
  //         scope: 0,
  //         qtyExecuted: 0,
  //         balanceQty: 0,
  //         percProgress: 0,
  //         weightage: 0.5),
  //   ];
  // }

  void StoreData() {
    Map<String, dynamic> table_data = Map();
    for (var i in _employeeDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button') {
          table_data[data.columnName] = data.value;
        }
      }
      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection('${widget.depoName}A11')
        .doc(widget.depoName)
        .set({
      'data': tabledata2,
    }).whenComplete(() {
      tabledata2.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Data are synced'),
        backgroundColor: blue,
      ));
    });
  }
}
