import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTable.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA10.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA5.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA3.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA4.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA6.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA8.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA9.dart';
import 'package:web_appllication/MenuPage/KeyEvents/datasource/employee_datasouce.dart';
import 'package:web_appllication/MenuPage/KeyEvents/model/employee.dart';
import 'package:web_appllication/MenuPage/KeyEvents/viewFIle.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/provider/key_provider.dart';
import 'package:web_appllication/style.dart';
import 'Grid_DataTableA7.dart';
import 'datasource/key_datasource.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(KeyEvents());
  initializeDateFormatting();
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
  KeyProvider? keyprovider;
  List<dynamic> tabledata2 = [];
  Stream? yourstream;
  Stream? yourstream1;
  double totalweightage = 0;
  List<String> startdate = [];
  List<String> enddate = [];
  List<String> asstartdate = [];
  List<String> asenddate = [];
  String? actualstartdate;
  String? actualenddate;
  List<double> weight = [];
  List<ChartData> chartData = <ChartData>[];
  List<ChartData> chartData2 = <ChartData>[];
  String? sdate;
  String? edate;
  String? asdate;
  String? aedate;
  var alldata;
  bool _isLoading = false;
  bool _isInit = true;
  int? length;

  @override
  void initState() {
    yourstream =
        FirebaseFirestore.instance.collection('${widget.depoName}').snapshots();
    super.initState();
  }

  List<Widget> menuwidget = [];

  @override
  Widget build(BuildContext context) {
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
      StatutoryAprovalA5(
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

    return _isLoading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Key Events '),
              backgroundColor: blue,
            ),
            body: StreamBuilder(
                stream: yourstream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingPage();
                  }
                  if (snapshot.data.docs.length == 0) {
                    _employees = getDefaultEmployeeData();
                    _KeyDataSourceKeyEvents =
                        KeyDataSourceKeyEvents(_employees, context);
                    _dataGridController = DataGridController();

                    return Container(
                      height: 580,
                      child: Row(
                        children: [
                          Expanded(
                            child: SfDataGrid(
                              source: _KeyDataSourceKeyEvents,
                              onCellTap: (DataGridCellTapDetails details) {
                                final DataGridRow row =
                                    _KeyDataSourceKeyEvents.effectiveRows[
                                        details.rowColumnIndex.rowIndex - 1];

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => menuwidget[
                                        details.rowColumnIndex.rowIndex - 1]));
                              },
                              allowEditing: true,
                              frozenColumnsCount: 2,
                              editingGestureType: EditingGestureType.tap,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
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
                                  autoFitPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  allowEditing: false,
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
                                  allowEditing: false,
                                  width: 220,
                                  label: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'ActualEnd',
                                  allowEditing: false,
                                  width: 150,
                                  label: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Actual End',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
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
                                        dataSource: chartData,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        pointColorMapper: (ChartData data, _) =>
                                            data.y1)
                                  ]))
                        ],
                      ),
                    );
                  } else {
                    int length = snapshot.data.docs.length;

                    weight.clear();
                    startdate.clear();
                    enddate.clear();
                    asstartdate.clear();
                    asenddate.clear();
                    for (int i = 0; i < length; i++) {
                      if (i != 3) {
                        alldata =
                            snapshot.data.docs[i]['data'] as List<dynamic>;
                      }
                      if (i != 3) {
                        sdate = alldata[0]['StartDate'];
                        edate = alldata[alldata.length - 1]['EndDate'];
                        asdate = alldata[0]['ActualStart'];
                        aedate = alldata[alldata.length - 1]['ActualEnd'];
                        startdate.add(sdate!);
                        enddate.add(edate!);
                        asstartdate.add(asdate!);
                        asenddate.add(aedate!);
                        print('Start$startdate');
                        print('Start$enddate');
                      }
                      for (int i = 0; i < alldata.length; i++) {
                        var weightage = alldata[i]['Weightage'];
                        totalweightage = totalweightage + weightage;
                      }
                      weight.add(totalweightage);
                      chartData = [
                        ChartData(
                            'A10',
                            weight.asMap().containsKey(8) ? weight[8] : 0,
                            Colors.yellow),
                        ChartData(
                            'A9',
                            weight.asMap().containsKey(7) ? weight[7] : 0,
                            Colors.yellow),
                        ChartData(
                            'A8',
                            weight.asMap().containsKey(6) ? weight[6] : 0,
                            Colors.yellow),
                        ChartData(
                            'A7',
                            weight.asMap().containsKey(5) ? weight[5] : 0,
                            Colors.yellow),
                        ChartData(
                            'A6',
                            weight.asMap().containsKey(4) ? weight[4] : 0,
                            Colors.yellow),
                        ChartData(
                            'A5',
                            weight.asMap().containsKey(3) ? weight[3] : 0,
                            Colors.yellow),
                        ChartData(
                            'A4',
                            weight.asMap().containsKey(2) ? weight[2] : 0,
                            Colors.yellow),
                        ChartData(
                            'A3',
                            weight.asMap().containsKey(1) ? weight[1] : 0,
                            Colors.yellow),
                        ChartData(
                            'A2',
                            weight.asMap().containsKey(0) ? weight[0] : 0,
                            Colors.yellow),
                        ChartData('A1', 5, Colors.yellow),
                      ];
                      chartData2 = [
                        ChartData(
                            'A10',
                            weight.asMap().containsKey(8) ? weight[8] : 0,
                            Colors.red),
                        ChartData(
                            'A9',
                            weight.asMap().containsKey(7) ? weight[7] : 0,
                            Colors.red),
                        ChartData(
                            'A8',
                            weight.asMap().containsKey(6) ? weight[6] : 0,
                            Colors.red),
                        ChartData(
                            'A7',
                            weight.asMap().containsKey(5) ? weight[5] : 0,
                            Colors.red),
                        ChartData(
                            'A6',
                            weight.asMap().containsKey(4) ? weight[4] : 0,
                            Colors.red),
                        ChartData(
                            'A5',
                            weight.asMap().containsKey(3) ? weight[3] : 0,
                            Colors.red),
                        ChartData(
                            'A4',
                            weight.asMap().containsKey(2) ? weight[2] : 0,
                            Colors.red),
                        ChartData(
                            'A3',
                            weight.asMap().containsKey(1) ? weight[1] : 0,
                            Colors.red),
                        ChartData(
                            'A2',
                            weight.asMap().containsKey(0) ? weight[0] : 0,
                            Colors.red),
                        ChartData('A1', 5, Colors.red),
                      ];

                      print(weight);
                      totalweightage = 0;
                    }

                    if (!snapshot.hasData) return LoadingPage();
                    _employees.clear();

                    alldata.forEach((element) {
                      _employees.add(Employee.fromJson(element));
                    });

                    _employees = getEmployeeData();
                    _KeyDataSourceKeyEvents =
                        KeyDataSourceKeyEvents(_employees, context);
                    _dataGridController = DataGridController();

                    return Container(
                      height: 580,
                      child: Row(
                        children: [
                          Expanded(
                            child: SfDataGrid(
                              source: _KeyDataSourceKeyEvents,
                              onCellTap: (DataGridCellTapDetails details) {
                                final DataGridRow row =
                                    _KeyDataSourceKeyEvents.effectiveRows[
                                        details.rowColumnIndex.rowIndex - 1];

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => menuwidget[
                                        details.rowColumnIndex.rowIndex - 1]));
                              },
                              allowEditing: true,
                              frozenColumnsCount: 2,
                              editingGestureType: EditingGestureType.tap,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
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
                                  autoFitPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  allowEditing: false,
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
                                  allowEditing: false,
                                  width: 220,
                                  label: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'ActualEnd',
                                  allowEditing: false,
                                  width: 150,
                                  label: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Actual End',
                                      overflow: TextOverflow.values.first,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: 350,
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
                                        dataSource: chartData,
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true),
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        pointColorMapper: (ChartData data, _) =>
                                            data.y1),

                                    BarSeries<ChartData, String>(
                                        dataSource: chartData2,
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true),
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        pointColorMapper: (ChartData data, _) =>
                                            data.y1)
                                  ]))
                        ],
                      ),
                    );
                  }
                }));
    //  _isLoading
    //     ? LoadingPage()
    //     :
  }

  List<Employee> getDefaultEmployeeData() {
    return [
      Employee(
          srNo: 'A1',
          activity: 'Letter of Award reveived  from TML',
          originalDuration: 0,
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
          weightage: 0),
      Employee(
          srNo: 'A2',
          activity:
              'Site Survey, Job scope finalization  and Proposed layout submission',
          originalDuration: 16,
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
          weightage: 0),
      // totalweightage),
      Employee(
          srNo: 'A3',
          activity:
              'Detailed Engineering for Approval of  Civil & Electrical  Layout, GA Drawing from TML',
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
          weightage: 0),
      Employee(
          srNo: 'A4',
          activity: 'Site Mobalization activity Completed',
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
          weightage: 0),
      Employee(
          srNo: 'A5',
          activity: 'Approval of statutory clearances of BUS Depot',
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
          weightage: 0),
      Employee(
          srNo: 'A6',
          activity: 'Procurement of Order Finalisation Completed',
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
          weightage: 0),
      Employee(
          srNo: 'A7',
          activity: 'Receipt of all Materials at Site',
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
          weightage: 0),
      Employee(
          srNo: 'A8',
          activity: 'Civil Infra Development completed at Bus Depot',
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
          weightage: 0),
      Employee(
          srNo: 'A9',
          activity: 'Electrical Infra Development completed at Bus Depot',
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
          weightage: 0),
      Employee(
        srNo: 'A10',
        activity: 'Bus Depot work Completed & Handover to TML',
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
        weightage: 0,
      ),
    ];
  }

  int durationParse(DateTime fromtime, DateTime todate) {
    DateTime startdate =
        DateTime.parse(DateFormat('dd-MM-yyyy').format(fromtime));
    DateTime enddate = DateTime.parse(DateFormat('dd-MM-yyyy').format(todate));
    return enddate.difference(startdate).inDays;
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
          srNo: 'A1',
          activity: 'Letter of Award reveived  from TML',
          originalDuration: 0,
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
          weightage: 10),
      Employee(
        srNo: 'A2',
        activity:
            'Site Survey, Job scope finalization  and Proposed layout submission',
        originalDuration: 10,
        // int.parse(
        //   durationParse(
        //           DateTime.parse('02-10-2020'), DateTime.parse('05-10-2020'))
        //       .toString(),
        // ),
        startDate: startdate.asMap().containsKey(0)
            ? startdate[0]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        endDate: enddate.asMap().containsKey(0)
            ? enddate[0]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualstartDate: asstartdate.asMap().containsKey(0)
            ? asstartdate[0]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualendDate: asenddate.asMap().containsKey(0)
            ? asenddate[0]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualDuration: 0,
        delay: 0,
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight.asMap().containsKey(0) ? weight[0] : 0.0,
      ),
      // totalweightage),
      Employee(
        srNo: 'A3',
        activity:
            'Detailed Engineering for Approval of  Civil & Electrical  Layout, GA Drawing from TML',
        originalDuration: 1,
        startDate: startdate.asMap().containsKey(1)
            ? startdate[1]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        endDate: enddate.asMap().containsKey(1)
            ? enddate[1]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualstartDate: asstartdate.asMap().containsKey(7)
            ? asstartdate[1]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualendDate: asenddate.asMap().containsKey(7)
            ? asenddate[1]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualDuration: 0,
        delay: 0,
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight.asMap().containsKey(1) ? weight[1] : 0.0,
      ),
      Employee(
        srNo: 'A4',
        activity: 'Site Mobalization activity Completed',
        originalDuration: 1,
        startDate: startdate.asMap().containsKey(2)
            ? startdate[2]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        endDate: enddate.asMap().containsKey(2)
            ? enddate[2]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualstartDate: asstartdate.asMap().containsKey(2)
            ? asstartdate[2]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualendDate: asenddate.asMap().containsKey(2)
            ? asenddate[2]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualDuration: 0,
        delay: 0,
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight.asMap().containsKey(2) ? weight[2] : 0.0,
      ),
      Employee(
          srNo: 'A5',
          activity: 'Approval of statutory clearances of BUS Depot',
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
          weightage: 0),
      Employee(
        srNo: 'A6',
        activity: 'Procurement of Order Finalisation Completed',
        originalDuration: 1,
        startDate: startdate.asMap().containsKey(3)
            ? startdate[3]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        endDate: enddate.asMap().containsKey(3)
            ? enddate[3]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualstartDate: asstartdate.asMap().containsKey(3)
            ? asstartdate[3]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualendDate: asenddate.asMap().containsKey(3)
            ? asenddate[3]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualDuration: 0,
        delay: 0,
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight.asMap().containsKey(3) ? weight[3] : 0.0,
      ),
      Employee(
        srNo: 'A7',
        activity: 'Receipt of all Materials at Site',
        originalDuration: 1,
        startDate: startdate.asMap().containsKey(4)
            ? startdate[4]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        endDate: enddate.asMap().containsKey(4)
            ? enddate[4]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualstartDate: asstartdate.asMap().containsKey(4)
            ? asstartdate[4]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualendDate: asenddate.asMap().containsKey(4)
            ? asenddate[4]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualDuration: 0,
        delay: 0,
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight.asMap().containsKey(4) ? weight[4] : 0.0,
      ),
      Employee(
        srNo: 'A8',
        activity: 'Civil Infra Development completed at Bus Depot',
        originalDuration: 1,
        startDate: startdate.asMap().containsKey(5)
            ? startdate[5]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        endDate: enddate.asMap().containsKey(5)
            ? enddate[5]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualstartDate: asstartdate.asMap().containsKey(5)
            ? asstartdate[5]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualendDate: asenddate.asMap().containsKey(5)
            ? asenddate[5]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualDuration: 0,
        delay: 0,
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight.asMap().containsKey(5) ? weight[5] : 0.0,
      ),
      Employee(
        srNo: 'A9',
        activity: 'Electrical Infra Development completed at Bus Depot',
        originalDuration: 1,
        startDate: startdate.asMap().containsKey(7)
            ? startdate[6]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        endDate: enddate.asMap().containsKey(6)
            ? enddate[6]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualstartDate: asstartdate.asMap().containsKey(6)
            ? asstartdate[6]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualendDate: asenddate.asMap().containsKey(6)
            ? asenddate[6]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualDuration: 0,
        delay: 0,
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight.asMap().containsKey(6) ? weight[6] : 0.0,
      ),
      Employee(
        srNo: 'A10',
        activity: 'Bus Depot work Completed & Handover to TML',
        originalDuration: 1,
        startDate: startdate.asMap().containsKey(7)
            ? startdate[7]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        endDate: enddate.asMap().containsKey(7)
            ? enddate[7]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualstartDate: asstartdate.asMap().containsKey(7)
            ? asstartdate[7]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualendDate: asenddate.asMap().containsKey(7)
            ? asenddate[7]
            : DateFormat('dd-MM-yyyy').format(DateTime(01 - 12 - 2022)),
        actualDuration: 0,
        delay: 0,
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight.asMap().containsKey(7) ? weight[7] : 0.0,
      ),
    ];
  }

  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance
  //         .collection('${widget.depoName}A2')
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       final DocumentSnapshot = snapshot.data!.docs[0];
  //       alldata = DocumentSnapshot['data'] as List<dynamic>;
  //       if (snapshot.hasData) {
  //         return alldata.forEach((element) {
  //           _employees.add(Employee.fromJson(element));
  //           for (int i = 0; i < alldata.length; i++) {
  //             double allWeightage = DocumentSnapshot['data'][i]['Weightage'];
  //             totalweightage = totalweightage + allWeightage;
  //             startdate = DocumentSnapshot['data'][0]['StartDate'];
  //             enddate = DocumentSnapshot['data'][alldata.length - 1]['EndDate'];
  //             actualstartdate = DocumentSnapshot['data'][0]['ActualStart'];
  //             actualenddate =
  //                 DocumentSnapshot['data'][alldata.length - 1]['ActualEnd'];
  //           }
  //         });
  //       } else {
  //         return LoadingPage();
  //       }
  //     },
  //   );
  // }

}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final String x;
  final double y;
  final Color y1;
}
