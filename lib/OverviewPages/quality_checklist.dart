import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:web_appllication/OverviewPages/summary.dart';
import '../Authentication/auth_service.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_Ironite_flooring.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_backfilling.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_ceiling.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_excavation.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_flooring.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_glazzing.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_inspection.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_massonary.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_painting.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_paving.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_proofing.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_roofing.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_EP.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_acdb.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_cdi.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_charger.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_ci.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_cmu.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_ct.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_msp.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_pss.dart';
import '../QualityDatasource/qualityElectricalDatasource/quality_rmu.dart';
import '../components/loading_page.dart';
import '../model/quality_checklistModel.dart';
import '../style.dart';
import '../widgets/activity_headings.dart';

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
late QualityExcavationDataSource _qualityExcavationDataSource;
late QualityBackFillingDataSource _qualityBackFillingDataSource;
late QualityMassonaryDataSource _qualityMassonaryDataSource;
late QualityGlazzingDataSource _qualityGlazzingDataSource;
late QualityCeillingDataSource _qualityCeillingDataSource;
late QualityIroniteflooringDataSource _qualityIroniteflooringDataSource;
late QualityflooringDataSource _qualityflooringDataSource;
late QualityInspectionDataSource _qualityInspectionDataSource;
late QualityPaintingDataSource _qualityPaintingDataSource;
late QualityPavingDataSource _qualityPavingDataSource;
late QualityRoofingDataSource _qualityRoofingDataSource;
late QualityProofingDataSource _qualityProofingDataSource;

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
Stream? _stream10;
Stream? _stream11;

TextEditingController ename = TextEditingController();
dynamic empName,
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
List<String> civil_title = [
  'CHECKLIST FOR INSTALLATION OF EXCAVATION WORK',
  'CHECKLIST FOR INSTALLATION OF EARTH WORK - BACKFILLING',
  'CHECKLIST FOR INSTALLATION OF BRICK & BLOCK MASSONARY',
  'CHECKLIST FOR INSTALLATION OF BLDG DOORS, WINDOWS, HARDWARE, GLAZING',
  'CHECKLIST FOR INSTALLATION OF FALSE CEILING',
  'CHECKLIST FOR FLOORING & TILING',
  'CHECKLIST FOR GROUT INSPECTION',
  'CHECKLIST FOR INRONITE FLOORING CHECK',
  'CHECKLIST FOR PAINTING',
  'CHECKLIST FOR PAVING WORK',
  'CHECKLIST FOR WALL CLADDING & ROOFING',
  'CHECKLIST FOR WALL WATER PROOFING',
];

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

