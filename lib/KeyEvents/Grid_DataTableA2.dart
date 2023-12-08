// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gantt_chart/gantt_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:web_appllication/KeyEvents/ChartData.dart';
// import 'package:web_appllication/datasource/employee_datasouce.dart';
// import 'package:web_appllication/model/employee.dart';
// import 'package:web_appllication/provider/key_provider.dart';
// import 'package:web_appllication/style.dart';
// import 'package:web_appllication/widgets/nodata_available.dart';
// import '../Authentication/auth_service.dart';
// import '../components/loading_page.dart';
// import '../widgets/custom_appbar.dart';
// import '../widgets/keyboard_listener.dart';

// /// The application that contains datagrid on it.

// /// The home page of the application which hosts the datagrid.
// class StatutoryAprovalA2 extends StatefulWidget {
//   /// Creates the home page.
//   String? userid;
//   String events;
//   String? depoName;
//   String? cityName;

//   StatutoryAprovalA2(
//       {Key? key,
//       required this.userid,
//       required this.events,
//       required this.depoName,
//       required this.cityName})
//       : super(key: key);

//   @override
//   _StatutoryAprovalA2State createState() => _StatutoryAprovalA2State();
// }

// class _StatutoryAprovalA2State extends State<StatutoryAprovalA2> {
//   late EmployeeDataSource _employeeDataSource;
//   List<Employee> _employees = <Employee>[];

//   late DataGridController _dataGridController;
//   KeyProvider? _keyProvider;
//   List<dynamic> tabledata2 = [];
//   List<dynamic> weightage = [];
//   var alldata;
//   bool _isLoading = true;
//   bool _isInit = true;
//   List<double> weight = [];
//   List<int> yAxis = [];
//   List<ChartData> chartData = [];
//   Stream? _stream;
//   bool specificUser = true;
//   QuerySnapshot? snap;
//   dynamic companyId;
//   int? num_id;
//   List docss = [];
//   final scrollController = ScrollController();

//   // calculate perc of progress
//   List<GanttEventBase> ganttdata = [];
//   // List<String>? srno = [];
//   // List<String>? startdate = [];
//   // List<String>? enddate = [];
//   // List<String>? actualstartdate = [];
//   // List<String>? actualenddate = [];

//   @override
//   void initState() {
//     _keyProvider = Provider.of<KeyProvider>(context, listen: false);
//     _keyProvider!
//         .getFirestoreData(widget.userid, widget.events, '${widget.depoName}')
//         .whenComplete(() {
//       print(_keyProvider!.startdate.length);
//       ganttdata = [];
//       for (int i = 0; i < _keyProvider!.startdate.length; i++) {
//         ganttdata.add(GanttAbsoluteEvent(
//           suggestedColor: Colors.yellow,
//           displayNameBuilder: (context) {
//             return _keyProvider!.serialNo[i].toString();
//           },
//           startDate: DateFormat('dd-MM-yyyy').parse(_keyProvider!.startdate[i]),
//           endDate: DateFormat('dd-MM-yyyy').parse(_keyProvider!.enddate[i]),
//           //displayName: yAxis[i].toString()
//         ));
//         ganttdata.add(GanttAbsoluteEvent(
//           suggestedColor: DateFormat('dd-MM-yyyy')
//                   .parse(_keyProvider!.actualdate[i])
//                   .isBefore(DateFormat('dd-MM-yyyy')
//                       .parse(_keyProvider!.enddate[i])
//                       .add(const Duration(days: 1)))
//               // _keyProvider!.actualdate[i]
//               //  == _keyProvider!.actualenddate[i]
//               ? green
//               : red,
//           displayNameBuilder: (context) {
//             return '';
//           },
//           startDate:
//               DateFormat('dd-MM-yyyy').parse(_keyProvider!.actualdate[i]),
//           endDate:
//               DateFormat('dd-MM-yyyy').parse(_keyProvider!.actualenddate[i]),
//           //DateFormat('dd-MM-yyyy').parse(_keyProvider!.enddate[i]),
//           //displayName: yAxis[i].toString()
//         ));
//       }
//       _stream = FirebaseFirestore.instance
//           .collection('KeyEventsTable')
//           .doc(widget.depoName!)
//           .collection('KeyDataTable')
//           .doc(widget.userid)
//           .collection('KeyAllEvents')
//           .doc('${widget.depoName}${widget.events}')
//           .snapshots();

