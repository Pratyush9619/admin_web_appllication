import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/KeyEvents/datasource/employee_datasouce.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/provider/text_provider.dart';
import 'package:web_appllication/style.dart';

import '../MenuPage/KeyEvents/datasource/depot_overviewdatasource.dart';
import '../MenuPage/KeyEvents/model/depot_overview.dart';

class DepotOverview extends StatefulWidget {
  String? depoName;
  DepotOverview({super.key, this.depoName});

  @override
  State<DepotOverview> createState() => _DepotOverviewState();
}

class _DepotOverviewState extends State<DepotOverview> {
  late DepotOverviewDatasource _employeeDataSource;
  List<DepotOverviewModel> _employees = <DepotOverviewModel>[];
  late DataGridController _dataGridController;
  List<dynamic> tabledata2 = [];
  FilePickerResult? result;
  FilePickerResult? result1;
  Uint8List? fileBytes;
  // TextEditingController? _textEditingController,
  //     _textEditingController2,
  //     _textEditingController3,
  //     _textEditingController4,
  //     _textEditingController5,
  //     _textEditingController6;
  var address,
      scope,
      required,
      charger,
      load,
      powerSource,
      boqElectrical,
      boqCivil;

  Stream? _stream;
  var alldata;

  @override
  void initState() {
    _employees = getEmployeeData();
    _employeeDataSource = DepotOverviewDatasource(_employees, context);
    _dataGridController = DataGridController();
    _stream = FirebaseFirestore.instance
        .collection('OverviewCollectionTable')
        .doc(widget.depoName)
        .snapshots();
    super.initState();
    // _textEditingController =
    //     TextEditingController(text: _textprovider.changedata);
    // _textEditingController2 =
    //     TextEditingController(text: _textprovider.changedata);
    // _textEditingController3 =
    //     TextEditingController(text: _textprovider.changedata);
    // _textEditingController4 =
    //     TextEditingController(text: _textprovider.changedata);
    // _textEditingController5 =
    //     TextEditingController(text: _textprovider.changedata);
    // _textEditingController6 =
    //     TextEditingController(text: _textprovider.changedata);
  }

