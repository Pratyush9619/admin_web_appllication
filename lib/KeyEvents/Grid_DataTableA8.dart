import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/KeyEvents/ChartData.dart';
import 'package:web_appllication/datasource/employee_datasouce.dart';
import 'package:web_appllication/model/employee.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/style.dart';

import '../widgets/custom_appbar.dart';

/// The home page of the application which hosts the datagrid.
class StatutoryAprovalA8 extends StatefulWidget {
  /// Creates the home page.
  String? userid;
  String? depoName;
  String? cityName;
  StatutoryAprovalA8(
      {Key? key, required this.userid, this.depoName, this.cityName})
      : super(key: key);

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
  List<dynamic> tabledata2 = [];
  bool _isLoading = false;
  bool _isInit = true;
  List<double> weight = [];
  List<int> yAxis = [];
  List<ChartData> chartData = [];
  Stream? _stream;
  var alldata;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     getFirestoreData().whenComplete(() {
  //       setState(() {
  //         if (_employees.length == 0 || _employees.isEmpty) {
  //           _employees = getEmployeeData();
  //         }
  //         _isLoading = false;
  //         _employeeDataSource = EmployeeDataSource(_employees, context);
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
  void initState() {
    _stream = FirebaseFirestore.instance
        .collection('KeyEventsTable')
        .doc(widget.depoName!)
        .collection(widget.userid!)
        .doc('${widget.depoName}A8')
        .snapshots();
    super.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: CustomAppBar(
          text: 'Key Events / ${widget.depoName!} /A8',
          haveSynced: true,
          store: () {
            StoreData();
          },
        ),
        preferredSize: Size.fromHeight(50),
      ),
      body: _isLoading
          ? LoadingPage()
          : StreamBuilder(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                }

                if (!snapshot.hasData || snapshot.data.exists == false) {
                  _employees = getEmployeeData();
                  _employeeDataSource = EmployeeDataSource(
                      _employees, context, widget.cityName, widget.depoName);
                  _dataGridController = DataGridController();

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: _employees.length * 60,
                          child: Row(
                            children: [
                              Expanded(
                                child: SfDataGrid(
                                  source: _employeeDataSource,
                                  allowEditing: true,
                                  frozenColumnsCount: 2,
                                  gridLinesVisibility: GridLinesVisibility.both,
                                  headerGridLinesVisibility:
                                      GridLinesVisibility.both,
                                  selectionMode: SelectionMode.single,
                                  navigationMode: GridNavigationMode.cell,
                                  columnWidthMode: ColumnWidthMode.auto,
                                  editingGestureType: EditingGestureType.tap,
                                  controller: _dataGridController,
                                  // onQueryRowHeight: (details) {
                                  //   return details.rowIndex == 0 ? 60.0 : 49.0;
                                  // },
                                  columns: [
                                    GridColumn(
                                      columnName: 'srNo',
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Sr No',
                                          overflow: TextOverflow.values.first,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                          //    textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Activity',
                                      width: 220,
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Activity',
                                          overflow: TextOverflow.values.first,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'button',
                                      width: 130,
                                      allowEditing: false,
                                      label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text('View File ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'OriginalDuration',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Original Duration',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'StartDate',
                                      allowEditing: true,
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
                                      allowEditing: true,
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
                                      columnName: 'ActualDuration',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Actual Duration',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Delay',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Delay',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'ReasonDelay',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Reason For Delay',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Unit',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Unit',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'QtyScope',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Oty as per scope',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'QtyExecuted',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Qty executed',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'BalancedQty',
                                      allowEditing: false,
                                      label: Container(
                                        width: 150,
                                        alignment: Alignment.center,
                                        child: Text('Balanced Qty',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Progress',
                                      allowEditing: false,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('% of Progress',
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
                                  ],
                                ),
                              ),
                              Container(
                                  width: 300,
                                  margin: EdgeInsets.only(top: 10),
                                  child: SfCartesianChart(
                                      title: ChartTitle(
                                          text: 'All Events Wightage Graph'),
                                      primaryXAxis: CategoryAxis(
                                          // title: AxisTitle(text: 'Key Events')
                                          ),
                                      primaryYAxis: NumericAxis(
                                          // title: AxisTitle(text: 'Weightage')
                                          ),
                                      series: <ChartSeries>[
                                        // Renders column chart
                                        BarSeries<ChartData, String>(
                                            dataLabelSettings:
                                                DataLabelSettings(
                                                    isVisible: true),
                                            dataSource: chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y,
                                            pointColorMapper:
                                                (ChartData data, _) => data.y1)
                                      ]))
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
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
                        //       child: const Text(
                        //         'Sync Data',
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //           fontSize: 15,
                        //         ),
                        //       )),
                        // ),
                      ],
                    ),
                  );
                } else {
                  alldata = snapshot.data['data'] as List<dynamic>;
                  _employees.clear();
                  alldata.forEach((element) {
                    _employees.add(Employee.fromJson(element));
                    _employeeDataSource = EmployeeDataSource(
                        _employees, context, widget.cityName, widget.depoName);
                    _dataGridController = DataGridController();
                  });
                  for (int i = 0; i < alldata.length; i++) {
                    var weightdata = alldata[i]['Weightage'];
                    var yaxisdata = alldata[i]['srNo'];
                    weight.add(weightdata);
                    yAxis.add(yaxisdata);
                  }
                  for (int i = weight.length - 1; i >= 0; i--) {
                    chartData.add(ChartData(
                        yAxis[i].toString(), weight[i], Colors.green));
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: _employees.length * 52,
                          child: Row(
                            children: [
                              Expanded(
                                child: SfDataGrid(
                                  source: _employeeDataSource,
                                  allowEditing: true,
                                  frozenColumnsCount: 2,
                                  gridLinesVisibility: GridLinesVisibility.both,
                                  headerGridLinesVisibility:
                                      GridLinesVisibility.both,
                                  selectionMode: SelectionMode.single,
                                  navigationMode: GridNavigationMode.cell,
                                  columnWidthMode: ColumnWidthMode.auto,
                                  editingGestureType: EditingGestureType.tap,
                                  controller: _dataGridController,
                                  // onQueryRowHeight: (details) {
                                  //   return details.rowIndex == 0 ? 60.0 : 49.0;
                                  // },
                                  columns: [
                                    GridColumn(
                                      columnName: 'srNo',
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Sr No',
                                          overflow: TextOverflow.values.first,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                          //    textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Activity',
                                      width: 220,
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Activity',
                                          overflow: TextOverflow.values.first,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'button',
                                      width: 130,
                                      allowEditing: false,
                                      label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text('View File ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'OriginalDuration',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Original Duration',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
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
                                      columnName: 'ActualDuration',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Actual Duration',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Delay',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Delay',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'ReasonDelay',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Reason For Delay',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Unit',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Unit',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'QtyScope',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Oty as per scope',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'QtyExecuted',
                                      allowEditing: true,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Qty executed',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'BalancedQty',
                                      allowEditing: false,
                                      label: Container(
                                        width: 150,
                                        alignment: Alignment.center,
                                        child: Text('Balanced Qty',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Progress',
                                      allowEditing: false,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('% of Progress',
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
                                  ],
                                ),
                              ),
                              Container(
                                  width: 300,
                                  margin: EdgeInsets.only(top: 10),
                                  child: SfCartesianChart(
                                      title: ChartTitle(
                                          text: 'All Events Wightage Graph'),
                                      primaryXAxis: CategoryAxis(
                                          // title: AxisTitle(text: 'Key Events')
                                          ),
                                      primaryYAxis: NumericAxis(
                                          // title: AxisTitle(text: 'Weightage')
                                          ),
                                      series: <ChartSeries>[
                                        // Renders column chart
                                        BarSeries<ChartData, String>(
                                            dataLabelSettings:
                                                DataLabelSettings(
                                                    isVisible: true),
                                            dataSource: chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y,
                                            pointColorMapper:
                                                (ChartData data, _) => data.y1)
                                      ]))
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
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
                        //       child: const Text(
                        //         'Sync Data',
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //           fontSize: 15,
                        //         ),
                        //       )),
                        // ),
                      ],
                    ),
                  );
                }
              }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() {
            _employees.add(
              Employee(
                srNo: 1,
                activity: 'Initial Survey Of Depot With TML & STA Team.',
                originalDuration: 1,
                startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                actualstartDate:
                    DateFormat('dd-MM-yyyy').format(DateTime.now()),
                actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                actualDuration: 0,
                delay: 0,
                reasonDelay: '',
                unit: 0,
                scope: 0,
                qtyExecuted: 0,
                balanceQty: 0,
                percProgress: 0,
                weightage: 0.5,
              ),
            );
            _employeeDataSource.buildDataGridRows();
            _employeeDataSource.updateDatagridSource();
          })),
    );
  }

  Future<void> getFirestoreData() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference tabledata = instance.collection(widget.depoName!);

    DocumentSnapshot snapshot =
        await tabledata.doc('${widget.depoName}A7').get();
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
          activity: 'Concrete breaking ',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 2.4),
      Employee(
          srNo: 2,
          activity: 'Manual Excavation',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.9),
      Employee(
          srNo: 3,
          activity: 'Soling',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.1),
      Employee(
          srNo: 4,
          activity: 'PCC & Curing',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.5),
      Employee(
          srNo: 5,
          activity: 'Reinforcement tying of Raft (charger Foundation)',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.5),
      Employee(
          srNo: 6,
          activity: 'Shuttering of Raft (charger Foundation)',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.5),
      Employee(
          srNo: 7,
          activity: 'Concreting of Raft (charger Foundation) and Curing',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.5),
      Employee(
          srNo: 8,
          activity: 'Reinforcement tying of pedestal (PSS)',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.5),
      Employee(
          srNo: 9,
          activity: 'Shuttering of pedestal (PSS Foundation) ',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.5),
      Employee(
          srNo: 10,
          activity: 'Concreting of pedestal (PSS Foundation) ',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 6.6),
      Employee(
          srNo: 11,
          activity: 'Reinforcement tying of Raft (shed)',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.6),
      Employee(
          srNo: 12,
          activity: 'Shuttering of Raft (shed)',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.6),
      Employee(
          srNo: 13,
          activity: 'Concreting of Raft (shed) and Curing',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.6),
      Employee(
          srNo: 14,
          activity: 'Backfilling',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.1),
      Employee(
          srNo: 15,
          activity: 'Erection of shed structure',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.2),
      Employee(
          srNo: 16,
          activity: 'Roof sheeting',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.1),
      Employee(
          srNo: 17,
          activity: 'Concreting around excavated area',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.6),
      Employee(
          srNo: 18,
          activity: 'Thermoplastic paint',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.3),
      Employee(
          srNo: 19,
          activity: 'Crash barrier ',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.3),
      Employee(
          srNo: 20,
          activity: '5S activity',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.3),
      Employee(
          srNo: 21,
          activity: 'Cable Trenching (for burried cable)',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 1.0),
      Employee(
          srNo: 22,
          activity: 'Compressor foundation and room',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
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
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.8),
      Employee(
          srNo: 25,
          activity: 'Painiting ',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: 0,
          delay: 0,
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: 0.3),
    ];
  }

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
        .doc('${widget.depoName}A8')
        .set({'data': tabledata2}).whenComplete(() {
      tabledata2.clear();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Data are synced'),
        backgroundColor: blue,
      ));
    });
  }
}
