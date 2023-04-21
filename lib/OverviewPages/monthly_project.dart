import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/OverviewPages/summary.dart';
import '../datasource/monthlyproject_datasource.dart';
import '../model/monthly_projectModel.dart';
import '../components/loading_page.dart';
import '../style.dart';
import '../widgets/custom_appbar.dart';

class MonthlyProject extends StatefulWidget {
  String? userid;
  String? cityName;
  String? depoName;
  MonthlyProject(
      {super.key,
      required this.userid,
      required this.cityName,
      required this.depoName});

  @override
  State<MonthlyProject> createState() => _MonthlyProjectState();
}

class _MonthlyProjectState extends State<MonthlyProject> {
  List<MonthlyProjectModel> monthlyProject = <MonthlyProjectModel>[];
  late MonthlyDataSource monthlyDataSource;
  late DataGridController _dataGridController;
  List<dynamic> tabledata2 = [];
  Stream? _stream;
  var alldata;
  bool _isloading = true;
  @override
  void initState() {
    // getmonthlyReport();
    // monthlyProject = getmonthlyReport();
    // monthlyDataSource = MonthlyDataSource(monthlyProject, context);
    // _dataGridController = DataGridController();
    // TODO: implement initState
    _stream = FirebaseFirestore.instance
        .collection('MonthlyProjectReport')
        .doc('${widget.depoName}')
        .collection(widget.userid!)
        .doc(DateFormat.yMMM().format(DateTime.now()))
        .snapshots();
    _isloading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: CustomAppBar(
            text: ' ${widget.cityName}/ ${widget.depoName} / Monthly Report',
            userid: widget.userid,
            haveSummary: true,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewSummary(
                      userId: widget.userid,
                      depoName: widget.depoName,
                      cityName: widget.cityName,
                      id: 'Monthly Report'),
                )),
            haveSynced: true,
            store: () {
              storeData();
            },
          ),
          preferredSize: const Size.fromHeight(50)),
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingPage();
            } else if (!snapshot.hasData || snapshot.data.exists == false) {
              monthlyProject = getmonthlyReport();
              monthlyDataSource = MonthlyDataSource(monthlyProject, context);
              _dataGridController = DataGridController();
              return Column(
                children: [
                  Expanded(
                      child: SfDataGridTheme(
                    data: SfDataGridThemeData(headerColor: blue),
                    child: SfDataGrid(
                        source: monthlyDataSource,
                        allowEditing: true,
                        frozenColumnsCount: 2,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        selectionMode: SelectionMode.single,
                        navigationMode: GridNavigationMode.cell,
                        columnWidthMode: ColumnWidthMode.auto,
                        editingGestureType: EditingGestureType.tap,
                        controller: _dataGridController,
                        columns: [
                          GridColumn(
                            columnName: 'ActivityNo',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: false,
                            width: 160,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Activities SI. No as per Gant Chart',
                                  overflow: TextOverflow.values.first,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)
                                  //    textAlign: TextAlign.center,
                                  ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'ActivityDetails',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: false,
                            width: 240,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Activities Details',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.values.first,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)),
                            ),
                          ),
                          // GridColumn(
                          //   columnName: 'Duration',
                          //   autoFitPadding:
                          //       const EdgeInsets.symmetric(horizontal: 16),
                          //   allowEditing: false,
                          //   width: 120,
                          //   label: Container(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 8.0),
                          //     alignment: Alignment.center,
                          //     child: Text('Duration in Days',
                          //         textAlign: TextAlign.center,
                          //         overflow: TextOverflow.values.first,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16,
                          //             color: white)
                          //         //    textAlign: TextAlign.center,
                          //         ),
                          //   ),
                          // ),
                          // GridColumn(
                          //   columnName: 'StartDate',
                          //   autoFitPadding:
                          //       const EdgeInsets.symmetric(horizontal: 16),
                          //   allowEditing: false,
                          //   width: 160,
                          //   label: Container(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 8.0),
                          //     alignment: Alignment.center,
                          //     child: Text('Start Date',
                          //         overflow: TextOverflow.values.first,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16,
                          //             color: white)
                          //         //    textAlign: TextAlign.center,
                          //         ),
                          //   ),
                          // ),
                          // GridColumn(
                          //   columnName: 'EndDate',
                          //   autoFitPadding:
                          //       const EdgeInsets.symmetric(horizontal: 16),
                          //   allowEditing: false,
                          //   width: 120,
                          //   label: Container(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 8.0),
                          //     alignment: Alignment.center,
                          //     child: Text('End Date',
                          //         overflow: TextOverflow.values.first,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16,
                          //             color: white)
                          //         //    textAlign: TextAlign.center,
                          //         ),
                          //   ),
                          // ),
                          GridColumn(
                            columnName: 'Progress',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: true,
                            width: 250,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Progress',
                                  overflow: TextOverflow.values.first,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)
                                  //    textAlign: TextAlign.center,
                                  ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'Status',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: true,
                            width: 250,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Status',
                                  overflow: TextOverflow.values.first,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)
                                  //    textAlign: TextAlign.center,
                                  ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'Action',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: true,
                            width: 250,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Next Month Action Plan',
                                  overflow: TextOverflow.values.first,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)
                                  //    textAlign: TextAlign.center,
                                  ),
                            ),
                          ),
                        ]),
                  )),
                ],
              );
            } else {
              alldata = snapshot.data['data'] as List<dynamic>;
              monthlyProject.clear();
              alldata.forEach((element) {
                monthlyProject.add(MonthlyProjectModel.fromjson(element));
                monthlyDataSource = MonthlyDataSource(monthlyProject, context);
                _dataGridController = DataGridController();
              });
              return Column(
                children: [
                  Expanded(
                      child: SfDataGridTheme(
                    data: SfDataGridThemeData(headerColor: blue),
                    child: SfDataGrid(
                        source: monthlyDataSource,
                        allowEditing: true,
                        frozenColumnsCount: 2,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        selectionMode: SelectionMode.single,
                        navigationMode: GridNavigationMode.cell,
                        columnWidthMode: ColumnWidthMode.auto,
                        editingGestureType: EditingGestureType.tap,
                        controller: _dataGridController,
                        columns: [
                          GridColumn(
                            columnName: 'ActivityNo',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: false,
                            width: 160,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Activities SI. No as per Gant Chart',
                                  overflow: TextOverflow.values.first,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)
                                  //    textAlign: TextAlign.center,
                                  ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'ActivityDetails',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: false,
                            width: 240,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Activities Details',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.values.first,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)),
                            ),
                          ),
                          // GridColumn(
                          //   columnName: 'Duration',
                          //   autoFitPadding:
                          //       const EdgeInsets.symmetric(horizontal: 16),
                          //   allowEditing: false,
                          //   width: 120,
                          //   label: Container(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 8.0),
                          //     alignment: Alignment.center,
                          //     child: Text('Duration in Days',
                          //         textAlign: TextAlign.center,
                          //         overflow: TextOverflow.values.first,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16,
                          //             color: white)
                          //         //    textAlign: TextAlign.center,
                          //         ),
                          //   ),
                          // ),
                          // GridColumn(
                          //   columnName: 'StartDate',
                          //   autoFitPadding:
                          //       const EdgeInsets.symmetric(horizontal: 16),
                          //   allowEditing: false,
                          //   width: 160,
                          //   label: Container(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 8.0),
                          //     alignment: Alignment.center,
                          //     child: Text('Start Date',
                          //         overflow: TextOverflow.values.first,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16,
                          //             color: white)
                          //         //    textAlign: TextAlign.center,
                          //         ),
                          //   ),
                          // ),
                          // GridColumn(
                          //   columnName: 'EndDate',
                          //   autoFitPadding:
                          //       const EdgeInsets.symmetric(horizontal: 16),
                          //   allowEditing: false,
                          //   width: 120,
                          //   label: Container(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 8.0),
                          //     alignment: Alignment.center,
                          //     child: Text('End Date',
                          //         overflow: TextOverflow.values.first,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16,
                          //             color: white)
                          //         //    textAlign: TextAlign.center,
                          //         ),
                          //   ),
                          // ),
                          GridColumn(
                            columnName: 'Progress',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: true,
                            width: 250,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Progress',
                                  overflow: TextOverflow.values.first,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)
                                  //    textAlign: TextAlign.center,
                                  ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'Status',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: true,
                            width: 250,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Status',
                                  overflow: TextOverflow.values.first,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)
                                  //    textAlign: TextAlign.center,
                                  ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'Action',
                            autoFitPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            allowEditing: true,
                            width: 250,
                            label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.center,
                              child: Text('Next Month Action Plan',
                                  overflow: TextOverflow.values.first,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white)
                                  //    textAlign: TextAlign.center,
                                  ),
                            ),
                          ),
                        ]),
                  )),
                ],
              );
            }
          }),
    );
  }

  void storeData() {
    Map<String, dynamic> table_data = Map();
    for (var i in monthlyDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button') {
          table_data[data.columnName] = data.value;
        }
      }

      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection('MonthlyProjectReport')
        .doc('${widget.depoName}')
        .collection(widget.userid!)
        .doc(DateFormat.yMMM().format(DateTime.now()))
        .set({
      'data': tabledata2,
    }).whenComplete(() {
      tabledata2.clear();
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Data are synced'),
        backgroundColor: blue,
      ));
    });
  }

  List<MonthlyProjectModel> getmonthlyReport() {
    return [
      MonthlyProjectModel(
          activityNo: 'A1',
          activityDetails: 'Letter of Award From TML',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
      MonthlyProjectModel(
          activityNo: 'A2',
          activityDetails:
              'Site Survey, Job scope finalization  and Proposed layout submission',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
      MonthlyProjectModel(
          activityNo: 'A3',
          activityDetails:
              'Detailed Engineering for Approval of  Civil & Electrical  Layout, GA Drawing from TML',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
      MonthlyProjectModel(
          activityNo: 'A4',
          activityDetails: 'Site Mobalization activity Completed',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
      MonthlyProjectModel(
          activityNo: 'A5',
          activityDetails: 'Approval of statutory clearances of BUS Depot',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
      MonthlyProjectModel(
          activityNo: 'A6',
          activityDetails: 'Procurement of Order Finalisation Completed',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
      MonthlyProjectModel(
          activityNo: 'A7',
          activityDetails: 'Receipt of all Materials at Site',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
      MonthlyProjectModel(
          activityNo: 'A8',
          activityDetails: 'Civil Infra Development completed at Bus Depot',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
      MonthlyProjectModel(
          activityNo: 'A9',
          activityDetails:
              'Electrical Infra Development completed at Bus Depot',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
      MonthlyProjectModel(
          activityNo: 'A10',
          activityDetails: 'Bus Depot work Completed & Handover to TML',
          // duration: 1,
          // startDate: DateFormat().add_yMd().format(DateTime.now()),
          // endDate: DateFormat().add_yMd().format(DateTime.now()),
          progress: '',
          status: '',
          action: ''),
    ];
  }
}