//       _isLoading = false;
//       setState(() {});
//     });

//     getUserId();
//     identifyUser();
//     _employeeDataSource = EmployeeDataSource(
//         _employees, context, widget.cityName, widget.depoName);
//     _dataGridController = DataGridController();

//     // getTableData().whenComplete(() {
//     //   nestedTableData(docss).whenComplete(() {
//     //     _employeeDataSource = EmployeeDataSource(
//     //         _employees, context, widget.cityName, widget.depoName);
//     //     _dataGridController = DataGridController();
//     //   });
//     // });

//     super.initState();

//     // });

//     int length = _employees.length * 66;
//   }

//   // @override
//   // void didChangeDependencies() {
//   //   if (_isInit) {
//   //     setState(() {
//   //       _isLoading = true;
//   //     });
//   //     getFirestoreData().whenComplete(() {
//   //       setState(() {
//   //         loadchartdata();
//   //         if (_employees.length == 0 || _employees.isEmpty) {
//   //           _employees = getEmployeeData();
//   //         }
//   //         _isLoading = false;
//   //         _employeeDataSource = EmployeeDataSource(_employees, context);
//   //         _dataGridController = DataGridController();
//   //       });
//   //       // _employeeDataSource = EmployeeDataSource(_employees);
//   //       // _dataGridController = DataGridController();
//   //     });
//   //     //getFirestoreData() as List<Employee>;
//   //     // getEmployeeData();

//   //   }
//   //   _isInit = false;
//   //   super.didChangeDependencies();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return keyBoardArrow(
//       scrollController: scrollController,
//       myScaffold: Scaffold(
//         appBar: PreferredSize(
//           // ignore: sort_child_properties_last
//           child: CustomAppBar(
//             cityName: widget.cityName,
//             userId: widget.userid,
//             depoName: widget.depoName,
//             text: 'Key Events / ${widget.depoName!} /${widget.events}',
//             haveSynced: specificUser ? true : false,
//             store: () {
//               StoreData();
//             },
//           ),
//           preferredSize: const Size.fromHeight(50),
//         ),
//         body: _isLoading
//             ? LoadingPage()
//             : StreamBuilder(
//                 stream: _stream,
//                 builder: (context, snapshot) {
//                   print(ganttdata);
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return LoadingPage();
//                   }
//                   if (!snapshot.data.exists) {
//                     return NodataAvailable();
//                   }
//                   if (snapshot.hasData || snapshot.data.exists == false) {
//                     _employees.clear();
//                     alldata = '';
//                     alldata = snapshot.data['data'] as List<dynamic>;

//                     alldata.forEach((element) {
//                       _employees.add(Employee.fromJson(element));
//                       _employeeDataSource = EmployeeDataSource(_employees,
//                           context, widget.cityName, widget.depoName);

