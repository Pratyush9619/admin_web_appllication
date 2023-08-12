import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'quality_checklist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../Authentication/auth_service.dart';
import '../components/loading_page.dart';
import 'package:web_appllication/style.dart';
import 'dart:js' as js;

int? _selectedIndex = 0;

List<String> completeTabForCivil = [
  'Excavation',
  'BackFilling',
  'Brick / Block Massonary',
  'Doors, Windows, Hardware & Glazing',
  'False Ceiling',
  'Flooring & Tiling',
  'Grouting Inspection',
  'Ironite / Ips Flooring',
  'Painting',
  'Interlock Paving Work',
  'Wall Cladding & Roofing',
  'Water Proofing'
];

// String currentDate = DateFormat.yMMMMd().format(DateTime.now());
List<String> tabForCivil = [
  'Exc',
  'BackFilling',
  'Massonary',
  'Glazzing',
  'Ceilling',
  'Flooring',
  'Inspection',
  'Ironite',
  'Painting',
  'Paving',
  'Roofing',
  'Proofing'
];

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

class _CivilQualityChecklistState extends State<CivilQualityChecklist> {
  bool enablePdfLoading = false;
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
  CollectionReference? _collectionReference10;
  CollectionReference? _collectionReference11;

  bool _isloading = true;

  initializeStream() {
    _collectionReference = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference1 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference2 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference3 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference4 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference5 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference6 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference7 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference8 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference9 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference10 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');

    _collectionReference11 = FirebaseFirestore.instance
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId');
  }

