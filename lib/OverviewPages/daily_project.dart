import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:web_appllication/OverviewPages/summary.dart';
import 'package:web_appllication/widgets/nodata_available.dart';
import '../Authentication/auth_service.dart';
import '../datasource/dailyproject_datasource.dart';
import '../model/daily_projectModel.dart';
import '../components/loading_page.dart';
import '../style.dart';
import '../widgets/custom_appbar.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;

class DailyProject extends StatefulWidget {
  String? userId;
  String? cityName;
  String? depoName;
  DailyProject({
    super.key,
    this.userId,
    this.cityName,
    required this.depoName,
  });

  @override
  State<DailyProject> createState() => _DailyProjectState();
}

class _DailyProjectState extends State<DailyProject> {
  List<dynamic> dataForPdf = [];
  DateTime? startdate = DateTime.now();
  DateTime? enddate = DateTime.now();
  DateTime? rangestartDate;
  DateTime? rangeEndDate;
  List<DailyProjectModel> DailyProject = <DailyProjectModel>[];
  late DailyDataSource _dailyDataSource;
  late DataGridController _dataGridController;
  List<dynamic> tabledata2 = [];
  Stream? _stream;
  bool _isLoading = true;
  bool specificUser = true;
  QuerySnapshot? snap;
  dynamic companyId;
  dynamic alldata;
  List id = [];
  List<dynamic> chosenDateList = [];
  List<dynamic> availableUserId = [];

  @override
  void initState() {
    getUserId();
    identifyUser();
    // getmonthlyReport();
    // DailyProject = getmonthlyReport();
    _dailyDataSource = DailyDataSource(
        DailyProject, context, widget.cityName!, widget.depoName!);
    _dataGridController = DataGridController();

    // _stream = FirebaseFirestore.instance
    //     .collection('DailyProjectReport')
    //     .doc('${widget.depoName}')
    //     // .collection(widget.userId!)
    //     // .doc(DateFormat.yMMMMd().format(DateTime.now()))
    //     .snapshots();

    super.initState();
    getAllData();
  }

  getAllData() {
    DailyProject.clear();
    id.clear();
    getTableData().whenComplete(() {
      nestedTableData(id).whenComplete(() {
        _dailyDataSource = DailyDataSource(
            DailyProject, context, widget.cityName!, widget.depoName!);
        _dataGridController = DataGridController();
        _isLoading = false;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: CustomAppBar(
            showDepoBar: true,
            donwloadFun: _generatePDF,
            toDaily: true,
            depoName: widget.depoName,
            cityName: widget.cityName,
            text: ' ${widget.cityName}/ ${widget.depoName} / Daily Report',
            userId: widget.userId,
            haveSynced: false,
            //specificUser ? true : false,
            isdownload: true,
            haveSummary: false,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewSummary(
                    cityName: widget.cityName.toString(),
                    depoName: widget.depoName.toString(),
                    id: 'Daily Report',
                    userId: widget.userId,
                  ),
                )),
            store: () {
              storeData();
            },
          ),
          preferredSize: const Size.fromHeight(50)),
      body: _isLoading
          ? LoadingPage()
          : Column(children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 250,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: blue)),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('choose Date'),
                                            content: SizedBox(
                                              width: 400,
                                              height: 500,
                                              child: SfDateRangePicker(
                                                view: DateRangePickerView.year,
                                                showTodayButton: false,
                                                showActionButtons: true,
                                                selectionMode:
                                                    DateRangePickerSelectionMode
                                                        .range,
                                                onSelectionChanged:
                                                    (DateRangePickerSelectionChangedArgs
                                                        args) {
                                                  if (args.value
                                                      is PickerDateRange) {
                                                    rangestartDate =
                                                        args.value.startDate;
                                                    rangeEndDate =
                                                        args.value.endDate;
                                                  }
                                                },
                                                onSubmit: (value) {
                                                  setState(() {
                                                    startdate = DateTime.parse(
                                                        rangestartDate
                                                            .toString());
                                                    enddate = DateTime.parse(
                                                        rangeEndDate
                                                            .toString());
                                                  });

                                                  getAllData();
                                                  Navigator.pop(context);
                                                },
                                                onCancel: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.today)),
                                  Text(
                                    DateFormat.yMMMMd().format(startdate!),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 250,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: blue)),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    DateFormat.yMMMMd().format(enddate!),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingPage();
                  } else if (!snapshot.hasData ||
                      snapshot.data.exists == false) {
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: SfDataGridTheme(
                            data: SfDataGridThemeData(headerColor: blue),
                            child: SfDataGrid(
                                source: _dailyDataSource,
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
                                columns: [
                                  GridColumn(
                                    columnName: 'Date',
                                    visible: true,
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    allowEditing: true,
                                    width: 150,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('Date',
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
                                    columnName: 'SiNo',
                                    visible: false,
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    allowEditing: true,
                                    width: 70,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('SI No.',
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
                                  // GridColumn(
                                  //   columnName: 'Date',
                                  //   autoFitPadding:
                                  //       const EdgeInsets.symmetric(
                                  //           horizontal: 16),
                                  //   allowEditing: false,
                                  //   width: 160,
                                  //   label: Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 8.0),
                                  //     alignment: Alignment.center,
                                  //     child: Text(' ,
                                  //         textAlign: TextAlign.center,
                                  //         overflow: TextOverflow.values.first,
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 16,
                                  //             color: white)),
                                  //   ),
                                  // ),
                                  // GridColumn(
                                  //   visible: false,
                                  //   columnName: 'State',
                                  //   autoFitPadding:
                                  //       const EdgeInsets.symmetric(horizontal: 16),
                                  //   allowEditing: true,
                                  //   width: 120,
                                  //   label: Container(
                                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  //     alignment: Alignment.center,
                                  //     child: Text('State',
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
                                  //   visible: false,
                                  //   columnName: 'DepotName',
                                  //   autoFitPadding:
                                  //       const EdgeInsets.symmetric(horizontal: 16),
                                  //   allowEditing: true,
                                  //   width: 150,
                                  //   label: Container(
                                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  //     alignment: Alignment.center,
                                  //     child: Text('Depot Name',
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
                                    columnName: 'TypeOfActivity',
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    allowEditing: true,
                                    width: 200,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('Type of Activity',
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
                                    columnName: 'ActivityDetails',
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    allowEditing: true,
                                    width: 220,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('Activity Details',
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
                                    columnName: 'Progress',
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    allowEditing: true,
                                    // width: 320,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
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
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    allowEditing: true,
                                    width: 320,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('Remark / Status',
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
                                    columnName: 'View',
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    allowEditing: false,
                                    width: 140,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('View Image',
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
                          ),
                        ),
                      ],
                    );
                  } else {
                    // alldata = '';
                    // alldata = snapshot.data['data'] as List<dynamic>;
                    // DailyProject.clear();
                    // alldata.forEach((element) {
                    //   DailyProject.add(DailyProjectModel.fromjson(element));
                    //   _dailyDataSource = DailyDataSource(
                    //       DailyProject, context, widget.depoName!);
                    //   _dataGridController = DataGridController();
                    // });
                    return const NodataAvailable();
                    // return Expanded(
                    //   child: Column(
                    //     children: [
                    //       SfDataGridTheme(
                    //         data: SfDataGridThemeData(headerColor: blue),
                    //         child: SfDataGrid(
                    //             source: _dailyDataSource,
                    //             allowEditing: true,
                    //             frozenColumnsCount: 2,
                    //             gridLinesVisibility: GridLinesVisibility.both,
                    //             headerGridLinesVisibility:
                    //                 GridLinesVisibility.both,
                    //             selectionMode: SelectionMode.single,
                    //             navigationMode: GridNavigationMode.cell,
                    //             columnWidthMode: ColumnWidthMode.auto,
                    //             editingGestureType: EditingGestureType.tap,
                    //             controller: _dataGridController,
                    //             columns: [
                    //               GridColumn(
                    //                 columnName: 'SiNo',
                    //                 autoFitPadding:
                    //                     const EdgeInsets.symmetric(
                    //                         horizontal: 16),
                    //                 allowEditing: true,
                    //                 width: 70,
                    //                 label: Container(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 8.0),
                    //                   alignment: Alignment.center,
                    //                   child: Text('SI No.',
                    //                       overflow: TextOverflow.values.first,
                    //                       textAlign: TextAlign.center,
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.bold,
                    //                           fontSize: 16,
                    //                           color: white)
                    //                       //    textAlign: TextAlign.center,
                    //                       ),
                    //                 ),
                    //               ),
                    //               // GridColumn(
                    //               //   columnName: 'Date',
                    //               //   autoFitPadding:
                    //               //       const EdgeInsets.symmetric(
                    //               //           horizontal: 16),
                    //               //   allowEditing: false,
                    //               //   width: 160,
                    //               //   label: Container(
                    //               //     padding: const EdgeInsets.symmetric(
                    //               //         horizontal: 8.0),
                    //               //     alignment: Alignment.center,
                    //               //     child: Text('Date',
                    //               //         textAlign: TextAlign.center,
                    //               //         overflow: TextOverflow.values.first,
                    //               //         style: TextStyle(
                    //               //             fontWeight: FontWeight.bold,
                    //               //             fontSize: 16,
                    //               //             color: white)),
                    //               //   ),
                    //               // ),
                    //               // GridColumn(
                    //               //   visible: false,
                    //               //   columnName: 'State',
                    //               //   autoFitPadding:
                    //               //       const EdgeInsets.symmetric(horizontal: 16),
                    //               //   allowEditing: true,
                    //               //   width: 120,
                    //               //   label: Container(
                    //               //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //               //     alignment: Alignment.center,
                    //               //     child: Text('State',
                    //               //         textAlign: TextAlign.center,
                    //               //         overflow: TextOverflow.values.first,
                    //               //         style: TextStyle(
                    //               //             fontWeight: FontWeight.bold,
                    //               //             fontSize: 16,
                    //               //             color: white)
                    //               //         //    textAlign: TextAlign.center,
                    //               //         ),
                    //               //   ),
                    //               // ),
                    //               // GridColumn(
                    //               //   visible: false,
                    //               //   columnName: 'DepotName',
                    //               //   autoFitPadding:
                    //               //       const EdgeInsets.symmetric(horizontal: 16),
                    //               //   allowEditing: true,
                    //               //   width: 150,
                    //               //   label: Container(
                    //               //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //               //     alignment: Alignment.center,
                    //               //     child: Text('Depot Name',
                    //               //         overflow: TextOverflow.values.first,
                    //               //         style: TextStyle(
                    //               //             fontWeight: FontWeight.bold,
                    //               //             fontSize: 16,
                    //               //             color: white)
                    //               //         //    textAlign: TextAlign.center,
                    //               //         ),
                    //               //   ),
                    //               // ),
                    //               GridColumn(
                    //                 columnName: 'TypeOfActivity',
                    //                 autoFitPadding:
                    //                     const EdgeInsets.symmetric(
                    //                         horizontal: 16),
                    //                 allowEditing: true,
                    //                 width: 200,
                    //                 label: Container(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 8.0),
                    //                   alignment: Alignment.center,
                    //                   child: Text('Type of Activity',
                    //                       overflow: TextOverflow.values.first,
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.bold,
                    //                           fontSize: 16,
                    //                           color: white)
                    //                       //    textAlign: TextAlign.center,
                    //                       ),
                    //                 ),
                    //               ),
                    //               GridColumn(
                    //                 columnName: 'ActivityDetails',
                    //                 autoFitPadding:
                    //                     const EdgeInsets.symmetric(
                    //                         horizontal: 16),
                    //                 allowEditing: true,
                    //                 width: 220,
                    //                 label: Container(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 8.0),
                    //                   alignment: Alignment.center,
                    //                   child: Text('Activity Details',
                    //                       overflow: TextOverflow.values.first,
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.bold,
                    //                           fontSize: 16,
                    //                           color: white)
                    //                       //    textAlign: TextAlign.center,
                    //                       ),
                    //                 ),
                    //               ),
                    //               GridColumn(
                    //                 columnName: 'Progress',
                    //                 autoFitPadding:
                    //                     const EdgeInsets.symmetric(
                    //                         horizontal: 16),
                    //                 allowEditing: true,
                    //                 width: 320,
                    //                 label: Container(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 8.0),
                    //                   alignment: Alignment.center,
                    //                   child: Text('Progress',
                    //                       overflow: TextOverflow.values.first,
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.bold,
                    //                           fontSize: 16,
                    //                           color: white)
                    //                       //    textAlign: TextAlign.center,
                    //                       ),
                    //                 ),
                    //               ),
                    //               GridColumn(
                    //                 columnName: 'Status',
                    //                 autoFitPadding:
                    //                     const EdgeInsets.symmetric(
                    //                         horizontal: 16),
                    //                 allowEditing: true,
                    //                 width: 320,
                    //                 label: Container(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 8.0),
                    //                   alignment: Alignment.center,
                    //                   child: Text('Remark / Status',
                    //                       overflow: TextOverflow.values.first,
                    //                       style: TextStyle(
                    //                           fontWeight: FontWeight.bold,
                    //                           fontSize: 16,
                    //                           color: white)
                    //                       //    textAlign: TextAlign.center,
                    //                       ),
                    //                 ),
                    //               ),
                    //             ]),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }
                },
              )
            ]),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: (() {
      //       DailyProject.add(DailyProjectModel(
      //           siNo: 1,
      //           // date: DateFormat().add_yMd().format(DateTime.now()),
      //           // state: "Maharashtra",
      //           // depotName: 'depotName',
      //           typeOfActivity: 'Electrical Infra',
      //           activityDetails: "Initial Survey of DEpot",
      //           progress: '',
      //           status: ''));
      //       _dailyDataSource.buildDataGridRows();
      //       _dailyDataSource.updateDatagridSource();
      //     })),
    );
  }

  void storeData() {
    Map<String, dynamic> table_data = Map();
    for (var i in _dailyDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button') {
          table_data[data.columnName] = data.value;
        }
      }

      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection('DailyProjectReport')
        .doc('${widget.depoName}')
        .collection(widget.userId!)
        .doc(DateFormat.yMMMMd().format(DateTime.now()))
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

  // List<DailyProjectModel> getmonthlyReport() {
  //   return [
  //     DailyProjectModel(
  //         siNo: 1,
  //         // date: DateFormat().add_yMd().format(DateTime.now()),
  //         // state: "Maharashtra",
  //         // depotName: 'depotName',
  //         typeOfActivity: 'Electrical Infra',
  //         activityDetails: "Initial Survey of DEpot",
  //         progress: '',
  //         status: '')
  //   ];
  // }

  Future<void> getUserId() async {
    await AuthService().getCurrentUserId().then((value) {
      companyId = value;
    });
  }

  identifyUser() async {
    snap = await FirebaseFirestore.instance.collection('Admin').get();

    for (int i = 0; i < snap!.docs.length; i++) {
      if (snap!.docs[i]['Employee Id'] == companyId &&
          snap!.docs[i]['CompanyName'] == 'TATA MOTOR') {
        setState(() {
          specificUser = false;
        });
      }
    }
  }

  Future getTableData() async {
    await FirebaseFirestore.instance
        .collection('DailyProjectReport2')
        .doc(widget.depoName!)
        .collection('userId')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        String documentId = element.id;
        id.add(documentId);
        print('userId - $id');
        // nestedTableData(docss);
      });
    });
  }

  Future<void> nestedTableData(docss) async {
    dataForPdf.clear();

    setState(() {
      _isLoading = true;
    });
    // showCupertinoDialog(
    //   context: context,
    //   builder: (context) => CupertinoAlertDialog(
    //     content: SizedBox(
    //       // height: 50,
    //       // width: 50,
    //       child: Center(child: LoadingPage()),
    //     ),
    //   ),
    // );
    for (int i = 0; i < docss.length; i++) {
      Map<String, dynamic> useridWithData = {};
      for (DateTime initialdate = startdate!;
          initialdate.isBefore(enddate!.add(Duration(days: 1)));
          initialdate = initialdate.add(const Duration(days: 1))) {
        String temp = DateFormat.yMMMMd().format(initialdate);
        await FirebaseFirestore.instance
            .collection('DailyProjectReport2')
            .doc(widget.depoName!)
            .collection('userId')
            .doc(docss[i])
            .collection('date')
            .doc(temp)
            .get()
            .then((value) {
          if (value.data() != null) {
            availableUserId.add(docss[i]);
            chosenDateList.add(temp);
            String userId = docss[i];
            useridWithData[userId] = value.data()!['data'];
            for (int j = 0; j < value.data()!['data'].length; j++) {
              DailyProject.add(
                  DailyProjectModel.fromjson(value.data()!['data'][j]));
              // print(DailyProject);
            }
            dataForPdf.add(useridWithData);
          }
        });
      }

      print(dataForPdf);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _generatePDF() async {
    setState(() {
      _isLoading = true;
    });

    final headerStyle =
        pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold);

    final fontData1 = await rootBundle.load('fonts/IBMPlexSans-Medium.ttf');
    final fontData2 = await rootBundle.load('fonts/IBMPlexSans-Bold.ttf');

    const cellStyle = pw.TextStyle(
      color: PdfColors.black,
      fontSize: 14,
    );

    final profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/Tata-Power.jpeg')).buffer.asUint8List(),
    );

    List<pw.TableRow> rows = [];

    rows.add(pw.TableRow(children: [
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Sr No',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding:
              const pw.EdgeInsets.only(top: 4, bottom: 4, left: 2, right: 2),
          child: pw.Center(
              child: pw.Text('Date',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Type of Activity',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Activity Details',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Progress',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Remark / Status',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Image1',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Image2',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
    ]));

    if (dataForPdf.isNotEmpty) {
      List<pw.Widget> imageUrls = [];

      for (int i = 0; i < chosenDateList.length; i++) {
        for (int j = 0; j < availableUserId.length; j++) {
          final currentUserId = availableUserId[j];
          for (Map<String, dynamic> mapData in dataForPdf) {
            List<dynamic> userData = mapData[currentUserId];

            for (int k = 0; k < userData.length; k++) {
              String imagesPath =
                  '/Daily Report/${widget.cityName}/${widget.depoName}/${availableUserId[j]}/${chosenDateList[i]}/${userData[k]['SiNo']}';
              print(imagesPath);

              ListResult result = await FirebaseStorage.instance
                  .ref()
                  .child(imagesPath)
                  .listAll();

              if (result.items.isNotEmpty) {
                for (var image in result.items) {
                  String downloadUrl = await image.getDownloadURL();
                  if (image.name.endsWith('.pdf')) {
                    imageUrls.add(
                      pw.Container(
                          width: 60,
                          alignment: pw.Alignment.center,
                          padding:
                              const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: pw.UrlLink(
                              child: pw.Text(image.name,
                                  style: const pw.TextStyle(
                                      color: PdfColors.blue)),
                              destination: downloadUrl)),
                    );
                  } else {
                    final myImage = await networkImage(downloadUrl);
                    imageUrls.add(
                      pw.Container(
                          padding:
                              const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                          width: 60,
                          height: 80,
                          child: pw.Center(
                            child: pw.Image(myImage),
                          )),
                    );
                  }
                }

                if (imageUrls.length < 2) {
                  int imageLoop = 2 - imageUrls.length;
                  for (int i = 0; i < imageLoop; i++) {
                    imageUrls.add(
                      pw.Container(
                          padding:
                              const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                          width: 60,
                          height: 80,
                          child: pw.Text('')),
                    );
                  }
                } else {
                  int imageLoop = 10 - imageUrls.length;
                  for (int i = 0; i < imageLoop; i++) {
                    imageUrls.add(
                      pw.Container(
                          padding:
                              const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                          width: 80,
                          height: 100,
                          child: pw.Text('')),
                    );
                  }
                }
              } else {
                for (int i = 0; i < 2; i++) {
                  imageUrls.add(
                    pw.Container(
                        padding:
                            const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                        width: 60,
                        height: 80,
                        child: pw.Text('')),
                  );
                }
              }
              result.items.clear();

              //Text Rows of PDF Table
              rows.add(pw.TableRow(children: [
                pw.Container(
                    padding: const pw.EdgeInsets.all(3.0),
                    child: pw.Center(
                        child: pw.Text(userData[k]['SiNo'].toString(),
                            style: const pw.TextStyle(fontSize: 14)))),
                pw.Container(
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Center(
                        child: pw.Text(userData[k]['Date'].toString(),
                            style: const pw.TextStyle(fontSize: 14)))),
                pw.Container(
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Center(
                        child: pw.Text(userData[k]['TypeOfActivity'].toString(),
                            style: const pw.TextStyle(fontSize: 14)))),
                pw.Container(
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Center(
                        child: pw.Text(
                            userData[k]['ActivityDetails'].toString(),
                            style: const pw.TextStyle(fontSize: 14)))),
                pw.Container(
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Center(
                        child: pw.Text(userData[k]['Progress'].toString(),
                            style: const pw.TextStyle(fontSize: 14)))),
                pw.Container(
                    padding: const pw.EdgeInsets.all(2.0),
                    child: pw.Center(
                        child: pw.Text(userData[k]['Status'].toString(),
                            style: const pw.TextStyle(fontSize: 14)))),
                imageUrls[0],
                imageUrls[1]
              ]));

              if (imageUrls.length - 2 > 0) {
                //Image Rows of PDF Table
                rows.add(pw.TableRow(children: [
                  pw.Container(
                      padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: pw.Text('')),
                  pw.Container(
                      padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                      width: 60,
                      height: 100,
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            imageUrls[2],
                            imageUrls[3],
                          ])),
                  imageUrls[4],
                  imageUrls[5],
                  imageUrls[6],
                  imageUrls[7],
                  imageUrls[8],
                  imageUrls[9]
                ]));
              }
              imageUrls.clear();
            }
          }
        }
      }
    }

    final pdf = pw.Document(
      pageMode: PdfPageMode.outlines,
    );

    //First Half Page

    pdf.addPage(
      pw.MultiPage(
        maxPages: 100,
        theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(fontData1), bold: pw.Font.ttf(fontData2)),
        pageFormat: const PdfPageFormat(1300, 900,
            marginLeft: 70, marginRight: 70, marginBottom: 80, marginTop: 40),
        orientation: pw.PageOrientation.natural,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                      bottom:
                          pw.BorderSide(width: 0.5, color: PdfColors.grey))),
              child: pw.Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Daily Report Table',
                          textScaleFactor: 2,
                          style: const pw.TextStyle(color: PdfColors.blue700)),
                      pw.Container(
                        width: 120,
                        height: 120,
                        child: pw.Image(profileImage),
                      ),
                    ]),
              ]));
        },
        // footer: (pw.Context context) {
        //   return pw.Container(
        //       alignment: pw.Alignment.centerRight,
        //       margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
        //       child: pw.Text('User ID - $user_id',
        //           // 'Page ${context.pageNumber} of ${context.pagesCount}',
        //           style: pw.Theme.of(context)
        //               .defaultTextStyle
        //               .copyWith(color: PdfColors.black)));
        // },
        build: (pw.Context context) => <pw.Widget>[
          pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Place:  ${widget.cityName}/${widget.depoName}',
                    textScaleFactor: 1.6,
                  ),
                  pw.Text(
                    'Date: $startdate to $enddate ',
                    textScaleFactor: 1.6,
                  )
                ]),
            pw.SizedBox(height: 20)
          ]),
          pw.SizedBox(height: 10),
          pw.Table(
              columnWidths: {
                0: const pw.FixedColumnWidth(30),
                1: const pw.FixedColumnWidth(160),
                2: const pw.FixedColumnWidth(70),
                3: const pw.FixedColumnWidth(70),
                4: const pw.FixedColumnWidth(70),
                5: const pw.FixedColumnWidth(70),
                6: const pw.FixedColumnWidth(70),
                7: const pw.FixedColumnWidth(70),
              },
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              tableWidth: pw.TableWidth.max,
              border: pw.TableBorder.all(),
              children: rows)
        ],
      ),
    );

    final List<int> pdfData = await pdf.save();
    const String pdfPath = 'Daily Report.pdf';

    // Save the PDF file to device storage
    if (kIsWeb) {
      html.AnchorElement(
          href: "data:application/octet-stream;base64,${base64Encode(pdfData)}")
        ..setAttribute("download", pdfPath)
        ..click();
    }

    setState(() {
      _isLoading = false;
    });
  }
}
