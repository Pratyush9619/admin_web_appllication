import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:web_appllication/OverviewPages/summary.dart';
import '../Authentication/auth_service.dart';
import '../QualityDatasource/quality_EP.dart';
import '../QualityDatasource/quality_acdb.dart';
import '../QualityDatasource/quality_cdi.dart';
import '../QualityDatasource/quality_charger.dart';
import '../QualityDatasource/quality_ci.dart';
import '../QualityDatasource/quality_cmu.dart';
import '../QualityDatasource/quality_ct.dart';
import '../QualityDatasource/quality_msp.dart';
import '../QualityDatasource/quality_pss.dart';
import '../QualityDatasource/quality_rmu.dart';
import '../components/loading_page.dart';
import '../model/quality_checklistModel.dart';
import '../style.dart';
import 'detailed_Eng.dart';

class QualityChecklist extends StatefulWidget {
  String? userId;
  String? cityName;
  String? depoName;
  String? currentDate;
  bool? isHeader;

  QualityChecklist(
      {super.key,
      this.userId,
      required this.cityName,
      required this.depoName,
      this.currentDate,
      this.isHeader = true});

  @override
  State<QualityChecklist> createState() => _QualityChecklistState();
}

// List<QualitychecklistModel> checklisttable = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable1 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable2 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable3 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable4 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable5 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable6 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable7 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable8 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable9 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable10 = <QualitychecklistModel>[];

// late QualityChecklistDataSource _checklistDataSource;
late QualityPSSDataSource _qualityPSSDataSource;
late QualityrmuDataSource _qualityrmuDataSource;
late QualityctDataSource _qualityctDataSource;
late QualitycmuDataSource _qualitycmuDataSource;
late QualityacdDataSource _qualityacdDataSource;
late QualityCIDataSource _qualityCIDataSource;
late QualityCDIDataSource _qualityCDIDataSource;
late QualityMSPDataSource _qualityMSPDataSource;
late QualityChargerDataSource _qualityChargerDataSource;
late QualityEPDataSource _qualityEPDataSource;

late DataGridController _dataGridController;
bool _isloading = true;
List<dynamic> psstabledatalist = [];
List<dynamic> rmutabledatalist = [];
List<dynamic> cttabledatalist = [];
List<dynamic> cmutabledatalist = [];
List<dynamic> acdbtabledatalist = [];
List<dynamic> citabledatalist = [];
List<dynamic> cditabledatalist = [];
List<dynamic> msptabledatalist = [];
List<dynamic> chargertabledatalist = [];
List<dynamic> eptabledatalist = [];
Stream? _stream;
Stream? _stream1;
Stream? _stream2;
Stream? _stream3;
Stream? _stream4;
Stream? _stream5;
Stream? _stream6;
Stream? _stream7;
Stream? _stream8;
Stream? _stream9;

TextEditingController ename = TextEditingController();
var empName,
    distev,
    vendorname,
    date,
    olano,
    panel,
    serialno,
    depotname,
    customername;

dynamic alldata;
int? _selectedIndex = 0;
dynamic userId;
List<String> title = [
  'CHECKLIST FOR INSTALLATION OF PSS',
  'CHECKLIST FOR INSTALLATION OF RMU',
  'CHECKLIST FOR INSTALLATION OF  COVENTIONAL TRANSFORMER',
  'CHECKLIST FOR INSTALLATION OF CTPT METERING UNIT',
  'CHECKLIST FOR INSTALLATION OF ACDB',
  'CHECKLIST FOR  CABLE INSTALLATION ',
  'CHECKLIST FOR  CABLE DRUM / ROLL INSPECTION',
  'CHECKLIST FOR MCCB PANEL',
  'CHECKLIST FOR CHARGER PANEL',
  'CHECKLIST FOR INSTALLATION OF  EARTH PIT',
];

