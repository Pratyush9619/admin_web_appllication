import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/datasource/employee_datasouce.dart';
import 'package:web_appllication/datasource/employee_statutory.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/style.dart';
import 'package:web_appllication/widgets/custom_appbar.dart';
import '../Authentication/auth_service.dart';
import '../model/employee_statutory.dart';

/// The home page of the application which hosts the datagrid.
class StatutoryAprovalA5 extends StatefulWidget {
  /// Creates the home page.
  String? userid;
  String? depoName;
  String? cityName;
  StatutoryAprovalA5(
      {Key? key, required this.userid, this.depoName, this.cityName})
      : super(key: key);

  @override
  _StatutoryAprovalA5State createState() => _StatutoryAprovalA5State();
}

class _StatutoryAprovalA5State extends State<StatutoryAprovalA5> {
  late EmployeeDataStatutory _employeeDataSource;
  List<EmployeeStatutory> _employees = <EmployeeStatutory>[];
  late DataGridController _dataGridController;
  DataGridRow? dataGridRow;
  RowColumnIndex? rowColumnIndex;
  GridColumn? column;
  List<dynamic> tabledata2 = [];
  bool _isLoading = false;
  bool _isInit = true;
  Stream? _stream;
  List<double> weight = [];
  List<int> yAxis = [];
  // List<ChartData> chartData = [];
  var alldata;
  bool specificUser = true;
  QuerySnapshot? snap;
  dynamic companyId;

