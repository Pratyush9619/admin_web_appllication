import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/KeyEvents/Grid_DataTable51.dart';
import 'package:web_appllication/KeyEvents/Grid_DataTableA10.dart';
import 'package:web_appllication/KeyEvents/Grid_DataTableA3.dart';
import 'package:web_appllication/KeyEvents/Grid_DataTableA4.dart';
import 'package:web_appllication/KeyEvents/Grid_DataTableA6.dart';
import 'package:web_appllication/KeyEvents/Grid_DataTableA8.dart';
import 'package:web_appllication/KeyEvents/Grid_DataTableA9.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';
import 'package:web_appllication/model/employee.dart';
import 'package:web_appllication/KeyEvents/upload.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/provider/key_provider.dart';
import 'package:web_appllication/style.dart';
import '../widgets/custom_appbar.dart';
import 'Grid_DataTableA2.dart';
import 'Grid_DataTableA7.dart';
import '../datasource/key_datasource.dart';

/// The application that contains datagrid on it.

/// The home page of the application which hosts the datagrid.
class KeyEvents extends StatefulWidget {
  /// Creates the home page.
  String? userId;
  String? depoName;
  String? cityName;
  KeyEvents({Key? key, this.userId, this.depoName, this.cityName})
      : super(key: key);

  @override
  _KeyEventsState createState() => _KeyEventsState();
}

class _KeyEventsState extends State<KeyEvents> {
  late KeyDataSourceKeyEvents _keyDataSourceKeyEvents;
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
  bool _isLoading = true;
  bool _isInit = true;
  int? length;
  String? sdate2,
      sdate3,
      sdate4,
      sdate5,
      sdate6,
      sdate7,
      sdate8,
      sdate9,
      sdate10;
  String? edate2,
      edate3,
      edate4,
      edate5,
      edate6,
      edate7,
      edate8,
      edate9,
      edate10;
  String? asdate2,
      asdate3,
      asdate4,
      asdate5,
      asdate6,
      asdate7,
      asdate8,
      asdate9,
      asdate10;
  String? aedate2,
      aedate3,
      aedate4,
      aedate5,
      aedate6,
      aedate7,
      aedate8,
      aedate9,
      aedate10;

  List<double> weight2 = [];
  List<double> weight3 = [];
  List<double> weight4 = [];
  List<double> weight5 = [];
  List<double> weight6 = [];
  List<double> weight7 = [];
  List<double> weight8 = [];
  List<double> weight9 = [];
  List<double> weight10 = [];

  String? startdate2,
      enddate2,
      asstartdate2,
      asenddate2,
      actualstartdate2,
      actualenddate2;
  String? startdate3,
      enddate3,
      asstartdate3,
      asenddate3,
      actualstartdate3,
      actualenddate3;
  String? startdate4,
      enddate4,
      asstartdate4,
      asenddate4,
      actualstartdate4,
      actualenddate4;
  String? startdate5,
      enddate5,
      asstartdate5,
      asenddate5,
      actualstartdate5,
      actualenddate5;
  String? startdate6,
      enddate6,
      asstartdate6,
      asenddate6,
      actualstartdate6,
      actualenddate6;
  String? startdate7,
      enddate7,
      asstartdate7,
      asenddate7,
      actualstartdate7,
      actualenddate7;
  String? startdate8,
      enddate8,
      asstartdate8,
      asenddate8,
      actualstartdate8,
      actualenddate8;
  String? startdate9,
      enddate9,
      asstartdate9,
      asenddate9,
      actualstartdate9,
      actualenddate9;

  @override
  void initState() {
    yourstream = FirebaseFirestore.instance
        .collection('KeyEventsTable')
        .doc(widget.depoName!)
        .collection(widget.userId!)
        // .doc('${widget.depoName}')
        .snapshots();

    _isLoading = false;
    setState(() {});
    super.initState();
  }

  List<Widget> menuwidget = [];