class _QualityChecklistState extends State<QualityChecklist> {
  @override
  void initState() {
    //   // final user = FirebaseAuth.instance.currentUser;
    //   // print('User$user');
    //   _isloading = false;
    //   _stream = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('PSS TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream1 = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('RMU TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream2 = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CONVENTIONAL TRANSFORMER TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream3 = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CTPT METERING UNIT TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream4 = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('ACDB TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream5 = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CABLE INSTALLATION TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream6 = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CDI TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream7 = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('MSP TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream8 = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CHARGER TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream9 = FirebaseFirestore.instance
    //       .collection('QualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('EARTH TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    // getUserId().whenComplete(() {
    qualitylisttable1 = getData();
    _qualityPSSDataSource = QualityPSSDataSource(
        qualitylisttable1, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    qualitylisttable2 = getData();
    _qualityrmuDataSource = QualityrmuDataSource(
        qualitylisttable2, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    qualitylisttable3 = getData();
    _qualityctDataSource = QualityctDataSource(
        qualitylisttable2, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    qualitylisttable4 = getData();
    _qualitycmuDataSource = QualitycmuDataSource(
        qualitylisttable4, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    qualitylisttable5 = getData();
    _qualityacdDataSource = QualityacdDataSource(
        qualitylisttable5, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    qualitylisttable6 = getData();
    _qualityCIDataSource = QualityCIDataSource(
        qualitylisttable6, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    qualitylisttable7 = getData();
    _qualityCDIDataSource = QualityCDIDataSource(
        qualitylisttable7, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    qualitylisttable8 = getData();
    _qualityMSPDataSource = QualityMSPDataSource(
        qualitylisttable8, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    qualitylisttable9 = getData();
    _qualityChargerDataSource = QualityChargerDataSource(
        qualitylisttable9, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    qualitylisttable10 = getData();
    _qualityEPDataSource = QualityEPDataSource(
        qualitylisttable10, widget.depoName!, widget.cityName!);
    _dataGridController = DataGridController();

    _isloading = false;
    setState(() {});
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.currentDate =
        widget.currentDate ?? DateFormat.yMMMMd().format(DateTime.now());

    _isloading = false;
    _stream = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('PSS TABLE DATA')
        .doc('PSS')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    _stream1 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('RMU TABLE DATA')
        .doc('RMU')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    _stream2 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CONVENTIONAL TRANSFORMER TABLE DATA')
        .doc('CONVENTIONAL TRANSFORMER')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    _stream3 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CTPT METERING UNIT TABLE DATA')
        .doc('CTPT METERING UNIT')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    _stream4 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('ACDB TABLE DATA')
        .doc('ACDB DATA')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    _stream5 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CABLE INSTALLATION TABLE DATA')
        .doc('CABLE INSTALLATION')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    _stream6 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CDI TABLE DATA')
        .doc('CDI DATA')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    _stream7 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('MSP TABLE DATA')
        .doc('MSP DATA')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    _stream8 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CHARGER TABLE DATA')
        .doc('CHARGER DATA')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    _stream9 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('EARTH TABLE DATA')
        .doc('EARTH DATA')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .snapshots();

    // qualitylisttable1 = getData();
    // _qualityPSSDataSource = QualityPSSDataSource(qualitylisttable1);
    // _dataGridController = DataGridController();

    // qualitylisttable2 = getData();
    // _qualityrmuDataSource = QualityrmuDataSource(qualitylisttable2);
    // _dataGridController = DataGridController();

    // qualitylisttable3 = getData();
    // _qualityctDataSource = QualityctDataSource(qualitylisttable2);
    // _dataGridController = DataGridController();

    // qualitylisttable4 = getData();
    // _qualitycmuDataSource = QualitycmuDataSource(qualitylisttable4);
    // _dataGridController = DataGridController();

    // qualitylisttable5 = getData();
    // _qualityacdDataSource = QualityacdDataSource(qualitylisttable5);
    // _dataGridController = DataGridController();

    // qualitylisttable6 = getData();
    // _qualityCIDataSource = QualityCIDataSource(qualitylisttable6);
    // _dataGridController = DataGridController();

    // qualitylisttable7 = getData();
    // _qualityCDIDataSource = QualityCDIDataSource(qualitylisttable7);
    // _dataGridController = DataGridController();

    // qualitylisttable8 = getData();
    // _qualityMSPDataSource = QualityMSPDataSource(qualitylisttable8);
    // _dataGridController = DataGridController();

    // qualitylisttable9 = getData();
    // _qualityChargerDataSource = QualityChargerDataSource(qualitylisttable9);
    // _dataGridController = DataGridController();

    // qualitylisttable10 = getData();
    // _qualityEPDataSource = QualityEPDataSource(qualitylisttable10);
    // _dataGridController = DataGridController();
    return SafeArea(
      child: DefaultTabController(
          length: 10,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading:
                  widget.isHeader! ? widget.isHeader! : false,
              backgroundColor: blue,
              title: widget.isHeader!
                  ? Text(
                      '${widget.cityName} / ${widget.depoName} / Quality Checklist')
                  : const Text(''),
              actions: [
                widget.isHeader!
                    ? Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 40, top: 10, bottom: 10),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewSummary(
                                            depoName: widget.depoName,
                                            cityName: widget.cityName,
                                            userId: widget.userId,
                                            id: 'Quality Checklist',
                                            selectedtab:
                                                _selectedIndex.toString(),
                                            isHeader: false,
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    'View Summary',
                                    style:
                                        TextStyle(color: white, fontSize: 20),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, top: 10, bottom: 10),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: lightblue),
                              child: TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection(
                                            'QualityChecklistCollection')
                                        .doc('${widget.depoName}')
                                        .collection('ChecklistData')
                                        .doc(widget.currentDate)
                                        .set({
                                      'EmployeeName':
                                          empName ?? 'Enter Employee Name',
                                      'Dist EV': distev ?? 'Enter Dist EV',
                                      'VendorName':
                                          vendorname ?? 'Enter Vendor Name',
                                      'Date': date ?? 'Enter Date',
                                      'OlaNo': olano ?? 'Enter Ola No',
                                      'PanelNo': panel ?? 'Enter Panel',
                                      'DepotName':
                                          depotname ?? 'Enter depot Name Name',
                                      'CustomerName':
                                          customername ?? 'Enter Customer Name'
                                    });
                                    storeData();
                                  },
                                  child: Text(
                                    'Sync Data',
                                    style:
                                        TextStyle(color: white, fontSize: 20),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 150),
                              child: GestureDetector(
                                  onTap: () {
                                    onWillPop(context);
                                  },
                                  child: Image.asset(
                                    'assets/logout.png',
                                    height: 20,
                                    width: 20,
                                  )))
                        ],
                      )
                    : Container()
              ],
              bottom: TabBar(
                labelColor: Colors.yellow,
                labelStyle: buttonWhite,
                unselectedLabelColor: white,

                //indicatorSize: TabBarIndicatorSize.label,
                indicator: MaterialIndicator(
                  horizontalPadding: 24,
                  bottomLeftRadius: 8,
                  bottomRightRadius: 8,
                  color: almostblack,
                  paintingStyle: PaintingStyle.fill,
                ),
                onTap: (value) {
                  _selectedIndex = value;
                  setState(() {});
                },
                tabs: const [
                  Tab(text: "PSS"),
                  Tab(text: "RMU"),
                  Tab(text: "CT"),
                  Tab(text: "CMU"),
                  Tab(text: "ACDB"),
                  Tab(text: "CI"),
                  Tab(text: "CDI"),
                  Tab(text: "MSP"),
                  Tab(text: "CHARGER"),
                  Tab(text: "EARTH PIT"),
                ],
              ),
            ),
            //  PreferredSize(
            //   child:
            //   CustomAppBar(
            //     text:
            //         'Quality Checklist / ${widget.cityName} / ${widget.depoName}',
            //     haveSynced: widget.isHeader!,
            //     havebottom: widget.isHeader!,
            //   ),
            //   preferredSize: Size.fromHeight(100),
            // ),
            body: TabBarView(children: [
              upperScreen(),
              upperScreen(),
              upperScreen(),
              upperScreen(),
              upperScreen(),
              upperScreen(),
              upperScreen(),
              upperScreen(),
              upperScreen(),
              upperScreen(),
            ]),
          )),
    );
  }

  void storeData() {
    Map<String, dynamic> pss_table_data = Map();
    Map<String, dynamic> rmu_table_data = Map();
    Map<String, dynamic> ct_table_data = Map();
    Map<String, dynamic> cmu_table_data = Map();
    Map<String, dynamic> acdb_table_data = Map();
    Map<String, dynamic> ci_table_data = Map();
    Map<String, dynamic> cdi_table_data = Map();
    Map<String, dynamic> msp_table_data = Map();
    Map<String, dynamic> charger_table_data = Map();
    Map<String, dynamic> ep_table_data = Map();

    for (var i in _qualityPSSDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button' && data.columnName != 'Delete') {
          pss_table_data[data.columnName] = data.value;
        }
      }

      psstabledatalist.add(pss_table_data);
      pss_table_data = {};
    }

    FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('PSS TABLE DATA')
        .doc('PSS')
        .collection(widget.userId!)
        .doc(widget.currentDate)
        .set({
      'data': psstabledatalist,
    }).whenComplete(() {
      psstabledatalist.clear();
      for (var i in _qualityrmuDataSource.dataGridRows) {
        for (var data in i.getCells()) {
          if (data.columnName != 'button' && data.columnName != 'Delete') {
            rmu_table_data[data.columnName] = data.value;
          }
        }
        rmutabledatalist.add(rmu_table_data);
        rmu_table_data = {};
      }

      FirebaseFirestore.instance
          .collection('QualityChecklist')
          .doc('${widget.depoName}')
          .collection('RMU TABLE DATA')
          .doc('RMU')
          .collection(widget.userId!)
          .doc(widget.currentDate)
          .set({
        'data': rmutabledatalist,
      }).whenComplete(() {
        rmutabledatalist.clear();
        for (var i in _qualityctDataSource.dataGridRows) {
          for (var data in i.getCells()) {
            if (data.columnName != 'button' && data.columnName != 'Delete') {
              ct_table_data[data.columnName] = data.value;
            }
          }

          cttabledatalist.add(ct_table_data);
          ct_table_data = {};
        }

        FirebaseFirestore.instance
            .collection('QualityChecklist')
            .doc('${widget.depoName}')
            .collection('CONVENTIONAL TRANSFORMER TABLE DATA')
            .doc('CONVENTIONAL TRANSFORMER')
            .collection(widget.userId!)
            .doc(widget.currentDate)
            .set({
          'data': cttabledatalist,
        }).whenComplete(() {
          cttabledatalist.clear();
          for (var i in _qualitycmuDataSource.dataGridRows) {
            for (var data in i.getCells()) {
              if (data.columnName != 'button' && data.columnName != 'Delete') {
                cmu_table_data[data.columnName] = data.value;
              }
            }
            cmutabledatalist.add(cmu_table_data);
            cmu_table_data = {};
          }

          FirebaseFirestore.instance
              .collection('QualityChecklist')
              .doc('${widget.depoName}')
              .collection('CTPT METERING UNIT TABLE DATA')
              .doc('CTPT METERING UNIT')
              .collection(widget.userId!)
              .doc(widget.currentDate)
              .set({
            'data': cmutabledatalist,
          }).whenComplete(() {
            cmutabledatalist.clear();
            for (var i in _qualityacdDataSource.dataGridRows) {
              for (var data in i.getCells()) {
                if (data.columnName != 'button' &&
                    data.columnName != 'Delete') {
                  acdb_table_data[data.columnName] = data.value;
                }
              }
              acdbtabledatalist.add(acdb_table_data);
              acdb_table_data = {};
            }

            FirebaseFirestore.instance
                .collection('QualityChecklist')
                .doc('${widget.depoName}')
                .collection('ACDB TABLE DATA')
                .doc('ACDB DATA')
                .collection(widget.userId!)
                .doc(widget.currentDate)
                .set({
              'data': acdbtabledatalist,
            }).whenComplete(() {
              acdbtabledatalist.clear();
              for (var i in _qualityCIDataSource.dataGridRows) {
                for (var data in i.getCells()) {
                  if (data.columnName != 'button' &&
                      data.columnName != 'Delete') {
                    ci_table_data[data.columnName] = data.value;
                  }
                }
                citabledatalist.add(ci_table_data);
                ci_table_data = {};
              }

              FirebaseFirestore.instance
                  .collection('QualityChecklist')
                  .doc('${widget.depoName}')
                  .collection('CABLE INSTALLATION TABLE DATA')
                  .doc('CABLE INSTALLATION')
                  .collection(widget.userId!)
                  .doc(widget.currentDate)
                  .set({
                'data': citabledatalist,
              }).whenComplete(() {
                citabledatalist.clear();
                for (var i in _qualityCDIDataSource.dataGridRows) {
                  for (var data in i.getCells()) {
                    if (data.columnName != 'button' &&
                        data.columnName != 'Delete') {
                      cdi_table_data[data.columnName] = data.value;
                    }
                  }
                  cditabledatalist.add(cdi_table_data);
                  cdi_table_data = {};
                }

                FirebaseFirestore.instance
                    .collection('QualityChecklist')
                    .doc('${widget.depoName}')
                    .collection('CDI TABLE DATA')
                    .doc('CDI DATA')
                    .collection(widget.userId!)
                    .doc(widget.currentDate)
                    .set({
                  'data': cditabledatalist,
                }).whenComplete(() {
                  cditabledatalist.clear();
                  for (var i in _qualityMSPDataSource.dataGridRows) {
                    for (var data in i.getCells()) {
                      if (data.columnName != 'button' &&
                          data.columnName != 'Delete') {
                        msp_table_data[data.columnName] = data.value;
                      }
                    }
                    msptabledatalist.add(msp_table_data);
                    msp_table_data = {};
                  }

                  FirebaseFirestore.instance
                      .collection('QualityChecklist')
                      .doc('${widget.depoName}')
                      .collection('MSP TABLE DATA')
                      .doc('MSP DATA')
                      .collection(widget.userId!)
                      .doc(widget.currentDate)
                      .set({
                    'data': msptabledatalist,
                  }).whenComplete(() {
                    msptabledatalist.clear();
                    for (var i in _qualityChargerDataSource.dataGridRows) {
                      for (var data in i.getCells()) {
                        if (data.columnName != 'button' &&
                            data.columnName != 'Delete') {
                          charger_table_data[data.columnName] = data.value;
                        }
                      }
                      chargertabledatalist.add(charger_table_data);
                      charger_table_data = {};
                    }

                    FirebaseFirestore.instance
                        .collection('QualityChecklist')
                        .doc('${widget.depoName}')
                        .collection('CHARGER TABLE DATA')
                        .doc('CHARGER DATA')
                        .collection(widget.userId!)
                        .doc(widget.currentDate)
                        .set({
                      'data': chargertabledatalist,
                    }).whenComplete(() {
                      chargertabledatalist.clear();
                      for (var i in _qualityEPDataSource.dataGridRows) {
                        for (var data in i.getCells()) {
                          if (data.columnName != 'button' &&
                              data.columnName != 'Delete') {
                            ep_table_data[data.columnName] = data.value;
                          }
                        }
                        eptabledatalist.add(ep_table_data);
                        ep_table_data = {};
                      }

                      FirebaseFirestore.instance
                          .collection('QualityChecklist')
                          .doc('${widget.depoName}')
                          .collection('EARTH TABLE DATA')
                          .doc('EARTH DATA')
                          .collection(widget.userId!)
                          .doc(widget.currentDate)
                          .set({
                        'data': eptabledatalist,
                      }).whenComplete(() {
                        eptabledatalist.clear();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Data are synced'),
                          backgroundColor: blue,
                        ));
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  // Future<void> getUserId() async {
  //   await AuthService().getCurrentUserId().then((value) {
  //     userId = value;
  //   });
  // }

  upperScreen() {
    return _isloading
        ? LoadingPage()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('QualityChecklistCollection')
                .doc('${widget.depoName}')
                .collection(widget.userId!)
                .doc(widget.currentDate)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 80,
                      decoration: BoxDecoration(color: lightblue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/Tata-Power.jpeg',
                                  height: 50, width: 100),
                              const Text('TATA POWER'),
                            ],
                          ),
                          Text(
                            title[int.parse(_selectedIndex.toString())],
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const Text('TPCL /DIST/EV/CHECKLIST ')
                        ],
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(color: lightblue),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  color: lightblue,
                                  width: 625,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            ' Employee Name',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: true
                                                  ? TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 0,
                                                                      bottom: 0,
                                                                      left: 5)),
                                                      initialValue: snapshot
                                                              .data!
                                                              .data()
                                                              .toString()
                                                              .contains(
                                                                  'EmployeeName')
                                                          ? snapshot.data!.get(
                                                              'EmployeeName')
                                                          : 'Employee Name',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      onChanged: (value) {
                                                        empName = value;
                                                      },
                                                      onSaved: (newValue) {
                                                        empName =
                                                            newValue.toString();
                                                      },
                                                    )
                                                  : Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: blue)),
                                                      child: Text(
                                                        snapshot.data!
                                                                .data()
                                                                .toString()
                                                                .contains(
                                                                    'EmployeeName')
                                                            ? snapshot.data!.get(
                                                                    'EmployeeName') ??
                                                                ''
                                                            : 'Employee Name',
                                                      )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 625,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Doc No.:TPCL/ DIST-EV',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: true
                                                  ? TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 0,
                                                                      bottom: 0,
                                                                      left: 5)),
                                                      initialValue: snapshot
                                                              .data!
                                                              .data()
                                                              .toString()
                                                              .contains(
                                                                  'Dist EV')
                                                          ? snapshot.data!.get(
                                                                  'Dist EV') ??
                                                              ''
                                                          : 'Dist EV',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      onChanged: (value) {
                                                        distev = value;
                                                      },
                                                      onSaved: (newValue) {
                                                        distev =
                                                            newValue.toString();
                                                      },
                                                    )
                                                  : Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: blue)),
                                                      child: Text(snapshot.data!
                                                              .data()
                                                              .toString()
                                                              .contains(
                                                                  'Dist EV')
                                                          ? snapshot.data!.get(
                                                                  'Dist EV') ??
                                                              ''
                                                          : 'Dist EV')))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 625,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            ' VENDOR NAME',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: true
                                                  ? TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 0,
                                                                      bottom: 0,
                                                                      left: 5)),
                                                      initialValue: snapshot
                                                              .data!
                                                              .data()
                                                              .toString()
                                                              .contains(
                                                                  'VendorName')
                                                          ? snapshot.data!.get(
                                                                  'VendorName') ??
                                                              ''
                                                          : 'VendorName',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      onChanged: (value) {
                                                        vendorname = value;
                                                      },
                                                      onSaved: (newValue) {
                                                        vendorname =
                                                            newValue.toString();
                                                      },
                                                    )
                                                  : Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: blue)),
                                                      child: Text(snapshot.data!
                                                              .data()
                                                              .toString()
                                                              .contains(
                                                                  'VendorName')
                                                          ? snapshot.data!.get(
                                                                  'VendorName') ??
                                                              ''
                                                          : 'VendorName')))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 625,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            ' DATE',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: true
                                                  ? TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 0,
                                                                      bottom: 0,
                                                                      left: 5)),
                                                      initialValue: snapshot
                                                              .data!
                                                              .data()
                                                              .toString()
                                                              .contains('Date')
                                                          ? snapshot.data!.get(
                                                                  'Date') ??
                                                              ''
                                                          : 'Date',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      onChanged: (value) {
                                                        date = value;
                                                      },
                                                      onSaved: (newValue) {
                                                        date =
                                                            newValue.toString();
                                                      },
                                                    )
                                                  : Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: blue)),
                                                      child: Text(
                                                        snapshot.data!
                                                                .data()
                                                                .toString()
                                                                .contains(
                                                                    'Date')
                                                            ? snapshot.data!.get(
                                                                    'Date') ??
                                                                ''
                                                            : 'Date',
                                                      )))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  color: lightblue,
                                  width: 625,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            ' OLA NUMBER',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: true
                                                  ? TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 0,
                                                                      bottom: 0,
                                                                      left: 5)),
                                                      initialValue: snapshot
                                                              .data!
                                                              .data()
                                                              .toString()
                                                              .contains('OlaNo')
                                                          ? snapshot.data!.get(
                                                                  'OlaNo') ??
                                                              ''
                                                          : 'OlaNo',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      onChanged: (value) {
                                                        olano = value;
                                                      },
                                                      onSaved: (newValue) {
                                                        olano =
                                                            newValue.toString();
                                                      },
                                                    )
                                                  : Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: blue)),
                                                      child: Text(snapshot.data!
                                                              .data()
                                                              .toString()
                                                              .contains('OlaNo')
                                                          ? snapshot.data!.get(
                                                                  'OlaNo') ??
                                                              ''
                                                          : 'OlaNo')))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 625,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            ' PANEL SR NO.',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: true
                                                  ? TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 0,
                                                                      bottom: 0,
                                                                      left: 5)),
                                                      initialValue: snapshot
                                                              .data!
                                                              .data()
                                                              .toString()
                                                              .contains(
                                                                  'PanelNo')
                                                          ? snapshot.data!.get(
                                                                  'PanelNo') ??
                                                              ''
                                                          : 'PanelNo',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      onChanged: (value) {
                                                        panel = value;
                                                      },
                                                      onSaved: (newValue) {
                                                        panel =
                                                            newValue.toString();
                                                      },
                                                    )
                                                  : Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: blue)),
                                                      child: Text(
                                                        snapshot.data!
                                                                .data()
                                                                .toString()
                                                                .contains(
                                                                    'PanelNo')
                                                            ? snapshot.data!.get(
                                                                    'PanelNo') ??
                                                                ''
                                                            : 'PanelNo',
                                                      )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 625,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            ' Depot Name',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: true
                                                  ? TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 0,
                                                                      bottom: 0,
                                                                      left: 5)),
                                                      initialValue: snapshot
                                                              .data!
                                                              .data()
                                                              .toString()
                                                              .contains(
                                                                  'DepotName')
                                                          ? snapshot.data!.get(
                                                                  'DepotName') ??
                                                              ''
                                                          : 'DepotName',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      onChanged: (value) {
                                                        depotname = value;
                                                      },
                                                      onSaved: (newValue) {
                                                        depotname =
                                                            newValue.toString();
                                                      },
                                                    )
                                                  : Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: blue)),
                                                      child: Text(
                                                        snapshot.data!
                                                                .data()
                                                                .toString()
                                                                .contains(
                                                                    'DepotName')
                                                            ? snapshot.data!.get(
                                                                    'DepotName') ??
                                                                ''
                                                            : 'DepotName',
                                                      )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 625,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'CustomerName',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: true
                                                  ? TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top: 0,
                                                                      bottom: 0,
                                                                      left: 5)),
                                                      initialValue: snapshot
                                                              .data!
                                                              .data()
                                                              .toString()
                                                              .contains(
                                                                  'CustomerName')
                                                          ? snapshot.data!.get(
                                                                  'CustomerName') ??
                                                              ''
                                                          : 'CustomerName',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      onChanged: (value) {
                                                        customername = value;
                                                      },
                                                      onSaved: (newValue) {
                                                        customername =
                                                            newValue.toString();
                                                      },
                                                    )
                                                  : Container(
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: blue)),
                                                      child: Text(
                                                        snapshot.data!
                                                                .data()
                                                                .toString()
                                                                .contains(
                                                                    'CustomerName')
                                                            ? snapshot.data!.get(
                                                                    'CustomerName') ??
                                                                ''
                                                            : 'CustomerName',
                                                      )))),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    Expanded(
                      child: StreamBuilder(
                        stream: _selectedIndex == 0
                            ? _stream
                            : _selectedIndex == 1
                                ? _stream1
                                : _selectedIndex == 2
                                    ? _stream2
                                    : _selectedIndex == 3
                                        ? _stream3
                                        : _selectedIndex == 4
                                            ? _stream4
                                            : _selectedIndex == 5
                                                ? _stream5
                                                : _selectedIndex == 6
                                                    ? _stream6
                                                    : _selectedIndex == 7
                                                        ? _stream7
                                                        : _selectedIndex == 8
                                                            ? _stream8
                                                            : _stream9,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingPage();
                          }
                          if (!snapshot.hasData ||
                              snapshot.data.exists == false) {
                            return widget.isHeader!
                                ? SfDataGridTheme(
                                    data:
                                        SfDataGridThemeData(headerColor: blue),
                                    child: SfDataGrid(
                                      source: _selectedIndex == 0
                                          ? _qualityPSSDataSource
                                          : _selectedIndex == 1
                                              ? _qualityrmuDataSource
                                              : _selectedIndex == 2
                                                  ? _qualityctDataSource
                                                  : _selectedIndex == 3
                                                      ? _qualitycmuDataSource
                                                      : _selectedIndex == 4
                                                          ? _qualityacdDataSource
                                                          : _selectedIndex == 5
                                                              ? _qualityCIDataSource
                                                              : _selectedIndex ==
                                                                      6
                                                                  ? _qualityCDIDataSource
                                                                  : _selectedIndex ==
                                                                          7
                                                                      ? _qualityMSPDataSource
                                                                      : _selectedIndex ==
                                                                              8
                                                                          ? _qualityChargerDataSource
                                                                          : _qualityEPDataSource,

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

                                      // onQueryRowHeight: (details) {
                                      //   return details.rowIndex == 0 ? 60.0 : 49.0;
                                      // },
                                      columns: [
                                        GridColumn(
                                          columnName: 'srNo',
                                          width: 80,
                                          autoFitPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                          allowEditing: true,
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
                                          width: 350,
                                          columnName: 'checklist',
                                          allowEditing: true,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('ACTIVITY',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'responsibility',
                                          width: 250,
                                          allowEditing: true,
                                          label: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            alignment: Alignment.center,
                                            child: Text('RESPONSIBILITY',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: white,
                                                )),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'Reference',
                                          allowEditing: true,
                                          width: 250,
                                          label: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('DOCUMENT REFERENCE',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'observation',
                                          allowEditing: true,
                                          width: 200,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('OBSERVATION',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'Upload',
                                          allowEditing: true,
                                          visible: true,
                                          width: 150,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('Upload',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'View',
                                          allowEditing: true,
                                          width: 150,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('View',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: white)),
                                          ),
                                        ),
                                        GridColumn(
                                          columnName: 'Delete',
                                          autoFitPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                          allowEditing: false,
                                          visible: true,
                                          width: 120,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text('Delete Row',
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
                                      ],

                                      // stackedHeaderRows: [
                                      //   StackedHeaderRow(cells: [
                                      //     StackedHeaderCell(
                                      //         columnNames: ['SrNo'],
                                      //         child: Container(child: Text('Project')))
                                      //   ])
                                      // ],
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                      padding: EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(color: blue)),
                                      child: const Text(
                                        '     No data available yet \n Please wait for admin process',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                          } else if (snapshot.hasData) {
                            alldata = '';
                            alldata = snapshot.data['data'] as List<dynamic>;
                            qualitylisttable1.clear();
                            alldata.forEach((element) {
                              qualitylisttable1
                                  .add(QualitychecklistModel.fromJson(element));
                              if (_selectedIndex == 0) {
                                _qualityPSSDataSource = QualityPSSDataSource(
                                    qualitylisttable1,
                                    widget.depoName!,
                                    widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 1) {
                                _qualityrmuDataSource = QualityrmuDataSource(
                                    qualitylisttable1,
                                    widget.depoName!,
                                    widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 2) {
                                _qualityctDataSource = QualityctDataSource(
                                    qualitylisttable1,
                                    widget.depoName!,
                                    widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 3) {
                                _qualitycmuDataSource = QualitycmuDataSource(
                                    qualitylisttable1,
                                    widget.depoName!,
                                    widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 4) {
                                _qualityacdDataSource = QualityacdDataSource(
                                    qualitylisttable1,
                                    widget.depoName!,
                                    widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 5) {
                                _qualityCIDataSource = QualityCIDataSource(
                                    qualitylisttable1,
                                    widget.depoName!,
                                    widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 6) {
                                _qualityCDIDataSource = QualityCDIDataSource(
                                    qualitylisttable1,
                                    widget.depoName!,
                                    widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 7) {
                                _qualityMSPDataSource = QualityMSPDataSource(
                                    qualitylisttable1,
                                    widget.depoName!,
                                    widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 8) {
                                _qualityChargerDataSource =
                                    QualityChargerDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 9) {
                                _qualityEPDataSource = QualityEPDataSource(
                                    qualitylisttable1,
                                    widget.depoName!,
                                    widget.cityName!);
                                _dataGridController = DataGridController();
                              }
                            });
                            return SfDataGridTheme(
                              data: SfDataGridThemeData(headerColor: blue),
                              child: SfDataGrid(
                                source: _selectedIndex == 0
                                    ? _qualityPSSDataSource
                                    : _selectedIndex == 1
                                        ? _qualityrmuDataSource
                                        : _selectedIndex == 2
                                            ? _qualityctDataSource
                                            : _selectedIndex == 3
                                                ? _qualitycmuDataSource
                                                : _selectedIndex == 4
                                                    ? _qualityacdDataSource
                                                    : _selectedIndex == 5
                                                        ? _qualityCIDataSource
                                                        : _selectedIndex == 6
                                                            ? _qualityCDIDataSource
                                                            : _selectedIndex ==
                                                                    7
                                                                ? _qualityMSPDataSource
                                                                : _selectedIndex ==
                                                                        8
                                                                    ? _qualityChargerDataSource
                                                                    : _qualityEPDataSource,

                                //key: key,
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
                                    width: 80,
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    allowEditing: true,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('Sr No',
                                          overflow: TextOverflow.values.first,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white)),
                                    ),
                                  ),
                                  GridColumn(
                                    width: 350,
                                    columnName: 'checklist',
                                    allowEditing: true,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('ACTIVITY',
                                          overflow: TextOverflow.values.first,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white)),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'responsibility',
                                    width: 250,
                                    allowEditing: true,
                                    label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: Text('RESPONSIBILITY',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: white,
                                          )),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Reference',
                                    allowEditing: true,
                                    width: 250,
                                    label: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('DOCUMENT REFERENCE',
                                          overflow: TextOverflow.values.first,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white)),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'observation',
                                    allowEditing: true,
                                    width: 200,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('OBSERVATION',
                                          overflow: TextOverflow.values.first,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white)),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Upload',
                                    allowEditing: true,
                                    visible: true,
                                    width: 150,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('Upload.',
                                          overflow: TextOverflow.values.first,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white)),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'View',
                                    allowEditing: true,
                                    width: 150,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('View',
                                          overflow: TextOverflow.values.first,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white)),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Delete',
                                    autoFitPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    allowEditing: false,
                                    width: 120,
                                    visible: true,
                                    label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text('Delete Row',
                                          overflow: TextOverflow.values.first,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white)
                                          //    textAlign: TextAlign.center,
                                          ),
                                    ),
                                  ),
                                ],

                                // stackedHeaderRows: [
                                //   StackedHeaderRow(cells: [
                                //     StackedHeaderCell(
                                //         columnNames: ['SrNo'],
                                //         child: Container(child: Text('Project')))
                                //   ])
                                // ],
                              ),
                            );
                          } else {
                            // here w3e have to put Nodata page
                            return LoadingPage();
                          }
                        },
                      ),
                    ),
                    widget.isHeader!
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: FloatingActionButton(
                                child: Icon(Icons.add),
                                onPressed: (() {
                                  if (_selectedIndex == 0) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualityPSSDataSource.buildDataGridRows();
                                    _qualityPSSDataSource
                                        .updateDatagridSource();
                                  } else if (_selectedIndex == 1) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualityrmuDataSource.buildDataGridRows();
                                    _qualityrmuDataSource
                                        .updateDatagridSource();
                                  } else if (_selectedIndex == 2) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualityctDataSource.buildDataGridRows();
                                    _qualityctDataSource.updateDatagridSource();
                                  } else if (_selectedIndex == 3) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualitycmuDataSource.buildDataGridRows();
                                    _qualitycmuDataSource
                                        .updateDatagridSource();
                                  } else if (_selectedIndex == 4) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualityacdDataSource.buildDataGridRows();
                                    _qualityacdDataSource
                                        .updateDatagridSource();
                                  } else if (_selectedIndex == 5) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualityCIDataSource.buildDataGridRows();
                                    _qualityCIDataSource.updateDatagridSource();
                                  } else if (_selectedIndex == 6) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualityCDIDataSource.buildDataGridRows();
                                    _qualityCDIDataSource
                                        .updateDatagridSource();
                                  } else if (_selectedIndex == 7) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualityMSPDataSource.buildDataGridRows();
                                    _qualityMSPDataSource
                                        .updateDatagridSource();
                                  } else if (_selectedIndex == 8) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualityChargerDataSource
                                        .buildDataGridRows();
                                    _qualityChargerDataSource
                                        .updateDatagridSource();
                                  } else if (_selectedIndex == 9) {
                                    qualitylisttable1.add(
                                      QualitychecklistModel(
                                        srNo: 1,
                                        checklist: 'checklist',
                                        responsibility: 'responsibility',
                                        reference: 'reference',
                                        observation: 'observation',
                                        // photoNo: 12345,
                                      ),
                                    );
                                    _qualityEPDataSource.buildDataGridRows();
                                    _qualityEPDataSource.updateDatagridSource();
                                  }
                                }),
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
              } else {
                return LoadingPage();
              }
            },
          );
  }

  HeaderValue(String title, String hintValue, String changeValue) {
    return Container(
      color: lightblue,
      width: 625,
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: 150,
              child: Text(
                title,
              )),
          SizedBox(width: 5),
          Expanded(
              child: Container(
                  height: 30,
                  child: widget.isHeader!
                      ? TextFormField(
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 0, bottom: 0, left: 5)),
                          initialValue: hintValue,
                          style: const TextStyle(fontSize: 15),
                          // onChanged: (value) {
                          //   changeValue = value;
                          // },
                          onSaved: (newValue) {
                            changeValue = newValue.toString();
                          },
                        )
                      : Container(
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: blue)),
                          child: Text(hintValue)))),
        ],
      ),
    );
  }

  List<QualitychecklistModel> getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: 'checklist',
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
        // // photoNo: 12345,
      ),
    ];
  }
}