// Main
class _QualityChecklistState extends State<QualityChecklist> {
  @override
  void initState() {
    getUserId().whenComplete(() {
      qualitylisttable1 = getData();
      _qualityPSSDataSource = QualityPSSDataSource(
          qualitylisttable1, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable2 = rmu_getData();
      _qualityrmuDataSource = QualityrmuDataSource(
          qualitylisttable2, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable3 = ct_getData();
      _qualityctDataSource = QualityctDataSource(
          qualitylisttable3, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable4 = cmu_getData();
      _qualitycmuDataSource = QualitycmuDataSource(
          qualitylisttable4, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable5 = acdb_getData();
      _qualityacdDataSource = QualityacdDataSource(
          qualitylisttable5, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable6 = ci_getData();
      _qualityCIDataSource = QualityCIDataSource(
          qualitylisttable6, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable7 = cdi_getData();
      _qualityCDIDataSource = QualityCDIDataSource(
          qualitylisttable7, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable8 = msp_getData();
      _qualityMSPDataSource = QualityMSPDataSource(
          qualitylisttable8, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable9 = charger_getData();
      _qualityChargerDataSource = QualityChargerDataSource(
          qualitylisttable9, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable10 = earth_pit_getData();
      _qualityEPDataSource = QualityEPDataSource(
          qualitylisttable10, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      _isloading = false;
      setState(() {});
    });

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
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream1 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('RMU TABLE DATA')
        .doc('RMU')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream2 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CONVENTIONAL TRANSFORMER TABLE DATA')
        .doc('CONVENTIONAL TRANSFORMER')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream3 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CTPT METERING UNIT TABLE DATA')
        .doc('CTPT METERING UNIT')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream4 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('ACDB TABLE DATA')
        .doc('ACDB DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream5 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CABLE INSTALLATION TABLE DATA')
        .doc('CABLE INSTALLATION')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream6 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CDI TABLE DATA')
        .doc('CDI DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream7 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('MSP TABLE DATA')
        .doc('MSP DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream8 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('CHARGER TABLE DATA')
        .doc('CHARGER DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream9 = FirebaseFirestore.instance
        .collection('QualityChecklist')
        .doc('${widget.depoName}')
        .collection('EARTH TABLE DATA')
        .doc('EARTH DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    // qualitylisttable1 = getData();
    // _qualityExcavationDataSource =QualityExcavationDataSource(qualitylisttable1);
    // _dataGridController = DataGridController();

    // qualitylisttable2 = getData();
    // _qualityBackFillingDataSource = QualityBackFillingDataSource(qualitylisttable2);
    // _dataGridController = DataGridController();

    // qualitylisttable3 = getData();
    // _qualityMassonaryDataSource = QualityMassonaryDataSource(qualitylisttable2);
    // _dataGridController = DataGridController();

    // qualitylisttable4 = getData();
    // _qualityGlazzingDataSource = QualityGlazzingDataSource(qualitylisttable4);
    // _dataGridController = DataGridController();

    // qualitylisttable5 = getData();
    // _qualityCeillingDataSource= = QualityCeillingDataSource(qualitylisttable5);
    // _dataGridController = DataGridController();

    // qualitylisttable6 = getData();
    // _QualityflooringDataSource = QualityflooringDataSource(qualitylisttable6);
    // _dataGridController = DataGridController();

    // qualitylisttable7 = getData();
    // _qualityInspectionDataSource = QualityInspectionDataSource(qualitylisttable7);
    // _dataGridController = DataGridController();

    // qualitylisttable8 = getData();
    // _qualityIroniteflooringDataSource = QualityIroniteflooringDataSource(qualitylisttable8);
    // _dataGridController = DataGridController();

    // qualitylisttable9 = getData();
    // _qualityPaintingDataSource = QualityPaintingDataSource(qualitylisttable9);
    // _dataGridController = DataGridController();

    // qualitylisttable10 = getData();
    //_qualityPavingDataSource = QualityPavingDataSource(qualitylisttable10);
    // _dataGridController = DataGridController();
    return SafeArea(
      child: DefaultTabController(
          length: 2,
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
                                    // onWillPop(context);
                                  },
                                  child: Image.asset(
                                    'assets/logout.png',
                                    height: 20,
                                    width: 20,
                                  )))
                        ],
                      )
                    : Container(),
              ],
              // leading:
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 50),
                child: Column(
                  children: [
                    TabBar(
                      labelColor: white,
                      labelStyle: buttonWhite,
                      unselectedLabelColor: Colors.black,
                      indicator: MaterialIndicator(
                          horizontalPadding: 24,
                          bottomLeftRadius: 8,
                          bottomRightRadius: 8,
                          color: white,
                          paintingStyle: PaintingStyle.fill),
                      tabs: const [
                        Tab(text: 'Civil Engineer'),
                        Tab(text: 'Electrical Engineer'),
                      ],
                    ),
                    //  TabBar(
                    //     labelColor: Colors.yellow,
                    //     labelStyle: buttonWhite,
                    //     unselectedLabelColor: white,

                    //     //indicatorSize: TabBarIndicatorSize.label,
                    //     indicator: MaterialIndicator(
                    //       horizontalPadding: 24,
                    //       bottomLeftRadius: 8,
                    //       bottomRightRadius: 8,
                    //       color: almostblack,
                    //       paintingStyle: PaintingStyle.fill,
                    //     ),
                    //     onTap: (value) {
                    //       _selectedIndex = value;
                    //       setState(() {});
                    //     },
                    //     tabs: const [
                    //       Tab(text: "PSS"),
                    //       Tab(text: "RMU"),
                    //       Tab(text: "CT"),
                    //       Tab(text: "CMU"),
                    //       Tab(text: "ACDB"),
                    //       Tab(text: "CI"),
                    //       Tab(text: "CDI"),
                    //       Tab(text: "MSP"),
                    //       Tab(text: "CHARGER"),
                    //       Tab(text: "EARTH PIT"),
                    //     ],
                    //   ),
                  ],
                ),
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
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // QualityChecklist_civil_enginear(cityName: widget.cityName, depoName: widget.depoName),
              CivilQualityChecklist(
                  cityName: widget.cityName, depoName: widget.depoName),
              QualityChecklist_electrical_enginear(
                  cityName: widget.cityName, depoName: widget.depoName)
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

    for (var i in _qualityExcavationDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button' ||
            data.columnName == 'View' ||
            data.columnName != 'Delete') {
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
        .collection(userId)
        .doc(widget.currentDate)
        .set({
      'data': psstabledatalist,
    }).whenComplete(() {
      psstabledatalist.clear();
      for (var i in _qualityBackFillingDataSource.dataGridRows) {
        for (var data in i.getCells()) {
          if (data.columnName != 'button' ||
              data.columnName == 'View' ||
              data.columnName != 'Delete') {
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
          .collection(userId)
          .doc(widget.currentDate)
          .set({
        'data': rmutabledatalist,
      }).whenComplete(() {
        rmutabledatalist.clear();
        for (var i in _qualityMassonaryDataSource.dataGridRows) {
          for (var data in i.getCells()) {
            if (data.columnName != 'button' ||
                data.columnName == 'View' ||
                data.columnName != 'Delete') {
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
            .collection(userId)
            .doc(widget.currentDate)
            .set({
          'data': cttabledatalist,
        }).whenComplete(() {
          cttabledatalist.clear();
          for (var i in _qualityGlazzingDataSource.dataGridRows) {
            for (var data in i.getCells()) {
              if (data.columnName != 'button' ||
                  data.columnName == 'View' ||
                  data.columnName != 'Delete') {
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
              .collection(userId)
              .doc(widget.currentDate)
              .set({
            'data': cmutabledatalist,
          }).whenComplete(() {
            cmutabledatalist.clear();
            for (var i in _qualityCeillingDataSource.dataGridRows) {
              for (var data in i.getCells()) {
                if (data.columnName != 'button' ||
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
                .collection(userId)
                .doc(widget.currentDate)
                .set({
              'data': acdbtabledatalist,
            }).whenComplete(() {
              acdbtabledatalist.clear();
              for (var i in _qualityflooringDataSource.dataGridRows) {
                for (var data in i.getCells()) {
                  if (data.columnName != 'button' ||
                      data.columnName == 'View' ||
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
                  .collection(userId)
                  .doc(widget.currentDate)
                  .set({
                'data': citabledatalist,
              }).whenComplete(() {
                citabledatalist.clear();
                for (var i in _qualityInspectionDataSource.dataGridRows) {
                  for (var data in i.getCells()) {
                    if (data.columnName != 'button' ||
                        data.columnName == 'View' ||
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
                    .collection(userId)
                    .doc(widget.currentDate)
                    .set({
                  'data': cditabledatalist,
                }).whenComplete(() {
                  cditabledatalist.clear();
                  for (var i
                      in _qualityIroniteflooringDataSource.dataGridRows) {
                    for (var data in i.getCells()) {
                      if (data.columnName != 'button' ||
                          data.columnName == 'View' ||
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
                      .collection(userId)
                      .doc(widget.currentDate)
                      .set({
                    'data': msptabledatalist,
                  }).whenComplete(() {
                    msptabledatalist.clear();
                    for (var i in _qualityPaintingDataSource.dataGridRows) {
                      for (var data in i.getCells()) {
                        if (data.columnName != 'button' ||
                            data.columnName == 'View' ||
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
                        .collection(userId)
                        .doc(widget.currentDate)
                        .set({
                      'data': chargertabledatalist,
                    }).whenComplete(() {
                      chargertabledatalist.clear();
                      for (var i in _qualityPavingDataSource.dataGridRows) {
                        for (var data in i.getCells()) {
                          if (data.columnName != 'button' ||
                              data.columnName == 'View' ||
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
                          .collection(userId)
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

  Future<void> getUserId() async {
    await AuthService().getCurrentUserId().then((value) {
      userId = value;
    });
  }

  upperScreen() {
    return _isloading
        ? LoadingPage()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('QualityChecklistCollection')
                .doc('${widget.depoName}')
                .collection(userId)
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
                                            'Employee Name',
                                          )),
                                      const SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                              //   children: [
                              //     HeaderValue('Employee Name', '', empName ?? ''),
                              //     HeaderValue('Doc No.:TPCL/ DIST-EV', '', distev ?? ''),
                              //     HeaderValue('VENDOR NAME', '', vendorname ?? ''),
                              //     HeaderValue('DATE', '', date ?? ''),
                              //   ],
                              // ),
                              // Column(
                              //   children: [
                              //     HeaderValue('OLA NUMBER', '', olano ?? ''),
                              //     HeaderValue('PANEL SR NO.', '', panel ?? ''),
                              //     HeaderValue('DepotName', '', depotname ?? ''),
                              //     HeaderValue('CUSTOMER NAME', '', customername ?? ''),
                              //   ],
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                          ? _qualityExcavationDataSource
                                          : _selectedIndex == 1
                                              ? _qualityBackFillingDataSource
                                              : _selectedIndex == 2
                                                  ? _qualityMassonaryDataSource
                                                  : _selectedIndex == 3
                                                      ? _qualityGlazzingDataSource
                                                      : _selectedIndex == 4
                                                          ? _qualityCeillingDataSource
                                                          : _selectedIndex == 5
                                                              ? _qualityflooringDataSource
                                                              : _selectedIndex ==
                                                                      6
                                                                  ? _qualityInspectionDataSource
                                                                  : _selectedIndex ==
                                                                          7
                                                                      ? _qualityIroniteflooringDataSource
                                                                      : _selectedIndex ==
                                                                              8
                                                                          ? _qualityPaintingDataSource
                                                                          : _qualityPavingDataSource,

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
                                          allowEditing: false,
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
                                          allowEditing: false,
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
                                          allowEditing: false,
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
                                        // GridColumn(
                                        //   columnName: 'Delete',
                                        //   autoFitPadding:
                                        //       const EdgeInsets.symmetric(
                                        //           horizontal: 16),
                                        //   allowEditing: false,
                                        //   visible: true,
                                        //   width: 120,
                                        //   label: Container(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 8.0),
                                        //     alignment: Alignment.center,
                                        //     child: Text('Delete Row',
                                        //         overflow:
                                        //             TextOverflow.values.first,
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 16,
                                        //             color: white)
                                        //         //    textAlign: TextAlign.center,
                                        //         ),
                                        //   ),
                                        // ),
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
                                _qualityExcavationDataSource =
                                    QualityExcavationDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 1) {
                                _qualityBackFillingDataSource =
                                    QualityBackFillingDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 2) {
                                _qualityMassonaryDataSource =
                                    QualityMassonaryDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 3) {
                                _qualityGlazzingDataSource =
                                    QualityGlazzingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 4) {
                                _qualityCeillingDataSource =
                                    QualityCeillingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 5) {
                                _qualityflooringDataSource =
                                    QualityflooringDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 6) {
                                _qualityInspectionDataSource =
                                    QualityInspectionDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 7) {
                                _qualityIroniteflooringDataSource =
                                    QualityIroniteflooringDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 8) {
                                _qualityPaintingDataSource =
                                    QualityPaintingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 9) {
                                _qualityPavingDataSource =
                                    QualityPavingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              }
                            });
                            return SfDataGridTheme(
                              data: SfDataGridThemeData(headerColor: blue),
                              child: SfDataGrid(
                                source: _selectedIndex == 0
                                    ? _qualityExcavationDataSource
                                    : _selectedIndex == 1
                                        ? _qualityBackFillingDataSource
                                        : _selectedIndex == 2
                                            ? _qualityMassonaryDataSource
                                            : _selectedIndex == 3
                                                ? _qualityGlazzingDataSource
                                                : _selectedIndex == 4
                                                    ? _qualityCeillingDataSource
                                                    : _selectedIndex == 5
                                                        ? _qualityflooringDataSource
                                                        : _selectedIndex == 6
                                                            ? _qualityInspectionDataSource
                                                            : _selectedIndex ==
                                                                    7
                                                                ? _qualityIroniteflooringDataSource
                                                                : _selectedIndex ==
                                                                        8
                                                                    ? _qualityPaintingDataSource
                                                                    : _qualityPavingDataSource,

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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                  // GridColumn(
                                  //   columnName: 'Delete',
                                  //   autoFitPadding: const EdgeInsets.symmetric(
                                  //       horizontal: 16),
                                  //   allowEditing: false,
                                  //   width: 120,
                                  //   visible: true,
                                  //   label: Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 8.0),
                                  //     alignment: Alignment.center,
                                  //     child: Text('Delete Row',
                                  //         overflow: TextOverflow.values.first,
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 16,
                                  //             color: white)
                                  //         //    textAlign: TextAlign.center,
                                  //         ),
                                  //   ),
                                  // ),
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
                    // widget.isHeader!!
                    //     ? Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Align(
                    //           alignment: Alignment.bottomRight,
                    //           child: FloatingActionButton(
                    //             child: Icon(Icons.add),
                    //             onPressed: (() {
                    //               if (_selectedIndex == 0) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityExcavationDataSource.buildDataGridRows();
                    //                 _qualityExcavationDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 1) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityBackFillingDataSource.buildDataGridRows();
                    //                 _qualityBackFillingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 2) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityMassonaryDataSource.buildDataGridRows();
                    //                 _qualityMassonaryDataSource.updateDatagridSource();
                    //               } else if (_selectedIndex == 3) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityGlazzingDataSource.buildDataGridRows();
                    //                 _qualityGlazzingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 4) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityCeillingDataSource=.buildDataGridRows();
                    //                 _qualityCeillingDataSource=
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 5) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _QualityflooringDataSource.buildDataGridRows();
                    //                 _QualityflooringDataSource.updateDatagridSource();
                    //               } else if (_selectedIndex == 6) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityInspectionDataSource.buildDataGridRows();
                    //                 _qualityInspectionDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 7) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityIroniteflooringDataSource.buildDataGridRows();
                    //                 _qualityIroniteflooringDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 8) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityPaintingDataSource
                    //                     .buildDataGridRows();
                    //                 _qualityPaintingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 9) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                _qualityPavingDataSource.buildDataGridRows();
                    //                _qualityPavingDataSource.updateDatagridSource();
                    //               }
                    //             }),
                    //           ),
                    //         ),
                    //       )
                    //     : Container()
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

// PSS ACTIVITY DATA
  List<QualitychecklistModel> getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: activity_data[6],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: activity_data[7],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: activity_data[8],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: activity_data[9],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: activity_data[11],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: activity_data[12],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: activity_data[13],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: activity_data[14],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: activity_data[15],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: activity_data[16],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 19,
        checklist: activity_data[18],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 20,
        checklist: activity_data[19],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 21,
        checklist: activity_data[20],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 22,
        checklist: activity_data[21],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 23,
        checklist: activity_data[22],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
    ];
  }

  // RMU ACTIVITY DATA
  List<QualitychecklistModel> rmu_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: rmu_activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: rmu_activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: rmu_activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: rmu_activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: rmu_activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: rmu_activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: rmu_activity_data[6],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: rmu_activity_data[7],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: rmu_activity_data[8],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: rmu_activity_data[9],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: rmu_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: rmu_activity_data[11],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: rmu_activity_data[12],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: rmu_activity_data[13],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: rmu_activity_data[14],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: rmu_activity_data[16],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: rmu_activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 19,
        checklist: rmu_activity_data[18],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 20,
        checklist: rmu_activity_data[19],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 21,
        checklist: rmu_activity_data[20],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
    ];
  }

  // CT ACTIVITY DATA
  List<QualitychecklistModel> ct_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: ct_activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: ct_activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: ct_activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: ct_activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: ct_activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: ct_activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: ct_activity_data[6],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: ct_activity_data[7],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: ct_activity_data[8],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: ct_activity_data[9],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: ct_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: ct_activity_data[11],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: ct_activity_data[12],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: ct_activity_data[13],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: ct_activity_data[14],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: ct_activity_data[16],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: ct_activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 19,
        checklist: ct_activity_data[18],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 20,
        checklist: ct_activity_data[19],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 21,
        checklist: ct_activity_data[20],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 22,
        checklist: ct_activity_data[21],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
    ];
  }

  // CMU ACTIVITY DATA
  List<QualitychecklistModel> cmu_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: cmu_activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: cmu_activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: cmu_activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: cmu_activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: cmu_activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: cmu_activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: cmu_activity_data[6],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: cmu_activity_data[7],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: cmu_activity_data[8],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: cmu_activity_data[9],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: cmu_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: cmu_activity_data[11],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: cmu_activity_data[12],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: cmu_activity_data[13],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: cmu_activity_data[14],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: cmu_activity_data[16],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: cmu_activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 19,
        checklist: cmu_activity_data[18],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 20,
        checklist: cmu_activity_data[19],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 21,
        checklist: cmu_activity_data[20],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 22,
        checklist: cmu_activity_data[21],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 23,
        checklist: cmu_activity_data[22],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
    ];
  }

  // ACDB ACTIVITY DATA
  List<QualitychecklistModel> acdb_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: acdb_activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: acdb_activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: acdb_activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: acdb_activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: acdb_activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: acdb_activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: acdb_activity_data[6],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: acdb_activity_data[7],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: acdb_activity_data[8],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: acdb_activity_data[9],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: acdb_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: acdb_activity_data[11],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: acdb_activity_data[12],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: acdb_activity_data[13],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: acdb_activity_data[14],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: acdb_activity_data[15],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: acdb_activity_data[16],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: acdb_activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 19,
        checklist: acdb_activity_data[18],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 20,
        checklist: acdb_activity_data[19],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 21,
        checklist: acdb_activity_data[20],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 22,
        checklist: acdb_activity_data[21],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 23,
        checklist: acdb_activity_data[22],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 24,
        checklist: acdb_activity_data[23],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 25,
        checklist: acdb_activity_data[24],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
    ];
  }

  // CI ACTIVITY DATA
  List<QualitychecklistModel> ci_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: ci_activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: ci_activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: ci_activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: ci_activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: ci_activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: ci_activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: ci_activity_data[6],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: ci_activity_data[7],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: ci_activity_data[8],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: ci_activity_data[9],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: ci_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: acdb_activity_data[11],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: ci_activity_data[12],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
    ];
  }

  // CDI ACTIVITY DATA
  List<QualitychecklistModel> cdi_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: cdi_activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: cdi_activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: cdi_activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: cdi_activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: cdi_activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: cdi_activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
    ];
  }

  // MSP ACTIVITY DATA
  List<QualitychecklistModel> msp_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: msp_activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: msp_activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: msp_activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: msp_activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: msp_activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: msp_activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: msp_activity_data[6],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: msp_activity_data[7],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: msp_activity_data[8],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: msp_activity_data[9],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: msp_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: msp_activity_data[11],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: msp_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: msp_activity_data[13],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: msp_activity_data[14],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: msp_activity_data[15],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: msp_activity_data[16],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: msp_activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: msp_activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 19,
        checklist: msp_activity_data[18],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 20,
        checklist: msp_activity_data[19],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 21,
        checklist: msp_activity_data[20],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 23,
        checklist: msp_activity_data[22],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      )
    ];
  }

  // CHARGER ACTIVITY DATA
  List<QualitychecklistModel> charger_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: charger_activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: charger_activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: charger_activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: charger_activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: charger_activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: charger_activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: charger_activity_data[6],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: charger_activity_data[7],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: charger_activity_data[8],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: charger_activity_data[9],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: charger_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: charger_activity_data[11],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: charger_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: charger_activity_data[13],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: charger_activity_data[14],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: charger_activity_data[15],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: charger_activity_data[16],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: charger_activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: charger_activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 19,
        checklist: charger_activity_data[18],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 20,
        checklist: charger_activity_data[19],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 21,
        checklist: charger_activity_data[20],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
    ];
  }

  // EARTH PIT ACTIVITY DATA
  List<QualitychecklistModel> earth_pit_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: earth_pit_activity_data[0],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: earth_pit_activity_data[1],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: earth_pit_activity_data[2],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: earth_pit_activity_data[3],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: earth_pit_activity_data[4],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: earth_pit_activity_data[5],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: earth_pit_activity_data[6],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: earth_pit_activity_data[7],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: earth_pit_activity_data[8],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: earth_pit_activity_data[9],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: earth_pit_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: earth_pit_activity_data[11],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: earth_pit_activity_data[10],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: earth_pit_activity_data[13],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: earth_pit_activity_data[14],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: earth_pit_activity_data[15],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: earth_pit_activity_data[16],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: earth_pit_activity_data[17],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 19,
        checklist: earth_pit_activity_data[18],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 20,
        checklist: earth_pit_activity_data[19],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 21,
        checklist: earth_pit_activity_data[20],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 22,
        checklist: earth_pit_activity_data[21],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 23,
        checklist: earth_pit_activity_data[22],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 24,
        checklist: earth_pit_activity_data[23],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 25,
        checklist: earth_pit_activity_data[24],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 26,
        checklist: earth_pit_activity_data[25],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
      QualitychecklistModel(
        srNo: 27,
        checklist: earth_pit_activity_data[26],
        responsibility: 'responsibility',
        reference: 'reference',
        observation: 'observation',
      ),
    ];
  }
}

// ELECTRICAL ENGINEAR TABLE
class QualityChecklist_electrical_enginear extends StatefulWidget {
  String? cityName;
  String? depoName;
  String? currentDate;
  bool? isHeader;

  QualityChecklist_electrical_enginear(
      {super.key,
      required this.cityName,
      required this.depoName,
      this.currentDate,
      this.isHeader = true});

  @override
  State<QualityChecklist_electrical_enginear> createState() =>
      _QualityChecklist_electrical_enginearState();
}

class _QualityChecklist_electrical_enginearState
    extends State<QualityChecklist_electrical_enginear> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 10,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 20,
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
        ));
  }

  upperScreen() {
    return _isloading
        ? LoadingPage()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('QualityChecklistCollection')
                .doc('${widget.depoName}')
                .collection(userId)
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
                                            'Employee Name',
                                          )),
                                      const SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                              //   children: [
                              //     HeaderValue('Employee Name', '', empName ?? ''),
                              //     HeaderValue('Doc No.:TPCL/ DIST-EV', '', distev ?? ''),
                              //     HeaderValue('VENDOR NAME', '', vendorname ?? ''),
                              //     HeaderValue('DATE', '', date ?? ''),
                              //   ],
                              // ),
                              // Column(
                              //   children: [
                              //     HeaderValue('OLA NUMBER', '', olano ?? ''),
                              //     HeaderValue('PANEL SR NO.', '', panel ?? ''),
                              //     HeaderValue('DepotName', '', depotname ?? ''),
                              //     HeaderValue('CUSTOMER NAME', '', customername ?? ''),
                              //   ],
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                          ? _qualityExcavationDataSource
                                          : _selectedIndex == 1
                                              ? _qualityBackFillingDataSource
                                              : _selectedIndex == 2
                                                  ? _qualityMassonaryDataSource
                                                  : _selectedIndex == 3
                                                      ? _qualityGlazzingDataSource
                                                      : _selectedIndex == 4
                                                          ? _qualityCeillingDataSource
                                                          : _selectedIndex == 5
                                                              ? _qualityflooringDataSource
                                                              : _selectedIndex ==
                                                                      6
                                                                  ? _qualityInspectionDataSource
                                                                  : _selectedIndex ==
                                                                          7
                                                                      ? _qualityIroniteflooringDataSource
                                                                      : _selectedIndex ==
                                                                              8
                                                                          ? _qualityPaintingDataSource
                                                                          : _qualityPavingDataSource,

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
                                          allowEditing: false,
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
                                          allowEditing: false,
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
                                          allowEditing: false,
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
                                        // GridColumn(
                                        //   columnName: 'Delete',
                                        //   autoFitPadding:
                                        //       const EdgeInsets.symmetric(
                                        //           horizontal: 16),
                                        //   allowEditing: false,
                                        //   visible: true,
                                        //   width: 120,
                                        //   label: Container(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 8.0),
                                        //     alignment: Alignment.center,
                                        //     child: Text('Delete Row',
                                        //         overflow:
                                        //             TextOverflow.values.first,
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 16,
                                        //             color: white)
                                        //         //    textAlign: TextAlign.center,
                                        //         ),
                                        //   ),
                                        // ),
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
                                _qualityExcavationDataSource =
                                    QualityExcavationDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 1) {
                                _qualityBackFillingDataSource =
                                    QualityBackFillingDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 2) {
                                _qualityMassonaryDataSource =
                                    QualityMassonaryDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 3) {
                                _qualityGlazzingDataSource =
                                    QualityGlazzingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 4) {
                                _qualityCeillingDataSource =
                                    QualityCeillingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 5) {
                                _qualityflooringDataSource =
                                    QualityflooringDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 6) {
                                _qualityInspectionDataSource =
                                    QualityInspectionDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 7) {
                                _qualityIroniteflooringDataSource =
                                    QualityIroniteflooringDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 8) {
                                _qualityPaintingDataSource =
                                    QualityPaintingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 9) {
                                _qualityPavingDataSource =
                                    QualityPavingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              }
                            });
                            return SfDataGridTheme(
                              data: SfDataGridThemeData(headerColor: blue),
                              child: SfDataGrid(
                                source: _selectedIndex == 0
                                    ? _qualityExcavationDataSource
                                    : _selectedIndex == 1
                                        ? _qualityBackFillingDataSource
                                        : _selectedIndex == 2
                                            ? _qualityMassonaryDataSource
                                            : _selectedIndex == 3
                                                ? _qualityGlazzingDataSource
                                                : _selectedIndex == 4
                                                    ? _qualityCeillingDataSource
                                                    : _selectedIndex == 5
                                                        ? _qualityflooringDataSource
                                                        : _selectedIndex == 6
                                                            ? _qualityInspectionDataSource
                                                            : _selectedIndex ==
                                                                    7
                                                                ? _qualityIroniteflooringDataSource
                                                                : _selectedIndex ==
                                                                        8
                                                                    ? _qualityPaintingDataSource
                                                                    : _qualityPavingDataSource,

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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                  // GridColumn(
                                  //   columnName: 'Delete',
                                  //   autoFitPadding: const EdgeInsets.symmetric(
                                  //       horizontal: 16),
                                  //   allowEditing: false,
                                  //   width: 120,
                                  //   visible: true,
                                  //   label: Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 8.0),
                                  //     alignment: Alignment.center,
                                  //     child: Text('Delete Row',
                                  //         overflow: TextOverflow.values.first,
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 16,
                                  //             color: white)
                                  //         //    textAlign: TextAlign.center,
                                  //         ),
                                  //   ),
                                  // ),
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
                    // widget.isHeader!!
                    //     ? Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Align(
                    //           alignment: Alignment.bottomRight,
                    //           child: FloatingActionButton(
                    //             child: Icon(Icons.add),
                    //             onPressed: (() {
                    //               if (_selectedIndex == 0) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityExcavationDataSource.buildDataGridRows();
                    //                 _qualityExcavationDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 1) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityBackFillingDataSource.buildDataGridRows();
                    //                 _qualityBackFillingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 2) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityMassonaryDataSource.buildDataGridRows();
                    //                 _qualityMassonaryDataSource.updateDatagridSource();
                    //               } else if (_selectedIndex == 3) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityGlazzingDataSource.buildDataGridRows();
                    //                 _qualityGlazzingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 4) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityCeillingDataSource=.buildDataGridRows();
                    //                 _qualityCeillingDataSource=
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 5) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _QualityflooringDataSource.buildDataGridRows();
                    //                 _QualityflooringDataSource.updateDatagridSource();
                    //               } else if (_selectedIndex == 6) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityInspectionDataSource.buildDataGridRows();
                    //                 _qualityInspectionDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 7) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityIroniteflooringDataSource.buildDataGridRows();
                    //                 _qualityIroniteflooringDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 8) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityPaintingDataSource
                    //                     .buildDataGridRows();
                    //                 _qualityPaintingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 9) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                _qualityPavingDataSource.buildDataGridRows();
                    //                _qualityPavingDataSource.updateDatagridSource();
                    //               }
                    //             }),
                    //           ),
                    //         ),
                    //       )
                    //     : Container()
                  ],
                );
              } else {
                return LoadingPage();
              }
            },
          );
  }
}

// CIVIL ENGINEAR TABLE
class QualityChecklist_civil_enginear extends StatefulWidget {
  String? cityName;
  String? depoName;
  String? currentDate;
  bool? isHeader;

  QualityChecklist_civil_enginear(
      {super.key,
      required this.cityName,
      required this.depoName,
      this.currentDate,
      this.isHeader = true});

  @override
  State<QualityChecklist_civil_enginear> createState() =>
      _QualityChecklist_civil_enginearState();
}

class _QualityChecklist_civil_enginearState
    extends State<QualityChecklist_civil_enginear> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 12,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 20,
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
                Tab(text: "Exc"),
                Tab(text: "B.F"),
                Tab(text: "Mass"),
                Tab(text: "D.W.G"),
                Tab(text: "F.C"),
                Tab(text: "F&T"),
                Tab(text: "G.I"),
                Tab(text: "I.F"),
                Tab(text: "Painting"),
                Tab(text: "Paving"),
                Tab(text: "WC&R"),
                Tab(text: "Proofing"),
              ],
            ),
          ),
          body: TabBarView(children: [
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
          ]),
        ));
  }

  civilupperScreen() {
    return _isloading
        ? LoadingPage()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('QualityChecklistCollection')
                .doc('${widget.depoName}')
                .collection(userId)
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
                            civil_title[int.parse(_selectedIndex.toString())],
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Project',
                                          )),
                                      const SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
                                                      )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Location',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                          : '')))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Vendor / Sub Vendor',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                          : '')))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Drawing No:',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
                                                      )))),
                                    ],
                                  ),
                                )
                              ],
                              //   children: [
                              //     HeaderValue('Employee Name', '', empName ?? ''),
                              //     HeaderValue('Doc No.:TPCL/ DIST-EV', '', distev ?? ''),
                              //     HeaderValue('VENDOR NAME', '', vendorname ?? ''),
                              //     HeaderValue('DATE', '', date ?? ''),
                              //   ],
                              // ),
                              // Column(
                              //   children: [
                              //     HeaderValue('OLA NUMBER', '', olano ?? ''),
                              //     HeaderValue('PANEL SR NO.', '', panel ?? ''),
                              //     HeaderValue('DepotName', '', depotname ?? ''),
                              //     HeaderValue('CUSTOMER NAME', '', customername ?? ''),
                              //   ],
                            ),
                            Column(
                              children: [
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Date',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                          : '')))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Component of the Structure',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
                                                      )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Grid / Axis & Level',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
                                                      )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Type of Filling',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
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
                                          ? _qualityExcavationDataSource
                                          : _selectedIndex == 1
                                              ? _qualityBackFillingDataSource
                                              : _selectedIndex == 2
                                                  ? _qualityMassonaryDataSource
                                                  : _selectedIndex == 3
                                                      ? _qualityGlazzingDataSource
                                                      : _selectedIndex == 4
                                                          ? _qualityCeillingDataSource
                                                          : _selectedIndex == 5
                                                              ? _qualityflooringDataSource
                                                              : _selectedIndex ==
                                                                      6
                                                                  ? _qualityInspectionDataSource
                                                                  : _selectedIndex ==
                                                                          7
                                                                      ? _qualityIroniteflooringDataSource
                                                                      : _selectedIndex ==
                                                                              8
                                                                          ? _qualityPaintingDataSource
                                                                          : _qualityPavingDataSource,

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
                                          allowEditing: false,
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
                                          allowEditing: false,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                                'Checks(Before Start of Backfill Activity)',
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
                                            child: Text(
                                                "Contractor’s Site Engineer",
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
                                            child: Text("Owner’s Site Engineer",
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
                                            child: Text(
                                                "Observation Comments by  Owner’s Engineer",
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
                                          allowEditing: false,
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
                                        // GridColumn(
                                        //   columnName: 'Delete',
                                        //   autoFitPadding:
                                        //       const EdgeInsets.symmetric(
                                        //           horizontal: 16),
                                        //   allowEditing: false,
                                        //   visible: true,
                                        //   width: 120,
                                        //   label: Container(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 8.0),
                                        //     alignment: Alignment.center,
                                        //     child: Text('Delete Row',
                                        //         overflow:
                                        //             TextOverflow.values.first,
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 16,
                                        //             color: white)
                                        //         //    textAlign: TextAlign.center,
                                        //         ),
                                        //   ),
                                        // ),
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
                                _qualityExcavationDataSource =
                                    QualityExcavationDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 1) {
                                _qualityBackFillingDataSource =
                                    QualityBackFillingDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 2) {
                                _qualityMassonaryDataSource =
                                    QualityMassonaryDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 3) {
                                _qualityGlazzingDataSource =
                                    QualityGlazzingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 4) {
                                _qualityCeillingDataSource =
                                    QualityCeillingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 5) {
                                _qualityflooringDataSource =
                                    QualityflooringDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 6) {
                                _qualityInspectionDataSource =
                                    QualityInspectionDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 7) {
                                _qualityIroniteflooringDataSource =
                                    QualityIroniteflooringDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 8) {
                                _qualityPaintingDataSource =
                                    QualityPaintingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 9) {
                                _qualityPavingDataSource =
                                    QualityPavingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              }
                            });
                            return SfDataGridTheme(
                              data: SfDataGridThemeData(headerColor: blue),
                              child: SfDataGrid(
                                source: _selectedIndex == 0
                                    ? _qualityExcavationDataSource
                                    : _selectedIndex == 1
                                        ? _qualityBackFillingDataSource
                                        : _selectedIndex == 2
                                            ? _qualityMassonaryDataSource
                                            : _selectedIndex == 3
                                                ? _qualityGlazzingDataSource
                                                : _selectedIndex == 4
                                                    ? _qualityCeillingDataSource
                                                    : _selectedIndex == 5
                                                        ? _qualityflooringDataSource
                                                        : _selectedIndex == 6
                                                            ? _qualityInspectionDataSource
                                                            : _selectedIndex ==
                                                                    7
                                                                ? _qualityIroniteflooringDataSource
                                                                : _selectedIndex ==
                                                                        8
                                                                    ? _qualityPaintingDataSource
                                                                    : _qualityPavingDataSource,

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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                  // GridColumn(
                                  //   columnName: 'Delete',
                                  //   autoFitPadding: const EdgeInsets.symmetric(
                                  //       horizontal: 16),
                                  //   allowEditing: false,
                                  //   width: 120,
                                  //   visible: true,
                                  //   label: Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 8.0),
                                  //     alignment: Alignment.center,
                                  //     child: Text('Delete Row',
                                  //         overflow: TextOverflow.values.first,
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 16,
                                  //             color: white)
                                  //         //    textAlign: TextAlign.center,
                                  //         ),
                                  //   ),
                                  // ),
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
                    // widget.isHeader!!
                    //     ? Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Align(
                    //           alignment: Alignment.bottomRight,
                    //           child: FloatingActionButton(
                    //             child: Icon(Icons.add),
                    //             onPressed: (() {
                    //               if (_selectedIndex == 0) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityExcavationDataSource.buildDataGridRows();
                    //                 _qualityExcavationDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 1) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityBackFillingDataSource.buildDataGridRows();
                    //                 _qualityBackFillingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 2) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityMassonaryDataSource.buildDataGridRows();
                    //                 _qualityMassonaryDataSource.updateDatagridSource();
                    //               } else if (_selectedIndex == 3) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityGlazzingDataSource.buildDataGridRows();
                    //                 _qualityGlazzingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 4) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityCeillingDataSource=.buildDataGridRows();
                    //                 _qualityCeillingDataSource=
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 5) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _QualityflooringDataSource.buildDataGridRows();
                    //                 _QualityflooringDataSource.updateDatagridSource();
                    //               } else if (_selectedIndex == 6) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityInspectionDataSource.buildDataGridRows();
                    //                 _qualityInspectionDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 7) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityIroniteflooringDataSource.buildDataGridRows();
                    //                 _qualityIroniteflooringDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 8) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityPaintingDataSource
                    //                     .buildDataGridRows();
                    //                 _qualityPaintingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 9) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                _qualityPavingDataSource.buildDataGridRows();
                    //                _qualityPavingDataSource.updateDatagridSource();
                    //               }
                    //             }),
                    //           ),
                    //         ),
                    //       )
                    //     : Container()
                  ],
                );
              } else {
                return LoadingPage();
              }
            },
          );
  }
}

