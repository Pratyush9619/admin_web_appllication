import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../Authentication/auth_service.dart';
import '../components/loading_page.dart';
import '../datasource/jmr_datasource.dart';
import '../model/jmr.dart';
import '../style.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/nodata_available.dart';

class JMRPage extends StatefulWidget {
  String? cityName;
  String? depoName;
  String? title;
  String? title1;
  // String? img;
  JMRPage(
      {super.key,
      this.title,
      // this.img,
      this.cityName,
      this.depoName,
      this.title1});

  @override
  State<JMRPage> createState() => _JMRPageState();
}

class _JMRPageState extends State<JMRPage> {
  List<JMRModel> jmrtable = <JMRModel>[];
  late JmrDataSource _jmrDataSource;
  late DataGridController _dataGridController;
  bool _isloading = true;
  List<dynamic> tabledata2 = [];
  Stream? _stream;
  var alldata;
  dynamic userId;

  @override
  void initState() {
    // getUserId().whenComplete(() {
    _stream = FirebaseFirestore.instance
        .collection('JMRCollection')
        .doc(widget.depoName)
        .collection('${widget.depoName}${widget.title1}')
        .doc(userId)
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
            text:
                '${widget.cityName} / ${widget.depoName} / ${widget.title.toString()}',
            // icon: Icons.logout,
            haveSynced: true,
            store: () {
              StoreData();
            }),
        preferredSize: const Size.fromHeight(50),
      ),
      body: _isloading
          ? LoadingPage()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          HeaderValue('Project', 'TML e-bus Project'),
                          HeaderValue('LOI Ref Number', 'TML-LOI-Dated'),
                          HeaderValue('Site Location', ''),
                          // HeaderValue('Working Period')
                          Container(
                            width: 600,
                            padding: EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 110,
                                    child: const Text('Working Dates')),
                                Expanded(
                                    child: TextFormField(
                                  scrollPadding: const EdgeInsets.all(0),
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 0, bottom: 0)),
                                )),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: TextFormField(
                                  scrollPadding: const EdgeInsets.all(0),
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 0, bottom: 0)),
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HeaderValue('Ref No', 'Abstract of Cost/1'),
                          HeaderValue('Date', ''),
                          HeaderValue('Note', ''),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingPage();
                      }
                      if (!snapshot.hasData || snapshot.data.exists == false) {
                        jmrtable = getData();
                        _jmrDataSource = JmrDataSource(jmrtable);
                        _dataGridController = DataGridController();
                        return SfDataGridTheme(
                          data: SfDataGridThemeData(headerColor: blue),
                          child: SfDataGrid(
                            source: _jmrDataSource,
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

                            // onQueryRowHeight: (details) {
                            //   return details.rowIndex == 0 ? 60.0 : 49.0;
                            // },
                            columns: [
                              GridColumn(
                                columnName: 'srNo',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                width: 200,
                                columnName: 'Description',
                                allowEditing: true,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Description of items',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'Activity',
                                allowEditing: true,
                                label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Activity Details',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: white,
                                      )),
                                ),
                              ),
                              GridColumn(
                                columnName: 'RefNo',
                                allowEditing: true,
                                label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('BOQ RefNo',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'Abstract',
                                allowEditing: true,
                                width: 180,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Abstract of JMR',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'UOM',
                                allowEditing: true,
                                width: 80,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('UOM',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'Rate',
                                allowEditing: true,
                                width: 80,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Rate',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'TotalQty',
                                allowEditing: true,
                                width: 120,
                                label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Total Qty',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'TotalAmount',
                                allowEditing: true,
                                label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Amount',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'Delete',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: false,
                                width: 120,
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
                      } else if (snapshot.hasData) {
                        alldata = '';
                        alldata = snapshot.data['data'] as List<dynamic>;
                        jmrtable.clear();
                        alldata.forEach((element) {
                          jmrtable.add(JMRModel.fromjson(element));
                          _jmrDataSource = JmrDataSource(jmrtable);
                          _dataGridController = DataGridController();
                        });
                        return SfDataGridTheme(
                          data: SfDataGridThemeData(headerColor: blue),
                          child: SfDataGrid(
                            source: _jmrDataSource,
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

                            // onQueryRowHeight: (details) {
                            //   return details.rowIndex == 0 ? 60.0 : 49.0;
                            // },
                            columns: [
                              GridColumn(
                                columnName: 'srNo',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                width: 200,
                                columnName: 'Description',
                                allowEditing: true,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Description of items',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'Activity',
                                allowEditing: true,
                                label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text('Activity Details',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: white,
                                      )),
                                ),
                              ),
                              GridColumn(
                                columnName: 'RefNo',
                                allowEditing: true,
                                label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('BOQ RefNo',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'Abstract',
                                allowEditing: true,
                                width: 180,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Abstract of JMR',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'UOM',
                                allowEditing: true,
                                width: 80,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('UOM',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'Rate',
                                allowEditing: true,
                                width: 80,
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Rate',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'TotalQty',
                                allowEditing: true,
                                width: 120,
                                label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Total Qty',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'TotalAmount',
                                allowEditing: true,
                                label: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  alignment: Alignment.center,
                                  child: Text('Amount',
                                      overflow: TextOverflow.values.first,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white)),
                                ),
                              ),
                              GridColumn(
                                columnName: 'Delete',
                                autoFitPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                allowEditing: false,
                                width: 120,
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
                            //         columnNames: ['srNo'],
                            //         child: Container(
                            //           child: Center(
                            //             child: Text(
                            //               'Project',
                            //               style: TextStyle(
                            //                   color: white,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ),
                            //         )),
                            //     StackedHeaderCell(
                            //       columnNames: ['Description', 'Activity'],
                            //       child: Center(
                            //         child: Text(
                            //           'TML e-bus Project',
                            //           style: TextStyle(
                            //               color: white,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //     ),
                            //     StackedHeaderCell(
                            //       columnNames: ['RefNo'],
                            //       child: Center(
                            //         child: Text(
                            //           'Ref No',
                            //           style: TextStyle(
                            //               color: white,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //     ),
                            //     StackedHeaderCell(
                            //       columnNames: [
                            //         'RefNo',
                            //         'Abstract',
                            //         'UOM',
                            //         'Rate',
                            //         'TotalQty',
                            //         'TotalAmount'
                            //       ],
                            //       child: Center(
                            //         child: Text(
                            //           'TML e-bus Project',
                            //           style: TextStyle(
                            //               color: white,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //     )
                            //   ]),
                            // ],

                            // // stackedHeaderRows: [
                            //   StackedHeaderRow(cells: [
                            //     StackedHeaderCell(
                            //         columnNames: ['srNo'],
                            //         child: Container(child: Text('Project'))),
                            //     // StackedHeaderCell(columnNames: [
                            //     //   'srNo'
                            //     // ], child: Container(child: Text('LOI Ref Number'))),
                            //     StackedHeaderCell(
                            //         columnNames: ['Description', 'Activity'],
                            //         child: Container(
                            //             child: Center(
                            //                 child: Text('TML E-BUS PROJECT')))),
                            //     StackedHeaderCell(columnNames: [
                            //       'srNo'
                            //     ], child: Container(child: Text('Working Period'))),
                            //   ])
                            // ],
                          ),
                        );
                      } else {
                        return NodataAvailable();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80, right: 20),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        heroTag: "btn1",
                        onPressed: () {
                          jmrtable.add(
                            JMRModel(
                                srNo: 1,
                                description: 'Supply and Laying',
                                activity:
                                    'onboarding one no. of EV charger of 200kw',
                                refNo: '8.31 (Additional)',
                                jmrAbstract:
                                    'abstract of JMR sheet No 1 & Item Sr No 1',
                                uom: 'Mtr',
                                rate: 500.00,
                                totalQty: 110,
                                totalAmount: 55000.00),
                          );
                          _jmrDataSource.buildDataGridRows();
                          _jmrDataSource.updateDatagridSource();
                        },
                        child: Icon(Icons.add),
                      )),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "btn2",
        isExtended: true,
        onPressed: () {},
        label: Text('Upload Excel For Data'),
      ),

      //   Center(
      // child: Image.asset(widget.img.toString()),
    );
  }

  // Future<void> getUserId() async {
  //   await AuthService().getCurrentUserId().then((value) {
  //     userId = value;
  //   });
  // }

  void StoreData() {
    Map<String, dynamic> table_data = Map();
    for (var i in _jmrDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        // if (data.columnName != 'button') {
        table_data[data.columnName] = data.value;
        // }
      }

      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection('JMRCollection')
        .doc(widget.depoName)
        .collection('${widget.depoName}${widget.title1}')
        .doc(userId)
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
}