//                       _dataGridController = DataGridController();
//                     });
//                     _dataGridController = DataGridController();
//                     return SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Container(
//                             height: _employees.length * 66,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: SfDataGrid(
//                                     source: _employeeDataSource,
//                                     allowEditing: true,
//                                     frozenColumnsCount: 2,
//                                     gridLinesVisibility:
//                                         GridLinesVisibility.both,
//                                     headerGridLinesVisibility:
//                                         GridLinesVisibility.both,
//                                     selectionMode: SelectionMode.single,
//                                     navigationMode: GridNavigationMode.cell,
//                                     columnWidthMode: ColumnWidthMode.auto,
//                                     editingGestureType: EditingGestureType.tap,
//                                     controller: _dataGridController,
//                                     // onQueryRowHeight: (details) {
//                                     //   return details.rowIndex == 0 ? 60.0 : 49.0;
//                                     // },
//                                     columns: [
//                                       GridColumn(
//                                         columnName: 'srNo',
//                                         autoFitPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 16),
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text(
//                                             'Sr No',
//                                             overflow: TextOverflow.values.first,
//                                             style: tableheader,
//                                             //    textAlign: TextAlign.center,
//                                           ),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Activity',
//                                         width: 220,
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text(
//                                             'Activity',
//                                             overflow: TextOverflow.values.first,
//                                             style: tableheader,
//                                           ),
//                                         ),
//                                       ),
//                                       // GridColumn(
//                                       //   columnName: 'button',
//                                       //   width: 130,
//                                       //   allowEditing: false,
//                                       //   label: Container(
//                                       //     padding: const EdgeInsets.all(8.0),
//                                       //     alignment: Alignment.center,
//                                       //     child: const Text('View File ',
//                                       //         style: TextStyle(
//                                       //             fontWeight: FontWeight.bold,
//                                       //             fontSize: 16)),
//                                       //   ),
//                                       // ),
//                                       GridColumn(
//                                         columnName: 'OriginalDuration',
//                                         allowEditing: false,
//                                         width: 80,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Original Duration',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'StartDate',
//                                         allowEditing: false,
//                                         width: 150,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Start Date',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'EndDate',
//                                         allowEditing: false,
//                                         width: 130,
//                                         label: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16.0),
//                                           alignment: Alignment.center,
//                                           child: Text('End Date',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'ActualStart',
//                                         allowEditing: false,
//                                         width: 140,
//                                         label: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16.0),
//                                           alignment: Alignment.center,
//                                           child: Text('Actual Start',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'ActualEnd',
//                                         allowEditing: false,
//                                         width: 140,
//                                         label: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16.0),
//                                           alignment: Alignment.center,
//                                           child: Text('Actual End',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'ActualDuration',
//                                         allowEditing: true,
//                                         width: 100,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Actual Duration',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Delay',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Delay',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'ReasonDelay',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Reason For Delay',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Unit',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Unit',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'QtyScope',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Oty as per scope',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'QtyExecuted',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Qty executed',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'BalancedQty',
//                                         allowEditing: false,
//                                         label: Container(
//                                           width: 150,
//                                           alignment: Alignment.center,
//                                           child: Text('Balanced Qty',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Progress',
//                                         allowEditing: false,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('% of Progress',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Weightage',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Weightage',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 Container(
//                                     width: 450,
//                                     child: GanttChartView(
//                                         scrollController: scrollController,
//                                         scrollPhysics:
//                                             const BouncingScrollPhysics(),
//                                         maxDuration: null,
//                                         // const Duration(days: 30 * 2),
//                                         // optional, set to null for infinite horizontal scroll
//                                         startDate:
//                                             DateTime(2023, 8, 1), //required
//                                         dayWidth:
//                                             40, //column width for each day
//                                         dayHeaderHeight: 35,
//                                         eventHeight: 25, //row height for events

//                                         stickyAreaWidth: 80, //sticky area width
//                                         showStickyArea:
//                                             true, //show sticky area or not
//                                         showDays: true, //show days or not
//                                         startOfTheWeek: WeekDay
//                                             .monday, //custom start of the week
//                                         weekHeaderHeight: 30,
//                                         weekEnds: const {
//                                           // WeekDay.saturday,
//                                           // WeekDay.sunday
//                                         }, //custom weekends
//                                         isExtraHoliday: (context, day) {
//                                           //define custom holiday logic for each day
//                                           return DateUtils.isSameDay(
//                                               DateTime(2023, 7, 1), day);
//                                         },
//                                         events: ganttdata
//                                         //  [
//                                         //   //event relative to startDate
//                                         //   // GanttRelativeEvent(
//                                         //   //   relativeToStart:
//                                         //   //       const Duration(days: 0),
//                                         //   //   duration: const Duration(days: 5),
//                                         //   //   displayName: '1',
//                                         //   // ),
//                                         //   //event with absolute start and end
//                                         //   GanttAbsoluteEvent(
//                                         //     startDate: DateTime(2022, 6, 10),
//                                         //     endDate: DateTime(2022, 6, 16),
//                                         //     displayName: '2',
//                                         //   ),
//                                         //   GanttAbsoluteEvent(
//                                         //     startDate: DateTime(2022, 6, 10),
//                                         //     endDate: DateTime(2022, 7, 25),
//                                         //     displayName: '3',
//                                         //   ),
//                                         // ],
//                                         ))

//                                 //   Container(
//                                 //       width: 300,
//                                 //       margin: EdgeInsets.only(top: 10),
//                                 //       child: SfCartesianChart(
//                                 //           title: ChartTitle(
//                                 //               text: 'All Events Wightage Graph'),
//                                 //           primaryXAxis: CategoryAxis(
//                                 //               // title: AxisTitle(text: 'Key Events')
//                                 //               ),
//                                 //           primaryYAxis: NumericAxis(
//                                 //               // title: AxisTitle(text: 'Weightage')
//                                 //               ),
//                                 //           series: <ChartSeries>[
//                                 //             // Renders column chart
//                                 //             BarSeries<ChartData, String>(
//                                 //                 dataLabelSettings:
//                                 //                     DataLabelSettings(
//                                 //                         isVisible: true),
//                                 //                 dataSource: chartData,
//                                 //                 xValueMapper: (ChartData data, _) =>
//                                 //                     data.x,
//                                 //                 yValueMapper: (ChartData data, _) =>
//                                 //                     data.y,
//                                 //                 pointColorMapper:
//                                 //                     (ChartData data, _) => data.y1)
//                                 //           ]))
//                               ],
//                             ),
//                           ),
//                           // const SizedBox(
//                           //   height: 5,
//                           // ),
//                           // Padding(
//                           //   padding: const EdgeInsets.all(10.0),
//                           //   child: ElevatedButton(
//                           //       style:
//                           //           ElevatedButton.styleFrom(backgroundColor: blue),
//                           //       onPressed: () async {
//                           //         showCupertinoDialog(
//                           //           context: context,
//                           //           builder: (context) =>
//                           //               const CupertinoAlertDialog(
//                           //             content: SizedBox(
//                           //               height: 50,
//                           //               width: 50,
//                           //               child: Center(
//                           //                 child: CircularProgressIndicator(
//                           //                   color: Colors.white,
//                         ],
//                       ),
//                     );
//                   } else {
//                     // alldata = snapshot.data['data'] as List<dynamic>;
//                     // _employees.clear();
//                     // alldata.forEach((element) {
//                     //   _employees.add(Employee.fromJson(element));
//                     //   _employeeDataSource = EmployeeDataSource(
//                     //       _employees, context, widget.cityName, widget.depoName);
//                     //   _dataGridController = DataGridController();
//                     // });
//                     // for (int i = 0; i < alldata.length; i++) {
//                     //   var weightdata = alldata[i]['Weightage'];
//                     //   var yaxisdata = alldata[i]['srNo'];
//                     //   weight.add(weightdata);
//                     //   yAxis.add(yaxisdata);
//                     // }
//                     // for (int i = weight.length - 1; i >= 0; i--) {
//                     //   chartData.add(ChartData(
//                     //       yAxis[i].toString(), weight[i], Colors.green));
//                     // }

//                     _employeeDataSource = EmployeeDataSource(
//                         _employees, context, widget.cityName, widget.depoName);
//                     _dataGridController = DataGridController();

//                     return SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Container(
//                             height: _employees.length * 66,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: SfDataGrid(
//                                     source: _employeeDataSource,
//                                     allowEditing: true,
//                                     frozenColumnsCount: 2,
//                                     gridLinesVisibility:
//                                         GridLinesVisibility.both,
//                                     headerGridLinesVisibility:
//                                         GridLinesVisibility.both,
//                                     selectionMode: SelectionMode.single,
//                                     navigationMode: GridNavigationMode.cell,
//                                     columnWidthMode: ColumnWidthMode.auto,
//                                     editingGestureType: EditingGestureType.tap,
//                                     controller: _dataGridController,
//                                     // onQueryRowHeight: (details) {
//                                     //   return details.rowIndex == 0 ? 60.0 : 49.0;
//                                     // },
//                                     columns: [
//                                       GridColumn(
//                                         columnName: 'srNo',
//                                         autoFitPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 16),
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text(
//                                             'Sr No',
//                                             overflow: TextOverflow.values.first,
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16),
//                                             //    textAlign: TextAlign.center,
//                                           ),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Activity',
//                                         width: 220,
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text(
//                                             'Activity',
//                                             overflow: TextOverflow.values.first,
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16),
//                                           ),
//                                         ),
//                                       ),
//                                       // GridColumn(
//                                       //   columnName: 'button',
//                                       //   width: 130,
//                                       //   allowEditing: false,
//                                       //   label: Container(
//                                       //     padding: const EdgeInsets.all(8.0),
//                                       //     alignment: Alignment.center,
//                                       //     child: const Text('View File ',
//                                       //         style: TextStyle(
//                                       //             fontWeight: FontWeight.bold,
//                                       //             fontSize: 16)),
//                                       //   ),
//                                       // ),
//                                       GridColumn(
//                                         columnName: 'OriginalDuration',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Original Duration',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'StartDate',
//                                         allowEditing: false,
//                                         width: 180,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Start Date',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'EndDate',
//                                         allowEditing: false,
//                                         width: 180,
//                                         label: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16.0),
//                                           alignment: Alignment.center,
//                                           child: Text('End Date',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'ActualStart',
//                                         allowEditing: false,
//                                         width: 180,
//                                         label: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16.0),
//                                           alignment: Alignment.center,
//                                           child: Text('Actual Start',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'ActualEnd',
//                                         allowEditing: false,
//                                         width: 180,
//                                         label: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16.0),
//                                           alignment: Alignment.center,
//                                           child: Text('Actual End',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'ActualDuration',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Actual Duration',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Delay',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Delay',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'ReasonDelay',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Reason For Delay',
//                                               textAlign: TextAlign.center,
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Unit',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Unit',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'QtyScope',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Oty as per scope',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'QtyExecuted',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Qty executed',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'BalancedQty',
//                                         allowEditing: false,
//                                         label: Container(
//                                           width: 150,
//                                           alignment: Alignment.center,
//                                           child: Text('Balanced Qty',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Progress',
//                                         allowEditing: false,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('% of Progress',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                       GridColumn(
//                                         columnName: 'Weightage',
//                                         allowEditing: true,
//                                         label: Container(
//                                           alignment: Alignment.center,
//                                           child: Text('Weightage',
//                                               overflow:
//                                                   TextOverflow.values.first,
//                                               style: tableheader),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                     width: 300,
//                                     height: _employees.length * 75,
//                                     margin: EdgeInsets.only(top: 10),
//                                     child: SfCartesianChart(
//                                         title: ChartTitle(
//                                             text: 'All Events Wightage Graph'),
//                                         primaryXAxis: CategoryAxis(
//                                             // title: AxisTitle(text: 'Key Events')
//                                             ),
//                                         primaryYAxis: NumericAxis(
//                                             // title: AxisTitle(text: 'Weightage')
//                                             ),
//                                         series: <ChartSeries>[
//                                           // Renders column chart
//                                           BarSeries<ChartData, String>(
//                                               width: 0.5,
//                                               trackPadding: 0,
//                                               dataLabelSettings:
//                                                   const DataLabelSettings(
//                                                       isVisible: true),
//                                               dataSource: chartData,
//                                               xValueMapper:
//                                                   (ChartData data, _) => data.x,
//                                               yValueMapper:
//                                                   (ChartData data, _) => data.y,
//                                               pointColorMapper:
//                                                   (ChartData data, _) =>
//                                                       data.y1)
//                                         ]))
//                               ],
//                             ),
//                           ),
//                           // const SizedBox(
//                           //   height: 5,
//                           // ),
//                           // Padding(
//                           //   padding: const EdgeInsets.all(10.0),
//                           //   child: ElevatedButton(
//                           //       style: ElevatedButton.styleFrom(
//                           //           backgroundColor: blue),
//                           //       onPressed: () async {
//                           //         showCupertinoDialog(
//                           //           context: context,
//                           //           builder: (context) =>
//                           //               const CupertinoAlertDialog(
//                           //             content: SizedBox(
//                           //               height: 50,
//                           //               width: 50,
//                           //               child: Center(
//                           //                 child: CircularProgressIndicator(
//                           //                   color: Colors.white,
//                           //                 ),
//                           //               ),
//                           //             ),
//                           //           ),
//                           //         );
//                           //         StoreData();
//                           //       },
//                           //       child: const Text(
//                           //         'Sync Data',
//                           //         textAlign: TextAlign.center,
//                           //         style: TextStyle(
//                           //           fontSize: 15,
//                           //         ),
//                           //       )),
//                           // ),
//                         ],
//                       ),
//                     );
//                   }
//                 }),
//         floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.add),
//             onPressed: (() {
//               _keyProvider!.startdate;
//               _employees.add(
//                 Employee(
//                   srNo: 1,
//                   activity: 'Initial Survey Of Depot With TML & STA Team.',
//                   originalDuration: 1,
//                   startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//                   endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//                   actualstartDate:
//                       DateFormat('dd-MM-yyyy').format(DateTime.now()),
//                   actualendDate:
//                       DateFormat('dd-MM-yyyy').format(DateTime.now()),
//                   actualDuration: 0,
//                   delay: 0,
//                   reasonDelay: '',
//                   unit: 0,
//                   scope: 0,
//                   qtyExecuted: 0,
//                   balanceQty: 0,
//                   percProgress: 0,
//                   weightage: 0.5,
//                 ),
//               );
//               _employeeDataSource.buildDataGridRows();
//               _employeeDataSource.updateDatagridSource();
//             })),
//       ),
//     );
//   }

//   // Future<void> getFirestoreData() async {
//   //   FirebaseFirestore instance = FirebaseFirestore.instance;
//   //   CollectionReference tabledata = instance.collection(widget.depoName!);

//   //   DocumentSnapshot snapshot =
//   //       await tabledata.doc('${widget.depoName}A2').get();
//   //   var data = snapshot.data() as Map;
//   //   alldata = data['data'] as List<dynamic>;

//   //   // _employees = [];
//   //   alldata.forEach((element) {
//   //     _employees.add(Employee.fromJson(element));
//   //   });

//   //   for (int i = 0; i < alldata.length; i++) {
//   //     var weightdata = alldata[i]['Weightage'];
//   //     var yaxisdata = alldata[i]['srNo'];
//   //     weight.add(weightdata);
//   //     yAxis.add(yaxisdata);
//   //   }
//   // }

//   // void loadchartdata() {
//   //   for (int i = 0; i < weight.length; i++) {
//   //     chartData.add(ChartData(yAxis[i].toString(), weight[i], Colors.green));
//   //   }
//   // }

//   List<Employee> getEmployeeData() {
//     return [
//       Employee(
//         srNo: 1,
//         activity: 'Initial Survey Of Depot With TML & STA Team.',
//         originalDuration: 1,
//         startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//         endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//         actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//         actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//         actualDuration: 0,
//         delay: 0,
//         reasonDelay: '',
//         unit: 0,
//         scope: 0,
//         qtyExecuted: 0,
//         balanceQty: 0,
//         percProgress: 0,
//         weightage: 0.5,
//       ),
//       Employee(
//           srNo: 2,
//           activity: 'Details Survey Of Depot With TPC Civil & Electrical Team',
//           originalDuration: 1,
//           startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualDuration: 0,
//           delay: 0,
//           reasonDelay: '',
//           unit: 0,
//           scope: 0,
//           qtyExecuted: 0,
//           balanceQty: 0,
//           percProgress: 0,
//           weightage: 1.0),
//       Employee(
//           srNo: 3,
//           activity:
//               'Survey Report Submission With Existing & Proposed Layout Drawings.',
//           originalDuration: 1,
//           startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualDuration: 0,
//           delay: 0,
//           reasonDelay: '',
//           unit: 0,
//           scope: 0,
//           qtyExecuted: 0,
//           balanceQty: 0,
//           percProgress: 0,
//           weightage: 0.3),
//       Employee(
//           srNo: 4,
//           activity: 'Job Scope Finalization & Preparation Of BOQ',
//           originalDuration: 1,
//           startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualDuration: 0,
//           delay: 0,
//           reasonDelay: '',
//           unit: 0,
//           scope: 0,
//           qtyExecuted: 0,
//           balanceQty: 0,
//           percProgress: 0,
//           weightage: 0.5),
//       Employee(
//           srNo: 5,
//           activity: 'Power Connection / Load Applied By STA To Discom.',
//           originalDuration: 1,
//           startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           endDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualstartDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualendDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
//           actualDuration: 0,
//           delay: 0,
//           reasonDelay: '',
//           unit: 0,
//           scope: 0,
//           qtyExecuted: 0,
//           balanceQty: 0,
//           percProgress: 0,
//           weightage: 0.3)
//     ];
//   }

//   void StoreData() {
//     Map<String, dynamic> table_data = Map();
//     for (var i in _employeeDataSource.dataGridRows) {
//       for (var data in i.getCells()) {
//         if (data.columnName != 'button') {
//           table_data[data.columnName] = data.value;
//         }
//       }

//       tabledata2.add(table_data);
//       table_data = {};
//     }

//     FirebaseFirestore.instance
//         .collection('KeyEventsTable')
//         .doc(widget.depoName!)
//         .collection('KeyDataTable')
//         .doc(widget.userid)
//         .collection('KeyAllEvents')
//         .doc('${widget.depoName}${widget.events}')
//         // .collection(widget.userid!)
//         // .doc('${widget.depoName}A2')
//         .set({
//       'data': tabledata2,
//     }).whenComplete(() {
//       tabledata2.clear();

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: const Text('Data are synced'),
//         backgroundColor: blue,
//       ));
//     });
//   }

//   Future<void> getUserId() async {
//     await AuthService().getCurrentUserId().then((value) {
//       companyId = value;
//     });
//   }

//   identifyUser() async {
//     snap = await FirebaseFirestore.instance.collection('Admin').get();

//     if (snap!.docs[0]['Employee Id'] == companyId &&
//         snap!.docs[0]['CompanyName'] == 'TATA MOTOR') {
//       setState(() {
//         specificUser = false;
//       });
//     }
//   }

//   Future getTableData() async {
//     await FirebaseFirestore.instance
//         .collection('KeyEventsTable')
//         .doc(widget.depoName!)
//         .collection('KeyDataTable')
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         String documentId = element.id;
//         print('Document ID: $documentId');
//         docss.add(documentId);
//         // nestedTableData(docss);
//       });
//     });
//   }

//   Future<void> nestedTableData(docss) async {
//     for (int i = 0; i < docss.length; i++) {
//       await FirebaseFirestore.instance
//           .collection('KeyEventsTable')
//           .doc(widget.depoName!)
//           .collection('KeyDataTable')
//           .doc(docss[i])
//           .collection('KeyAllEvents')
//           .get()
//           .then((value) {
//         value.docs.forEach((element) {
//           print('after');
//           if (element.id == '${widget.depoName}${widget.events}') {
//             for (int i = 0; i < element.data()['data'].length; i++) {
//               // if (widget.events == 'A5') {
//               // statutory
//               //     .add(EmployeeStatutory.fromJson(element.data()['data'][i]));
//               // print(_employees);
//               //    }
//               _employees.add(Employee.fromJson(element.data()['data'][i]));

//               print(_employees);
//             }
//           }
//         });
//       });
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }
