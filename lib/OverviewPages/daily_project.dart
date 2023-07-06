import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:web_appllication/OverviewPages/summary.dart';
import 'package:web_appllication/widgets/date_range.dart';
import 'package:web_appllication/widgets/nodata_available.dart';
import '../Authentication/auth_service.dart';
import '../datasource/dailyproject_datasource.dart';
import '../model/daily_projectModel.dart';
import '../components/loading_page.dart';
import '../style.dart';
import '../widgets/custom_appbar.dart';

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

  @override
  void initState() {
    getUserId();
    identifyUser();
    // getmonthlyReport();
    // DailyProject = getmonthlyReport();
    _dailyDataSource = DailyDataSource(DailyProject, context, widget.depoName!);
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
        _dailyDataSource =
            DailyDataSource(DailyProject, context, widget.depoName!);
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
            text: ' ${widget.cityName}/ ${widget.depoName} / Dailly Report',
            userid: widget.userId,
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
                padding: const EdgeInsets.all(8.0),
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
                                                onCancel: () {},
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
                    SizedBox(width: 20),
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
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingPage();
                    } else if (!snapshot.hasData ||
                        snapshot.data.exists == false) {
                      return Column(
                        children: [
                          Expanded(
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
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
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
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
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
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
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
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
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
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      allowEditing: true,
                                      width: 320,
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
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
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
                      return NodataAvailable();
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
                ),
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
        print('$id');
        // nestedTableData(docss);
      });
    });
  }

  Future<void> nestedTableData(docss) async {
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
    for (int i = 0; i < docss.length; i++) {
      for (DateTime initialdate = startdate!;
          initialdate.isBefore(enddate!.add(Duration(days: 1)));
          initialdate = initialdate.add(const Duration(days: 1))) {
        String temp = DateFormat.yMMMMd().format(initialdate);
        print(temp);
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
            for (int j = 0; j < value.data()!['data'].length; j++) {
              DailyProject.add(
                  DailyProjectModel.fromjson(value.data()!['data'][j]));
              print(DailyProject);
            }
          }
        });
      }
    }
    Navigator.pop(context);
  }
  // value.docs.forEach((element) {
  //   print('after');
  //   // if (element.id == '${widget.depoName}${widget.events}') {
  //   print('${element.data()['data'].length}');
  //   for (int i = 0; i < element.data()['data'].length; i++) {
  //     DailyProject.add(
  //         DailyProjectModel.fromjson(element.data()['data'][i]));
  //     print(DailyProject);
  //     //   }
  //   }
  // });
}