  @override
  void initState() {
    super.initState();
    getUserId().whenComplete(() {
      initializeStream();
      _isloading = false;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return enablePdfLoading
        ? LoadingPage()
        : DefaultTabController(
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
              body: _isloading
                  ? LoadingPage()
                  : TabBarView(
                      children: [
                        civilUpperScreen(0),
                        civilUpperScreen(1),
                        civilUpperScreen(2),
                        civilUpperScreen(3),
                        civilUpperScreen(4),
                        civilUpperScreen(5),
                        civilUpperScreen(6),
                        civilUpperScreen(7),
                        civilUpperScreen(8),
                        civilUpperScreen(9),
                        civilUpperScreen(10),
                        civilUpperScreen(11),
                      ],
                    ),
            ),
          );
  }

  civilUpperScreen(int selectedIndex) {
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
                                                : selectedIndex == 9
                                                    ? fetchData(
                                                        _collectionReference9!,
                                                        selectedIndex)
                                                    : selectedIndex == 10
                                                        ? fetchData(
                                                            _collectionReference10!,
                                                            selectedIndex)
                                                        : fetchData(
                                                            _collectionReference11!,
                                                            selectedIndex),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingPage(),
                  ],
                ));
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data'),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data!;

                if (data.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Data Available for Selected Depo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  );
                }

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
                                      DataCell(
                                        ElevatedButton(
                                          onPressed: () async {
                                            await _generatePDF(
                                                rowData[0], rowData[2], 1);
                                          },
                                          child: const Text('View Report'),
                                        ),
                                      ),
                                      DataCell(ElevatedButton(
                                        onPressed: () async {
                                          await _generatePDF(
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
    QuerySnapshot querySnapshot = await currentColReference.get();

    List<dynamic> userIdList = querySnapshot.docs.map((e) => e.id).toList();

    for (int i = 0; i < userIdList.length; i++) {
      QuerySnapshot userEntryDate = await currentColReference
          .doc(userIdList[i])
          .collection('${tabForCivil[_selectedIndex!]} TABLE')
          .get();

      List<dynamic> withDateData = userEntryDate.docs.map((e) => e.id).toList();

      for (int j = 0; j < withDateData.length; j++) {
        rowList.add([userIdList[i], 'PDF', withDateData[j]]);
      }
    }
    userIdList.clear();
  }

  Future<void> _generatePDF(String user_id, String date, int decision) async {
    setState(() {
      enablePdfLoading = true;
    });

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
      (await rootBundle.load('assets/white_background2.jpeg'))
          .buffer
          .asUint8List(),
    );

    final pdfLogo = pw.MemoryImage(
      (await rootBundle.load('assets/pdf_logo.png')).buffer.asUint8List(),
    );

    //Getting safety Field Data from firestore

    DocumentSnapshot civilFieldDocSnapshot = await FirebaseFirestore.instance
        .collection('CivilChecklistField')
        .doc('${widget.depoName}')
        .collection('userId')
        .doc(user_id)
        .collection('${tabForCivil[_selectedIndex!]} TABLE')
        .doc(date)
        .get();

    Map<String, dynamic> civilMapData =
        civilFieldDocSnapshot.data() as Map<String, dynamic>;

    List<List<dynamic>> fieldData = [
      ['PROJECT :', '${civilMapData['Project']}'],
      ['P.O.No. :', '${civilMapData['PO No']}'],
      ['CONTRACTOR :', '${civilMapData['Contractor']}'],
      ['DESCRIPTION : ', '${civilMapData['Description']}'],
      ['SYSTEM / BLDG. :', '${civilMapData['System']}'],
      ['REF DOCUMENT1 :', '${civilMapData['Ref Document1']}'],
      ['REF DOCUMENT2 :', '${civilMapData['Ref Document2']}'],
      ['REF DOCUMENT3 :', '${civilMapData['Ref Document3']}'],
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
        .collection('CivilQualityChecklist')
        .doc('${widget.depoName}')
        .collection('userId')
        .doc(user_id)
        .collection('${tabForCivil[_selectedIndex!]} TABLE')
        .doc(date)
        .get();

    Map<String, dynamic> docData =
        documentSnapshot.data() as Map<String, dynamic>;
    if (docData.isNotEmpty) {
      userData.addAll(docData['data']);
      List<pw.Widget> imageUrls = [];

      for (Map<String, dynamic> mapData in userData) {
        String imagesPath =
            'QualityChecklist/civil_Engineer/${widget.cityName}/${widget.depoName}/$user_id/${tabForCivil[_selectedIndex!]} Table/$date/${mapData['srNo']}';

        ListResult result =
            await FirebaseStorage.instance.ref().child(imagesPath).listAll();

        if (result.items.isNotEmpty) {
          for (var image in result.items) {
            String downloadUrl = await image.getDownloadURL();
            if (image.name.endsWith('.pdf')) {
              imageUrls.add(
                pw.Container(
                    alignment: pw.Alignment.center,
                    padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: pw.UrlLink(
                        child: pw.Text(image.name,
                            style: const pw.TextStyle(color: PdfColors.blue)),
                        destination: downloadUrl)),
              );
            } else {
              final myImage = await networkImage(downloadUrl);
              imageUrls.add(
                pw.Container(
                    padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                    width: 60,
                    height: 100,
                    child: pw.Center(
                      child: pw.Image(myImage),
                    )),
              );
            }
          }
          if (imageUrls.length < 8) {
            int imageLoop = 8 - imageUrls.length;
            for (int i = 0; i < imageLoop; i++) {
              imageUrls.add(
                pw.Container(
                    padding: const pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                    width: 60,
                    height: 100,
                    child: pw.Text('')),
              );
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
                      style: const pw.TextStyle(fontSize: 14)))),
          pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Center(
                  child: pw.Text(mapData['checklist'],
                      style: const pw.TextStyle(fontSize: 14)))),
          pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Center(
                  child: pw.Text(mapData['responsibility'],
                      style: const pw.TextStyle(fontSize: 14)))),
          pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Center(
                  child: pw.Text(mapData['reference'].toString(),
                      style: const pw.TextStyle(fontSize: 14)))),
          pw.Container(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Center(
                  child: pw.Text(mapData['observation'].toString(),
                      style: const pw.TextStyle(fontSize: 14)))),
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
                      imageUrls[0],
                      imageUrls[1],
                    ])),
            imageUrls[2],
            imageUrls[3],
            imageUrls[4],
            imageUrls[5],
            imageUrls[6],
            imageUrls[7]
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
                      pw.Text(
                          'Civil Quality Report / ${completeTabForCivil[_selectedIndex!]} Table',
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
                    textScaleFactor: 1.6,
                  ),
                  pw.Text(
                    'Date:  $date ',
                    textScaleFactor: 1.6,
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
                      pw.Text(
                          'Civil Quality Report / ${completeTabForCivil[_selectedIndex!]} Table',
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
                    textScaleFactor: 1.6,
                  ),
                  pw.Text(
                    'Date:  $date ',
                    textScaleFactor: 1.6,
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
    final String pdfPath =
        'CivilQualityReport_${completeTabForCivil[_selectedIndex!]}($user_id/$date).pdf';

    // Save the PDF file to device storage
    if (kIsWeb) {
      if (decision == 1) {
        final blob = html.Blob([pdfData], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        html.window.open(url, '_blank');
        final encodedUrl = Uri.encodeFull(url);
        html.Url.revokeObjectUrl(encodedUrl);
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

    setState(() {
      enablePdfLoading = false;
    });
  }

  openPdf(var url) {
    js.JsObject(openPdf(url));
  }
}
