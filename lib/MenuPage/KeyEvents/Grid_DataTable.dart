import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/KeyEvents/ChartData.dart';
import 'package:web_appllication/MenuPage/KeyEvents/datasource/employee_datasouce.dart';
import 'package:web_appllication/MenuPage/KeyEvents/model/employee.dart';
import 'package:web_appllication/style.dart';
import '../../components/loading_page.dart';

void main() {
  runApp(StatutoryAprovalA2());
}

/// The application that contains datagrid on it.

/// The home page of the application which hosts the datagrid.
class StatutoryAprovalA2 extends StatefulWidget {
  /// Creates the home page.
  String? depoName;
  String? cityName;

  StatutoryAprovalA2({Key? key, this.depoName, this.cityName})
      : super(key: key);

  @override
  _StatutoryAprovalA2State createState() => _StatutoryAprovalA2State();
}

class _StatutoryAprovalA2State extends State<StatutoryAprovalA2> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];
  late DataGridController _dataGridController;
  List<dynamic> tabledata2 = [];
  List<dynamic> weightage = [];
  var alldata;
  bool _isLoading = false;
  bool _isInit = true;
  List<double> weight = [];
  List<int> yAxis = [];
  List<ChartData> chartData = [];
  Stream? _stream;

  @override
  void initState() {
    _stream = FirebaseFirestore.instance
        .collection('${widget.depoName}')
        .doc('${widget.depoName}A1')
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
  //         loadchartdata();
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
  Widget build(BuildContext context) {
    // chartData = [
    //   // ChartData('7', 32, Color.fromARGB(255, 124, 136, 135)),
    //   // ChartData('6', 35, Colors.teal),
    //   ChartData('5', 35, Colors.teal),
    //   ChartData('4', 23, Colors.orange),
    //   ChartData('3', 34, Colors.brown),
    //   ChartData('2', 25, Colors.deepOrange),
    //   ChartData('1', 50, Colors.blue),
    //   // ChartData('A6', 35, Colors.teal),
    //   // ChartData('A7', 23, Colors.orange),
    //   // ChartData('A8', 34, Colors.brown),
    //   // ChartData('A9', 25, Colors.deepOrange),
    //   // ChartData('A10', 50, Colors.blue),
    // ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Key Events / ' + widget.depoName! + ' /A2'),
        backgroundColor: blue,
      ),
      body: _isLoading
          ? LoadingPage()
          : StreamBuilder(
              stream: _stream,
              builder: (context, snapshot) {
                chartData = [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                }
                if (!snapshot.hasData || snapshot.data.exists == false) {
                  _employees = getEmployeeData();
                  _employeeDataSource = EmployeeDataSource(
                      _employees, context, widget.cityName, widget.depoName);
                  _dataGridController = DataGridController();

                  return Column(
                    children: [
                      Container(
                        height: _employees.length * 66,
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
                                    autoFitPadding: const EdgeInsets.symmetric(
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
                                    width: 200,
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
                                    width: 200,
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
                                    allowEditing: true,
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
                                    allowEditing: true,
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
                                          dataLabelSettings: DataLabelSettings(
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
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(backgroundColor: blue),
                            onPressed: () async {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) =>
                                    const CupertinoAlertDialog(
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
                            child: const Text(
                              'Sync Data',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )),
                      ),
                    ],
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
                          height: _employees.length * 66,
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
                                      allowEditing: true,
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
                                      allowEditing: true,
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
                                  height: _employees.length * 75,
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
                                            width: 0.5,
                                            trackPadding: 0,
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
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: blue),
                              onPressed: () async {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) =>
                                      const CupertinoAlertDialog(
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
                              child: const Text(
                                'Sync Data',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                        ),
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

  // Future<void> getFirestoreData() async {
  //   FirebaseFirestore instance = FirebaseFirestore.instance;
  //   CollectionReference tabledata = instance.collection(widget.depoName!);

  //   DocumentSnapshot snapshot =
  //       await tabledata.doc('${widget.depoName}A1').get();
  //   var data = snapshot.data() as Map;
  //   alldata = data['data'] as List<dynamic>;

  //   // _employees = [];
  //   alldata.forEach((element) {
  //     _employees.add(Employee.fromJson(element));
  //   });

  //   for (int i = 0; i < alldata.length; i++) {
  //     var weightdata = alldata[i]['Weightage'];
  //     var yaxisdata = alldata[i]['srNo'];
  //     weight.add(weightdata);
  //     yAxis.add(yaxisdata);
  //   }
  // }

  // void loadchartdata() {
  //   for (int i = 0; i < weight.length; i++) {
  //     chartData.add(ChartData(yAxis[i].toString(), weight[i], Colors.green));
  //   }
  // }

  List<Employee> getEmployeeData() {
    return [
      Employee(
        srNo: 1,
        activity: 'Initial Survey Of Depot With TML & STA Team.',
        originalDuration: 1,
        startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualDuration: 0,
        delay: 0,
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: 0.5,
      ),
      Employee(
          srNo: 2,
          activity: 'Details Survey Of Depot With TPC Civil & Electrical Team',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          activity:
              'Survey Report Submission With Existing & Proposed Layout Drawings.',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          activity: 'Job Scope Finalization & Preparation Of BOQ',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
          activity: 'Power Connection / Load Applied By STA To Discom.',
          originalDuration: 1,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
        if (data.columnName != 'button') {
          table_data[data.columnName] = data.value;
        }
      }

      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection(widget.depoName!)
        .doc('${widget.depoName}A1')
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
