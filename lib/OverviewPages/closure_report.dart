import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/datasource/closereport_datasource.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../Authentication/auth_service.dart';
import '../components/loading_page.dart';
import '../model/close_report.dart';
import '../style.dart';
import '../widgets/custom_appbar.dart';

class ClosureReport extends StatefulWidget {
  String? userId;
  String? cityName;
  String? depoName;
  ClosureReport(
      {super.key, this.userId, required this.cityName, required this.depoName});

  @override
  State<ClosureReport> createState() => _ClosureReportState();
}

class _ClosureReportState extends State<ClosureReport> {
  List<CloseReportModel> closereport = <CloseReportModel>[];
  late CloseReportDataSource _closeReportDataSource;

  late DataGridController _dataGridController;
  Stream? _stream;
  var alldata;
  String? depotname, state;
  var buses;
  var longitude, latitude, loa;
  dynamic userId;
  dynamic companyId;
  bool specificUser = false;
  QuerySnapshot? snap;
  bool _isloading = true;

  @override
  void initState() {
    // _fetchClosureField();
    // getUserId().whenComplete(() {
    getUserId();
    identifyUser();
    closereport = getcloseReport();
    _closeReportDataSource = CloseReportDataSource(closereport, context,
        widget.depoName!, widget.cityName!, widget.userId!);
    _dataGridController = DataGridController();
    _stream = FirebaseFirestore.instance
        .collection('ClosureProjectReport')
        .doc('${widget.depoName}')
        .collection('ClosureReport')
        .doc(widget.userId)
        .snapshots();

    _isloading = false;
    setState(() {});
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            // ignore: sort_child_properties_last
            child: CustomAppBar(
              text: ' ${widget.cityName}/ ${widget.depoName} / Close Report',
              userid: widget.userId,
              haveSynced: specificUser ? true : false,
              store: () {
                FirebaseFirestore.instance
                    .collection('ClosureReport')
                    .doc('${widget.depoName}')
                    .collection("ClosureData")
                    .doc(widget.userId)
                    .set(
                  {
                    'DepotName': depotname ?? 'Enter Depot Name',
                    'Longitude': longitude ?? 'Enter Longitude',
                    'Latitude': latitude ?? 'Enter Latitude',
                    'State': state ?? 'Enter State',
                    'Buses': buses ?? 'Enter Buse',
                    'LaoNo': loa ?? 'Enter LOA No.',
                  },
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Data are synced'),
                  backgroundColor: blue,
                ));
              },
            ),
            preferredSize: const Size.fromHeight(50)),
        body: _isloading ? LoadingPage() : upperScreen());
  }

  // Future<void> getUserId() async {
  //   await AuthService().getCurrentUserId().then((value) {
  //     userId = value;
  //   });
  // }

  upperScreen() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('ClosureReport')
          .doc('${widget.depoName}')
          .collection("ClosureData")
          .doc(widget.userId)
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
                    const Text(
                      '',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: 150,
                                    child: const Text(
                                      ' Depot Name',
                                    )),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Container(
                                        height: 30,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, bottom: 0, left: 5)),
                                          initialValue: snapshot.data!
                                                  .data()
                                                  .toString()
                                                  .contains('DepotName')
                                              ? snapshot.data!
                                                      .get('DepotName') ??
                                                  ''
                                              : 'Depot Name',
                                          style: const TextStyle(fontSize: 15),
                                          onChanged: (value) {
                                            depotname = value;
                                          },
                                          onSaved: (newValue) {
                                            // empName = newValue.toString();
                                          },
                                        ))),
                              ],
                            ),
                          ),
                          Container(
                            color: lightblue,
                            width: 625,
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: 150,
                                    child: Text(
                                      'Longitude',
                                    )),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Container(
                                        height: 30,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, bottom: 0, left: 5)),
                                          initialValue: snapshot.data!
                                                  .data()
                                                  .toString()
                                                  .contains('Longitude')
                                              ? snapshot.data!
                                                      .get('Longitude') ??
                                                  'Longitude'
                                              : '',
                                          style: const TextStyle(fontSize: 15),
                                          onChanged: (value) {
                                            longitude = value;
                                          },
                                          onSaved: (newValue) {
                                            // distev = newValue.toString();
                                          },
                                        ))),
                              ],
                            ),
                          ),
                          Container(
                            color: lightblue,
                            width: 625,
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: 150,
                                    child: Text(
                                      ' Latitude',
                                    )),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Container(
                                        height: 30,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, bottom: 0, left: 5)),
                                          initialValue: snapshot.data!
                                                  .data()
                                                  .toString()
                                                  .contains('Latitude')
                                              ? snapshot.data!
                                                      .get('Latitude') ??
                                                  ''
                                              : 'Latitude',
                                          style: const TextStyle(fontSize: 15),
                                          onChanged: (value) {
                                            latitude = value;
                                          },
                                          onSaved: (newValue) {
                                            // vendorname =
                                            //     newValue.toString();
                                          },
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            color: lightblue,
                            width: 625,
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: 150,
                                    child: Text(
                                      ' State',
                                    )),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Container(
                                        height: 30,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, bottom: 0, left: 5)),
                                          initialValue: snapshot.data!
                                                  .data()
                                                  .toString()
                                                  .contains('State')
                                              ? snapshot.data!.get('State') ??
                                                  ''
                                              : 'State',
                                          style: const TextStyle(fontSize: 15),
                                          onChanged: (value) {
                                            state = value;
                                          },
                                          onSaved: (newValue) {
                                            // olano = newValue.toString();
                                          },
                                        ))),
                              ],
                            ),
                          ),
                          Container(
                            color: lightblue,
                            width: 625,
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: 150,
                                    child: Text(
                                      ' No. Of Buses',
                                    )),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Container(
                                        height: 30,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, bottom: 0, left: 5)),
                                          initialValue: snapshot.data!
                                                  .data()
                                                  .toString()
                                                  .contains('Buses')
                                              ? snapshot.data!.get('Buses') ??
                                                  ''
                                              : 'Buses',
                                          style: const TextStyle(fontSize: 15),
                                          onChanged: (value) {
                                            buses = value.toString();
                                          },
                                          onSaved: (newValue) {
                                            // panel = newValue.toString();
                                          },
                                        ))),
                              ],
                            ),
                          ),
                          Container(
                            color: lightblue,
                            width: 625,
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: 150,
                                    child: Text(
                                      ' LAO No.',
                                    )),
                                SizedBox(width: 5),
                                Expanded(
                                    child: Container(
                                        height: 30,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, bottom: 0, left: 5)),
                                          initialValue: snapshot.data!
                                                  .data()
                                                  .toString()
                                                  .contains('LaoNo')
                                              ? snapshot.data!.get('LaoNo') ??
                                                  ''
                                              : 'LOA No',
                                          style: const TextStyle(fontSize: 15),
                                          onChanged: (value) {
                                            loa = value;
                                          },
                                          onSaved: (newValue) {
                                            // depotname =
                                            //     newValue.toString();
                                          },
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              Expanded(
                child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingPage();
                    }
                    if (!snapshot.hasData || snapshot.data.exists == false) {
                      return SfDataGridTheme(
                        data: SfDataGridThemeData(headerColor: blue),
                        child: SfDataGrid(
                          source: _closeReportDataSource,
                          //key: key,
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
                              columnName: 'srNo',
                              width: 80,
                              autoFitPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              allowEditing: false,
                              label: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                              columnName: 'Content',
                              width: 700,
                              allowEditing: false,
                              label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                    'List of Content for ${widget.depoName}  Infrastructure',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white,
                                    )),
                              ),
                            ),
                            GridColumn(
                              columnName: 'Upload',
                              allowEditing: false,
                              visible: true,
                              width: 250,
                              label: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.center,
                                child: Text('Upload',
                                    overflow: TextOverflow.values.first,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: white)),
                              ),
                            ),
                            GridColumn(
                              columnName: 'View',
                              allowEditing: false,
                              width: 250,
                              label: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.center,
                                child: Text('View',
                                    overflow: TextOverflow.values.first,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: white)),
                              ),
                            ),
                          ],

                          stackedHeaderRows: [
                            StackedHeaderRow(cells: [
                              StackedHeaderCell(
                                  columnNames: ['Upload', 'View'],
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Attachment Details',
                                      style:
                                          TextStyle(color: white, fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                            ])
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // alldata = '';
                      // alldata = snapshot.data['data'] as List<dynamic>;
                      // qualitylisttable1.clear();
                      alldata.forEach((element) {});
                      return SfDataGridTheme(
                        data: SfDataGridThemeData(headerColor: blue),
                        child: SfDataGrid(
                          source: _closeReportDataSource,
                          //key: key,
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
                              columnName: 'srNo',
                              width: 80,
                              autoFitPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              allowEditing: false,
                              label: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                              columnName: 'Content',
                              width: 450,
                              allowEditing: false,
                              label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                    'List of Content for ${widget.depoName}  Infrastructure',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: white,
                                    )),
                              ),
                            ),
                            GridColumn(
                              columnName: 'Upload',
                              allowEditing: false,
                              visible: true,
                              width: 150,
                              label: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.center,
                                child: Text('Upload',
                                    overflow: TextOverflow.values.first,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: white)),
                              ),
                            ),
                            GridColumn(
                              columnName: 'View',
                              allowEditing: false,
                              width: 150,
                              label: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.center,
                                child: Text('View',
                                    overflow: TextOverflow.values.first,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: white)),
                              ),
                            ),
                          ],

                          stackedHeaderRows: [
                            StackedHeaderRow(cells: [
                              StackedHeaderCell(
                                  columnNames: ['Upload', 'View'],
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Attachment Details',
                                      style:
                                          TextStyle(color: white, fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                            ])
                          ],
                        ),
                      );
                    } else {
                      // here w3e have to put Nodata page
                      return LoadingPage();
                    }
                  },
                ),
              ),
              //  Padding(
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
              //                 _qualityPSSDataSource.buildDataGridRows();
              //                 _qualityPSSDataSource.updateDatagridSource();
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
              //                 _qualityrmuDataSource.buildDataGridRows();
              //                 _qualityrmuDataSource.updateDatagridSource();
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
              //                 _qualityctDataSource.buildDataGridRows();
              //                 _qualityctDataSource.updateDatagridSource();
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
              //                 _qualitycmuDataSource.buildDataGridRows();
              //                 _qualitycmuDataSource.updateDatagridSource();
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
              //                 _qualityacdDataSource.buildDataGridRows();
              //                 _qualityacdDataSource.updateDatagridSource();
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
              //                 _qualityCIDataSource.buildDataGridRows();
              //                 _qualityCIDataSource.updateDatagridSource();
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
              //                 _qualityCDIDataSource.buildDataGridRows();
              //                 _qualityCDIDataSource.updateDatagridSource();
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
              //                 _qualityMSPDataSource.buildDataGridRows();
              //                 _qualityMSPDataSource.updateDatagridSource();
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
              //                 _qualityChargerDataSource.buildDataGridRows();
              //                 _qualityChargerDataSource.updateDatagridSource();
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
              //                 _qualityEPDataSource.buildDataGridRows();
              //                 _qualityEPDataSource.updateDatagridSource();
              //               }
              //             }),
              //           ),
              //         ),
              //       )
            ],
          );
        } else {
          return LoadingPage();
        }
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

  // void _fetchClosureField() async {
  //   await FirebaseFirestore.instance
  //       .collection('ClosureReport')
  //       .doc('${widget.depoName}')
  //       .collection("ClosureData")
  //       .doc(userId)
  //       .get()
  //       .then((ds) {
  //     setState(() {
  //       depotname = ds.data()!['DepotName'];
  //       longitude = ds.data()!['Longitude'];
  //       latitude = ds.data()!['Latitude'];
  //       state = ds.data()!['State'];
  //       buses = ds.data()!['Buses'];
  //       loa = ds.data()!['LaoNo'];
  //     });
  //   });
  // }

  List<CloseReportModel> getcloseReport() {
    return [
      CloseReportModel(
        siNo: 1,
        content: 'Introduction of Project',
      ),
      CloseReportModel(
        siNo: 1.1,
        content: 'RFP for DTC Bus Project ',
      ),
      CloseReportModel(
        siNo: 1.2,
        content: 'Project Purchase Order or LOI or LOA ',
      ),
      CloseReportModel(
        siNo: 1.3,
        content: 'Project Governance Structure',
      ),
      CloseReportModel(
        siNo: 1.4,
        content: 'Site Location Details',
      ),
      CloseReportModel(
        siNo: 1.5,
        content: 'Final  Site Survey Report.',
      ),
      CloseReportModel(
        siNo: 1.6,
        content: 'BOQ (Bill of Quantity)',
      ),
    ];
  }
}
