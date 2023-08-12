import 'dart:convert';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:web_appllication/components/Loading_page.dart';
import '../widgets/custom_appbar.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/widgets.dart' as widgets;

class MonthlySummary extends StatefulWidget {
  final String? userId;
  final String? cityName;
  final String? depoName;
  final String? id;
  const MonthlySummary(
      {super.key, this.userId, this.cityName, required this.depoName, this.id});
  @override
  State<MonthlySummary> createState() => _MonthlySummaryState();
}

class _MonthlySummaryState extends State<MonthlySummary> {
  bool enableLoading = false;
  List<dynamic> temp = [];

  //Daily Project Row List for view summary
  List<List<dynamic>> rowList = [];

  // Daily project available user ID List
  List<dynamic> presentUser = [];

  //All user id list
  List<dynamic> userList = [];

  // Daily Project data entry date list
  List<dynamic> userEntryDate = [];

  // Daily Project data according to entry date
  List<dynamic> dailyProjectData = [];

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  Future<List<List<dynamic>>> fetchData() async {
    await getMonthlyData();
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: CustomAppBar(
          text: ' ${widget.cityName}/ ${widget.depoName} / Monthly Report',
          userid: widget.userId,
        ),
        preferredSize: const Size.fromHeight(50),
      ),
      body: enableLoading
          ? LoadingPage()
          : FutureBuilder<List<List<dynamic>>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                  // Center(
                  //     child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: const [
                  //     CircularProgressIndicator(),
                  //     Text(
                  //       'Collecting Data...',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //   ],
                  // ));
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

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            left: 3.0, right: 3.0, bottom: 5.0),
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
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Monthly Report Data',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'PDF Download',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                            rows: data.map(
                              (rowData) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(rowData[0]),
                                    ),
                                    DataCell(Text(rowData[2])),
                                    DataCell(ElevatedButton(
                                      onPressed: () {
                                        _generatePDF(rowData[0], rowData[2], 1);
                                      },
                                      child: const Text('View Report'),
                                    )),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {
                                          _generatePDF(
                                              rowData[0], rowData[2], 2);
                                        },
                                        child: const Text('Download'),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Container();
              },
            ),
    );
  }

  Future<void> getMonthlyData() async {
    rowList.clear();
    QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
        .collection('MonthlyProjectReport2')
        .doc('${widget.depoName}')
        .collection('userId')
        .get();
    List<dynamic> userIdList = querySnapshot1.docs.map((e) => e.id).toList();
    for (int i = 0; i < userIdList.length; i++) {
      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('MonthlyProjectReport2')
          .doc('${widget.depoName}')
          .collection('userId')
          .doc('${userIdList[i]}')
          .collection('Monthly Data')
          .get();

      List<dynamic> monthlyDate = querySnapshot2.docs.map((e) => e.id).toList();
      for (int j = 0; j < monthlyDate.length; j++) {
        rowList.add([userIdList[i], 'PDF', monthlyDate[j]]);
      }
    }
  }

  Future<void> _generatePDF(String userId, String date, int decision) async {
    setState(() {
      enableLoading = true;
    });

    final profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/Tata-Power.jpeg')).buffer.asUint8List(),
    );

    final headerStyle =
        pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold);

    const cellStyle = pw.TextStyle(
      fontSize: 13,
    );

    List<List<dynamic>> allData = [];
    List<dynamic> userData = [];
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('MonthlyProjectReport2')
        .doc('${widget.depoName}')
        .collection('userId')
        .doc(userId)
        .collection('Monthly Data')
        .doc(date)
        .get();

    Map<String, dynamic> docData =
        documentSnapshot.data() as Map<String, dynamic>;
    if (docData.isNotEmpty) {
      userData.addAll(docData['data']);
      for (Map<String, dynamic> mapData in userData) {
        allData.add([
          mapData['ActivityDetails'].toString().trim() == 'null' ||
                  mapData['ActivityDetails'].toString().trim() == 'Null'
              ? ''
              : mapData['ActivityDetails'],
          mapData['Progress'].toString().trim() == 'null' ||
                  mapData['Progress'].toString().trim() == 'Null'
              ? ''
              : mapData['Progress'],
          mapData['Status'].toString().trim() == 'null' ||
                  mapData['Status'].toString().trim() == 'Null'
              ? ''
              : mapData['Status'],
          mapData['Action'].toString().trim() == 'null' ||
                  mapData['Action'].toString().trim() == 'Null'
              ? ''
              : mapData['Action'],
        ]);
      }
    }

    final pdf = pw.Document(pageMode: PdfPageMode.outlines);
    final fontData2 = await rootBundle.load('fonts/IBMPlexSans-Medium.ttf');

    pdf.addPage(pw.MultiPage(
        theme: pw.ThemeData.withFont(
          bold: pw.Font.ttf(fontData2),
        ),
        pageFormat: const PdfPageFormat(1300, 900,
            marginLeft: 70, marginRight: 70, marginBottom: 80, marginTop: 40),
        orientation: pw.PageOrientation.natural,
        crossAxisAlignment: pw.CrossAxisAlignment.start,

        //Header part of PDF
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
                      pw.Text('Monthly Report',
                          textScaleFactor: 2,
                          style: const pw.TextStyle(color: PdfColors.blue700)),
                      pw.Container(
                        width: 100,
                        height: 100,
                        child: pw.Image(profileImage),
                      ),
                    ]),
              ]));
        },
        footer: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text(
                  // 'Page ${context.pageNumber} of ${context.pagesCount}',
                  'User ID - $userId',
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
              pw.Table.fromTextArray(
                columnWidths: {
                  0: const pw.FixedColumnWidth(250),
                  1: const pw.FixedColumnWidth(250),
                  2: const pw.FixedColumnWidth(250),
                  3: const pw.FixedColumnWidth(250),
                },
                headers: [
                  'Activity Details',
                  'Progress',
                  'Status',
                  'Next Month Action Plan'
                ],
                headerStyle: headerStyle,
                headerHeight: 30,
                cellHeight: 20,
                cellStyle: cellStyle,
                context: context,
                data: allData,
              ),
              pw.Padding(padding: const pw.EdgeInsets.all(10)),
            ]));

    final pdfData = await pdf.save();
    const String pdfPath = 'MonthlyReport.pdf';

    // Save the PDF file to device storage
    if (kIsWeb) {
      if (decision == 1) {
        final blob = html.Blob([pdfData], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        html.window.open(url, '_blank');
        html.Url.revokeObjectUrl(url);
      } else if (decision == 2) {
        final anchor = html.AnchorElement(
            href:
                "data:application/octet-stream;base64,${base64Encode(pdfData)}")
          ..setAttribute("download", pdfPath)
          ..click();
      }
    } else {
      //Write code so that it can be downloaded in android
      print('Sorry it is not ready for mobile platform');
    }

    setState(() {
      enableLoading = false;
    });
  }
}
