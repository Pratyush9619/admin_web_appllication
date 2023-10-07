import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';
import 'package:web_appllication/widgets/nodata_available.dart';
import '../components/loading_page.dart';
import '../datasource/dailyproject_datasource.dart';
import '../datasource/monthlyproject_datasource.dart';
import '../datasource/safetychecklist_datasource.dart';
import '../model/daily_projectModel.dart';
import '../model/monthly_projectModel.dart';
import '../model/safety_checklistModel.dart';
import '../style.dart';

class ViewSummary extends StatefulWidget {
  String? depoName;
  String? cityName;
  String? id;
  String? selectedtab;
  bool isHeader;
  String? currentDate;
  dynamic userId;
  ViewSummary(
      {super.key,
      required this.depoName,
      required this.cityName,
      required this.id,
      this.userId,
      this.selectedtab,
      this.currentDate,
      this.isHeader = false});

  @override
  State<ViewSummary> createState() => _ViewSummaryState();
}

class _ViewSummaryState extends State<ViewSummary> {
  DateTime? startdate = DateTime.now();
  DateTime? rangestartDate;

  List<MonthlyProjectModel> monthlyProject = <MonthlyProjectModel>[];
  List<SafetyChecklistModel> safetylisttable = <SafetyChecklistModel>[];
  late MonthlyDataSource monthlyDataSource;
  late SafetyChecklistDataSource _safetyChecklistDataSource;
  late DataGridController _dataGridController;
  List<DailyProjectModel> dailyproject = <DailyProjectModel>[];
  late DailyDataSource _dailyDataSource;
  List<dynamic> tabledata2 = [];
  Stream? stream;
  dynamic alldata;
  bool isloading = false;
  dynamic userId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              '${widget.cityName} / ${widget.depoName} / ${widget.id} / View Summary'),
          backgroundColor: blue,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                                      view: DateRangePickerView.month,
                                      showTodayButton: false,
                                      showActionButtons: true,
                                      selectionMode:
                                          DateRangePickerSelectionMode.single,
                                      onSelectionChanged:
                                          (DateRangePickerSelectionChangedArgs
                                              args) {
                                        if (args.value is PickerDateRange) {
                                          rangestartDate = args.value.startDate;
                                        }
                                      },
                                      onSubmit: (value) {
                                        setState(() {
                                          startdate =
                                              DateTime.parse(value.toString());
                                        });
                                        Navigator.pop(context);
                                      },
                                      onCancel: () {},
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.today)),
                        Text(widget.id == 'Monthly Report'
                            ? DateFormat.yMMM().format(startdate!)
                            : DateFormat.yMMMMd().format(startdate!))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.id == 'Monthly Report'
                ? Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('MonthlyProjectReport')
                            .doc('${widget.depoName}')
                            .collection(widget.userId)
                            .doc(DateFormat.yMMM().format(startdate!))
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingPage();
                          } else if (!snapshot.hasData ||
                              snapshot.data!.exists == false) {
                            return const NodataAvailable();
                          } else {
                            alldata = snapshot.data!['data'] as List<dynamic>;
                            monthlyProject.clear();
                            alldata.forEach((element) {
                              monthlyProject
                                  .add(MonthlyProjectModel.fromjson(element));
                              monthlyDataSource =
                                  MonthlyDataSource(monthlyProject, context);
                              _dataGridController = DataGridController();
                            });
                            return Column(
                              children: [
                                Expanded(
                                    child: SfDataGridTheme(
                                  data: SfDataGridThemeData(
                                      headerColor: lightblue),
                                  child: SfDataGrid(
                                      source: monthlyDataSource,
                                      allowEditing: true,
                                      frozenColumnsCount: 2,
                                      gridLinesVisibility:
                                          GridLinesVisibility.both,
                                      headerGridLinesVisibility:
                                          GridLinesVisibility.both,
                                      selectionMode: SelectionMode.single,
                                      navigationMode: GridNavigationMode.cell,
                                      columnWidthMode: ColumnWidthMode.auto,
                                      editingGestureType:
                                          EditingGestureType.tap,
                                      controller: _dataGridController,
                                      columns: [
                                        GridColumn(
                                          columnName: 'ActivityNo',
                                          autoFitPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                          allowEditing: true,
                                          width: 160,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Activities SI. No as per Gant Chart',
                                              overflow:
                                                  TextOverflow.values.first,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: white),
                                            ),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'ActivityDetails',
                                          autoFitPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                          allowEditing: true,
                                          width: 240,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('Activities Details',
                                                textAlign: TextAlign.center,
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        // GridColumn(
                                        //   columnName: 'Months',
                                        //   autoFitPadding: const EdgeInsets.symmetric(
                                        //       horizontal: 16),
                                        //   allowEditing: false,
                                        //   width: 200,
                                        //   label: Container(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 8.0),
                                        //     alignment: Alignment.center,
                                        //     child: Text('Months',
                                        //         textAlign: TextAlign.center,
                                        //         overflow: TextOverflow.values.first,
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 16,
                                        //             color: white)),
                                        //   ),
                                        // ),
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
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                          allowEditing: true,
                                          width: 250,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('Progress',
                                                overflow:
                                                    TextOverflow.values.first,
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
                                          width: 250,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('Remark/Status',
                                                overflow:
                                                    TextOverflow.values.first,
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
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                          allowEditing: true,
                                          width: 250,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                                'Next Month Action Plan',
                                                overflow:
                                                    TextOverflow.values.first,
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
                  )
                : widget.id == 'Daily Report'
                    ? Expanded(
                        child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('DailyProjectReport')
                            .doc('${widget.depoName}')
                            .collection('ZW3210')
                            .doc(DateFormat.yMMMMd().format(DateTime.now()))
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingPage();
                          } else if (!snapshot.hasData ||
                              snapshot.data!.exists == false) {
                            return const NodataAvailable();
                          } else {
                            alldata = '';
                            alldata = snapshot.data!['data'] as List<dynamic>;
                            dailyproject.clear();
                            alldata.forEach((element) {
                              dailyproject
                                  .add(DailyProjectModel.fromjson(element));
                              _dailyDataSource = DailyDataSource(dailyproject,
                                  context, widget.cityName!, widget.depoName!);
                              _dataGridController = DataGridController();
                            });
                            return SfDataGridTheme(
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
                                      columnName: 'SiNo',
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
                                    //     child: Text('Date',
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
                                    GridColumn(
                                      columnName: 'view',
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      allowEditing: true,
                                      width: 150,
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
                            );
                          }
                        },
                      ))
                    : widget.id == 'Quality Checklist'
                        ? Expanded(
                            child: QualityChecklist(
                                userId: widget.userId,
                                currentDate:
                                    DateFormat.yMMMMd().format(startdate!),
                                isHeader: widget.isHeader,
                                cityName: widget.cityName,
                                depoName: widget.depoName))
                        : Expanded(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('SafetyChecklistTable')
                                  .doc(widget.depoName!)
                                  .collection(widget.userId)
                                  .doc(DateFormat.yMMMMd().format(startdate!))
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return LoadingPage();
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.exists == false) {
                                  return const NodataAvailable();
                                } else {
                                  alldata = '';
                                  alldata =
                                      snapshot.data!['data'] as List<dynamic>;
                                  safetylisttable.clear();
                                  alldata.forEach((element) {
                                    safetylisttable.add(
                                        SafetyChecklistModel.fromJson(element));
                                    _safetyChecklistDataSource =
                                        SafetyChecklistDataSource(
                                      safetylisttable,
                                      widget.cityName!,
                                      widget.depoName!,
                                      // widget.userId
                                    );
                                    _dataGridController = DataGridController();
                                  });
                                  return SfDataGridTheme(
                                    data:
                                        SfDataGridThemeData(headerColor: blue),
                                    child: SfDataGrid(
                                      source: _safetyChecklistDataSource,
                                      //key: key,

                                      allowEditing: true,
                                      frozenColumnsCount: 2,
                                      gridLinesVisibility:
                                          GridLinesVisibility.both,
                                      headerGridLinesVisibility:
                                          GridLinesVisibility.both,
                                      selectionMode: SelectionMode.single,
                                      navigationMode: GridNavigationMode.cell,
                                      columnWidthMode: ColumnWidthMode.auto,
                                      editingGestureType:
                                          EditingGestureType.tap,
                                      controller: _dataGridController,

                                      columns: [
                                        GridColumn(
                                          columnName: 'srNo',
                                          autoFitPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                          allowEditing: true,
                                          width: 80,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('Sr No',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        GridColumn(
                                          width: 450,
                                          columnName: 'Details',
                                          allowEditing: true,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('Details of Enclosure ',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'Status',
                                          allowEditing: true,
                                          width: 150,
                                          label: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                                'Status of Submission of information/ documents ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: white,
                                                )),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'Remark',
                                          allowEditing: true,
                                          width: 150,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('Remarks',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'Photo',
                                          allowEditing: false,
                                          width: 180,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('Upload Photo',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'ViewPhoto',
                                          allowEditing: false,
                                          width: 180,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('View Photo',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          )
          ],
        ));
  }
}
