import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../datasource/safetychecklist_datasource.dart';
import '../model/safety_checklistModel.dart';
import '../components/loading_page.dart';
import '../style.dart';
import '../widgets/custom_appbar.dart';

class SafetyChecklist extends StatefulWidget {
  String? userId;
  String? cityName;
  String? depoName;

  SafetyChecklist(
      {super.key,
      required this.userId,
      required this.cityName,
      required this.depoName});

  @override
  State<SafetyChecklist> createState() => _SafetyChecklistState();
}

List<SafetyChecklistModel> safetylisttable = <SafetyChecklistModel>[];
late SafetyChecklistDataSource _safetyChecklistDataSource;
late DataGridController _dataGridController;
List<dynamic> tabledata2 = [];
Stream? _stream;
var alldata;

class _SafetyChecklistState extends State<SafetyChecklist> {
  @override
  void initState() {
    safetylisttable = getData();
    _safetyChecklistDataSource = SafetyChecklistDataSource(safetylisttable);
    _dataGridController = DataGridController();

    _stream = FirebaseFirestore.instance
        .collection('SafetyChecklistTable')
        .doc(widget.depoName!)
        .collection(widget.userId!)
        .doc(DateFormat.yMMMMd().format(DateTime.now()))
        .snapshots();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: CustomAppBar(
            text: '${widget.cityName} / ${widget.depoName} / SafetyChecklist',
            userid: widget.userId,
            // icon: Icons.logout,
            haveSynced: true,
            store: () {
              store();
            }),
        preferredSize: Size.fromHeight(50),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                    source: _safetyChecklistDataSource,
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
                        autoFitPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        allowEditing: false,
                        width: 80,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        width: 450,
                        columnName: 'Details',
                        allowEditing: false,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text('Details of Enclosure ',
                              overflow: TextOverflow.values.first,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: white)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Status',
                        allowEditing: false,
                        width: 150,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                              'Status of Submission of information/ documents ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: white,
                              )),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Remark',
                        allowEditing: true,
                        width: 150,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text('Remarks',
                              overflow: TextOverflow.values.first,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: white)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Photo',
                        allowEditing: false,
                        width: 180,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text('Upload Photo',
                              overflow: TextOverflow.values.first,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: white)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'ViewPhoto',
                        allowEditing: false,
                        width: 180,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text('View Photo',
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
              } else {
                alldata = '';
                alldata = snapshot.data['data'] as List<dynamic>;
                safetylisttable.clear();
                alldata.forEach((element) {
                  safetylisttable.add(SafetyChecklistModel.fromJson(element));
                  _safetyChecklistDataSource =
                      SafetyChecklistDataSource(safetylisttable);
                  _dataGridController = DataGridController();
                });
                return SfDataGridTheme(
                  data: SfDataGridThemeData(headerColor: blue),
                  child: SfDataGrid(
                    source: _safetyChecklistDataSource,
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
                        autoFitPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        allowEditing: false,
                        width: 80,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        width: 450,
                        columnName: 'Details',
                        allowEditing: false,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text('Details of Enclosure ',
                              overflow: TextOverflow.values.first,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: white)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Status',
                        allowEditing: false,
                        width: 150,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                              'Status of Submission of information/ documents ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: white,
                              )),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Remark',
                        allowEditing: true,
                        width: 150,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text('Remarks',
                              overflow: TextOverflow.values.first,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: white)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'Photo',
                        allowEditing: false,
                        width: 180,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text('Upload Photo',
                              overflow: TextOverflow.values.first,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: white)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'ViewPhoto',
                        allowEditing: false,
                        width: 180,
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text('View Photo',
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
        ),
      ),
    );
  }

  void store() {
    Map<String, dynamic> table_data = Map();
    for (var i in _safetyChecklistDataSource.dataGridRows) {
      for (var data in i.getCells()) {
        if (data.columnName != 'button') {
          table_data[data.columnName] = data.value;
        }
      }

      tabledata2.add(table_data);
      table_data = {};
    }

    FirebaseFirestore.instance
        .collection('SafetyChecklistTable')
        .doc(widget.depoName!)
        .collection(widget.userId!)
        .doc(DateFormat.yMMMMd().format(DateTime.now()))
        .set(
      {'data': tabledata2},
      SetOptions(merge: true),
    ).whenComplete(() {
      tabledata2.clear();
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Data are synced'),
        backgroundColor: blue,
      ));
    });
  }

  List<SafetyChecklistModel> getData() {
    return [
      SafetyChecklistModel(
        srNo: 1,
        details:
            'Safe work procedure for each activity is available i.e. foundation works including civil works, erection, stringing (as applicable), testing & commissioning, disposal of materials at site / store etc.to be executed at site',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 2,
        details:
            'Manpower deployment plan activity wise is available  foundation works including civil works, erection, stringing (as applicable), testing & commissioning, disposal of materials at site / store etc. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 3,
        details:
            'List of Lifting Machines used for lifting purposes along with test certificates i.e. Crane, Hoist, Triffor, Chain Pulley Blocks etc. and Lifting Tools and Tackles i.e. D shackle, Pulleys, come along clamps, wire rope slings etc. and all types of ropes i.e. Wire ropes, Poly propylene Rope etc.. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4,
        details:
            'List of Personal Protective Equipment (PPE) with test certificate of each as applicable: ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.1,
        details:
            'Industrial Safety Helmet to all workmen at site. (EN 397 / IS 2925) with chin strap and back stay arrangement. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.2,
        details:
            'Safety Shoes and Rubber Gum Boot to workers working in rainy season / concreting job. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.3,
        details:
            'Twin lanyard Full Body Safety harness with shock absorber and leg strap arrangement for all workers working at height for more than three meters. Safety Harness should be with attachments of light weight such as of aluminium alloy etc. and having a feature of automatic locking arrangement of snap hook and comply with EN 361 / IS 3521 standards. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.4,
        details:
            'Mobile fall arrestors for safety of workers during their ascending / descending from tower / on tower. EN 353 -2 (Guide)',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.5,
        details:
            'Retractable type fall arrestor (EN360: 2002) for ascending / descending on suspension insulator string etc. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.6,
        details:
            'Providing of good quality cotton hand gloves / leather hand gloves for workers engaged in handling of tower parts or as per requirement at site. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.7,
        details:
            'Electrical Resistance hand gloves to workers for handling electrical equipment / Electrical connections. IS : 4770 ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.8,
        details: 'Dust masks to workers handling cement as per requirement. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.9,
        details: 'Face shield for welder and Grinders. IS : 1179 / IS : 2553 ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 4.10,
        details: 'Other PPEs, if any, as per requirement etc. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 5,
        details:
            'L3st of Earthing Equipment / Earthing devices with Earthing lead conforming to IECs for earthing equipment’s are – (855, 1230, 1235 etc.) gang wise for stringing activity/as per requirement ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 6,
        details:
            'List of Qualified Safety Officer(s) along with their contact details ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 7,
        details:
            'Details of Explosive Operator (if required), Safety officer / Safety supervisor for every erection / stinging gang, any other person nominated for safety, list of personnel trained in First Aid as well as brief information about safety set up by the Contractor along with copy of organisation of the Contractor in regard to safety ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 8,
        details:
            'Copy of Safety Policy/ Safety Document of the Contractor’s company ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 9,
        details:
            'Emergency Preparedness Plan’ for different incidences i.e. Fall from height, Electrocution, Sun Stroke, Collapse of pit, Collapse of Tower, Snake bite, Fire in camp / Store, Flood, Storm, Earthquake, Militancy etc. while carrying out different activities under execution i.e. Foundation works including civil works, erection, stringing (as applicable), testing & commissioning, disposal of materials at site / store etc. ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10,
        details: 'Safety Audit Check Lists (Formats to be enclosed) ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.1,
        details:
            'All emergency exits are clear of materials and are easily accessible. The  way to the fire extinguishers, first aid box, ladders and fire hoses is clear of material & is easily accessible',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.2,
        details:
            'First Aid Box is maintained - The list of contents of the first aid box is displayed on the box and contents are within expiry dates. Last verification and frequency of Inspection is displayed.',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.3,
        details:
            'Aisles, walkways, stairs are clear of material / equipment. Free  access to tools  /equipment machines etc.).',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.4,
        details:
            'No loose electrical wires on panels or   machines and equipment in the working areas',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.5,
        details: 'Earthing is provided where necessary',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.6,
        details:
            'The junction / connection boxes are properly closed  locked/ fastened with all screws',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.7,
        details: 'All electrical / control panels are properly closed.',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.8,
        details:
            'The parking spaces for vehicles and material handling equipment are identified and vehicles are in ready-to-go position',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.9,
        details:
            'Locations for materials/equipment like fire extinguishers, first-aid boxes,  stretcher, breathing apparatus , etc. are clearly marked and visible',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.10,
        details:
            'Calibration status of instruments is displayed and up to date',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.11,
        details:
            'All the machines/ equipment are maintained in proper working condition with adherence to the maintenance schedule',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.12,
        details:
            'Test certificates are available and status is identified on equipment, tools and tackles (like D shackle, slings, chain pulley blocks, hoists, cranes etc. )',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.13,
        details:
            'Engineering jobs are carried out with proper work permits and there is adherence to the LOTO system.',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.14,
        details: 'Safe operating instructions are available for the equipment',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.15,
        details:
            'The unsafe /restricted areas etc. are to be identified with warnings and clear demarcation There are ways and means to prevent un-authorised access to restricted areas.',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.16,
        details: 'Temporary Electrical Supply Board with ELCB Provision',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 10.17,
        details:
            'Vehicle safety: 1.Valid RC 2.Valid insurance 6.Valid pollution check 4.Valid DL of driver',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 11,
        details:
            'Details of Insur2nce Policies along with documentary evidence taken by the Contractor for the insurance coverage against accident for all employees as below: a.	Under Workmen Compensation Act 1923 or latest and Rules. b.	Public Insurance Liabilities Act 1991 or latest c.	Any Other Insurance Policies ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 12,
        details:
            'Copy of the modu3e of Safety Training Programs on Safety, Health and Environment, safe execution of different activities of works for Contractor’s own employees on regular basis and sub-contractor employees.',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
      SafetyChecklistModel(
        srNo: 13,
        details:
            'Information along with documentary evidences in regard to the Contractor’s compliance to various statutory requirements including the following: I.	Electricity Act 2003 II.	Factories Act 1948 or latest III.	Building & other construction workers (Regulation of Employment and Conditions of Services Act and Central Act 1996 or latest) and Welfare Cess Act 1996 or latest with Rules. IV.	Workmen Compensation Act 1923 or latest and Rules. V.	Public Insurance Liabilities Act 1991 or latest and Rules. VI.	Indian Explosive Act 1948 or latest and Rules. VII.	Indian Petroleum Act 1934 or latest and Rules VIII.	License under the contract Labour (Regulation & Abolition) Act 1970 or latest and Rules. IX.	Indian Electricity Rule 2003 and amendments if any, from time to time. X.	The Environment (Protection) Act 1986 or latest and Rules. XI.	Child Labour (Prohibition & Regulation) Act 1986 or latest. XII.	National Building Code of India 2005 or latest (NBC 2005). XIII.	Indian standards for construction of Low/ Medium/ High/ Extra High Voltage Equipment(AC/DC EV Charger) XIV.	Any other statutory requirement(s) ',
        status: 'Yes',
        remark: '',
        photo: ' ',
      ),
    ];
  }
}
