import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';
import 'package:web_appllication/QualityDatasource/qualityCivilDatasource/quality_glazzing.dart';
import '../Authentication/auth_service.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_Ironite_flooring.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_backfilling.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_ceiling.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_excavation.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_flooring.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_inspection.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_massonary.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_painting.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_paving.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_proofing.dart';
import '../QualityDatasource/qualityCivilDatasource/quality_roofing.dart';
import '../components/loading_page.dart';
import '../model/quality_checklistModel.dart';
import '../style.dart';
import '../widgets/activity_headings.dart';
// / import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class _CivilQualityChecklistState extends State<CivilQualityChecklist> {
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
  int? _selectedIndex = 0;
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
