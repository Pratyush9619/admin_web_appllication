import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:web_appllication/widgets/nodata_available.dart';
import 'quality_checklist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../Authentication/auth_service.dart';
import '../components/loading_page.dart';
import 'package:web_appllication/style.dart';

int? _selectedIndex = 0;
// String currentDate = DateFormat.yMMMMd().format(DateTime.now());

class ElectricalQualityChecklist extends StatefulWidget {
  String? cityName;
  String? depoName;
  String? currentDate;
  bool? isHeader;

  ElectricalQualityChecklist(
      {super.key,
      required this.cityName,
      required this.depoName,
      this.currentDate,
      this.isHeader = true});

  @override
  State<ElectricalQualityChecklist> createState() =>
      _ElectricalQualityChecklistState();
}

class _ElectricalQualityChecklistState
    extends State<ElectricalQualityChecklist> {
  List tabForElec = [
    'PSS',
    'RMU',
    'CT',
    'CMU',
    'ACDB',
    'CI',
    'CDI',
    'MSP',
    'CHARGER',
    'EARTH PIT'
  ];

//Quality Project Row List for view summary
  List<List<dynamic>> rowList = [];

  CollectionReference? _collectionReference;
  CollectionReference? _collectionReference1;
  CollectionReference? _collectionReference2;
  CollectionReference? _collectionReference3;
  CollectionReference? _collectionReference4;
  CollectionReference? _collectionReference5;
  CollectionReference? _collectionReference6;
  CollectionReference? _collectionReference7;
  CollectionReference? _collectionReference8;
  CollectionReference? _collectionReference9;

  bool _isloading = true;

  initializeStream() {
    _collectionReference = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference1 = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference2 = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference3 = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference4 = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference5 = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference6 = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference7 = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference8 = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference9 = FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');
  }

  @override
  void initState() {
    storeImages();
    super.initState();
    getUserId().whenComplete(() {
      initializeStream();
      _isloading = false;
      setState(() {});
    });
  }

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
          body: _isloading
              ? LoadingPage()
              : TabBarView(children: [
                  civilupperScreen(0),
                  civilupperScreen(1),
                  civilupperScreen(2),
                  civilupperScreen(3),
                  civilupperScreen(4),
                  civilupperScreen(5),
                  civilupperScreen(6),
                  civilupperScreen(7),
                  civilupperScreen(8),
                  civilupperScreen(9)
                ]),
        ));
  }

  civilupperScreen(int selectedIndex) {
    rowList.clear();
    return _isloading
        ? LoadingPage()
        : FutureBuilder<List<List<dynamic>>>(
            future: selectedIndex == 0
                ? fetchData(_collectionReference!, selectedIndex)
                : selectedIndex == 1
                    ? fetchData(_collectionReference1!, selectedIndex)
                    : selectedIndex == 2
                        ? fetchData(_collectionReference2!, selectedIndex)
                        : selectedIndex == 3
                            ? fetchData(_collectionReference3!, selectedIndex)
                            : selectedIndex == 4
                                ? fetchData(
                                    _collectionReference4!, selectedIndex)
                                : selectedIndex == 5
                                    ? fetchData(
                                        _collectionReference5!, selectedIndex)
                                    : selectedIndex == 6
                                        ? fetchData(_collectionReference6!,
                                            selectedIndex)
                                        : selectedIndex == 7
                                            ? fetchData(_collectionReference7!,
                                                selectedIndex)
                                            : selectedIndex == 8
                                                ? fetchData(
                                                    _collectionReference8!,
                                                    selectedIndex)
                                                : fetchData(
                                                    _collectionReference9!,
                                                    selectedIndex),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingPage()
                    // CircularProgressIndicator(),
                    // Text(
                    //   'Collecting Data...',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //   ),
                    // ),
                  ],
                ));
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data'),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data!;

                // if (data.isEmpty) {
                //   return NodataAvailable();
                //   //  const Center(
                //   //   child: Text(
                //   //     'No Data Available for Selected Depo',
                //   //     style: TextStyle(
                //   //       fontWeight: FontWeight.bold,
                //   //       fontSize: 20,
                //   //     ),
                //   //   ),
                //   // );
                // }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.00, bottom: 5.00),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DataTable(
                              showBottomBorder: true,
                              sortAscending: true,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[600]!,
                                  width: 1.0,
                                ),
                              ),
                              columnSpacing: 150.0,
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue[800]!),
                              headingTextStyle:
                                  const TextStyle(color: Colors.white),
                              columns: const [
                                DataColumn(
                                    label: Text(
                                  'User_ID',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                )),
                                DataColumn(
                                    label: Text('Date',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ))),
                                DataColumn(
                                    label: Text('Quality Report Data',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ))),
                                DataColumn(
                                    label: Text('PDF Download',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ))),
                              ],
                              rows: data.map(
                                (rowData) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(rowData[0])),
                                      DataCell(Text(rowData[2])),
                                      DataCell(ElevatedButton(
                                        onPressed: () {
                                          _generatePDF(
                                              rowData[0], rowData[2], 1);
                                        },
                                        child: const Text('View Report'),
                                      )),
                                      DataCell(ElevatedButton(
                                        onPressed: () {
                                          _generatePDF(
                                              rowData[0], rowData[2], 2);
                                        },
                                        child: const Text('Download'),
                                      )),
                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          )),
                    ],
                  ),
                );
              }
              return Container();
            },
          );
  }

  Future<void> storeImages() async {
    final sourcePath = 'SafetyChecklist/Bengaluru/BMTC KR Puram-29/JT4610/1';

    final path =
        'QualityChecklist/Electrical_Engineer/${widget.cityName}/${widget.depoName}/ZW3210'
        '/${tabForElec[_selectedIndex!]} TABLE/April 11, 2023';

    Reference pathRef = FirebaseStorage.instance.ref().child(path);
    Reference sourceRef = FirebaseStorage.instance.ref().child(sourcePath);
    ListResult result = await sourceRef.listAll();
    final downloadUrl = await result.items.first.getDownloadURL();
    await pathRef.putString(downloadUrl);
  }

  Future<void> getUserId() async {
    await AuthService().getCurrentUserId().then((value) {
      userId = value;
    });
  }

  Future<List<List<dynamic>>> fetchData(
      CollectionReference colRef, int selectedIndex) async {
    if (selectedIndex == _selectedIndex) {
      if (_selectedIndex == 0) {
        setState(() {});
      }
      await getRowsForFutureBuilder(colRef);
    }
    return rowList;
  }

  Future<void> getRowsForFutureBuilder(
      CollectionReference currentColReference) async {
    rowList.clear();

    QuerySnapshot querySnapshot = await currentColReference.get();

    List<dynamic> userIdList = querySnapshot.docs.map((e) => e.id).toList();

    for (int i = 0; i < userIdList.length; i++) {
      QuerySnapshot userEntryDate = await currentColReference
          .doc(userIdList[i])
          .collection('${tabForElec[_selectedIndex!]} TABLE')
          .get();

      List<dynamic> withDateData = userEntryDate.docs.map((e) => e.id).toList();

      for (int j = 0; j < withDateData.length; j++) {
        rowList.add([userIdList[i], 'PDF', withDateData[j]]);
      }
    }
    userIdList.clear();
  }

  Future<void> _generatePDF(String user_id, String date, int decision) async {
    final headerStyle =
        pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold);

    final fontData1 = await rootBundle.load('fonts/IBMPlexSans-Medium.ttf');
    final fontData2 = await rootBundle.load('fonts/IBMPlexSans-Bold.ttf');

    const cellStyle = pw.TextStyle(
      color: PdfColors.black,
      fontSize: 14,
    );

    final profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/Tata-Power.jpeg')).buffer.asUint8List(),
    );

    final white_background = pw.MemoryImage(
      (await rootBundle.load('assets/white_background2.png'))
          .buffer
          .asUint8List(),
    );

    final pdfLogo = pw.MemoryImage(
      (await rootBundle.load('assets/pdf_logo.png')).buffer.asUint8List(),
    );

    //Getting safety Field Data from firestore

    DocumentSnapshot elecFieldDocSanpshot = await FirebaseFirestore.instance
        .collection('ElectricalChecklistField')
        .doc('${widget.depoName}')
        .collection('userId')
        .doc(user_id)
        .collection('${tabForElec[_selectedIndex!]} TABLE')
        .doc(date)
        .get();

    Map<String, dynamic> electricalMapData =
        elecFieldDocSanpshot.data() as Map<String, dynamic>;

    List<List<dynamic>> fieldData = [
      ['EMPLOYEE NAME :', '${electricalMapData['EmployeeName']}'],
      ['DIST EV :', '${electricalMapData['Dist EV']}'],
      ['VENDOR NAME :', '${electricalMapData['VendorName']}'],
      ['DATE : ', '${electricalMapData['Date']}'],
      ['OLA NUMBER :', '${electricalMapData['OlaNo']}'],
      ['PANEL SR NO :', '${electricalMapData['PanelNo']}'],
      ['DEPOT NAME :', '${electricalMapData['DepotName']}'],
      ['CUSTOMER NAME :', '${electricalMapData['CustomerName']}'],
    ];

    List<pw.TableRow> rows = [];

    rows.add(pw.TableRow(children: [
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Sr No',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding:
              const pw.EdgeInsets.only(top: 4, bottom: 4, left: 2, right: 2),
          child: pw.Center(
              child: pw.Text('Activity',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Responsibility',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Reference',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Observation',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Image6',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Image7',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
      pw.Container(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Center(
              child: pw.Text('Image8',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
    ]));

    List<dynamic> userData = [];

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('ElectricalQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId')
        .doc(user_id)
        .collection('${tabForElec[_selectedIndex!]} TABLE')
        .doc(date)
        .get();

    Map<String, dynamic> docData =
        documentSnapshot.data() as Map<String, dynamic>;
    if (docData.isNotEmpty) {
      userData.addAll(docData['data']);
      print('userdata - $userData');
      List<dynamic> imageUrls = [];

      for (Map<String, dynamic> mapData in userData) {
        String images_Path =
            'gs://tp-zap-solz.appspot.com/QualityChecklist/Electrical_Engineer/'
            '${widget.cityName}/${widget.depoName}/$user_id/${tabForElec[_selectedIndex!]} TABLE/$date/${mapData['srNo']}';

        ListResult result =
            await FirebaseStorage.instance.ref().child(images_Path).listAll();

        if (result.items.isNotEmpty) {
          for (var image in result.items) {
            if (image.name.endsWith('.pdf')) {
              imageUrls.add(pdfLogo);
            } else {
              String downloadUrl = await image.getDownloadURL();
              final myImage = await networkImage(downloadUrl);
              imageUrls.add(myImage);
            }
          }
          if (imageUrls.length < 8) {
            int imageLoop = 8 - imageUrls.length;
            for (int i = 0; i < imageLoop; i++) {
              imageUrls.add(white_background);
            }
          }
        }
        result.items.clear();

        //Text Rows of PDF Table
        rows.add(pw.TableRow(children: [
          pw.Container(
              padding: const pw.EdgeInsets.all(3.0),
              child: pw.Center(
                  child: pw.Text(mapData['srNo'].toString(),
                      style: const pw.TextStyle(fontSize: 13)))),
          pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Center(
                  child: pw.Text(mapData['checklist'],
                      style: const pw.TextStyle(fontSize: 11)))),
          pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Center(
                  child: pw.Text(mapData['responsibility'],
                      style: const pw.TextStyle(fontSize: 11)))),
          pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Center(
                  child: pw.Text(mapData['reference'].toString(),
                      style: const pw.TextStyle(fontSize: 11)))),
          pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Center(
                  child: pw.Text(mapData['observation'].toString(),
                      style: const pw.TextStyle(fontSize: 11)))),
        ]));

        if (imageUrls.isNotEmpty) {
          //Image Rows of PDF Table
          rows.add(pw.TableRow(children: [
            pw.Container(
                padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: pw.Text('')),
            pw.Container(
                padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                width: 60,
                height: 100,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Image(imageUrls[0]),
                      pw.Image(imageUrls[1]),
                    ])),
            pw.Container(
                padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                width: 60,
                height: 100,
                child: pw.Center(
                  child: pw.Image(imageUrls[2]),
                )),
            pw.Container(
                padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                width: 60,
                height: 100,
                child: pw.Center(
                  child: pw.Image(imageUrls[3]),
                )),
            pw.Container(
                padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                width: 60,
                height: 100,
                child: pw.Center(
                  child: pw.Image(imageUrls[4]),
                )),
            pw.Container(
                padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                width: 60,
                height: 100,
                child: pw.Center(
                  child: pw.Image(imageUrls[5]),
                )),
            pw.Container(
                padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                width: 60,
                height: 100,
                child: pw.Center(
                  child: pw.Image(imageUrls[6]),
                )),
            pw.Container(
                padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                width: 60,
                height: 100,
                child: pw.Center(
                  child: pw.Image(imageUrls[7]),
                ))
          ]));
        }
        imageUrls.clear();
      }
    }

    final pdf = pw.Document(
      pageMode: PdfPageMode.outlines,
    );

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(fontData1), bold: pw.Font.ttf(fontData2)),
        pageFormat: const PdfPageFormat(1300, 900,
            marginLeft: 70, marginRight: 70, marginBottom: 80, marginTop: 40),
        orientation: pw.PageOrientation.natural,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                      bottom:
                          pw.BorderSide(width: 0.5, color: PdfColors.grey))),
              child: pw.Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Electrical Quality Report',
                          textScaleFactor: 2,
                          style: const pw.TextStyle(color: PdfColors.blue700)),
                      pw.Container(
                        width: 120,
                        height: 120,
                        child: pw.Image(profileImage),
                      ),
                    ]),
              ]));
        },
        footer: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text('User ID - $user_id',
                  // 'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.black)));
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Place:  ${widget.cityName}/${widget.depoName}',
                    textScaleFactor: 1.1,
                  ),
                  pw.Text(
                    'Date:  $date ',
                    textScaleFactor: 1.1,
                  )
                ]),
            pw.SizedBox(height: 20)
          ]),
          pw.SizedBox(height: 10),
          pw.Table.fromTextArray(
            columnWidths: {
              0: const pw.FixedColumnWidth(100),
              1: const pw.FixedColumnWidth(100),
            },
            headers: ['Details', 'Values'],
            headerStyle: headerStyle,
            headerPadding: const pw.EdgeInsets.all(10.0),
            data: fieldData,
            cellHeight: 35,
            cellStyle: cellStyle,
          )
        ],
      ),
    );

    //First Half Page

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(fontData1), bold: pw.Font.ttf(fontData2)),
        pageFormat: const PdfPageFormat(1300, 900,
            marginLeft: 70, marginRight: 70, marginBottom: 80, marginTop: 40),
        orientation: pw.PageOrientation.natural,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                      bottom:
                          pw.BorderSide(width: 0.5, color: PdfColors.grey))),
              child: pw.Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Electrical Quality Report',
                          textScaleFactor: 2,
                          style: const pw.TextStyle(color: PdfColors.blue700)),
                      pw.Container(
                        width: 120,
                        height: 120,
                        child: pw.Image(profileImage),
                      ),
                    ]),
              ]));
        },
        footer: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text('User ID - $user_id',
                  // 'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.black)));
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Place:  ${widget.cityName}/${widget.depoName}',
                    textScaleFactor: 1.1,
                  ),
                  pw.Text(
                    'Date:  $date ',
                    textScaleFactor: 1.1,
                  )
                ]),
            pw.SizedBox(height: 20)
          ]),
          pw.SizedBox(height: 10),
          pw.Table(
              columnWidths: {
                0: const pw.FixedColumnWidth(30),
                1: const pw.FixedColumnWidth(160),
                2: const pw.FixedColumnWidth(70),
                3: const pw.FixedColumnWidth(70),
                4: const pw.FixedColumnWidth(70),
                5: const pw.FixedColumnWidth(70),
                6: const pw.FixedColumnWidth(70),
                7: const pw.FixedColumnWidth(70),
              },
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              tableWidth: pw.TableWidth.max,
              border: pw.TableBorder.all(),
              children: rows)
        ],
      ),
    );

    final List<int> pdfData = await pdf.save();
    final String pdfPath = 'ElectricalQualityReport($user_id/$date).pdf';

    // Save the PDF file to device storage
    if (kIsWeb) {
      if (decision == 1) {
        final blob = html.Blob([pdfData], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        html.window.open(url, '_blank');
        final encodedUrl = Uri.encodeFull(url);
        html.Url.revokeObjectUrl(encodedUrl);
        Future.delayed(const Duration(seconds: 1), () {
          html.Url.revokeObjectUrl(url);
        }).catchError((error) {
          print('Error revoking object URL: $error');
        });
      } else if (decision == 2) {
        html.AnchorElement(
            href:
                "data:application/octet-stream;base64,${base64Encode(pdfData)}")
          ..setAttribute("download", pdfPath)
          ..click();
      }
    } else {
      const Text('Sorry it is not ready for mobile platform');
    }
    // // For mobile platforms
    // final String dir = (await getApplicationDocumentsDirectory()).path;
    // final String path = '$dir/$pdfPath';
    // final File file = File(path);
    // await file.writeAsBytes(pdfData);
    //
    // // Open the PDF file for preview or download
    // OpenFile.open(file.path);
  }
}
