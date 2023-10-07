import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/Authentication/auth_service.dart';
import 'package:web_appllication/KeyEvents/ChartData.dart';
import 'package:web_appllication/style.dart';
import 'package:web_appllication/widgets/custom_appbar.dart';
import 'package:web_appllication/widgets/nodata_available.dart';
import '../KeyEvents/view_AllFiles.dart';
import '../datasource/depot_overviewdatasource.dart';
import '../model/depot_overview.dart';
import '../components/Loading_page.dart';
import '../widgets/custom_textfield.dart';

class DepotOverview extends StatefulWidget {
  String? userid;
  String? cityName;
  String? depoName;
  DepotOverview(
      {super.key, this.userid, required this.cityName, required this.depoName});

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
  FilePickerResult? result2;
  Uint8List? fileBytes;
  bool specificUser = true;

  dynamic address,
      scope,
      required,
      charger,
      load,
      powerSource,
      boqElectrical,
      boqCivil,
      managername,
      electmanagername,
      elecEng,
      elecVendor,
      civilmanagername,
      civilEng,
      civilVendor;

  Stream? _stream, _stream1;
  dynamic alldata;
  dynamic companyId;
  Uint8List? fileBytes1;
  Uint8List? fileBytes2;
  QuerySnapshot? snap;
  bool isloading = true;

  late TextEditingController _addressController,
      _scopeController,
      _chargerController,
      _ratingController,
      _loadController,
      _powersourceController,
      _elctricalManagerNameController,
      _electricalEngineerController,
      _electricalVendorController,
      _civilManagerNameController,
      _civilEngineerController,
      _civilVendorController;

  List id = [];

  void initializeController() {
    _addressController = TextEditingController();
    _scopeController = TextEditingController();
    _chargerController = TextEditingController();
    _ratingController = TextEditingController();
    _loadController = TextEditingController();
    _powersourceController = TextEditingController();
    _elctricalManagerNameController = TextEditingController();
    _electricalEngineerController = TextEditingController();
    _electricalVendorController = TextEditingController();
    _civilManagerNameController = TextEditingController();
    _civilEngineerController = TextEditingController();
    _civilVendorController = TextEditingController();
  }

