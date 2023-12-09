import 'dart:convert';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_appllication/KeyEvents/ChartData.dart';
import 'package:web_appllication/KeyEvents/key_events.dart';
import 'package:web_appllication/components/Loading_page.dart';
import 'package:web_appllication/style.dart';
import 'package:web_appllication/widgets/nodata_available.dart';
import '../provider/key_provider.dart';
import '../widgets/custom_appbar.dart';
import 'package:pdf/widgets.dart' as pw;

import 'key_events2.dart';

class KeyEventsUser extends StatefulWidget {
  final String? userId;
  final String? cityName;
  final String? depoName;
  final String? id;
  const KeyEventsUser(
      {super.key, this.userId, this.cityName, required this.depoName, this.id});

  @override
  State<KeyEventsUser> createState() => _KeyEventsUserState();
}

class _KeyEventsUserState extends State<KeyEventsUser> {
  //Daily Project Row List for view summary
  List<List<dynamic>> rowList = [];
  bool enableLoading = false;
  KeyProvider? _keyProvider;

  @override
  void initState() {
    // _keyProvider = Provider.of<KeyProvider>(context, listen: false);
    // _keyProvider!.fetchDelayData(widget.depoName!, widget.userId);

    super.initState();
  }

  Future<List<List<dynamic>>> fetchData() async {
    await getRowsForFutureBuilder();
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: CustomAppBar(
            cityName: widget.cityName,
            showDepoBar: true,
            toPlanning: true,
            depoName: widget.depoName,
            text: ' ${widget.cityName} / ${widget.depoName}',
            userId: widget.userId,
          ),
          preferredSize: const Size.fromHeight(50)),
      body: enableLoading
          ? LoadingPage()
          : FutureBuilder<List<List<dynamic>>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;