class CivilQualityChecklist extends StatefulWidget {
  String? cityName;
  String? depoName;
  String? currentDate;
  bool? isHeader;

  CivilQualityChecklist(
      {super.key,
      required this.cityName,
      required this.depoName,
      this.currentDate,
      this.isHeader = true});

  @override
  State<CivilQualityChecklist> createState() => _CivilQualityChecklistState();
}

// List<QualitychecklistModel> checklisttable = <QualitychecklistModel>[];

List<QualitychecklistModel> qualitylisttable11 = <QualitychecklistModel>[];
List<QualitychecklistModel> qualitylisttable12 = <QualitychecklistModel>[];

// late CivilQualityChecklistDataSource _checklistDataSource;
// lateQualityExcavationDataSource _qualityExcavationDataSource;
// late QualityBackFillingDataSource _qualityBackFillingDataSource;
// late QualityMassonaryDataSource _qualityMassonaryDataSource;
// late QualityGlazzingDataSource _qualityGlazzingDataSource;
// late QualityCeillingDataSource _qualityCeillingDataSource=;
// late QualityflooringDataSource _QualityflooringDataSource;
// late QualityInspectionDataSource _qualityInspectionDataSource;
// late QualityIroniteflooringDataSource _qualityIroniteflooringDataSource;
// late QualityPaintingDataSource _qualityPaintingDataSource;
// late QualityPavingDataSource_qualityPavingDataSource;
// late QualityWCRDataSource _qualityRoofingDataSource;
// late QualityPROOFINGDataSource _qualityPROOFINGDataSource;