List<JMRModel> getData() {
  return [
    JMRModel(
        srNo: 1,
        description: 'Supply and Laying',
        activity: 'onboarding one no. of EV charger of 200kw',
        refNo: '8.31 (Additional)',
        jmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
        uom: 'Mtr',
        rate: 500.00,
        totalQty: 110,
        totalAmount: 55000.00),
    // JMRModel(
    //     srNo: 2,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 3,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 4,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 5,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 6,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 7,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 8,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 9,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 10,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 11,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 12,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 13,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 14,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 15,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 16,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
    // JMRModel(
    //     srNo: 17,
    //     Description: 'Supply and Laying',
    //     Activity: 'onboarding one no. of EV charger of 200kw',
    //     RefNo: '8.31 (Additional)',
    //     JmrAbstract: 'bstract of JMR sheet No 1 & Item Sr No 1',
    //     Uom: 'Mtr',
    //     rate: 500.00,
    //     TotalQty: 110,
    //     TotalAmount: 55000.00),
  ];
}

HeaderValue(String title, String hintValue) {
  return Container(
    width: 600,
    padding: EdgeInsets.all(3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            width: 100,
            child: Text(
              title,
            )),
        SizedBox(width: 10),
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 0, bottom: 0)),
          initialValue: hintValue,
          style: TextStyle(fontSize: 12),
        )),
      ],
    ),
  );
}