                  if (data.isEmpty) {
                    return const NodataAvailable();
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, bottom: 5.0),
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
                                  label: Text('Project Planning Data',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ))),
                              DataColumn(
                                  label: Text('Percentage of Progress',
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
                                    DataCell(ElevatedButton(
                                      onPressed: () {
                                        // _generatePDF(rowData[0], rowData[2], 1);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => KeyEvents2(
                                                userId: rowData[0],
                                                cityName: widget.cityName,
                                                depoName: widget.depoName,
                                              ),
                                            ));
                                      },
                                      child: const Text('View Report'),
                                    )),
                                    DataCell(Container(
                                        height: 20,
                                        width: 250,
                                        child: Consumer<KeyProvider>(
                                          builder: (context, value, child) {
                                            return LinearPercentIndicator(
                                              backgroundColor: red,
                                              animation: true,
                                              lineHeight: 20.0,
                                              animationDuration: 2000,
                                              percent: rowData[1] / 100,
                                              center: Text(
                                                  '${rowData[1].toStringAsFixed(2)} %'),
                                              progressColor: Colors.green,
                                            );
                                          },
                                        ))),
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

  Future<void> getRowsForFutureBuilder() async {
    double weightage = 0;
    int qtyExecuted = 0;

    double totalperc = 0.0;
    rowList.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('KeyEventsTable')
        .doc('${widget.depoName}')
        .collection('KeyDataTable')
        .get();

    List<dynamic> userIdList = querySnapshot.docs.map((e) => e.id).toList();

    for (int i = 0; i < userIdList.length; i++) {
      dynamic allweightage = 0;
      dynamic allperScope = 0;
      dynamic allExecuted = 0;
      dynamic weightage;
      dynamic balanceQty = 0;
      dynamic perscope;
      dynamic qtyExecuted;
      num percprogress = 0;
      await FirebaseFirestore.instance
          .collection('KeyEventsTable')
          .doc('${widget.depoName}')
          .collection('KeyDataTable')
          .doc(userIdList[i])
          .collection('KeyAllEvents')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          var alldata = element.data()['data'];
          List<int> indicesToSkip = [0, 2, 6, 13, 18, 28, 32, 38, 64, 76];
          for (int i = 0; i < alldata.length; i++) {
            print('skipe${indicesToSkip.contains(i)}');

            if (indicesToSkip.contains(i)) {
              qtyExecuted = alldata[i]['QtyExecuted'];
              weightage = alldata[i]['Weightage'];
              int scope = alldata[i]['QtyScope'];

              dynamic perc = ((qtyExecuted / scope) * weightage);
              double value = perc.isNaN ? 0.0 : perc;
              totalperc = totalperc + value;
              print('perc progress${totalperc}');
            }
          }
        });
      });
      rowList.add([userIdList[i], double.parse(totalperc.toStringAsFixed(1))]);
      //  print(rowList);
    }
  }

  // Future<void> _generatePDF(String userId, String date, int decision) async {
  //   setState(() {
  //     enableLoading = true;
  //   });

  //   final headerStyle =
  //       pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold);

  //   final fontData1 = await rootBundle.load('fonts/IBMPlexSans-Medium.ttf');
  //   final fontData2 = await rootBundle.load('fonts/IBMPlexSans-Bold.ttf');

  //   final cellStyle = pw.TextStyle(
  //     color: PdfColors.black,
  //     fontSize: 14,
  //   );

  //   final profileImage = pw.MemoryImage(
  //     (await rootBundle.load('assets/Tata-Power.jpeg')).buffer.asUint8List(),
  //   );

  //   final whiteBackground = pw.MemoryImage(
  //     (await rootBundle.load('assets/white_background2.jpeg'))
  //         .buffer
  //         .asUint8List(),
  //   );

  //   //Getting safety Field Data from firestore

  //   DocumentSnapshot safetyFieldDocSanpshot = await FirebaseFirestore.instance
  //       .collection('SafetyFieldData2')
  //       .doc('${widget.depoName}')
  //       .collection('userId')
  //       .doc(userId)
  //       .collection('date')
  //       .doc(date)
  //       .get();

  //   Map<String, dynamic> safetyMapData =
  //       safetyFieldDocSanpshot.data() as Map<String, dynamic>;

  //   Timestamp installationDate = safetyMapData['InstallationDate'];
  //   DateTime date1 = installationDate.toDate();
  //   Timestamp EnegizationDate = safetyMapData['EnegizationDate'];
  //   DateTime date2 = EnegizationDate.toDate();
  //   Timestamp BoardingDate = safetyMapData['BoardingDate'];
  //   DateTime date3 = BoardingDate.toDate();

  //   List<List<dynamic>> fieldData = [
  //     ['Installation Date', '$date1'],
  //     ['Enegization Date', '$date2'],
  //     ['On Boarding Date', '$date3'],
  //     ['TPNo : ', '${safetyMapData['TPNo']}'],
  //     ['Rev :', '${safetyMapData['Rev']}'],
  //     ['Bus Depot Location :', '${safetyMapData['DepotLocation']}'],
  //     ['Address :', '${safetyMapData['Address']}'],
  //     ['Contact no / Mail Id :', '${safetyMapData['ContactNo']}'],
  //     ['Latitude & Longitude :', '${safetyMapData['Latitude']}'],
  //     ['State :', '${safetyMapData['State']}'],
  //     ['Charger Type : ', '${safetyMapData['ChargerType']}'],
  //     ['Conducted By :', '${safetyMapData['ConductedBy']}']
  //   ];

  //   List<pw.TableRow> rows = [];

  //   rows.add(pw.TableRow(children: [
  //     pw.Container(
  //         padding: const pw.EdgeInsets.all(2.0),
  //         child: pw.Center(
  //             child: pw.Text('Sr No',
  //                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
  //     pw.Container(
  //         padding:
  //             const pw.EdgeInsets.only(top: 4, bottom: 4, left: 2, right: 2),
  //         child: pw.Center(
  //             child: pw.Text('Details',
  //                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
  //     pw.Container(
  //         padding: const pw.EdgeInsets.all(2.0),
  //         child: pw.Center(
  //             child: pw.Text('Status',
  //                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
  //     pw.Container(
  //         padding: const pw.EdgeInsets.all(2.0),
  //         child: pw.Center(
  //             child: pw.Text('Remark',
  //                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
  //     pw.Container(
  //         padding: const pw.EdgeInsets.all(2.0),
  //         child: pw.Center(
  //             child: pw.Text(
  //           'Image5',
  //         ))),
  //     pw.Container(
  //         padding: const pw.EdgeInsets.all(2.0),
  //         child: pw.Center(
  //             child: pw.Text(
  //           'Image6',
  //         ))),
  //     pw.Container(
  //         padding: const pw.EdgeInsets.all(2.0),
  //         child: pw.Center(
  //             child: pw.Text(
  //           'Image7',
  //         ))),
  //     pw.Container(
  //         padding: const pw.EdgeInsets.all(2.0),
  //         child: pw.Center(
  //             child: pw.Text(
  //           'Image8',
  //         ))),
  //   ]));

  //   List<dynamic> userData = [];

  //   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //       .collection('SafetyChecklistTable2')
  //       .doc('${widget.depoName}')
  //       .collection('userId')
  //       .doc(userId)
  //       .collection('date')
  //       .doc(date)
  //       .get();

  //   Map<String, dynamic> docData =
  //       documentSnapshot.data() as Map<String, dynamic>;
  //   if (docData.isNotEmpty) {
  //     userData.addAll(docData['data']);
  //     List<dynamic> imageUrls = [];

  //     for (Map<String, dynamic> mapData in userData) {
  //       String imagesPath =
  //           'gs://tp-zap-solz.appspot.com/SafetyChecklist/Bengaluru/${widget.depoName}/$userId/${mapData['srNo']}';
  //       ListResult result =
  //           await FirebaseStorage.instance.ref().child(imagesPath).listAll();

  //       if (result.items.isNotEmpty) {
  //         for (var image in result.items) {
  //           String downloadUrl = await image.getDownloadURL();
  //           final myImage = await networkImage(downloadUrl);
  //           imageUrls.add(myImage);
  //         }
  //         if (imageUrls.length < 8) {
  //           int imageLoop = 8 - imageUrls.length;
  //           for (int i = 0; i < imageLoop; i++) {
  //             imageUrls.add(whiteBackground);
  //           }
  //         }
  //       }
  //       result.items.clear();

  //       //Text Rows of PDF Table
  //       rows.add(pw.TableRow(children: [
  //         pw.Container(
  //             padding: const pw.EdgeInsets.all(3.0),
  //             child: pw.Center(
  //                 child: pw.Text(mapData['srNo'].toString(),
  //                     style: const pw.TextStyle(fontSize: 13)))),
  //         pw.Container(
  //             padding: const pw.EdgeInsets.all(5.0),
  //             child: pw.Center(
  //                 child: pw.Text(mapData['Details'],
  //                     style: const pw.TextStyle(
  //                       fontSize: 13,
  //                     )))),
  //         pw.Container(
  //             padding: const pw.EdgeInsets.all(2.0),
  //             child: pw.Center(
  //                 child: pw.Text(mapData['Status'],
  //                     style: const pw.TextStyle(fontSize: 13)))),
  //         pw.Container(
  //             padding: const pw.EdgeInsets.all(2.0),
  //             child: pw.Center(
  //                 child: pw.Text(mapData['Remark'].toString(),
  //                     style: const pw.TextStyle(fontSize: 13)))),
  //       ]));

  //       if (imageUrls.isNotEmpty) {
  //         //Image Rows of PDF Table
  //         rows.add(pw.TableRow(children: [
  //           pw.Container(
  //               padding: const pw.EdgeInsets.only(
  //                   top: 8.0, bottom: 8.0, left: 3, right: 3),
  //               child: pw.Text('')),
  //           pw.Container(
  //               padding: const pw.EdgeInsets.only(
  //                   top: 8.0, bottom: 8.0, left: 3, right: 3),
  //               width: 100,
  //               height: 80,
  //               child: pw.Row(
  //                   mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
  //                   children: [
  //                     pw.Image(imageUrls[0]),
  //                     pw.Image(imageUrls[1]),
  //                   ])),
  //           pw.Container(
  //               padding: const pw.EdgeInsets.only(
  //                   top: 8.0, bottom: 8.0, left: 3, right: 3),
  //               width: 100,
  //               height: 80,
  //               child: pw.Center(
  //                 child: pw.Image(imageUrls[2]),
  //               )),
  //           pw.Container(
  //               padding: const pw.EdgeInsets.only(
  //                   top: 8.0, bottom: 8.0, left: 3, right: 3),
  //               width: 100,
  //               height: 80,
  //               child: pw.Center(
  //                 child: pw.Image(imageUrls[3]),
  //               )),
  //           pw.Container(
  //               padding: const pw.EdgeInsets.only(
  //                   top: 8.0, bottom: 8.0, left: 3, right: 3),
  //               width: 100,
  //               height: 80,
  //               child: pw.Center(
  //                 child: pw.Image(imageUrls[4]),
  //               )),
  //           pw.Container(
  //               padding: const pw.EdgeInsets.only(
  //                   top: 8.0, bottom: 8.0, left: 3, right: 3),
  //               width: 100,
  //               height: 80,
  //               child: pw.Center(
  //                 child: pw.Image(imageUrls[5]),
  //               )),
  //           pw.Container(
  //               padding: const pw.EdgeInsets.only(
  //                   top: 8.0, bottom: 8.0, left: 3, right: 3),
  //               width: 100,
  //               height: 80,
  //               child: pw.Center(
  //                 child: pw.Image(imageUrls[6]),
  //               )),
  //           pw.Container(
  //               padding: const pw.EdgeInsets.only(
  //                   top: 8.0, bottom: 8.0, left: 3, right: 3),
  //               width: 100,
  //               height: 80,
  //               child: pw.Center(
  //                 child: pw.Image(imageUrls[7]),
  //               ))
  //         ]));
  //       }
  //       imageUrls.clear();
  //     }
  //   }

  //   final pdf = pw.Document(
  //     pageMode: PdfPageMode.outlines,
  //   );

  //   pdf.addPage(
  //     pw.MultiPage(
  //       theme: pw.ThemeData.withFont(
  //           base: pw.Font.ttf(fontData1), bold: pw.Font.ttf(fontData2)),
  //       pageFormat: const PdfPageFormat(1300, 900,
  //           marginLeft: 70, marginRight: 70, marginBottom: 80, marginTop: 40),
  //       orientation: pw.PageOrientation.natural,
  //       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //       header: (pw.Context context) {
  //         return pw.Container(
  //             alignment: pw.Alignment.centerRight,
  //             margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
  //             padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
  //             decoration: const pw.BoxDecoration(
  //                 border: pw.Border(
  //                     bottom:
  //                         pw.BorderSide(width: 0.5, color: PdfColors.grey))),
  //             child: pw.Column(children: [
  //               pw.Row(
  //                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     pw.Text('Safety Report',
  //                         textScaleFactor: 2,
  //                         style: const pw.TextStyle(color: PdfColors.blue700)),
  //                     pw.Container(
  //                       width: 120,
  //                       height: 120,
  //                       child: pw.Image(profileImage),
  //                     ),
  //                   ]),
  //             ]));
  //       },
  //       footer: (pw.Context context) {
  //         return pw.Container(
  //             alignment: pw.Alignment.centerRight,
  //             margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
  //             child: pw.Text('User ID - $userId',
  //                 // 'Page ${context.pageNumber} of ${context.pagesCount}',
  //                 style: pw.Theme.of(context)
  //                     .defaultTextStyle
  //                     .copyWith(color: PdfColors.black)));
  //       },
  //       build: (pw.Context context) => <pw.Widget>[
  //         pw.Column(children: [
  //           pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Text(
  //                   'Place:  ${widget.cityName}/${widget.depoName}',
  //                   textScaleFactor: 1.1,
  //                 ),
  //                 pw.Text(
  //                   'Date:  $date ',
  //                   textScaleFactor: 1.1,
  //                 )
  //               ]),
  //           pw.SizedBox(height: 20)
  //         ]),
  //         pw.SizedBox(height: 10),
  //         pw.Table.fromTextArray(
  //           columnWidths: {
  //             0: const pw.FixedColumnWidth(100),
  //             1: const pw.FixedColumnWidth(100),
  //           },
  //           headers: ['Details', 'Values'],
  //           headerStyle: headerStyle,
  //           headerPadding: const pw.EdgeInsets.all(10.0),
  //           data: fieldData,
  //           cellHeight: 35,
  //           cellStyle: cellStyle,
  //         )
  //       ],
  //     ),
  //   );

  //   //First Half Page

  //   pdf.addPage(
  //     pw.MultiPage(
  //       theme: pw.ThemeData.withFont(
  //           base: pw.Font.ttf(fontData1), bold: pw.Font.ttf(fontData2)),
  //       pageFormat: const PdfPageFormat(1300, 900,
  //           marginLeft: 70, marginRight: 70, marginBottom: 80, marginTop: 40),
  //       orientation: pw.PageOrientation.natural,
  //       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //       header: (pw.Context context) {
  //         return pw.Container(
  //             alignment: pw.Alignment.centerRight,
  //             margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
  //             padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
  //             decoration: const pw.BoxDecoration(
  //                 border: pw.Border(
  //                     bottom:
  //                         pw.BorderSide(width: 0.5, color: PdfColors.grey))),
  //             child: pw.Column(children: [
  //               pw.Row(
  //                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     pw.Text('Safety Report',
  //                         textScaleFactor: 2,
  //                         style: const pw.TextStyle(color: PdfColors.blue700)),
  //                     pw.Container(
  //                       width: 120,
  //                       height: 120,
  //                       child: pw.Image(profileImage),
  //                     ),
  //                   ]),
  //             ]));
  //       },
  //       footer: (pw.Context context) {
  //         return pw.Container(
  //             alignment: pw.Alignment.centerRight,
  //             margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
  //             child: pw.Text('User ID - $userId',
  //                 // 'Page ${context.pageNumber} of ${context.pagesCount}',
  //                 style: pw.Theme.of(context)
  //                     .defaultTextStyle
  //                     .copyWith(color: PdfColors.black)));
  //       },
  //       build: (pw.Context context) => <pw.Widget>[
  //         pw.Column(children: [
  //           pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Text(
  //                   'Place:  ${widget.cityName}/${widget.depoName}',
  //                   textScaleFactor: 1.1,
  //                 ),
  //                 pw.Text(
  //                   'Date:  $date ',
  //                   textScaleFactor: 1.1,
  //                 )
  //               ]),
  //           pw.SizedBox(height: 20)
  //         ]),
  //         pw.SizedBox(height: 10),
  //         pw.Table(
  //             columnWidths: {
  //               0: const pw.FixedColumnWidth(30),
  //               1: const pw.FixedColumnWidth(160),
  //               2: const pw.FixedColumnWidth(70),
  //               3: const pw.FixedColumnWidth(70),
  //               4: const pw.FixedColumnWidth(70),
  //               5: const pw.FixedColumnWidth(70),
  //               6: const pw.FixedColumnWidth(70),
  //               7: const pw.FixedColumnWidth(70),
  //             },
  //             defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
  //             tableWidth: pw.TableWidth.max,
  //             border: pw.TableBorder.all(),
  //             children: rows)
  //       ],
  //     ),
  //   );

  //   final List<int> pdfData = await pdf.save();
  //   const String pdfPath = 'MonthlyData.pdf';

  //   // Save the PDF file to device storage
  //   if (kIsWeb) {
  //     if (decision == 1) {
  //       final blob = html.Blob([pdfData], 'application/pdf');
  //       final url = html.Url.createObjectUrlFromBlob(blob);
  //       html.window.open(url, '_blank');
  //       final encodedUrl = Uri.encodeFull(url);
  //       html.Url.revokeObjectUrl(encodedUrl);
  //       Future.delayed(const Duration(seconds: 1), () {
  //         html.Url.revokeObjectUrl(url);
  //       }).catchError((error) {
  //         print('Error revoking object URL: $error');
  //       });
  //     } else if (decision == 2) {
  //       html.AnchorElement(
  //           href:
  //               "data:application/octet-stream;base64,${base64Encode(pdfData)}")
  //         ..setAttribute("download", pdfPath)
  //         ..click();
  //     }
  //   } else {
  //     const Text('Sorry it is not ready for mobile platform');
  //   }

  //   setState(() {
  //     enableLoading = false;
  //   });
  // }
}
