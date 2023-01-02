import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTable.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA10.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA11.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA3.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA4.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA5.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA6.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA8.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA9.dart';
import 'package:web_appllication/MenuPage/KeyEvents/datasource/employee_datasouce.dart';
import 'package:web_appllication/MenuPage/KeyEvents/model/employee.dart';
import 'package:web_appllication/MenuPage/KeyEvents/viewFIle.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/style.dart';

import 'Grid_DataTableA7.dart';
import 'datasource/key_datasource.dart';

void main() {
  runApp(KeyEvents());
}

/// The application that contains datagrid on it.

/// The home page of the application which hosts the datagrid.
class KeyEvents extends StatefulWidget {
  /// Creates the home page.
  String? depoName;
  String? cityName;
  KeyEvents({Key? key, this.depoName, this.cityName}) : super(key: key);

  @override
  _KeyEventsState createState() => _KeyEventsState();
}

class _KeyEventsState extends State<KeyEvents> {
  late KeyDataSourceKeyEvents _KeyDataSourceKeyEvents;
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
  void initState() {
    _employees = getEmployeeData();
    _KeyDataSourceKeyEvents = KeyDataSourceKeyEvents(_employees, context);
    _dataGridController = DataGridController();
    super.initState();
  }

  List<Widget> menuwidget = [];
  // @override
  // void didChangeDependencies() {
  //   _employees = getEmployeeData();
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
  //         _KeyDataSourceKeyEvents = KeyDataSourceKeyEvents(_employees, context);
  //         _dataGridController = DataGridController();
  //       });
  //       // _KeyDataSourceKeyEvents = KeyDataSourceKeyEvents(_employees);
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
    final List<ChartData> chartData = [
      ChartData('A10', 35, Colors.teal),
      ChartData('A9', 23, Colors.orange),
      ChartData('A8', 34, Colors.brown),
      ChartData('A7', 25, Colors.deepOrange),
      ChartData('A6', 50, Colors.blue),
      ChartData('A5', 35, Colors.teal),
      ChartData('A4', 23, Colors.orange),
      ChartData('A3', 34, Colors.brown),
      ChartData('A2', 25, Colors.deepOrange),
      ChartData('A1', 50, Colors.blue),
      // ChartData('A6', 35, Colors.teal),
      // ChartData('A7', 23, Colors.orange),
      // ChartData('A8', 34, Colors.brown),
      // ChartData('A9', 25, Colors.deepOrange),
      // ChartData('A10', 50, Colors.blue),
    ];
    menuwidget = [
      const ViewFile(),
      StatutoryAprovalA2(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA3(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA4(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA11(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA6(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA7(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA8(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA9(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA10(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Events '),
        backgroundColor: blue,
      ),
      body: _isLoading
          ? LoadingPage()
          : Row(
              children: [
                Expanded(
                  child: SfDataGrid(
                    source: _KeyDataSourceKeyEvents,

                    onCellTap: (DataGridCellTapDetails details) {
                      final DataGridRow row = _KeyDataSourceKeyEvents
                          .effectiveRows[details.rowColumnIndex.rowIndex - 1];

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              menuwidget[details.rowColumnIndex.rowIndex - 1]));
                    },
                    allowEditing: true,
                    frozenColumnsCount: 2,
                    editingGestureType: EditingGestureType.tap,
                    headerGridLinesVisibility: GridLinesVisibility.both,
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
                          alignment: Alignment.center,
                          child: Text(
                            'Sr No',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),

                            //    textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Activity',
                        allowEditing: false,
                        width: 220,
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Activity',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      // GridColumn(
                      //   columnName: 'button',
                      //   width: 130,
                      //   allowEditing: false,
                      //   label: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     alignment: Alignment.center,
                      //     child: const Text('View File '),
                      //   ),
                      // ),
                      GridColumn(
                        columnName: 'OriginalDuration',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Original Duration',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'StartDate',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Start Date',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'EndDate',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'End Date',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'ActualStart',
                        allowEditing: false,
                        width: 150,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Actual Start',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'ActualEnd',
                        allowEditing: false,
                        width: 150,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Actual End',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'ActualDuration',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Actual Duration',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Delay',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Delay',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Unit',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Unit',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'QtyScope',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Oty as per scope',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'QtyExecuted',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Qty executed',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'BalancedQty',
                        allowEditing: false,
                        label: Container(
                          width: 150,
                          alignment: Alignment.center,
                          child: Text(
                            'Balanced Qty',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Progress',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '% of Progress',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Weightage',
                        allowEditing: false,
                        label: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Weightage',
                            overflow: TextOverflow.values.first,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    width: 300,
                    child: SfCartesianChart(
                        title: ChartTitle(),
                        primaryXAxis: CategoryAxis(
                            // title: AxisTitle(text: 'Key Events')
                            ),
                        primaryYAxis: NumericAxis(
                            // title: AxisTitle(text: 'Weightage')
                            ),
                        series: <ChartSeries>[
                          // Renders column chart
                          BarSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) => data.y1)
                        ]))

                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(backgroundColor: blue),
                //     onPressed: () async {
                //       showCupertinoDialog(
                //         context: context,
                //         builder: (context) => const CupertinoAlertDialog(
                //           content: SizedBox(
                //             height: 50,
                //             width: 50,
                //             child: Center(
                //               child: CircularProgressIndicator(
                //                 color: Colors.white,
                //               ),
                //             ),
                //           ),
                //         ),
                //       );
                //       StoreData();
                //     },
                //   ),

                //   )
              ],
            ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
          srNo: 'A1',
          activity: 'Letter of Award reveived  from TML',
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
          srNo: 'A2',
          activity:
              'Site Survey, Job scope finalization  and Proposed layout submission',
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
          srNo: 'A3',
          activity:
              'Detailed Engineering for Approval of  Civil & Electrical  Layout, GA Drawing from TML',
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
          srNo: 'A4',
          activity: 'Site Mobalization activity Completed',
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
          srNo: 'A5',
          activity: 'Approval of statutory clearances of BUS Depot',
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
          srNo: 'A6',
          activity: 'Procurement of Order Finalisation Completed',
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
          srNo: 'A7',
          activity: 'Receipt of all Materials at Site',
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
          srNo: 'A8',
          activity: 'Civil Infra Development completed at Bus Depot',
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
          srNo: 'A9',
          activity: 'Electrical Infra Development completed at Bus Depot',
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
          srNo: 'A10',
          activity: 'Bus Depot work Completed & Handover to TML',
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

  Future<void> getFirestoreData() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference tabledata = instance.collection('${widget.depoName}A3');

    DocumentSnapshot snapshot = await tabledata.doc(widget.depoName).get();
    var data = snapshot.data() as Map;
    var alldata = data['data'] as List<dynamic>;

    _employees = [];
    alldata.forEach((element) {
      _employees.add(Employee.fromJson(element));
    });
  }

  void StoreData() {
    Map<String, dynamic> table_data = Map();
    for (var i in _KeyDataSourceKeyEvents.dataGridRows) {
      for (var data in i.getCells()) {
        table_data[data.columnName] = data.value;
      }
      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection('${widget.depoName}A3')
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

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final String x;
  final double y;
  final Color y1;
}