  @override
  Widget build(BuildContext context) {
    menuwidget = [
      UploadDocument(
        title: '',
        activity: '',
        userId: userId,
        depoName: widget.depoName,
      ),
      StatutoryAprovalA2(
        userid: widget.userId,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA3(
        userid: widget.userId,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA4(
        userid: widget.userId,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAproval(
        userid: widget.userId,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA6(
        userid: widget.userId,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA7(
        userid: widget.depoName,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA8(
        userid: widget.userId,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA9(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      StatutoryAprovalA10(
        userid: widget.userId,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
    ];

    return _isLoading
        ? LoadingPage()
        : Scaffold(
            appBar: PreferredSize(
                // ignore: sort_child_properties_last
                child: CustomAppBar(
                  text: 'Overview - ${widget.cityName} - ${widget.depoName}',
                  userid: widget.userId,
                ),
                preferredSize: const Size.fromHeight(50)),
            // AppBar(
            //   title:
            //       Text('Key Events - ${widget.cityName} - ${widget.depoName}'),
            //   backgroundColor: blue,
            // ),
            body: StreamBuilder(
                stream: yourstream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length != 0) {
                      int length = snapshot.data.docs.length;
                      startdate.clear();
                      enddate.clear();
                      asstartdate.clear();
                      asenddate.clear();
                      weight.clear();
                      for (int i = 0; i < length; i++) {
                        for (int j = 0; j < length; j++) {
                          if (snapshot.data.docs[j].reference.id.toString() ==
                              '${widget.depoName}A10') {
                            var alldataA10 =
                                snapshot.data.docs[j]['data'] as List<dynamic>;
                            sdate10 = alldataA10[0]['StartDate'];
                            edate10 =
                                alldataA10[alldataA10.length - 1]['EndDate'];
                            asdate10 = alldataA10[0]['ActualStart'];
                            aedate10 =
                                alldataA10[alldataA10.length - 1]['ActualEnd'];

                            for (int i = 0; i < alldataA10.length; i++) {
                              var weightage = alldataA10[i]['Weightage'];
                              totalweightage = totalweightage + weightage;
                            }
                            weight10.add(totalweightage);
                          }
                        }

                        for (int j = 0; j < length; j++) {
                          if (snapshot.data.docs[j].reference.id.toString() ==
                              '${widget.depoName}A2') {
                            var alldataA2 =
                                snapshot.data.docs[j]['data'] as List<dynamic>;
                            sdate2 = alldataA2[0]['StartDate'];
                            edate2 = alldataA2[alldataA2.length - 1]['EndDate'];
                            asdate2 = alldataA2[0]['ActualStart'];
                            aedate2 =
                                alldataA2[alldataA2.length - 1]['ActualEnd'];

                            for (int i = 0; i < alldataA2.length; i++) {
                              var weightage = alldataA2[i]['Weightage'];
                              totalweightage = totalweightage + weightage;
                            }
                            weight2.add(totalweightage);
                          }
                        }

                        for (int j = 0; j < length; j++) {
                          if (snapshot.data.docs[j].reference.id.toString() ==
                              '${widget.depoName}A3') {
                            var alldataA3 =
                                snapshot.data.docs[j]['data'] as List<dynamic>;
                            sdate3 = alldataA3[0]['StartDate'];
                            edate3 = alldataA3[alldataA3.length - 1]['EndDate'];
                            asdate3 = alldataA3[0]['ActualStart'];
                            aedate3 =
                                alldataA3[alldataA3.length - 1]['ActualEnd'];

                            for (int i = 0; i < alldataA3.length; i++) {
                              var weightage = alldataA3[i]['Weightage'];
                              totalweightage = totalweightage + weightage;
                            }
                            weight3.add(totalweightage);
                          }
                        }

                        for (int j = 0; j < length; j++) {
                          if (snapshot.data.docs[j].reference.id.toString() ==
                              '${widget.depoName}A4') {
                            var alldataA4 =
                                snapshot.data.docs[j]['data'] as List<dynamic>;
                            sdate4 = alldataA4[0]['StartDate'];
                            edate4 = alldataA4[alldataA4.length - 1]['EndDate'];
                            asdate4 = alldataA4[0]['ActualStart'];
                            aedate4 =
                                alldataA4[alldataA4.length - 1]['ActualEnd'];

                            for (int i = 0; i < alldataA4.length; i++) {
                              var weightage = alldataA4[i]['Weightage'];
                              totalweightage = totalweightage + weightage;
                            }
                            weight4.add(totalweightage);
                          }
                        }

                        for (int j = 0; j < length; j++) {
                          if (snapshot.data.docs[j].reference.id.toString() ==
                              '${widget.depoName}A5') {
                            var alldataA5 =
                                snapshot.data.docs[4]['data'] as List<dynamic>;
                            sdate5 = alldataA5[0]['StartDate'];
                            edate5 = alldataA5[alldataA5.length - 1]['EndDate'];
                            asdate5 = alldataA5[0]['ActualStart'];
                            aedate5 =
                                alldataA5[alldataA5.length - 1]['ActualEnd'];

                            for (int i = 0; i < alldataA5.length; i++) {
                              var weightage = alldataA5[i]['Weightage'];
                              totalweightage = totalweightage + weightage;
                            }
                            weight5.add(totalweightage);
                          }
                        }

                        for (int j = 0; j < length; j++) {
                          if (snapshot.data.docs[j].reference.id.toString() ==
                              '${widget.depoName}A6') {
                            var alldataA6 =
                                snapshot.data.docs[j]['data'] as List<dynamic>;
                            sdate6 = alldataA6[0]['StartDate'];
                            edate6 = alldataA6[alldataA6.length - 1]['EndDate'];
                            asdate6 = alldataA6[0]['ActualStart'];
                            aedate6 =
                                alldataA6[alldataA6.length - 1]['ActualEnd'];

                            for (int i = 0; i < alldataA6.length; i++) {
                              var weightage = alldataA6[i]['Weightage'];
                              totalweightage = totalweightage + weightage;
                            }
                            weight6.add(totalweightage);
                          }
                        }

                        for (int j = 0; j < length; j++) {
                          if (snapshot.data.docs[j].reference.id.toString() ==
                              '${widget.depoName}A7') {
                            var alldataA7 =
                                snapshot.data.docs[j]['data'] as List<dynamic>;
                            sdate7 = alldataA7[0]['StartDate'];
                            edate7 = alldataA7[alldataA7.length - 1]['EndDate'];
                            asdate7 = alldataA7[0]['ActualStart'];
                            aedate7 =
                                alldataA7[alldataA7.length - 1]['ActualEnd'];

                            for (int i = 0; i < alldataA7.length; i++) {
                              var weightage = alldataA7[i]['Weightage'];
                              totalweightage = totalweightage + weightage;
                            }
                            weight7.add(totalweightage);
                          }
                        }

                        for (int j = 0; j < length; j++) {
                          if (snapshot.data.docs[j].reference.id.toString() ==
                              '${widget.depoName}A8') {
                            var alldataA8 =
                                snapshot.data.docs[j]['data'] as List<dynamic>;
                            sdate8 = alldataA8[0]['StartDate'];
                            edate8 = alldataA8[alldataA8.length - 1]['EndDate'];
                            asdate8 = alldataA8[0]['ActualStart'];
                            aedate8 =
                                alldataA8[alldataA8.length - 1]['ActualEnd'];

                            for (int i = 0; i < alldataA8.length; i++) {
                              var weightage = alldataA8[i]['Weightage'];
                              totalweightage = totalweightage + weightage;
                            }
                            weight8.add(totalweightage);
                          }
                        }

                        for (int j = 0; j < length; j++) {
                          if (snapshot.data.docs[j].reference.id.toString() ==
                              '${widget.depoName}A9') {
                            var alldataA9 =
                                snapshot.data.docs[j]['data'] as List<dynamic>;
                            sdate9 = alldataA9[0]['StartDate'];
                            edate9 = alldataA9[alldataA9.length - 1]['EndDate'];
                            asdate9 = alldataA9[0]['ActualStart'];
                            aedate9 =
                                alldataA9[alldataA9.length - 1]['ActualEnd'];

                            for (int i = 0; i < alldataA9.length; i++) {
                              var weightage = alldataA9[i]['Weightage'];
                              totalweightage = totalweightage + weightage;
                            }
                          }
                          weight9.add(totalweightage);
                        }
                      }
                      // }
                      // if (i == 4) {
                      //   var alldataA5 =
                      //       snapshot.data.docs[i]['data'] as List<dynamic>;
                      //   sdate = alldataA5[0]['StartDate'];
                      //   edate = alldataA5[alldataA5.length - 1]['EndDate'];
                      //   asdate = alldataA5[0]['ActualStart'];
                      //   aedate = alldataA5[alldataA5.length - 1]['ActualEnd'];
                      //   startdate.add(sdate!);
                      //   enddate.add(edate!);
                      //   asstartdate.add(asdate!);
                      //   asenddate.add(aedate!);
                      //   print('Start$startdate');
                      //   print('Start$enddate');
                      //   for (int i = 0; i < alldataA5.length; i++) {
                      //     var weightage = alldataA5[i]['Weightage'];
                      //     totalweightage = totalweightage + weightage;
                      //   }
                      //   weight.add(totalweightage);
                      // } else {
                      //   alldata =
                      //       snapshot.data.docs[i]['data'] as List<dynamic>;
                      //   sdate = alldata[0]['StartDate'];
                      //   edate = alldata[alldata.length - 1]['EndDate'];
                      //   asdate = alldata[0]['ActualStart'];
                      //   aedate = alldata[alldata.length - 1]['ActualEnd'];
                      //   startdate.add(sdate!);
                      //   enddate.add(edate!);
                      //   asstartdate.add(asdate!);
                      //   asenddate.add(aedate!);
                      //   print('Start$startdate');
                      //   print('End$enddate');

                      // for (int i = 0; i < alldata.length; i++) {
                      //   var weightage = alldata[i]['Weightage'];
                      //   totalweightage = totalweightage + weightage;
                      // }

                      // weight.add(totalweightage);
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

                      _employees = getEmployeeData();
                      _keyDataSourceKeyEvents =
                          KeyDataSourceKeyEvents(_employees, context);
                      _dataGridController = DataGridController();

                      return Container(
                          height: 580,
                          child: Row(children: [
                            Expanded(
                              child: SfDataGrid(
                                source: _keyDataSourceKeyEvents,
                                onCellTap: (DataGridCellTapDetails details) {
                                  final DataGridRow row =
                                      _keyDataSourceKeyEvents.effectiveRows[
                                          details.rowColumnIndex.rowIndex - 1];

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => menuwidget[
                                          details.rowColumnIndex.rowIndex -
                                              1]));
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
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
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
                                    columnName: 'Dependency',
                                    allowEditing: false,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Dependency',
                                        overflow: TextOverflow.values.first,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  // GridColumn(
                                  //   columnName: 'QtyScope',
                                  //   allowEditing: false,
                                  //   label: Container(
                                  //     alignment: Alignment.center,
                                  //     child: Text(
                                  //       'Oty as per scope',
                                  //       overflow: TextOverflow.values.first,
                                  //       style: const TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 16),
                                  //     ),
                                  //   ),
                                  // ),
                                  // GridColumn(
                                  //   columnName: 'QtyExecuted',
                                  //   allowEditing: false,
                                  //   label: Container(
                                  //     alignment: Alignment.center,
                                  //     child: Text(
                                  //       'Qty executed',
                                  //       overflow: TextOverflow.values.first,
                                  //       style: const TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 16),
                                  //     ),
                                  //   ),
                                  // ),
                                  // GridColumn(
                                  //   columnName: 'BalancedQty',
                                  //   allowEditing: false,
                                  //   label: Container(
                                  //     width: 150,
                                  //     alignment: Alignment.center,
                                  //     child: Text(
                                  //       'Balanced Qty',
                                  //       overflow: TextOverflow.values.first,
                                  //       style: const TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 16),
                                  //     ),
                                  //   ),
                                  // ),
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
                                          dataSource: chartData2,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          pointColorMapper:
                                              (ChartData data, _) => data.y1),

                                      BarSeries<ChartData, String>(
                                          dataSource: chartData,
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true),
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          pointColorMapper:
                                              (ChartData data, _) => data.y1)
                                    ]))
                          ]));
                    }
                  } else {
                    return LoadingPage();
                  }

                  _employees = getDefaultEmployeeData();
                  _keyDataSourceKeyEvents =
                      KeyDataSourceKeyEvents(_employees, context);
                  _dataGridController = DataGridController();

                  return Container(
                      height: 580,
                      child: Row(children: [
                        Expanded(
                          child: SfDataGrid(
                            source: _keyDataSourceKeyEvents,
                            onCellTap: (DataGridCellTapDetails details) {
                              final DataGridRow row =
                                  _keyDataSourceKeyEvents.effectiveRows[
                                      details.rowColumnIndex.rowIndex - 1];

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => menuwidget[
                                      details.rowColumnIndex.rowIndex - 1]));
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
                                columnName: 'Dependency',
                                allowEditing: false,
                                label: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Dependency',
                                    overflow: TextOverflow.values.first,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              // GridColumn(
                              //   columnName: 'QtyScope',
                              //   allowEditing: false,
                              //   label: Container(
                              //     alignment: Alignment.center,
                              //     child: Text(
                              //       'Oty as per scope',
                              //       overflow: TextOverflow.values.first,
                              //       style: const TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 16),
                              //     ),
                              //   ),
                              // ),
                              // GridColumn(
                              //   columnName: 'QtyExecuted',
                              //   allowEditing: false,
                              //   label: Container(
                              //     alignment: Alignment.center,
                              //     child: Text(
                              //       'Qty executed',
                              //       overflow: TextOverflow.values.first,
                              //       style: const TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 16),
                              //     ),
                              //   ),
                              // ),
                              // GridColumn(
                              //   columnName: 'BalancedQty',
                              //   allowEditing: false,
                              //   label: Container(
                              //     width: 150,
                              //     alignment: Alignment.center,
                              //     child: Text(
                              //       'Balanced Qty',
                              //       overflow: TextOverflow.values.first,
                              //       style: const TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 16),
                              //     ),
                              //   ),
                              // ),
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
                        )
                      ]));
                })); //  _isLoading

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
          reasonDelay: '',
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
          reasonDelay: '',
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
          reasonDelay: '',
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
          reasonDelay: '',
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
          reasonDelay: '',
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
          reasonDelay: '',
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
          reasonDelay: '',
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
          reasonDelay: '',
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
          reasonDelay: '',
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
        reasonDelay: '',
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: 0,
      ),
    ];
  }