  @override
  void initState() {
    initializeController();
    _employeeDataSource = DepotOverviewDatasource(_employees, context);
    _dataGridController = DataGridController();
    getUserId().whenComplete(() {
      identifyUser();

      getFieldUserId().whenComplete(() {
        // _fetchUserData().then((value) {
        if (id.length == 0) id.add('mmmm');
        _fetchUserData();
        // _stream1 = FirebaseFirestore.instance
        //     .collection('OverviewCollection')
        //     .doc(widget.depoName)
        //     .collection('OverviewFieldData')
        //     .doc(id[0])
        //     .snapshots();
        getTableData().whenComplete(() {
          _employeeDataSource = DepotOverviewDatasource(_employees, context);
          _dataGridController = DataGridController();
        });
        isloading = false;
        setState(() {});
      });
    });
    //});

    // _employees = getEmployeeData();

    // ignore: use_build_context_synchronously

    _stream = FirebaseFirestore.instance
        .collection('OverviewCollectionTable')
        .doc(widget.depoName)
        .collection("OverviewTabledData")
        .doc(widget.userid)
        .snapshots();

    // _fetchUserData();

    // _employees = getEmployeeData();
    // _employeeDataSource = DepotOverviewDatasource(_employees, context);
    // _dataGridController = DataGridController();
    // _stream = FirebaseFirestore.instance
    //     .collection('OverviewCollectionTable')
    //     .doc(widget.depoName)
    //     .snapshots();

    // _stream1 = FirebaseFirestore.instance
    //     .collection('OverviewCollection')
    //     .doc(widget.depoName)
    //     .snapshots();

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

  final List<PieChartData> chartData = [
    PieChartData('A1', 25, blue),
    PieChartData('A2', 38, Colors.lightBlue),
    PieChartData('A3', 34, green),
    PieChartData('A4', 52, Colors.yellow)
  ];

  @override
  Widget build(BuildContext context) {
    // final textprovider _textprovider = Provider.of<textprovider>(context);

    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: CustomAppBar(
            toOverview: true,
            showDepoBar: true,
              depoName: widget.depoName,
              cityName: widget.cityName,
              text: '${widget.cityName}/ ${widget.depoName} /Depot Overview',
              userId: widget.userid,
              // icon: Icons.logout,
              haveSynced: false,
              // specificUser ? true : false,
              store: () {
                FirebaseFirestore.instance
                    .collection('OverviewCollection')
                    .doc(widget.depoName)
                    .collection("OverviewFieldData")
                    .doc(widget.userid)
                    .set({
                  'address': address ?? '',
                  'scope': scope ?? '',
                  'required': required ?? '',
                  'charger': charger ?? '',
                  'load': load ?? '',
                  'powerSource': powerSource ?? '',
                  'ManagerName': managername ?? '',
                  'CivilManagerName': civilmanagername ?? '',
                  'CivilEng': civilEng ?? '',
                  'CivilVendor': civilVendor ?? '',
                  'ElectricalManagerName': electmanagername ?? '',
                  'ElectricalEng': elecEng ?? '',
                  'ElectricalVendor': elecVendor ?? '',
                });
                storeData();
              }),
          preferredSize: const Size.fromHeight(50),
        ),

        //  AppBar(
        //   title: const Text('Depot Overview'),
        //   backgroundColor: blue,
        // ),
        body: isloading
            ? LoadingPage()
            : Column(
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5.0),
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
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: blue),
                            child: Text(
                              'Brief Overview of ${widget.depoName} E-Bus Depot',
                              style: TextStyle(color: white, fontSize: 16),
                            )),
                        const SizedBox(height: 5),
                        cards(),
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
                                columnWidthMode: ColumnWidthMode.fill,
                                editingGestureType: EditingGestureType.tap,
                                controller: _dataGridController,
                                onQueryRowHeight: (details) {
                                  return details.getIntrinsicRowHeight(
                                      details.rowIndex,
                                      canIncludeHiddenColumns: true);
                                },
                                columns: [
                                  GridColumn(
                                    visible: false,
                                    width: 100,
                                    columnName: 'srNo',
                                    allowEditing: true,
                                    label: Container(
                                      child: Text(
                                        'Sr No',
                                        style: tableheader,
                                        softWrap: true, // Allow text to wrap
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Date',
                                    width: 160,
                                    allowEditing: false,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Risk On Date',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'RiskDescription',
                                    width: 200,
                                    allowEditing: true,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Risk Description',
                                          overflow: TextOverflow.ellipsis,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'TypeRisk',
                                    width: 180,
                                    allowEditing: false,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Type',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'impactRisk',
                                    width: 150,
                                    allowEditing: false,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Impact Risk',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
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
                                          child: const Text('Owner',
                                              softWrap:
                                                  true, // Allow text to wrap
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ),
                                        const Text(
                                            'Person Who will manage the risk',
                                            softWrap:
                                                true, // Allow text to wrap
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
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
                                          child: const Text('Mitigation Action',
                                              softWrap:
                                                  true, // Allow text to wrap
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ),
                                        const Text(
                                            'Action to Mitigate the risk e.g reduce the likelihood',
                                            softWrap:
                                                true, // Allow text to wrap
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
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
                                          alignment: Alignment.center,
                                          child: const Text('Contigent Action',
                                              softWrap:
                                                  true, // Allow text to wrap
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ),
                                        const Text(
                                            'Action to be taken if the risk happens',
                                            softWrap:
                                                true, // Allow text to wrap
                                            overflow: TextOverflow.clip,

                                            //  textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))
                                      ],
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'ProgressionAction',
                                    allowEditing: true,
                                    width: 180,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Progression Action',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          // overflow: TextOverflow.values.first,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Reason',
                                    allowEditing: true,
                                    width: 150,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Remark',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          // overflow: TextOverflow.values.first,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'TargetDate',
                                    allowEditing: false,
                                    width: 160,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                          'Target Completion Date Of Risk',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Status',
                                    allowEditing: false,
                                    width: 150,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Status',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              alldata = snapshot.data['data'] as List<dynamic>;
                              _employees.clear();
                              alldata.forEach((element) {
                                _employees
                                    .add(DepotOverviewModel.fromJson(element));
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
                                columnWidthMode: ColumnWidthMode.fill,
                                editingGestureType: EditingGestureType.tap,
                                controller: _dataGridController,
                                onQueryRowHeight: (details) {
                                  return details.getIntrinsicRowHeight(
                                      details.rowIndex,
                                      canIncludeHiddenColumns: true);
                                },
                                columns: [
                                  GridColumn(
                                    visible: false,
                                    width: 100,
                                    columnName: 'srNo',
                                    allowEditing: true,
                                    label: Container(
                                      child: Text(
                                        'Sr No',
                                        style: tableheader,
                                        softWrap: true, // Allow text to wrap
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Date',
                                    width: 160,
                                    allowEditing: false,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Risk On Date',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'RiskDescription',
                                    width: 200,
                                    allowEditing: true,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Risk Description',
                                          overflow: TextOverflow.ellipsis,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'TypeRisk',
                                    width: 180,
                                    allowEditing: false,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Type',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'impactRisk',
                                    width: 150,
                                    allowEditing: false,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Impact Risk',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
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
                                          child: const Text('Owner',
                                              softWrap:
                                                  true, // Allow text to wrap
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ),
                                        const Text(
                                            'Person Who will manage the risk',
                                            softWrap:
                                                true, // Allow text to wrap
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
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
                                          child: const Text('Mitigation Action',
                                              softWrap:
                                                  true, // Allow text to wrap
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ),
                                        const Text(
                                            'Action to Mitigate the risk e.g reduce the likelihood',
                                            softWrap:
                                                true, // Allow text to wrap
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
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
                                          alignment: Alignment.center,
                                          child: const Text('Contigent Action',
                                              softWrap:
                                                  true, // Allow text to wrap
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ),
                                        const Text(
                                            'Action to be taken if the risk happens',
                                            softWrap:
                                                true, // Allow text to wrap
                                            overflow: TextOverflow.clip,

                                            //  textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))
                                      ],
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'ProgressionAction',
                                    allowEditing: true,
                                    width: 180,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Progression Action',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          // overflow: TextOverflow.values.first,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Reason',
                                    allowEditing: true,
                                    width: 150,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Remark',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          // overflow: TextOverflow.values.first,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'TargetDate',
                                    allowEditing: false,
                                    width: 160,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                          'Target Completion Date Of Risk',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Status',
                                    allowEditing: false,
                                    width: 150,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text('Status',
                                          softWrap: true, // Allow text to wrap
                                          overflow: TextOverflow.clip,
                                          style: tableheader),
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

        floatingActionButton: AuthService().getcompany() == 'TATA POWER'
            ? FloatingActionButton(
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
                      reason: '',
                      TargetDate:
                          DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      status: 'Close'));
                  _employeeDataSource.buildDataGridRows();
                  _employeeDataSource.updateDatagridSource();
                }))
            : Container(),
      ),
    );
  }

  void _fetchUserData() async {
    await FirebaseFirestore.instance
        .collection('OverviewCollection')
        .doc(widget.depoName)
        .collection("OverviewFieldData")
        .doc(id[0])
        .get()
        .then((ds) {
      setState(() {
        // managername = ds.data()!['ManagerName'];
        _addressController.text = ds.data()!['address'];
        _scopeController.text = ds.data()!['scope'];
        _chargerController.text = ds.data()!['required'];
        _ratingController.text = ds.data()!['charger'];
        _loadController.text = ds.data()!['load'];
        _powersourceController.text = ds.data()!['powerSource'];
        _elctricalManagerNameController.text =
            ds.data()!['ElectricalManagerName'];
        _electricalEngineerController.text = ds.data()!['ElectricalEng'];
        _electricalVendorController.text = ds.data()!['ElectricalVendor'];
        _civilManagerNameController.text = ds.data()!['CivilManagerName'];
        _civilEngineerController.text = ds.data()!['CivilEng'];
        _civilVendorController.text = ds.data()!['CivilVendor'];
      });
    });
  }

  cards() {
    return StreamBuilder(
      stream: _stream1,
      builder: (context, snapshot) {
        // if (snapshot.hasData) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OverviewField(
                      'Depots location and Address ', _addressController),
                  const SizedBox(height: 5),
                  OverviewField('No of Buses in Scope', _scopeController),
                  const SizedBox(height: 5),
                  OverviewField('No. of Charger Required ', _chargerController),
                  const SizedBox(height: 5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OverviewField('Rating of Charger', _ratingController),
                  const SizedBox(height: 5),
                  OverviewField('Required Sanctioned load', _loadController),
                  const SizedBox(height: 5),
                  OverviewField('Existing Utility Of PowerSource ',
                      _powersourceController),
                  const SizedBox(height: 5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OverviewField(
                      'Project Manager ', _elctricalManagerNameController),
                  const SizedBox(height: 5),
                  OverviewField(
                      'Electrical Engineer', _electricalEngineerController),
                  const SizedBox(height: 5),
                  OverviewField(
                      'Electrical Vendor', _electricalVendorController),
                  const SizedBox(height: 5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OverviewField('Civil Manager', _civilManagerNameController),
                  const SizedBox(height: 5),
                  OverviewField('Civil Engineer ', _civilEngineerController),
                  const SizedBox(height: 5),
                  OverviewField('Civil Vendor', _civilVendorController),
                  const SizedBox(height: 5),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                OverviewViewButton(
                    'Details of Survey Report', 'BOQSurvey', 'survey'),
                OverviewViewButton(
                    'BOQ Electrical', 'BOQElectrical', 'electrical'),
                OverviewViewButton('BOQ Civil', 'BOQCivil', 'civil')
              ]),

              // if (AuthService().getcompany() == 'TATA POWER') ...[
              //   Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Container(
              //           width: 200,
              //           height: 35,
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 child: Text(
              //                   'Details of Survey Report',
              //                   textAlign: TextAlign.start,
              //                   style: TextStyle(
              //                       fontSize: 13,
              //                       fontWeight: FontWeight.bold,
              //                       color: black),
              //                 ),
              //               ),
              //               const SizedBox(width: 10),
              //               SizedBox(width: 10),
              //               IconButton(
              //                   alignment: Alignment.bottomRight,
              //                   padding: const EdgeInsets.only(bottom: 5),
              //                   onPressed: () {
              //                     Navigator.of(context).push(MaterialPageRoute(
              //                         builder: (context) => ViewAllPdf(
              //                             title: '/BOQSurvey',
              //                             cityName: widget.cityName!,
              //                             depoName: widget.depoName!,
              //                             userId: id[0],
              //                             docId: 'survey')));
              //                   },
              //                   icon: Icon(Icons.folder, color: yellow))
              //             ],
              //           ),
              //         ),
              //       ]),
              // ] else ...[
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       // mainAxisSize: MainAxisSize.max,
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Container(
              //                 width: 200,
              //                 height: 35,
              //                 child: Row(
              //                   children: [
              //                     Expanded(
              //                       child: Text(
              //                         'Details of Survey Report',
              //                         textAlign: TextAlign.start,
              //                         style: TextStyle(
              //                             fontSize: 13,
              //                             fontWeight: FontWeight.bold,
              //                             color: black),
              //                       ),
              //                     ),
              //                     const SizedBox(width: 10),
              //                     ElevatedButton(
              //                         onPressed: () async {
              //                           result =
              //                               await FilePicker.platform.pickFiles(
              //                             type: FileType.any,
              //                             withData: true,
              //                           );

              //                           fileBytes = result!.files.first.bytes!;
              //                           if (result == null) {
              //                             print("No file selected");
              //                           } else {
              //                             setState(() {});
              //                             result!.files.forEach((element) {
              //                               print(element.name);
              //                               print(result!.files.first.name);
              //                             });
              //                           }
              //                         },
              //                         child: const Text(
              //                           'Pick file',
              //                           textAlign: TextAlign.end,
              //                         )),
              //                     SizedBox(width: 10)
              //                   ],
              //                 ),
              //               ),
              //               Row(
              //                 children: [
              //                   Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     children: [
              //                       Container(
              //                           width: 180,
              //                           height: 35,
              //                           decoration: BoxDecoration(
              //                               color: lightblue,
              //                               border: Border.all(color: grey),
              //                               borderRadius:
              //                                   BorderRadius.circular(5)),
              //                           child: Row(
              //                             children: [
              //                               if (result != null)
              //                                 Expanded(
              //                                   child: Text(
              //                                     maxLines: 1,
              //                                     overflow:
              //                                         TextOverflow.ellipsis,
              //                                     result!.files.first.name,
              //                                     textAlign: TextAlign.center,
              //                                     style: TextStyle(
              //                                         fontSize: 15,
              //                                         color: white),
              //                                   ),
              //                                 )
              //                             ],
              //                           )),
              //                       IconButton(
              //                           alignment: Alignment.bottomRight,
              //                           padding:
              //                               const EdgeInsets.only(bottom: 5),
              //                           onPressed: () {
              //                             Navigator.of(context).push(
              //                                 MaterialPageRoute(
              //                                     builder: (context) =>
              //                                         ViewAllPdf(
              //                                             title: '/BOQSurvey',
              //                                             cityName:
              //                                                 widget.cityName!,
              //                                             depoName:
              //                                                 widget.depoName!,
              //                                             userId: id[0],
              //                                             docId: 'survey')));
              //                           },
              //                           icon: Icon(Icons.folder, color: yellow))
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ]),
              //         Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Container(
              //                 width: 200,
              //                 height: 35,
              //                 child: Row(
              //                   children: [
              //                     Expanded(
              //                       child: Text(
              //                         'BOQ Electrical',
              //                         textAlign: TextAlign.start,
              //                         style: TextStyle(
              //                             fontSize: 13,
              //                             fontWeight: FontWeight.bold,
              //                             color: black),
              //                       ),
              //                     ),
              //                     const SizedBox(width: 10),
              //                     ElevatedButton(
              //                         onPressed: () async {
              //                           result1 =
              //                               await FilePicker.platform.pickFiles(
              //                             type: FileType.any,
              //                             withData: true,
              //                           );

              //                           fileBytes1 =
              //                               result1!.files.first.bytes!;
              //                           if (result1 == null) {
              //                             print("No file selected");
              //                           } else {
              //                             setState(() {});
              //                             result1!.files.forEach((element) {
              //                               print(element.name);
              //                             });
              //                           }
              //                         },
              //                         child: const Text(
              //                           'Pick file',
              //                           textAlign: TextAlign.end,
              //                         ))
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 10),
              //               Row(
              //                 children: [
              //                   Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     children: [
              //                       Container(
              //                           width: 180,
              //                           height: 35,
              //                           decoration: BoxDecoration(
              //                               color: lightblue,
              //                               border: Border.all(color: grey),
              //                               borderRadius:
              //                                   BorderRadius.circular(5)),
              //                           child: Row(
              //                             children: [
              //                               if (result1 != null)
              //                                 Expanded(
              //                                   child: Text(
              //                                     maxLines: 1,
              //                                     overflow:
              //                                         TextOverflow.ellipsis,
              //                                     result1!.files.first.name,
              //                                     textAlign: TextAlign.center,
              //                                     style: TextStyle(
              //                                         fontSize: 15,
              //                                         color: white),
              //                                   ),
              //                                 )
              //                             ],
              //                           )),
              //                       IconButton(
              //                           alignment: Alignment.bottomRight,
              //                           padding:
              //                               const EdgeInsets.only(bottom: 5),
              //                           onPressed: () {
              //                             Navigator.of(context).push(
              //                                 MaterialPageRoute(
              //                                     builder: (context) =>
              //                                         ViewAllPdf(
              //                                             title:
              //                                                 '/BOQElectrical',
              //                                             cityName:
              //                                                 widget.cityName!,
              //                                             depoName:
              //                                                 widget.depoName!,
              //                                             userId: id[0],
              //                                             docId:
              //                                                 'electrical')));
              //                           },
              //                           icon: Icon(Icons.folder, color: yellow))
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ]),
              //         SizedBox(width: 10),
              //         Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Container(
              //                 width: 170,
              //                 height: 35,
              //                 child: Row(
              //                   children: [
              //                     Expanded(
              //                       child: Text(
              //                         'BOQ Civil',
              //                         textAlign: TextAlign.start,
              //                         style: TextStyle(
              //                             fontSize: 13,
              //                             fontWeight: FontWeight.bold,
              //                             color: black),
              //                       ),
              //                     ),
              //                     const SizedBox(width: 10),
              //                     ElevatedButton(
              //                         onPressed: () async {
              //                           result2 =
              //                               await FilePicker.platform.pickFiles(
              //                             type: FileType.any,
              //                             withData: true,
              //                           );

              //                           fileBytes2 =
              //                               result2!.files.first.bytes!;
              //                           if (result == null) {
              //                             print("No file selected");
              //                           } else {
              //                             setState(() {});
              //                             result2!.files.forEach((element) {
              //                               print(element.name);
              //                               print(result!.files.first.name);
              //                             });
              //                           }
              //                         },
              //                         child: const Text(
              //                           'Pick file',
              //                           textAlign: TextAlign.end,
              //                         ))
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 10),
              //               Row(
              //                 children: [
              //                   Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     children: [
              //                       Container(
              //                           width: 180,
              //                           height: 35,
              //                           decoration: BoxDecoration(
              //                               color: lightblue,
              //                               border: Border.all(color: grey),
              //                               borderRadius:
              //                                   BorderRadius.circular(5)),
              //                           child: Row(
              //                             children: [
              //                               if (result2 != null)
              //                                 Expanded(
              //                                   child: Text(
              //                                     result2!.files.first.name,
              //                                     overflow:
              //                                         TextOverflow.ellipsis,
              //                                     textAlign: TextAlign.center,
              //                                     style: TextStyle(
              //                                         fontSize: 15,
              //                                         color: white),
              //                                   ),
              //                                 )
              //                             ],
              //                           )),
              //                       IconButton(
              //                           alignment: Alignment.bottomRight,
              //                           padding:
              //                               const EdgeInsets.only(bottom: 5),
              //                           onPressed: () {
              //                             Navigator.of(context).push(
              //                                 MaterialPageRoute(
              //                                     builder: (context) =>
              //                                         ViewAllPdf(
              //                                             title: '/BOQCivil',
              //                                             cityName:
              //                                                 widget.cityName!,
              //                                             depoName:
              //                                                 widget.depoName!,
              //                                             userId: id[0],
              //                                             docId: 'civil')));
              //                           },
              //                           icon: Icon(Icons.folder, color: yellow))
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ]),

              //         // overviewFieldbutton(
              //         //     'BOQ Civil  ',
              //         //     fileBytes1,
              //         //     result1,
              //         //     result1 != null ? result1!.files.first.name : ''),
              //         // overviewFieldbutton(
              //         //     'Details of Survey Report  ',
              //         //     fileBytes2,
              //         //     result2,
              //         //     result2 != null ? result2!.files.first.name : ''),
              //       ],
              //     ),
              //   )
              // ]
            ]));
        // }
        // return LoadingPage();
      },
    );
  }

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
    if (id.length != 0) {
      var res = await FirebaseFirestore.instance
          .collection('OverviewCollectionTable')
          .doc(widget.depoName)
          .collection("OverviewTabledData")
          .doc(id[0])
          .get()
          .then((element) {
        // value.data() {
        if (element.data() != null) {
          for (int i = 0; i < element.data()!["data"].length; i++) {
            print(element.data()!['data'][i]);
            _employees
                .add(DepotOverviewModel.fromJson(element.data()!['data'][i]));
            print(_employees.length);
          }
        }
      });
    }
    //  });
    // .doc(widget.userid)
    // .snapshots();
    print(_employees.length);
    setState(() {});
  }

  Future getFieldUserId() async {
    await FirebaseFirestore.instance
        .collection('OverviewCollection')
        .doc(widget.depoName!)
        .collection('OverviewFieldData')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data().length != null) {
          if (element.data()['Designation'] == "Project Manager") {
            String documentId = element.id;
            id.add(documentId);
          }
        }

        // for (int i = 0; i < element.data()["data"].length; i++) {
        //   print(element.data()['data']['address']);
        // }

        // nestedTableData(docss);
      });
    });
  }

  // Future<void> _fetchUserData() async {
  //   await FirebaseFirestore.instance
  //       .collection('OverviewCollection')
  //       .doc(widget.depoName)
  //       .collection("OverviewFieldData")
  //       .doc(id[0])
  //       .get()
  //       .then((ds) {
  //     setState(() {
  //       managername = ds.data()!['ManagerName'];
  //       address = ds.data()!['address'];
  //       scope = ds.data()!['scope'];
  //       required = ds.data()!['required'];
  //       charger = ds.data()!['charger'];
  //       load = ds.data()!['load'];
  //       powerSource = ds.data()!['powerSource'];
  //       electmanagername = ds.data()!['ElectricalManagerName'];
  //       elecEng = ds.data()!['ElectricalEng'];
  //       elecVendor = ds.data()!['ElectricalVendor'];
  //       civilmanagername = ds.data()!['CivilManagerName'];
  //       civilEng = ds.data()!['CivilEng'];
  //       civilVendor = ds.data()!['CivilVendor'];
  //     });
  //   });
  // }

  // Future<void> getcompany() async {
  //   await AuthService().getCurrentCompanyName().then((value) {
  //     companyName = value;
  //     setState(() {
  //       isloading = false;
  //     });
  //   });
  // }

  void storeData() {
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
    }).whenComplete(() async {
      tabledata2.clear();
      tabledata2.clear();
      if (fileBytes != null || fileBytes1 != null || fileBytes2 != null) {
        await FirebaseStorage.instance
            .ref(
                'BOQElectrical/${widget.cityName}/${widget.depoName}/${widget.userid}/electrical/${result!.files.first.name}')
            .putData(
                fileBytes!, SettableMetadata(contentType: 'application/pdf'));
        await FirebaseStorage.instance
            .ref(
                'BOQCivil/${widget.cityName}/${widget.depoName}/${widget.userid}/civil/${result1!.files.first.name}')
            .putData(
                fileBytes1!, SettableMetadata(contentType: 'application/pdf'));

        await FirebaseStorage.instance
            .ref(
                'BOQSurvey/${widget.cityName}/${widget.depoName}/${widget.userid}/survey/${result1!.files.first.name}')
            .putData(
                fileBytes2!, SettableMetadata(contentType: 'application/pdf'));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Data are synced'),
      backgroundColor: blue,
    ));
  }

  OverviewField(String title, TextEditingController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 200,
              child: Text(title, textAlign: TextAlign.start, style: formtext),
            ),
            Container(
              width: 200,
              child: CustomTextField(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  OverviewViewButton(String title, String subtitle, String docId) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 200,
              child: Text(title, textAlign: TextAlign.start, style: formtext),
            ),
            Container(
              height: 30,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewAllPdf(
                            title: subtitle,
                            cityName: widget.cityName!,
                            depoName: widget.depoName!,
                            userId: id[0],
                            docId: docId)));
                  },
                  child: const Text('View Files')),
            ),
          ],
        ),
      ),
    );
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
          reason: '',
          TargetDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          status: 'Close')
    ];
  }
}