// late DataGridController _dataGridController;
// bool _isloading = true;
// List<dynamic> psstabledatalist = [];
// List<dynamic> rmutabledatalist = [];
// List<dynamic> cttabledatalist = [];
// List<dynamic> cmutabledatalist = [];
// List<dynamic> acdbtabledatalist = [];
// List<dynamic> citabledatalist = [];
// List<dynamic> cditabledatalist = [];
// List<dynamic> msptabledatalist = [];
// List<dynamic> chargertabledatalist = [];
// List<dynamic> eptabledatalist = [];
// Stream? _stream;
// Stream? _stream1;
// Stream? _stream2;
// Stream? _stream3;
// Stream? _stream4;
// Stream? _stream5;
// Stream? _stream6;
// Stream? _stream7;
// Stream? _stream8;
// Stream? _stream9;
// Stream? _stream10;
// Stream? _stream11;

// TextEditingController ename = TextEditingController();
// dynamic empName,
//     distev,
//     vendorname,
//     date,
//     olano,
//     panel,
//     serialno,
//     depotname,
//     customername;

// dynamic alldata;
// int? _selectedIndex = 0;
// dynamic userId;
// List<String> title = [
//   'CHECKLIST FOR INSTALLATION OF PSS',
//   'CHECKLIST FOR INSTALLATION OF RMU',
//   'CHECKLIST FOR INSTALLATION OF  COVENTIONAL TRANSFORMER',
//   'CHECKLIST FOR INSTALLATION OF CTPT METERING UNIT',
//   'CHECKLIST FOR INSTALLATION OF ACDB',
//   'CHECKLIST FOR  CABLE INSTALLATION ',
//   'CHECKLIST FOR  CABLE DRUM / ROLL INSPECTION',
//   'CHECKLIST FOR MCCB PANEL',
//   'CHECKLIST FOR CHARGER PANEL',
//   'CHECKLIST FOR INSTALLATION OF  EARTH PIT',
// ];
// List<String> civil_title = [
//   'CHECKLIST FOR INSTALLATION OF EXCAVATION WORK',
//   'CHECKLIST FOR INSTALLATION OF EARTH WORK - BACKFILLING',
//   'CHECKLIST FOR INSTALLATION OF BRICK & BLOCK MASSONARY',
//   'CHECKLIST FOR INSTALLATION OF BLDG DOORS, WINDOWS, HARDWARE, GLAZING',
//   'CHECKLIST FOR INSTALLATION OF FALSE CEILING',
//   'CHECKLIST FOR FLOORING & TILING',
//   'CHECKLIST FOR GROUT INSPECTION',
//   'CHECKLIST FOR INRONITE FLOORING CHECK',
//   'CHECKLIST FOR PAINTING',
//   'CHECKLIST FOR PAVING WORK',
//   'CHECKLIST FOR WALL CLADDING & ROOFING',
//   'CHECKLIST FOR WALL WATER PROOFING',
// ];

