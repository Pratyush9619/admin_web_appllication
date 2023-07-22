import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../Authentication/auth_service.dart';
import '../FirebaseApi/firebase_api.dart';
import '../components/loading_page.dart';
import '../datasource/materialprocurement_datasource.dart';
import '../model/material_vendor.dart';
import '../style.dart';
import '../widgets/custom_appbar.dart';

class MaterialProcurement extends StatefulWidget {
  String? cityName;
  String? depoName;
  MaterialProcurement(
      {super.key, required this.cityName, required this.depoName});

  @override
  State<MaterialProcurement> createState() => _MaterialProcurementState();
}

class _MaterialProcurementState extends State<MaterialProcurement> {
  List<MaterialProcurementModel> _materialprocurement =
      <MaterialProcurementModel>[];
  late MaterialDatasource _materialDatasource;
  late DataGridController _dataGridController;
  List<dynamic> tabledata2 = [];
  dynamic userId;
  Stream? _stream;
  bool _isloading = true;
  dynamic alldata;

  @override
  void initState() {
    // _materialprocurement = getmonthlyReport();
    _materialDatasource = MaterialDatasource(
        _materialprocurement, context, widget.cityName, widget.depoName);
    _dataGridController = DataGridController();
    getTableData().whenComplete(
      () {
        _materialDatasource = MaterialDatasource(
            _materialprocurement, context, widget.cityName, widget.depoName);
        _dataGridController = DataGridController();
        _isloading = false;
        setState(() {});
      },
    );
    // getUserId().whenComplete(() {
    //   _stream = FirebaseFirestore.instance
    //       .collection('MaterialProcurement')
    //       .doc('${widget.depoName}')
    //       .collection('Material Data')
    //       .doc(userId)
    //       .snapshots();
    //   _isloading = false;
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            // ignore: sort_child_properties_last
            child: CustomAppBar(
              text:
                  ' ${widget.cityName}/ ${widget.depoName} / Material Procurement',
              haveSummary: false,
              // onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ViewSummary(
              //         cityName: widget.cityName.toString(),
              //         depoName: widget.depoName.toString(),
              //         id: 'Monthly Report',
              //         // userId: userId,
              //       ),
              //     )),
              haveSynced: false,
              store: () {
                _showDialog(context);
                // FirebaseApi().defaultKeyEventsField(
                //     'MaterialProcurement', widget.depoName!);
                // FirebaseApi().nestedKeyEventsField('MaterialProcurement',
                //     widget.depoName!, 'Material Data', userId);
                storeData();
              },
            ),
            preferredSize: const Size.fromHeight(50)),
        body: _isloading
            ? LoadingPage()
            : Column(children: [
                Expanded(
                    child: SfDataGridTheme(
                  data: SfDataGridThemeData(headerColor: blue),
                  child: StreamBuilder(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data.exists == false) {
                        return SfDataGrid(
                            source: _materialDatasource,
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
                                columnName: 'cityName',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 100,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('City Name',
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
                                columnName: 'details',
                                width: 250,
                                allowEditing: true,
                                label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Details Item Description',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'olaNo',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 130,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('OLA No',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'vendorName',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 130,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Vendor Name',
                                      textAlign: TextAlign.center,
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
                                columnName: 'oemApproval',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 150,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('OEM Drawing Approval by Engg',
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
                                columnName: 'oemClearance',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 250,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Manufacturing clearance Given to OEM',
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
                                columnName: 'croPlacement',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 250,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Delivery time line after Placement of CRO',
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
                                columnName: 'croVendor',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 250,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('CRO release to Vendor',
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
                                columnName: 'croNumber',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 120,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('CRO Number ',
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
                                columnName: 'unit',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 120,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Unit',
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
                                columnName: 'qty',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 120,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Qty',
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
                                columnName: 'materialSite',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: false,
                                width: 250,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Receipt of Material at site',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)
                                      //    textAlign: TextAlign.center,
                                      ),
                                ),
                              ),
                            ]);
                      } else {
                        alldata = '';
                        alldata = snapshot.data['data'] as List<dynamic>;
                        _materialprocurement.clear();
                        alldata.forEach((element) {
                          _materialprocurement
                              .add(MaterialProcurementModel.fromjsaon(element));
                          _materialDatasource = MaterialDatasource(
                              _materialprocurement,
                              context,
                              widget.cityName,
                              widget.depoName);
                          _dataGridController = DataGridController();
                        });
                        return SfDataGrid(
                            source: _materialDatasource,
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
                                columnName: 'cityName',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 100,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('City Name',
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
                                columnName: 'details',
                                width: 250,
                                allowEditing: true,
                                label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Details Item Description',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'olaNo',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 130,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('OLA No',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'vendorName',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 130,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Vendor Name',
                                      textAlign: TextAlign.center,
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
                                columnName: 'oemApproval',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 150,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('OEM Drawing Approval by Engg',
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
                                columnName: 'oemClearance',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 250,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Manufacturing clearance Given to OEM',
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
                                columnName: 'croPlacement',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 250,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Delivery time line after Placement of CRO',
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
                                columnName: 'croVendor',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 250,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('CRO release to Vendor',
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
                                columnName: 'croNumber',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 120,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('CRO Number ',
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
                                columnName: 'unit',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 120,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Unit',
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
                                columnName: 'qty',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: true,
                                width: 120,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Qty',
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
                                columnName: 'materialSite',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: false,
                                width: 250,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Receipt of Material at site',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)
                                      //    textAlign: TextAlign.center,
                                      ),
                                ),
                              ),
                            ]);
                      }
                    },
                  ),
                )),
              ]),
        floatingActionButton: AuthService().getcompany() == 'TATA POWER'
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: (() {
                  _materialprocurement.add(MaterialProcurementModel(
                      cityName: '',
                      details: '',
                      olaNo: '',
                      vendorName: '',
                      oemApproval: '',
                      oemClearance: '',
                      croPlacement: '',
                      croVendor: '',
                      croNumber: '',
                      unit: '',
                      qty: 1,
                      materialSite:
                          DateFormat().add_yMd().format(DateTime.now())));
                  _materialDatasource.buildDataGridRows();
                  _materialDatasource.updateDatagridSource();
                }),
              )
            : Container());
  }

  void storeData() {
    Map<String, dynamic> tableData = Map();
    for (var i in _materialDatasource.dataGridRows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button') {
          tableData[data.columnName] = data.value;
        }
      }

      tabledata2.add(tableData);
      tableData = {};
    }

    FirebaseFirestore.instance
        .collection('MaterialProcurement')
        .doc('${widget.depoName}')
        .collection('Material Data')
        .doc(userId)
        .set({
      'data': tabledata2,
    }).whenComplete(() {
      tabledata2.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Data are synced'),
        backgroundColor: blue,
      ));
    });
  }

  Future<void> getUserId() async {
    await AuthService().getCurrentUserId().then((value) {
      userId = value;
    });
  }

  void _showDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(
              color: blue,
            ),
          ),
        ),
      ),
    );
  }

  List<MaterialProcurementModel> getmonthlyReport() {
    return [
      MaterialProcurementModel(
          cityName: '',
          details: '',
          olaNo: '',
          vendorName: '',
          oemApproval: '',
          oemClearance: '',
          croPlacement: '',
          croVendor: '',
          croNumber: '',
          unit: '',
          qty: 1,
          materialSite: DateFormat().add_yMd().format(DateTime.now()))
    ];
  }

  Future getTableData() async {
    var res = await FirebaseFirestore.instance
        .collection('MaterialProcurement')
        .doc(widget.depoName)
        .collection("Material Data")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        for (int i = 0; i < element.data()["data"].length; i++) {
          print(element.data()['data'][i]);

          _materialprocurement.add(
              MaterialProcurementModel.fromjsaon(element.data()['data'][i]));
          print(_materialprocurement.length);
        }
      });
    });
    // .doc(widget.userid)
    // .snapshots();
    print(_materialprocurement.length);
    setState(() {});
  }
}