  int durationParse(String fromtime, String todate) {
    DateTime startdate = DateFormat('dd-MM-yyyy').parse(fromtime);
    DateTime enddate = DateFormat('dd-MM-yyyy').parse(todate);
    return enddate.difference(startdate).inDays;
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
          srNo: 'A1',
          activity: 'Letter of Award reveived  from TML',
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
          percProgress: 100,
          weightage: 10),
      Employee(
          srNo: 'A2',
          activity:
              'Site Survey, Job scope finalization  and Proposed layout submission',
          originalDuration: durationParse(
              sdate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
              edate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
          startDate: sdate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
          endDate: edate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualstartDate:
              asdate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualendDate:
              aedate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
          actualDuration: durationParse(
              asdate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
              aedate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
          delay: durationParse(
              edate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
              aedate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
          reasonDelay: '',
          unit: 0,
          scope: 0,
          qtyExecuted: 0,
          balanceQty: 0,
          percProgress: 0,
          weightage: weight2.isNotEmpty
              ? double.parse(weight2[0].toStringAsFixed(4))
              : 0.0),
      Employee(
        srNo: 'A3',
        activity:
            'Detailed Engineering for Approval of  Civil & Electrical  Layout, GA Drawing from TML',
        originalDuration: durationParse(
            sdate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            edate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        startDate: sdate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        endDate: edate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualstartDate:
            asdate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualendDate:
            aedate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualDuration: durationParse(
            asdate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        delay: durationParse(
            edate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate3 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        reasonDelay: '',
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight3.isNotEmpty
            ? double.parse(weight3[0].toStringAsFixed(4))
            : 0.0,
      ),
      Employee(
        srNo: 'A4',
        activity: 'Site Mobalization activity Completed',
        originalDuration: durationParse(
            sdate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            edate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        startDate: sdate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        endDate: edate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualstartDate:
            asdate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualendDate:
            aedate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualDuration: durationParse(
            asdate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        delay: durationParse(
            edate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate4 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        reasonDelay: '',
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight4.isNotEmpty
            ? double.parse(weight4[0].toStringAsFixed(4))
            : 0.0,
      ),
      Employee(
        srNo: 'A5',
        activity: 'Approval of statutory clearances of BUS Depot',
        originalDuration: durationParse(
            sdate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            edate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        startDate: sdate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        endDate: edate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualstartDate:
            asdate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualendDate:
            aedate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualDuration: durationParse(
            asdate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        delay: durationParse(
            edate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate5 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        reasonDelay: '',
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight5.isNotEmpty
            ? double.parse(weight5[0].toStringAsFixed(4))
            : 0.0,
      ),
      Employee(
        srNo: 'A6',
        activity: 'Procurement of Order Finalisation Completed',
        originalDuration: durationParse(
            sdate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            edate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        startDate: sdate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        endDate: edate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualstartDate:
            asdate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualendDate:
            aedate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualDuration: durationParse(
            asdate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        delay: durationParse(
            edate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate6 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        reasonDelay: '',
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight6.isNotEmpty
            ? double.parse(weight6[0].toStringAsFixed(4))
            : 0.0,
      ),
      Employee(
        srNo: 'A7',
        activity: 'Receipt of all Materials at Site',
        originalDuration: durationParse(
            sdate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            edate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        startDate: sdate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        endDate: edate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualstartDate:
            asdate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualendDate:
            aedate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualDuration: durationParse(
            asdate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        delay: durationParse(
            edate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate7 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        reasonDelay: '',
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight7.isNotEmpty
            ? double.parse(weight7[0].toStringAsFixed(4))
            : 0.0,
      ),
      Employee(
        srNo: 'A8',
        activity: 'Civil Infra Development completed at Bus Depot',
        originalDuration: durationParse(
            sdate8 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            edate8 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        startDate: sdate8 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        endDate: edate8 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualstartDate:
            asdate8 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualendDate:
            aedate8 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualDuration: durationParse(
            asdate8 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate8 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        delay: 0,
        reasonDelay: '',
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight8.isNotEmpty
            ? double.parse(weight8[0].toStringAsFixed(4))
            : 0.0,
      ),
      Employee(
        srNo: 'A9',
        activity: 'Electrical Infra Development completed at Bus Depot',
        originalDuration: durationParse(
            sdate9 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            edate9 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        startDate: sdate9 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        endDate: edate9 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualstartDate:
            asdate9 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualendDate:
            aedate9 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualDuration: durationParse(
            asdate9 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate9 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        delay: durationParse(
            edate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate2 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        reasonDelay: '',
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight9.isNotEmpty
            ? double.parse(weight9[0].toStringAsFixed(4))
            : 0.0,
      ),
      Employee(
        srNo: 'A10',
        activity: 'Bus Depot work Completed & Handover to TML',
        originalDuration: durationParse(
            sdate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            edate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        startDate: sdate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        endDate: edate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualstartDate:
            asdate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualendDate:
            aedate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
        actualDuration: durationParse(
            asdate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        delay: durationParse(
            edate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now()),
            aedate10 ?? DateFormat('dd-MM-yyyy').format(DateTime.now())),
        reasonDelay: '',
        unit: 0,
        scope: 0,
        qtyExecuted: 0,
        balanceQty: 0,
        percProgress: 0,
        weightage: weight10.isNotEmpty
            ? double.parse(weight10[0].toStringAsFixed(4))
            : 0.0,
      ),
    ];
  }
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

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final String x;
  final double y;
  final Color y1;
}