class _CivilQualityChecklistState extends State<CivilQualityChecklist> {
  @override
  void initState() {
    //   // final user = FirebaseAuth.instance.currentUser;
    //   // print('User$user');
    //   _isloading = false;
    //   _stream = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('PSS TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream1 = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('RMU TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream2 = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CONVENTIONAL TRANSFORMER TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream3 = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CTPT METERING UNIT TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream4 = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('ACDB TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream5 = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CABLE INSTALLATION TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream6 = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CDI TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream7 = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('MSP TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream8 = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('CHARGER TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    //   _stream9 = FirebaseFirestore.instance
    //       .collection('CivilQualityChecklist')
    //       .doc('${widget.depoName}')
    //       .collection('EARTH TABLE DATA')
    //       .doc(widget.currentDate)
    //       .snapshots();

    getUserId().whenComplete(() {
      qualitylisttable1 = excavation_getData();
      _qualityExcavationDataSource = QualityExcavationDataSource(
          qualitylisttable1, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable2 = backfilling_getData();
      _qualityBackFillingDataSource = QualityBackFillingDataSource(
          qualitylisttable2, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable3 = massonary_getData();
      _qualityMassonaryDataSource = QualityMassonaryDataSource(
          qualitylisttable3, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable4 = glazzing_getData();
      _qualityGlazzingDataSource = QualityGlazzingDataSource(
          qualitylisttable4, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable5 = ceilling_getData();
      _qualityCeillingDataSource = QualityCeillingDataSource(
          qualitylisttable5, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable6 = florring_getData();
      _qualityflooringDataSource = QualityflooringDataSource(
          qualitylisttable6, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable7 = inspection_getData();
      _qualityInspectionDataSource = QualityInspectionDataSource(
          qualitylisttable7, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable8 = ironite_florring_getData();
      _qualityIroniteflooringDataSource = QualityIroniteflooringDataSource(
          qualitylisttable8, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable9 = painting_getData();
      _qualityPaintingDataSource = QualityPaintingDataSource(
          qualitylisttable9, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable10 = paving_getData();
      _qualityPavingDataSource = QualityPavingDataSource(
          qualitylisttable10, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable11 = roofing_getData();
      _qualityRoofingDataSource = QualityRoofingDataSource(
          qualitylisttable11, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      qualitylisttable12 = proofing_getData();
      _qualityProofingDataSource = QualityProofingDataSource(
          qualitylisttable12, widget.depoName!, widget.cityName!);
      _dataGridController = DataGridController();

      _isloading = false;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.currentDate =
        widget.currentDate ?? DateFormat.yMMMMd().format(DateTime.now());

    _isloading = false;
    _stream = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('PSS TABLE DATA')
        .doc('PSS')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream1 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('RMU TABLE DATA')
        .doc('RMU')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream2 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('CONVENTIONAL TRANSFORMER TABLE DATA')
        .doc('CONVENTIONAL TRANSFORMER')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream3 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('CTPT METERING UNIT TABLE DATA')
        .doc('CTPT METERING UNIT')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream4 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('ACDB TABLE DATA')
        .doc('ACDB DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream5 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('CABLE INSTALLATION TABLE DATA')
        .doc('CABLE INSTALLATION')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream6 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('CDI TABLE DATA')
        .doc('CDI DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream7 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('MSP TABLE DATA')
        .doc('MSP DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream8 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('CHARGER TABLE DATA')
        .doc('CHARGER DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream9 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('EARTH TABLE DATA')
        .doc('EARTH DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream10 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('WALL CLADDING & ROOFING DATA')
        .doc('WCR DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    _stream11 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('PROOFING DATA')
        .doc('Proofing DATA')
        .collection(userId)
        .doc(widget.currentDate)
        .snapshots();

    // qualitylisttable1 = getData();
    // _qualityExcavationDataSource =QualityExcavationDataSource(qualitylisttable1);
    // _dataGridController = DataGridController();

    // qualitylisttable2 = getData();
    // _qualityBackFillingDataSource = QualityBackFillingDataSource(qualitylisttable2);
    // _dataGridController = DataGridController();

    // qualitylisttable3 = getData();
    // _qualityMassonaryDataSource = QualityMassonaryDataSource(qualitylisttable2);
    // _dataGridController = DataGridController();

    // qualitylisttable4 = getData();
    // _qualityGlazzingDataSource = QualityGlazzingDataSource(qualitylisttable4);
    // _dataGridController = DataGridController();

    // qualitylisttable5 = getData();
    // _qualityCeillingDataSource= = QualityCeillingDataSource(qualitylisttable5);
    // _dataGridController = DataGridController();

    // qualitylisttable6 = getData();
    // _QualityflooringDataSource = QualityflooringDataSource(qualitylisttable6);
    // _dataGridController = DataGridController();

    // qualitylisttable7 = getData();
    // _qualityInspectionDataSource = QualityInspectionDataSource(qualitylisttable7);
    // _dataGridController = DataGridController();

    // qualitylisttable8 = getData();
    // _qualityIroniteflooringDataSource = QualityIroniteflooringDataSource(qualitylisttable8);
    // _dataGridController = DataGridController();

    // qualitylisttable9 = getData();
    // _qualityPaintingDataSource = QualityPaintingDataSource(qualitylisttable9);
    // _dataGridController = DataGridController();

    // qualitylisttable10 = getData();
    //_qualityPavingDataSource = QualityPavingDataSource(qualitylisttable10);
    // _dataGridController = DataGridController();
    return SafeArea(
      child: DefaultTabController(
          length: 10,
          child: Scaffold(
            body: TabBarView(children: [
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              // upperScreen(),
              CivilQualityChecklist_civil_enginear(
                  cityName: widget.cityName, depoName: widget.depoName),
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
    Map<String, dynamic> wcr_table_data = Map();
    Map<String, dynamic> proofing_table_data = Map();

    for (var i in _qualityExcavationDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button' ||
            data.columnName == 'View' ||
            data.columnName != 'Delete') {
          pss_table_data[data.columnName] = data.value;
        }
      }

      psstabledatalist.add(pss_table_data);
      pss_table_data = {};
    }

    FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('PSS TABLE DATA')
        .doc('PSS')
        .collection(userId)
        .doc(widget.currentDate)
        .set({
      'data': psstabledatalist,
    }).whenComplete(() {
      psstabledatalist.clear();
      for (var i in _qualityBackFillingDataSource.dataGridRows) {
        for (var data in i.getCells()) {
          if (data.columnName != 'button' ||
              data.columnName == 'View' ||
              data.columnName != 'Delete') {
            rmu_table_data[data.columnName] = data.value;
          }
        }
        rmutabledatalist.add(rmu_table_data);
        rmu_table_data = {};
      }

      FirebaseFirestore.instance
          .collection('CivilQualityChecklist')
          .doc('${widget.depoName}')
          .collection('RMU TABLE DATA')
          .doc('RMU')
          .collection(userId)
          .doc(widget.currentDate)
          .set({
        'data': rmutabledatalist,
      }).whenComplete(() {
        rmutabledatalist.clear();
        for (var i in _qualityMassonaryDataSource.dataGridRows) {
          for (var data in i.getCells()) {
            if (data.columnName != 'button' ||
                data.columnName == 'View' ||
                data.columnName != 'Delete') {
              ct_table_data[data.columnName] = data.value;
            }
          }

          cttabledatalist.add(ct_table_data);
          ct_table_data = {};
        }

        FirebaseFirestore.instance
            .collection('CivilQualityChecklist')
            .doc('${widget.depoName}')
            .collection('CONVENTIONAL TRANSFORMER TABLE DATA')
            .doc('CONVENTIONAL TRANSFORMER')
            .collection(userId)
            .doc(widget.currentDate)
            .set({
          'data': cttabledatalist,
        }).whenComplete(() {
          cttabledatalist.clear();
          for (var i in _qualityGlazzingDataSource.dataGridRows) {
            for (var data in i.getCells()) {
              if (data.columnName != 'button' ||
                  data.columnName == 'View' ||
                  data.columnName != 'Delete') {
                cmu_table_data[data.columnName] = data.value;
              }
            }
            cmutabledatalist.add(cmu_table_data);
            cmu_table_data = {};
          }

          FirebaseFirestore.instance
              .collection('CivilQualityChecklist')
              .doc('${widget.depoName}')
              .collection('CTPT METERING UNIT TABLE DATA')
              .doc('CTPT METERING UNIT')
              .collection(userId)
              .doc(widget.currentDate)
              .set({
            'data': cmutabledatalist,
          }).whenComplete(() {
            cmutabledatalist.clear();
            for (var i in _qualityCeillingDataSource.dataGridRows) {
              for (var data in i.getCells()) {
                if (data.columnName != 'button' ||
                    data.columnName != 'Delete') {
                  acdb_table_data[data.columnName] = data.value;
                }
              }
              acdbtabledatalist.add(acdb_table_data);
              acdb_table_data = {};
            }

            FirebaseFirestore.instance
                .collection('CivilQualityChecklist')
                .doc('${widget.depoName}')
                .collection('ACDB TABLE DATA')
                .doc('ACDB DATA')
                .collection(userId)
                .doc(widget.currentDate)
                .set({
              'data': acdbtabledatalist,
            }).whenComplete(() {
              acdbtabledatalist.clear();
              for (var i in _qualityflooringDataSource.dataGridRows) {
                for (var data in i.getCells()) {
                  if (data.columnName != 'button' ||
                      data.columnName == 'View' ||
                      data.columnName != 'Delete') {
                    ci_table_data[data.columnName] = data.value;
                  }
                }
                citabledatalist.add(ci_table_data);
                ci_table_data = {};
              }

              FirebaseFirestore.instance
                  .collection('CivilQualityChecklist')
                  .doc('${widget.depoName}')
                  .collection('CABLE INSTALLATION TABLE DATA')
                  .doc('CABLE INSTALLATION')
                  .collection(userId)
                  .doc(widget.currentDate)
                  .set({
                'data': citabledatalist,
              }).whenComplete(() {
                citabledatalist.clear();
                for (var i in _qualityInspectionDataSource.dataGridRows) {
                  for (var data in i.getCells()) {
                    if (data.columnName != 'button' ||
                        data.columnName == 'View' ||
                        data.columnName != 'Delete') {
                      cdi_table_data[data.columnName] = data.value;
                    }
                  }
                  cditabledatalist.add(cdi_table_data);
                  cdi_table_data = {};
                }

                FirebaseFirestore.instance
                    .collection('CivilQualityChecklist')
                    .doc('${widget.depoName}')
                    .collection('CDI TABLE DATA')
                    .doc('CDI DATA')
                    .collection(userId)
                    .doc(widget.currentDate)
                    .set({
                  'data': cditabledatalist,
                }).whenComplete(() {
                  cditabledatalist.clear();
                  for (var i
                      in _qualityIroniteflooringDataSource.dataGridRows) {
                    for (var data in i.getCells()) {
                      if (data.columnName != 'button' ||
                          data.columnName == 'View' ||
                          data.columnName != 'Delete') {
                        msp_table_data[data.columnName] = data.value;
                      }
                    }
                    msptabledatalist.add(msp_table_data);
                    msp_table_data = {};
                  }

                  FirebaseFirestore.instance
                      .collection('CivilQualityChecklist')
                      .doc('${widget.depoName}')
                      .collection('MSP TABLE DATA')
                      .doc('MSP DATA')
                      .collection(userId)
                      .doc(widget.currentDate)
                      .set({
                    'data': msptabledatalist,
                  }).whenComplete(() {
                    msptabledatalist.clear();
                    for (var i in _qualityPaintingDataSource.dataGridRows) {
                      for (var data in i.getCells()) {
                        if (data.columnName != 'button' ||
                            data.columnName == 'View' ||
                            data.columnName != 'Delete') {
                          charger_table_data[data.columnName] = data.value;
                        }
                      }
                      chargertabledatalist.add(charger_table_data);
                      charger_table_data = {};
                    }

                    FirebaseFirestore.instance
                        .collection('CivilQualityChecklist')
                        .doc('${widget.depoName}')
                        .collection('CHARGER TABLE DATA')
                        .doc('CHARGER DATA')
                        .collection(userId)
                        .doc(widget.currentDate)
                        .set({
                      'data': chargertabledatalist,
                    }).whenComplete(() {
                      chargertabledatalist.clear();
                      for (var i in _qualityPavingDataSource.dataGridRows) {
                        for (var data in i.getCells()) {
                          if (data.columnName != 'button' ||
                              data.columnName == 'View' ||
                              data.columnName != 'Delete') {
                            ep_table_data[data.columnName] = data.value;
                          }
                        }
                        eptabledatalist.add(ep_table_data);
                        ep_table_data = {};
                      }

                      FirebaseFirestore.instance
                          .collection('CivilQualityChecklist')
                          .doc('${widget.depoName}')
                          .collection('EARTH TABLE DATA')
                          .doc('EARTH DATA')
                          .collection(userId)
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
                      FirebaseFirestore.instance
                          .collection('CivilQualityChecklist')
                          .doc('${widget.depoName}')
                          .collection('WALL CLADDING & ROOFING DATA')
                          .doc('WCR DATA')
                          .collection(userId)
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
                      FirebaseFirestore.instance
                          .collection('CivilQualityChecklist')
                          .doc('${widget.depoName}')
                          .collection('POOFING DATA')
                          .doc('Proofing DATA')
                          .collection(userId)
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

  Future<void> getUserId() async {
    await AuthService().getCurrentUserId().then((value) {
      userId = value;
    });
  }

  upperScreen() {
    return _isloading
        ? LoadingPage()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('CivilQualityChecklistCollection')
                .doc('${widget.depoName}')
                .collection(userId)
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
                                            'Employee Name',
                                          )),
                                      const SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                              //   children: [
                              //     HeaderValue('Employee Name', '', empName ?? ''),
                              //     HeaderValue('Doc No.:TPCL/ DIST-EV', '', distev ?? ''),
                              //     HeaderValue('VENDOR NAME', '', vendorname ?? ''),
                              //     HeaderValue('DATE', '', date ?? ''),
                              //   ],
                              // ),
                              // Column(
                              //   children: [
                              //     HeaderValue('OLA NUMBER', '', olano ?? ''),
                              //     HeaderValue('PANEL SR NO.', '', panel ?? ''),
                              //     HeaderValue('DepotName', '', depotname ?? ''),
                              //     HeaderValue('CUSTOMER NAME', '', customername ?? ''),
                              //   ],
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                              child: widget.isHeader!
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
                                                            : _selectedIndex ==
                                                                    9
                                                                ? _stream9
                                                                : _selectedIndex ==
                                                                        10
                                                                    ? _stream10
                                                                    : _stream11,
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
                                          ? _qualityExcavationDataSource
                                          : _selectedIndex == 1
                                              ? _qualityBackFillingDataSource
                                              : _selectedIndex == 2
                                                  ? _qualityMassonaryDataSource
                                                  : _selectedIndex == 3
                                                      ? _qualityGlazzingDataSource
                                                      : _selectedIndex == 4
                                                          ? _qualityCeillingDataSource
                                                          : _selectedIndex == 5
                                                              ? _qualityflooringDataSource
                                                              : _selectedIndex ==
                                                                      6
                                                                  ? _qualityInspectionDataSource
                                                                  : _selectedIndex ==
                                                                          7
                                                                      ? _qualityIroniteflooringDataSource
                                                                      : _selectedIndex ==
                                                                              8
                                                                          ? _qualityPaintingDataSource
                                                                          : _selectedIndex == 9
                                                                              ? _qualityPavingDataSource
                                                                              : _qualityInspectionDataSource,
                                      // _selectedIndex == 10
                                      //     ? _qualityRoofingDataSource
                                      //     : _qualityPROOFINGDataSource,

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
                                          allowEditing: false,
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
                                          allowEditing: false,
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
                                          allowEditing: false,
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
                                        // GridColumn(
                                        //   columnName: 'Delete',
                                        //   autoFitPadding:
                                        //       const EdgeInsets.symmetric(
                                        //           horizontal: 16),
                                        //   allowEditing: false,
                                        //   visible: true,
                                        //   width: 120,
                                        //   label: Container(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 8.0),
                                        //     alignment: Alignment.center,
                                        //     child: Text('Delete Row',
                                        //         overflow:
                                        //             TextOverflow.values.first,
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 16,
                                        //             color: white)
                                        //         //    textAlign: TextAlign.center,
                                        //         ),
                                        //   ),
                                        // ),
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
                                _qualityExcavationDataSource =
                                    QualityExcavationDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 1) {
                                _qualityBackFillingDataSource =
                                    QualityBackFillingDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 2) {
                                _qualityMassonaryDataSource =
                                    QualityMassonaryDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 3) {
                                _qualityGlazzingDataSource =
                                    QualityGlazzingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 4) {
                                _qualityCeillingDataSource =
                                    QualityCeillingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 5) {
                                _qualityflooringDataSource =
                                    QualityflooringDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 6) {
                                _qualityInspectionDataSource =
                                    QualityInspectionDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 7) {
                                _qualityIroniteflooringDataSource =
                                    QualityIroniteflooringDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 8) {
                                _qualityPaintingDataSource =
                                    QualityPaintingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 9) {
                                _qualityPavingDataSource =
                                    QualityPavingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              }
                              //  else if (_selectedIndex == 10) {
                              //   _qualityRoofingDataSource = QualityWCRDataSource(
                              //       qualitylisttable1,
                              //       widget.depoName!,
                              //       widget.cityName!);
                              //   _dataGridController = DataGridController();
                              // } else if (_selectedIndex == 11) {
                              //   _qualityPROOFINGDataSource =
                              //       QualityPROOFINGDataSource(qualitylisttable1,
                              //           widget.depoName!, widget.cityName!);
                              //   _dataGridController = DataGridController();
                              // }
                            });
                            return SfDataGridTheme(
                              data: SfDataGridThemeData(headerColor: blue),
                              child: SfDataGrid(
                                source: _selectedIndex == 0
                                    ? _qualityExcavationDataSource
                                    : _selectedIndex == 1
                                        ? _qualityBackFillingDataSource
                                        : _selectedIndex == 2
                                            ? _qualityMassonaryDataSource
                                            : _selectedIndex == 3
                                                ? _qualityGlazzingDataSource
                                                : _selectedIndex == 4
                                                    ? _qualityCeillingDataSource
                                                    : _selectedIndex == 5
                                                        ? _qualityflooringDataSource
                                                        : _selectedIndex == 6
                                                            ? _qualityInspectionDataSource
                                                            : _selectedIndex ==
                                                                    7
                                                                ? _qualityIroniteflooringDataSource
                                                                : _selectedIndex ==
                                                                        8
                                                                    ? _qualityPaintingDataSource
                                                                    :
                                                                    // _selectedIndex ==
                                                                    //         9
                                                                    //     ?
                                                                    _qualityPavingDataSource,
                                // : _selectedIndex ==
                                //         10
                                //     ? _qualityRoofingDataSource
                                // : _qualityPROOFINGDataSource,

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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                  // GridColumn(
                                  //   columnName: 'Delete',
                                  //   autoFitPadding: const EdgeInsets.symmetric(
                                  //       horizontal: 16),
                                  //   allowEditing: false,
                                  //   width: 120,
                                  //   visible: true,
                                  //   label: Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 8.0),
                                  //     alignment: Alignment.center,
                                  //     child: Text('Delete Row',
                                  //         overflow: TextOverflow.values.first,
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 16,
                                  //             color: white)
                                  //         //    textAlign: TextAlign.center,
                                  //         ),
                                  //   ),
                                  // ),
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
                    // widget.isHeader!!
                    //     ? Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Align(
                    //           alignment: Alignment.bottomRight,
                    //           child: FloatingActionButton(
                    //             child: Icon(Icons.add),
                    //             onPressed: (() {
                    //               if (_selectedIndex == 0) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityExcavationDataSource.buildDataGridRows();
                    //                 _qualityExcavationDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 1) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityBackFillingDataSource.buildDataGridRows();
                    //                 _qualityBackFillingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 2) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityMassonaryDataSource.buildDataGridRows();
                    //                 _qualityMassonaryDataSource.updateDatagridSource();
                    //               } else if (_selectedIndex == 3) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityGlazzingDataSource.buildDataGridRows();
                    //                 _qualityGlazzingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 4) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityCeillingDataSource=.buildDataGridRows();
                    //                 _qualityCeillingDataSource=
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 5) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _QualityflooringDataSource.buildDataGridRows();
                    //                 _QualityflooringDataSource.updateDatagridSource();
                    //               } else if (_selectedIndex == 6) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityInspectionDataSource.buildDataGridRows();
                    //                 _qualityInspectionDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 7) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityIroniteflooringDataSource.buildDataGridRows();
                    //                 _qualityIroniteflooringDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 8) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                 _qualityPaintingDataSource
                    //                     .buildDataGridRows();
                    //                 _qualityPaintingDataSource
                    //                     .updateDatagridSource();
                    //               } else if (_selectedIndex == 9) {
                    //                 qualitylisttable1.add(
                    //                   QualitychecklistModel(
                    //                     srNo: 1,
                    //                     checklist: 'checklist',
                    //                     responsibility: 'responsibility',
                    //                     reference: 'reference',
                    //                     observation: 'observation',
                    //                     // photoNo: 12345,
                    //                   ),
                    //                 );
                    //                _qualityPavingDataSource.buildDataGridRows();
                    //                _qualityPavingDataSource.updateDatagridSource();
                    //               }
                    //             }),
                    //           ),
                    //         ),
                    //       )
                    //     : Container()
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

// EXCAVATION ACTIVITY DATA
  List<QualitychecklistModel> excavation_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_exc_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_exc_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_exc_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_exc_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_exc_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_exc_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_exc_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_exc_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_exc_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_exc_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_exc_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_exc_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_exc_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_exc_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: civil_exc_activity_data[14],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

  // BACKFILLING ACTIVITY DATA
  List<QualitychecklistModel> backfilling_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_bf_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_bf_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_bf_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_bf_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_bf_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_bf_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_bf_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_bf_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_bf_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_bf_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_bf_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_bf_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_bf_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_bf_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: civil_bf_activity_data[14],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: civil_bf_activity_data[15],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

  // BRICK & BLOCK MASSONARY ACTIVITY DATA
  List<QualitychecklistModel> massonary_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_mass_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_mass_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_mass_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_mass_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_mass_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_mass_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_mass_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_mass_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_mass_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_mass_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_mass_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_mass_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_mass_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_mass_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: civil_mass_activity_data[14],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: civil_mass_activity_data[15],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

  // BLDG DOORS, WINDOWS, HARDWARE, GLAZING ACTIVITY DATA
  List<QualitychecklistModel> glazzing_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_dwg_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_dwg_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_dwg_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_dwg_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_dwg_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_dwg_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_dwg_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_dwg_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_dwg_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_dwg_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_dwg_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_dwg_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_dwg_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_dwg_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: civil_dwg_activity_data[14],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: civil_dwg_activity_data[15],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: civil_dwg_activity_data[16],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: civil_dwg_activity_data[17],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

  // FALSE CEILING ACTIVITY DATA
  List<QualitychecklistModel> ceilling_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_fc_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_fc_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_fc_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_fc_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_fc_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_fc_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_fc_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_fc_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_fc_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_fc_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_fc_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_fc_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_fc_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_fc_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: civil_fc_activity_data[14],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: civil_fc_activity_data[15],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

  // FLOORING & TILING ACTIVITY DATA
  List<QualitychecklistModel> florring_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_ft_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_ft_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_ft_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_ft_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_ft_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_ft_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_ft_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_ft_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_ft_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_ft_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_ft_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_ft_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

  // GROUTING INSPECTION ACTIVITY DATA
  List<QualitychecklistModel> inspection_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_gi_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_gi_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_gi_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_gi_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_gi_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_gi_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_gi_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_gi_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_gi_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_gi_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_gi_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_gi_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_gi_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_gi_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

  // IRONITE FLORRING ACTIVITY DATA
  List<QualitychecklistModel> ironite_florring_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_if_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_if_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_if_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_if_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_if_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_if_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_if_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_if_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_if_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_if_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_if_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_if_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_if_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_if_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

  // PAINTING ACTIVITY DATA
  List<QualitychecklistModel> painting_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_painting_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_painting_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_painting_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_painting_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_painting_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_painting_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_painting_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_painting_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_painting_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_painting_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_painting_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_painting_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_painting_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_painting_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: civil_painting_activity_data[14],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: civil_painting_activity_data[15],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: civil_painting_activity_data[16],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

// PAVING ACTIVITY DATA
  List<QualitychecklistModel> paving_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_paving_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_paving_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_paving_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_paving_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_paving_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_paving_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_paving_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_paving_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_paving_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_paving_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_paving_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

// WCR ACTIVITY DATA
  List<QualitychecklistModel> roofing_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_wcr_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_wcr_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_wcr_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_wcr_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_wcr_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_wcr_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_wcr_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_wcr_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_wcr_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_wcr_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_wcr_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_wcr_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_wcr_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_wcr_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: civil_wcr_activity_data[14],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: civil_wcr_activity_data[15],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: civil_wcr_activity_data[16],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 18,
        checklist: civil_wcr_activity_data[17],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 19,
        checklist: civil_wcr_activity_data[18],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }

// PROOFING ACTIVITY DATA
  List<QualitychecklistModel> proofing_getData() {
    return [
      QualitychecklistModel(
        srNo: 1,
        checklist: civil_wp_activity_data[0],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 2,
        checklist: civil_wp_activity_data[1],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 3,
        checklist: civil_wp_activity_data[2],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 4,
        checklist: civil_wp_activity_data[3],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 5,
        checklist: civil_wp_activity_data[4],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 6,
        checklist: civil_wp_activity_data[5],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 7,
        checklist: civil_wp_activity_data[6],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 8,
        checklist: civil_wp_activity_data[7],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 9,
        checklist: civil_wp_activity_data[8],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 10,
        checklist: civil_wp_activity_data[9],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 11,
        checklist: civil_wp_activity_data[10],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 12,
        checklist: civil_wp_activity_data[11],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 13,
        checklist: civil_wp_activity_data[12],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 14,
        checklist: civil_wp_activity_data[13],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 15,
        checklist: civil_wp_activity_data[14],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 16,
        checklist: civil_wp_activity_data[15],
        responsibility: '',
        reference: '',
        observation: '',
      ),
      QualitychecklistModel(
        srNo: 17,
        checklist: civil_wp_activity_data[16],
        responsibility: '',
        reference: '',
        observation: '',
      ),
    ];
  }
}

// CIVIL ENGINEAR TABLE
class CivilQualityChecklist_civil_enginear extends StatefulWidget {
  String? cityName;
  String? depoName;
  String? currentDate;
  bool? isHeader;

  CivilQualityChecklist_civil_enginear(
      {super.key,
      required this.cityName,
      required this.depoName,
      this.currentDate,
      this.isHeader = true});

  @override
  State<CivilQualityChecklist_civil_enginear> createState() =>
      _CivilQualityChecklist_civil_enginearState();
}

class _CivilQualityChecklist_civil_enginearState
    extends State<CivilQualityChecklist_civil_enginear> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 12,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 20,
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
                Tab(text: "Exc"),
                Tab(text: "B.F"),
                Tab(text: "Mass"),
                Tab(text: "D.W.G"),
                Tab(text: "F.C"),
                Tab(text: "F&T"),
                Tab(text: "G.I"),
                Tab(text: "I.F"),
                Tab(text: "Painting"),
                Tab(text: "Paving"),
                Tab(text: "WC&R"),
                Tab(text: "Proofing"),
              ],
            ),
          ),
          body: TabBarView(children: [
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
            civilupperScreen(),
          ]),
        ));
  }

  civilupperScreen() {
    return _isloading
        ? LoadingPage()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('CivilQualityChecklistCollection')
                .doc('${widget.depoName}')
                .collection(userId)
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
                            civil_title[int.parse(_selectedIndex.toString())],
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Project',
                                          )),
                                      const SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
                                                      )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Location',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                          : '')))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Vendor / Sub Vendor',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                          : '')))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Drawing No:',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
                                                      )))),
                                    ],
                                  ),
                                )
                              ],
                              //   children: [
                              //     HeaderValue('Employee Name', '', empName ?? ''),
                              //     HeaderValue('Doc No.:TPCL/ DIST-EV', '', distev ?? ''),
                              //     HeaderValue('VENDOR NAME', '', vendorname ?? ''),
                              //     HeaderValue('DATE', '', date ?? ''),
                              //   ],
                              // ),
                              // Column(
                              //   children: [
                              //     HeaderValue('OLA NUMBER', '', olano ?? ''),
                              //     HeaderValue('PANEL SR NO.', '', panel ?? ''),
                              //     HeaderValue('DepotName', '', depotname ?? ''),
                              //     HeaderValue('CUSTOMER NAME', '', customername ?? ''),
                              //   ],
                            ),
                            Column(
                              children: [
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Date',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                          : '')))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Component of the Structure',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
                                                      )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Grid / Axis & Level',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
                                                      )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: lightblue,
                                  width: 600,
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          child: Text(
                                            'Type of Filling',
                                          )),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Container(
                                              height: 30,
                                              child: widget.isHeader!
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
                                                          : '',
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
                                                            : '',
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
                                                            : _selectedIndex ==
                                                                    9
                                                                ? _stream9
                                                                : _selectedIndex ==
                                                                        10
                                                                    ? _stream10
                                                                    : _stream11,
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
                                          ? _qualityExcavationDataSource
                                          : _selectedIndex == 1
                                              ? _qualityBackFillingDataSource
                                              : _selectedIndex == 2
                                                  ? _qualityMassonaryDataSource
                                                  : _selectedIndex == 3
                                                      ? _qualityGlazzingDataSource
                                                      : _selectedIndex == 4
                                                          ? _qualityCeillingDataSource
                                                          : _selectedIndex == 5
                                                              ? _qualityflooringDataSource
                                                              : _selectedIndex ==
                                                                      6
                                                                  ? _qualityInspectionDataSource
                                                                  : _selectedIndex ==
                                                                          7
                                                                      ? _qualityIroniteflooringDataSource
                                                                      : _selectedIndex ==
                                                                              8
                                                                          ? _qualityPaintingDataSource
                                                                          : _selectedIndex == 9
                                                                              ? _qualityPavingDataSource
                                                                              : _qualityPavingDataSource,
                                      // _selectedIndex == 10
                                      //     ? _qualityRoofingDataSource
                                      //     : _qualityPROOFINGDataSource,

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
                                          allowEditing: false,
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
                                          allowEditing: false,
                                          label: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                                'Checks(Before Start of Backfill Activity)',
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
                                            child: Text(
                                                "Contractor’s Site Engineer",
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
                                            child: Text("Owner’s Site Engineer",
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
                                            child: Text(
                                                "Observation Comments by  Owner’s Engineer",
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
                                          allowEditing: false,
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
                                        // GridColumn(
                                        //   columnName: 'Delete',
                                        //   autoFitPadding:
                                        //       const EdgeInsets.symmetric(
                                        //           horizontal: 16),
                                        //   allowEditing: false,
                                        //   visible: true,
                                        //   width: 120,
                                        //   label: Container(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 8.0),
                                        //     alignment: Alignment.center,
                                        //     child: Text('Delete Row',
                                        //         overflow:
                                        //             TextOverflow.values.first,
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 16,
                                        //             color: white)
                                        //         //    textAlign: TextAlign.center,
                                        //         ),
                                        //   ),
                                        // ),
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
                                _qualityExcavationDataSource =
                                    QualityExcavationDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 1) {
                                _qualityBackFillingDataSource =
                                    QualityBackFillingDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 2) {
                                _qualityMassonaryDataSource =
                                    QualityMassonaryDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 3) {
                                _qualityGlazzingDataSource =
                                    QualityGlazzingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 4) {
                                _qualityCeillingDataSource =
                                    QualityCeillingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 5) {
                                _qualityflooringDataSource =
                                    QualityflooringDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 6) {
                                _qualityInspectionDataSource =
                                    QualityInspectionDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 7) {
                                _qualityIroniteflooringDataSource =
                                    QualityIroniteflooringDataSource(
                                        qualitylisttable1,
                                        widget.depoName!,
                                        widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 8) {
                                _qualityPaintingDataSource =
                                    QualityPaintingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              } else if (_selectedIndex == 9) {
                                _qualityPavingDataSource =
                                    QualityPavingDataSource(qualitylisttable1,
                                        widget.depoName!, widget.cityName!);
                                _dataGridController = DataGridController();
                              }
                              //  else if (_selectedIndex == 10) {
                              //   _qualityRoofingDataSource = QualityWCRDataSource(
                              //       qualitylisttable1,
                              //       widget.depoName!,
                              //       widget.cityName!);
                              //   _dataGridController = DataGridController();
                              // } else if (_selectedIndex == 11) {
                              //   _qualityPROOFINGDataSource =
                              //       QualityPROOFINGDataSource(qualitylisttable1,
                              //           widget.depoName!, widget.cityName!);
                              //   _dataGridController = DataGridController();
                              // }
                            });
                            return SfDataGridTheme(
                              data: SfDataGridThemeData(headerColor: blue),
                              child: SfDataGrid(
                                source: _selectedIndex == 0
                                    ? _qualityExcavationDataSource
                                    : _selectedIndex == 1
                                        ? _qualityBackFillingDataSource
                                        : _selectedIndex == 2
                                            ? _qualityMassonaryDataSource
                                            : _selectedIndex == 3
                                                ? _qualityGlazzingDataSource
                                                : _selectedIndex == 4
                                                    ? _qualityCeillingDataSource
                                                    : _selectedIndex == 5
                                                        ? _qualityflooringDataSource
                                                        : _selectedIndex == 6
                                                            ? _qualityInspectionDataSource
                                                            : _selectedIndex ==
                                                                    7
                                                                ? _qualityIroniteflooringDataSource
                                                                : _selectedIndex ==
                                                                        8
                                                                    ? _qualityPaintingDataSource
                                                                    : _selectedIndex ==
                                                                            9
                                                                        ? _qualityPavingDataSource
                                                                        : _qualityPavingDataSource,
                                // _selectedIndex ==
                                //         10
                                //     ? _qualityRoofingDataSource
                                //     : _qualityPROOFINGDataSource,

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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                    allowEditing: false,
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
                                  // GridColumn(
                                  //   columnName: 'Delete',
                                  //   autoFitPadding: const EdgeInsets.symmetric(
                                  //       horizontal: 16),
                                  //   allowEditing: false,
                                  //   width: 120,
                                  //   visible: true,
                                  //   label: Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 8.0),
                                  //     alignment: Alignment.center,
                                  //     child: Text('Delete Row',
                                  //         overflow: TextOverflow.values.first,
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 16,
                                  //             color: white)
                                  //         //    textAlign: TextAlign.center,
                                  //         ),
                                  //   ),
                                  // ),
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
                  ],
                );
              } else {
                return LoadingPage();
              }
            },
          );
  }
}