  @override
  Widget build(BuildContext context) {
    final textprovider _textprovider = Provider.of<textprovider>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Depot Overview'),
          backgroundColor: blue,
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                        'Current Progress of Depot Infrastructure Work ',
                        style: TextStyle(color: white, fontSize: 18)),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '50 %',
                      style: TextStyle(color: white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: 600,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: blue),
                              child: Text(
                                'Brief Overview of ${widget.depoName} E-Bus Depot',
                                style: TextStyle(color: white, fontSize: 18),
                              )),
                          const SizedBox(height: 25),
                          cards(),
                          SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection('OverviewCollection')
                                    .doc(widget.depoName)
                                    .set({
                                  'address': address,
                                  'scope': scope,
                                  'required': required,
                                  'charger': charger,
                                  'load': load,
                                  'powerSource': powerSource,
                                });
                                StoreData();
                                // Uint8List? fileBytes1 = result!.files.first.bytes;
                                // Uint8List? fileBytes2 = result!.files.first.bytes;
                                // await FirebaseStorage.instance
                                //     .ref('DepotOverviewFile/' + widget.depoName!)
                                //     .putData(fileBytes1!);
                              },
                              child: Text('Sync'))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'E-Bus Depot Name : ${widget.depoName}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Project Manager: Sumit Swarup Sarkar',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: blue),
                              child: Text('Risk Register',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: white)),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          Expanded(
                              child: StreamBuilder(
                            stream: _stream,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData ||
                                  snapshot.data.exists == false) {
                                return SfDataGrid(
                                  source: _employeeDataSource,
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
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      allowEditing: true,
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
                                      columnName: 'Date',
                                      width: 180,
                                      allowEditing: false,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Date',
                                          overflow: TextOverflow.values.first,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'RiskDescription',
                                      width: 130,
                                      allowEditing: false,
                                      label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text('Risk Description',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'TypeRisk',
                                      width: 180,
                                      allowEditing: false,
                                      label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text('Type',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'impactRisk',
                                      width: 150,
                                      allowEditing: false,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Impact Risk',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Owner',
                                      allowEditing: true,
                                      width: 150,
                                      label: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text('Owner',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ),
                                          Text(
                                              'Person Who will manage the risk',
                                              overflow:
                                                  TextOverflow.values.first,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12))
                                        ],
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'MigratingRisk',
                                      allowEditing: true,
                                      width: 150,
                                      label: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text('Mitigation Action',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ),
                                          Text(
                                              'Action to Mitigate the risk e.g reduce the likelihood',
                                              overflow:
                                                  TextOverflow.values.first,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12))
                                        ],
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'ContigentAction',
                                      allowEditing: true,
                                      width: 180,
                                      label: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            alignment: Alignment.center,
                                            child: Text('Contigent Action',
                                                overflow:
                                                    TextOverflow.values.first,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ),
                                          Text(
                                              'Action to be taken if the risk happens',
                                              overflow:
                                                  TextOverflow.values.first,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12))
                                        ],
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'ProgressionAction',
                                      allowEditing: false,
                                      width: 180,
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: Text('Progression Action',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Status',
                                      allowEditing: false,
                                      width: 150,
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: Text('Status',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                alldata =
                                    snapshot.data['data'] as List<dynamic>;
                                _employees.clear();
                                alldata.forEach((element) {
                                  _employees.add(
                                      DepotOverviewModel.fromJson(element));
                                  _employeeDataSource = DepotOverviewDatasource(
                                      _employees, context);
                                  _dataGridController = DataGridController();
                                });
                                return SfDataGrid(
                                  source: _employeeDataSource,
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
                                      autoFitPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      allowEditing: true,
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
                                      columnName: 'Date',
                                      width: 180,
                                      allowEditing: false,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Date',
                                          overflow: TextOverflow.values.first,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'RiskDescription',
                                      width: 130,
                                      allowEditing: false,
                                      label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text('Risk Description',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'TypeRisk',
                                      width: 180,
                                      allowEditing: false,
                                      label: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: const Text('Type',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'impactRisk',
                                      width: 150,
                                      allowEditing: false,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Impact Risk',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'MigratingRisk',
                                      allowEditing: true,
                                      width: 150,
                                      label: Container(
                                        alignment: Alignment.center,
                                        child: Text('Migrating Risk',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'ContigentAction',
                                      allowEditing: true,
                                      width: 180,
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: Text('Contigent Action',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'ProgressionAction',
                                      allowEditing: false,
                                      width: 180,
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: Text('Progression Action',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                    GridColumn(
                                      columnName: 'Status',
                                      allowEditing: false,
                                      width: 150,
                                      label: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        alignment: Alignment.center,
                                        child: Text('Status',
                                            overflow: TextOverflow.values.first,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (() {
              _employees.add(DepotOverviewModel(
                  srNo: 1,
                  date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  riskDescription: 'dedd',
                  typeRisk: 'Material Supply',
                  impactRisk: 'High',
                  owner: 'Pratyush',
                  migrateAction: ' lkmlm',
                  contigentAction: 'mlkmlk',
                  progressAction: 'iio',
                  status: 'Close'));
              _employeeDataSource.buildDataGridRows();
              _employeeDataSource.updateDatagridSource();
            })),
      ),
    );
  }

  cards() {
    return Expanded(
      child: Container(
        width: 550,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('OverviewCollection')
              .doc(widget.depoName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 280,
                        child: const Text(
                          'Depots location and Address ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                          width: 200,
                          height: 50,
                          child: TextFormField(
                              initialValue: snapshot.data!
                                      .data()
                                      .toString()
                                      .contains('address')
                                  ? snapshot.data!.get('address')
                                  : 'Enter Address',
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              minLines: 1,
                              autofocus: false,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: black, fontSize: 16),
                              onChanged: (value) {
                                address = value;
                              })),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: const Text(
                          'No of Buses in Scope',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                            initialValue: snapshot.data!
                                    .data()
                                    .toString()
                                    .contains('scope')
                                ? snapshot.data!.get('scope')
                                : 'Enter scope',
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            minLines: 1,
                            autofocus: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 16),
                            onChanged: (value) {
                              scope = value;
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: const Text(
                          'No. of Charger Required ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                            initialValue: snapshot.data!
                                    .data()
                                    .toString()
                                    .contains('required')
                                ? snapshot.data!.get('required')
                                : 'Enter Required',
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            minLines: 1,
                            autofocus: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 16),
                            onChanged: (value) {
                              required = value;
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: const Text(
                          'Rating Of charger ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                            initialValue: snapshot.data!
                                    .data()
                                    .toString()
                                    .contains('charger')
                                ? snapshot.data!.get('charger')
                                : 'Enter no. of Charger ',
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            minLines: 1,
                            autofocus: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 16),
                            onChanged: (value) {
                              charger = value;
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: const Text(
                          'Required Sanctioned load ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                            initialValue: snapshot.data!
                                    .data()
                                    .toString()
                                    .contains('load')
                                ? snapshot.data!.get('load')
                                : 'Enter  load ',
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            minLines: 1,
                            autofocus: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 16),
                            onChanged: (value) {
                              load = value;
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 280,
                        child: const Text(
                          'Existing Utility for power source ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                            initialValue: snapshot.data!
                                    .data()
                                    .toString()
                                    .contains('powerSource')
                                ? snapshot.data!.get('powerSource')
                                : 'Enter  PowerSource ',
                            textInputAction: TextInputAction.done,
                            minLines: 1,
                            autofocus: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 16),
                            onChanged: (value) {
                              powerSource = value;
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          'BOQ Electrical',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                      ),
                      Container(
                          width: 200,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (result != null)
                                const Padding(
                                  padding: const EdgeInsets.all(8.0),
                                ),
                              ElevatedButton(
                                  onPressed: () async {
                                    result = await FilePicker.platform
                                        .pickFiles(withData: true);
                                    if (result == null) {
                                      print("No file selected");
                                    } else {
                                      setState(() {});
                                      result?.files.forEach((element) {
                                        print(element.name);
                                      });
                                    }
                                  },
                                  child: const Text(
                                    'Pick file',
                                    textAlign: TextAlign.end,
                                  )),
                              Container(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (result != null)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                result!.files.first.name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  )),
                            ],
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 280,
                        child: Text(
                          'BOQ Civil',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                      ),
                      Container(
                          width: 250,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (result1 != null)
                                const Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                ),
                              ElevatedButton(
                                  onPressed: () async {
                                    result1 = await FilePicker.platform
                                        .pickFiles(withData: true);
                                    if (result1 == null) {
                                      print("No file selected");
                                    } else {
                                      setState(() {});
                                      result1?.files.forEach((element) {
                                        print(element.name);
                                      });
                                    }
                                  },
                                  child: const Text('Pick file')),
                              Container(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (result1 != null)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                        child: Text(
                                          result1!.files.first.name,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                ],
                              )),
                            ],
                          )),
                    ],
                  ),
                ],
              );
            }
            return LoadingPage();
          },
        ),
      ),
    );
  }

  void StoreData() {
    Map<String, dynamic> table_data = Map();
    for (var i in _employeeDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        table_data[data.columnName] = data.value;
      }

      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection('OverviewCollectionTable')
        .doc(widget.depoName)
        .set({
      'data': tabledata2,
    }).whenComplete(() {
      tabledata2.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Data are synced'),
        backgroundColor: blue,
      ));
    });
  }
}

List<DepotOverviewModel> getEmployeeData() {
  return [
    DepotOverviewModel(
        srNo: 1,
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        riskDescription: 'dedd',
        typeRisk: 'Material Supply',
        impactRisk: 'High',
        owner: 'Pratyush',
        migrateAction: ' lkmlm',
        contigentAction: 'mlkmlk',
        progressAction: 'iio',
        status: 'Close')
  ];
}
