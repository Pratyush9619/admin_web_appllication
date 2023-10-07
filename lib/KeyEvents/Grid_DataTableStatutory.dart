import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../Authentication/login_register.dart';
import '../components/loading_page.dart';
import '../datasource/employee_statutory.dart';
import '../model/employee_statutory.dart';
import '../style.dart';
import '../widgets/custom_appbar.dart';

void main() {
  runApp(MyHomePage2());
}

/// The application that contains datagrid on it.

/// The home page of the application which hosts the datagrid.
class MyHomePage2 extends StatefulWidget {
  String? cityName;
  String? depoName;
  String? keyEvents;
  String? keyEvents2;

  /// Creates the home page.
  MyHomePage2(
      {Key? key, this.cityName, this.depoName, this.keyEvents, this.keyEvents2})
      : super(key: key);

  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  bool _isloading = true;
  List<EmployeeStatutory> employees = <EmployeeStatutory>[];
  late EmployeeDataStatutory employeeDataSource;
  late DataGridController _dataGridController;
  Stream? _stream;
  var alldata;
  List<dynamic> tabledata2 = [];

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('KeyEventsTable')
        .doc(widget.depoName!)
        .collection('AllKeyEventsTable')
        .doc('${widget.depoName}${widget.keyEvents}')
        .snapshots();
    _isloading = false;
    // getFirestoreData().whenComplete(() {
    //   setState(() {
    //     employeeDataSource = EmployeeDataStatutory(
    //         employeeData: employees, mainContext: context);
    //     _isloading = false;
    //   });
    // });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
              depoName: widget.depoName,
              cityName: widget.cityName,
              text: '${widget.depoName}/${widget.keyEvents2}',
              // icon: Icons.logout,
              haveSynced: true,
              store: () {
                StoreData();
              })
          // title: Text('${widget.depoName}/${widget.keyEvents2}'),
          // backgroundColor: blue,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 25, top: 15, bottom: 15),
          //     child: Container(
          //       height: 15,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10), color: Colors.blue),
          //       child: TextButton(
          //           onPressed: () {
          //             StoreData();
          //           },
          //           child: Text(
          //             'Sync Data',
          //             style: TextStyle(color: white, fontSize: 20),
          //           )),
          //     ),
          //   ),
          //   Padding(
          //       padding: const EdgeInsets.only(right: 150),
          //       child: IconButton(
          //         icon: Icon(
          //           Icons.logout,
          //           size: 25,
          //           color: white,
          //         ),
          //         onPressed: () {
          //           onWillPop(context);
          //         },
          //       ))
          // ],

          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         setState(() {
          //           _isloading = false;
          //         });
          //       },
          //       icon: Icon(Icons.refresh)),
          // ],
          // leading: InkWell(
          //     onTap: () {
          //       SystemChrome.setPreferredOrientations([
          //         DeviceOrientation.portraitUp,
          //       ]);
          //       Navigator.of(context).pop();
          //     },
          //     child: const Icon(Icons.arrow_back)),
          ),
      body: _isloading
          ? LoadingPage()
          : StreamBuilder(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                }
                if (!snapshot.hasData || snapshot.data.exists == false) {
                  return NodataAvailable();
                } else {
                  alldata = '';
                  alldata = snapshot.data['data'] as List<dynamic>;
                  employees.clear();
                  alldata.forEach((element) {
                    employees.add(EmployeeStatutory.fromJson(element));
                    // employeeDataSource = EmployeeDataStatutory(
                    //   employees,
                    //   context,
                    //   widget.cityName,
                    //   widget.depoName,
                    // );
                    employeeDataSource =
                        EmployeeDataStatutory(employees, context);
                    _dataGridController = DataGridController();
                  });

                  return SfDataGridTheme(
                    data: SfDataGridThemeData(headerColor: Colors.blue),
                    child: SfDataGrid(
                      source: employeeDataSource,
                      allowEditing: true,
                      frozenColumnsCount: 2,
                      editingGestureType: EditingGestureType.tap,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      selectionMode: SelectionMode.single,
                      navigationMode: GridNavigationMode.cell,
                      columnWidthMode: ColumnWidthMode.auto,
                      // controller: _dataGridController,
                      // onQueryRowHeight: (details) {
                      //   return details.rowIndex == 0 ? 60.0 : 49.0;
                      // },
                      columns: [
                        GridColumn(
                          columnName: 'srNo',
                          autoFitPadding: EdgeInsets.symmetric(horizontal: 16),
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
                                    color: white)
                                //    textAlign: TextAlign.center,
                                ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'Approval',
                          allowEditing: true,
                          label: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('Detail of approval',
                                overflow: TextOverflow.values.first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'button',
                          width: 130,
                          allowEditing: false,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Upload File',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'StartDate',
                          allowEditing: false,
                          width: 120,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text('Start Date',
                                overflow: TextOverflow.values.first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'EndDate',
                          allowEditing: false,
                          width: 120,
                          label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('End Date',
                                overflow: TextOverflow.values.first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'ActualStart',
                          allowEditing: false,
                          width: 180,
                          label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('Actual Start',
                                overflow: TextOverflow.values.first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'ActualEnd',
                          allowEditing: false,
                          width: 180,
                          label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('Actual End',
                                overflow: TextOverflow.values.first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        // GridColumn(
                        //   columnName: 'Weightage',
                        //   allowEditing: true,
                        //   label: Container(
                        //     padding: EdgeInsets.symmetric(horizontal: 8.0),
                        //     alignment: Alignment.center,
                        //     child: Text('Weightage',
                        //         overflow: TextOverflow.values.first,
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 16,
                        //             color: white)),
                        //   ),
                        // ),
                        GridColumn(
                          columnName: 'Applicability',
                          allowEditing: true,
                          width: 120,
                          label: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('Applicability',
                                overflow: TextOverflow.values.first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'ApprovingAuthority',
                          allowEditing: true,
                          label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('Approving Authority',
                                overflow: TextOverflow.values.first,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'CurrentStatusPerc',
                          allowEditing: true,
                          label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('Current status in % for Approval ',
                                overflow: TextOverflow.values.first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'OverallWeightage',
                          allowEditing: true,
                          label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('Overall Weightage',
                                overflow: TextOverflow.values.first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'CurrentStatus',
                          allowEditing: true,
                          label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('Current Status',
                                overflow: TextOverflow.values.first,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: white)),
                          ),
                        ),
                        GridColumn(
                          columnName: 'ListDocument',
                          allowEditing: true,
                          label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.center,
                            child: Text('List of Document Required',
                                overflow: TextOverflow.values.first,
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

      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.refresh),
      //     onPressed: () {
      //       _isloading = false;
      //     })
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  Future<void> getFirestoreData() async {
    FirebaseFirestore instance = FirebaseFirestore.instance;
    CollectionReference tabledata = instance.collection('KeyEventsTable');

    DocumentSnapshot snapshot = await tabledata
        .doc(widget.depoName!)
        .collection('AllKeyEventsTable')
        .doc('${widget.depoName}${widget.keyEvents}')
        .get();

    var data = snapshot.data() as Map;
    var alldata = data['data'] as List<dynamic>;

    alldata.forEach((element) {
      employees.add(EmployeeStatutory.fromJson(element));
    });
  }

  // List<Employee> getEmployeeData() {
  //   return [
  //     Employee(
  //         srNo: 1,
  //         activity: 'Initial Survey Of Depot With TML & STA Team.',
  //         originalDuration: 1,
  //         startDate: DateFormat().add_yMd().format(DateTime.now()),
  //         endDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualendDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualDuration: 0,
  //         delay: 0,
  //         unit: 0,
  //         scope: 0,
  //         qtyExecuted: 0,
  //         balanceQty: 0,
  //         percProgress: 0,
  //         weightage: 0.5),
  //     Employee(
  //         srNo: 2,
  //         activity: 'Details Survey Of Depot With TPC Civil & Electrical Team',
  //         originalDuration: 1,
  //         startDate: DateFormat().add_yMd().format(DateTime.now()),
  //         endDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualendDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualDuration: 0,
  //         delay: 0,
  //         unit: 0,
  //         scope: 0,
  //         qtyExecuted: 0,
  //         balanceQty: 0,
  //         percProgress: 0,
  //         weightage: 0.5),
  //     Employee(
  //         srNo: 3,
  //         activity:
  //             'Survey Report Submission With Existing & Proposed Layout Drawings.',
  //         originalDuration: 1,
  //         startDate: DateFormat().add_yMd().format(DateTime.now()),
  //         endDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualendDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualDuration: 0,
  //         delay: 0,
  //         unit: 0,
  //         scope: 0,
  //         qtyExecuted: 0,
  //         balanceQty: 0,
  //         percProgress: 0,
  //         weightage: 0.5),
  //     Employee(
  //         srNo: 4,
  //         activity: 'Job Scope Finalization & Preparation Of BOQ',
  //         originalDuration: 1,
  //         startDate: DateFormat().add_yMd().format(DateTime.now()),
  //         endDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualendDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualDuration: 0,
  //         delay: 0,
  //         unit: 0,
  //         scope: 0,
  //         qtyExecuted: 0,
  //         balanceQty: 0,
  //         percProgress: 0,
  //         weightage: 0.5),
  //     Employee(
  //         srNo: 5,
  //         activity: 'Power Connection / Load Applied By STA To Discom.',
  //         originalDuration: 1,
  //         startDate: DateFormat().add_yMd().format(DateTime.now()),
  //         endDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualstartDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualendDate: DateFormat().add_yMd().format(DateTime.now()),
  //         actualDuration: 0,
  //         delay: 0,
  //         unit: 0,
  //         scope: 0,
  //         qtyExecuted: 0,
  //         balanceQty: 0,
  //         percProgress: 0,
  //         weightage: 0.5)
  //   ];
  // }

  void StoreData() {
    Map<String, dynamic> table_data = Map();
    for (var i in employeeDataSource.rows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button') {
          table_data[data.columnName] = data.value;
        }
      }

      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection('KeyEventsTable')
        .doc(widget.depoName!)
        .collection('AllKeyEventsTable')
        .doc('${widget.depoName}${widget.keyEvents}')
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

  NodataAvailable() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 1000,
        width: 1000,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: blue)),
        child: Column(children: [
          Image.asset(
            'assets/Tata-Power.jpeg',
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/sustainable.jpeg',
                height: 100,
                width: 100,
              ),
              SizedBox(width: 50),
              Image.asset(
                'assets/Green.jpeg',
                height: 100,
                width: 100,
              )
            ],
          ),
          const SizedBox(height: 50),
          Center(
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: blue)),
              child: const Text(
                '     No data available yet \n Please wait for admin process',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
      ),
    ));
  }

  Future<bool> onWillPop(BuildContext context) async {
    bool a = false;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Close TATA POWER?",
                      style: subtitle1White,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              //color: blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //color: blue,
                            child: Center(
                                child: Text(
                              "No",
                              style: button.copyWith(color: blue),
                            )),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            a = true;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginRegister(),
                                ));
                            // exit(0);
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //color: blue,
                            child: Center(
                                child: Text(
                              "Yes",
                              style: button,
                            )),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ));
    return a;
  }
}