  @override
  void initState() {
    getUserId();
    identifyUser();
    _stream = FirebaseFirestore.instance
        .collection('KeyEventsTable')
        .doc(widget.depoName!)
        .collection(widget.userid!)
        .doc('${widget.depoName}A5')
        .snapshots();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     getFirestoreData().whenComplete(() {
  //       setState(() {
  //         if (_employees.length == 0 || _employees.isEmpty) {
  //           _employees = getData();
  //         }
  //         _isLoading = false;
  //         _employeeDataSource = EmployeeDataStatutory(_employees, context);
  //         _dataGridController = DataGridController();
  //       });
  //       // _employeeDataSource = EmployeeDataSource(_employees);
  //       // _dataGridController = DataGridController();
  //     });
  //     //getFirestoreData() as List<Employee>;
  //     // getEmployeeData();
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: CustomAppBar(
            text: 'Key Events / ${widget.depoName!} /A5',
            haveSynced: specificUser ? true : false,
            store: () {
              StoreData();
            },
          ),
          preferredSize: Size.fromHeight(50),
        ),
        // AppBar(
        //   title: Text('Key Events / ' + widget.depoName! + ' /A5'),
        //   backgroundColor: blue,
        // ),
        body: _isLoading
            ? LoadingPage()
            : StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingPage();
                  }
                  if (!snapshot.hasData || snapshot.data.exists == false) {
                    _employees = getData();
                    _employeeDataSource =
                        EmployeeDataStatutory(_employees, context);
                    _dataGridController = DataGridController();

                    return Row(
                      children: [
                        Expanded(
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
                                autoFitPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: false,
                                label: Container(
                                  alignment: Alignment.center,
                                  child: Text('Sr No',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'StartDate',
                                allowEditing: false,
                                width: 180,
                                label: Container(
                                  alignment: Alignment.center,
                                  child: Text('Start Date',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'EndDate',
                                allowEditing: false,
                                width: 180,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text('End Date',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'ActualStart',
                                allowEditing: false,
                                width: 180,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text('Actual Start',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'ActualEnd',
                                allowEditing: false,
                                width: 180,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text('Actual End',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'CurrentStatusPerc',
                                allowEditing: true,
                                label: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Current status in % for Approval ',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    alldata = snapshot.data['data'] as List<dynamic>;
                    _employees.clear();
                    alldata.forEach((element) {
                      _employees.add(EmployeeStatutory.fromJson(element));
                      _employeeDataSource =
                          EmployeeDataStatutory(_employees, context);
                      _dataGridController = DataGridController();
                    });
                    for (int i = 0; i < alldata.length; i++) {
                      var weightdata = alldata[i]['Weightage'];
                      var yaxisdata = alldata[i]['srNo'];
                      weight.add(weightdata);
                      yAxis.add(yaxisdata);
                    }
                    // for (int i = weight.length - 1; i >= 0; i--) {
                    //   chartData.add(ChartData(
                    //       yAxis[i].toString(), weight[i], Colors.green));
                    // }
                    return Column(
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
                                autoFitPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: false,
                                label: Container(
                                  alignment: Alignment.center,
                                  child: Text('Sr No',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'StartDate',
                                allowEditing: false,
                                width: 180,
                                label: Container(
                                  alignment: Alignment.center,
                                  child: Text('Start Date',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'EndDate',
                                allowEditing: false,
                                width: 180,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text('End Date',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'ActualStart',
                                allowEditing: false,
                                width: 180,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text('Actual Start',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'ActualEnd',
                                allowEditing: false,
                                width: 180,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  alignment: Alignment.center,
                                  child: Text('Actual End',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'CurrentStatusPerc',
                                allowEditing: true,
                                label: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Current status in % for Approval ',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 10),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //           backgroundColor: blue),
                        //       onPressed: () async {
                        //         showCupertinoDialog(
                        //           context: context,
                        //           builder: (context) =>
                        //               const CupertinoAlertDialog(
                        //             content: SizedBox(
                        //               height: 50,
                        //               width: 50,
                        //               child: Center(
                        //                 child: CircularProgressIndicator(
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         );
                        //         StoreData();
                        //       },
                        //       child: const Text('Sync Data',
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //             fontSize: 20,
                        //           ))),
                        // )
                      ],
                    );
                  }
                },
              )

        // Column(
        //     children: [
        //       Flexible(
        //         child: SfDataGrid(
        //           source: _employeeDataSource,
        //           allowEditing: true,
        //           frozenColumnsCount: 2,
        //           editingGestureType: EditingGestureType.tap,
        //           gridLinesVisibility: GridLinesVisibility.both,
        //           headerGridLinesVisibility: GridLinesVisibility.both,
        //           selectionMode: SelectionMode.single,
        //           navigationMode: GridNavigationMode.cell,
        //           columnWidthMode: ColumnWidthMode.auto,
        //           controller: _dataGridController,
        //           // onQueryRowHeight: (details) {
        //           //   return details.rowIndex == 0 ? 60.0 : 49.0;
        //           // },
        //           columns: [
        //             GridColumn(
        //               columnName: 'srNo',
        //               autoFitPadding: EdgeInsets.symmetric(horizontal: 16),
        //               allowEditing: false,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('Sr No',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)
        //                     //    textAlign: TextAlign.center,
        //                     ),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'Approval',
        //               allowEditing: true,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('Detail of approval',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'button',
        //               width: 130,
        //               allowEditing: false,
        //               label: Container(
        //                 padding: const EdgeInsets.all(8.0),
        //                 alignment: Alignment.center,
        //                 child: const Text('View File',
        //                     style: TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'StartDate',
        //               allowEditing: false,
        //               width: 180,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('Start Date',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'EndDate',
        //               allowEditing: false,
        //               width: 180,
        //               label: Container(
        //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //                 alignment: Alignment.center,
        //                 child: Text('End Date',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'ActualStart',
        //               allowEditing: false,
        //               width: 180,
        //               label: Container(
        //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //                 alignment: Alignment.center,
        //                 child: Text('Actual Start',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'ActualEnd',
        //               allowEditing: false,
        //               width: 180,
        //               label: Container(
        //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //                 alignment: Alignment.center,
        //                 child: Text('Actual End',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'Weightage',
        //               allowEditing: true,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('Weightage',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'Applicability',
        //               allowEditing: true,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('Applicability',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'ApprovingAuthority',
        //               allowEditing: true,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('ApprovingAuthority',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'CurrentStatusPerc',
        //               allowEditing: true,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('Current status in % for Approval ',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'OverallWeightage',
        //               allowEditing: true,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('OverallWeightage',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'CurrentStatus',
        //               allowEditing: true,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('Current Status',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //             GridColumn(
        //               columnName: 'ListDocument',
        //               allowEditing: true,
        //               label: Container(
        //                 alignment: Alignment.center,
        //                 child: Text('List of Document Required',
        //                     overflow: TextOverflow.values.first,
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold, fontSize: 16)),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       const SizedBox(height: 10),
        //       Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: ElevatedButton(
        //             style: ElevatedButton.styleFrom(backgroundColor: blue),
        //             onPressed: () async {
        //               showCupertinoDialog(
        //                 context: context,
        //                 builder: (context) => const CupertinoAlertDialog(
        //                   content: SizedBox(
        //                     height: 50,
        //                     width: 50,
        //                     child: Center(
        //                       child: CircularProgressIndicator(
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               );
        //               StoreData();
        //             },
        //             child: const Text('Sync Data',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(
        //                   fontSize: 20,
        //                 ))),
        //       )
        //     ],
        //   ),

        );
  }

  Future<void> getFirestoreData() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference tabledata = instance.collection(widget.depoName!);

    DocumentSnapshot snapshot =
        await tabledata.doc('${widget.depoName}A4').get();
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
        .collection('KeyEventsTable')
        .doc(widget.depoName!)
        .collection(widget.userid!)
        .doc('${widget.depoName}A5')
        .set({
      'data': tabledata2,
    }).whenComplete(() {
      tabledata2.clear();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Data are synced'),
        backgroundColor: blue,
      ));
    });
  }

  Future<void> getUserId() async {
    await AuthService().getCurrentUserId().then((value) {
      companyId = value;
    });
  }

  identifyUser() async {
    snap = await FirebaseFirestore.instance.collection('Admin').get();

    if (snap!.docs[0]['Employee Id'] == companyId &&
        snap!.docs[0]['CompanyName'] == 'TATA MOTOR') {
      setState(() {
        specificUser = false;
      });
    }
  }
}
