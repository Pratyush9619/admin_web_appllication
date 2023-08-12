import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:web_appllication/widgets/nodata_available.dart';
import '../widgets/custom_appbar.dart';
import 'quality_checklist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../Authentication/auth_service.dart';
import '../components/loading_page.dart';
import 'package:web_appllication/style.dart';

class ClosureSummary extends StatefulWidget {
  final String? userId;
  final String? cityName;
  final String? depoName;
  final String? id;
  final String? date;
  final String? user_id;

  const ClosureSummary(
      {super.key, this.userId, this.cityName, required this.depoName, this.id,this.date,this.user_id}
      );

  @override
  State<ClosureSummary> createState() => _ClosureSummaryState();
}

class _ClosureSummaryState extends State<ClosureSummary> {

  List<TableRow> rowOfWidget = [
    TableRow(
        children: [
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                color: Colors.blue[500],
                padding: const EdgeInsets.all(10.0),
                child: const Text('Sr No',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
              )
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                color: Colors.blue[500],
                padding: const EdgeInsets.all(10.0),
                child: const Text('List of Rows',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18
                  ),),
              )
          ),
        ]
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<List<TableRow>> fetchData() async {
    await getRowsForFutureBuilder('${widget.date}', '${widget.user_id}');
    return rowOfWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          // ignore: sort_child_properties_last
            child: CustomAppBar(
              text: ' ${widget.cityName}/ ${widget.depoName} / ${widget.id}',
              userid: widget.userId,
            ),
            preferredSize: const Size.fromHeight(50)),
        body: FutureBuilder<List<TableRow>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      LoadingPage()
                    ],
                  ),
              );
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

              return SingleChildScrollView(
                padding: const EdgeInsets.only(left: 6.0,right: 6.0),
                child: AnimatedContainer(
                  duration:  const Duration(milliseconds: 300),
                  child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(100),
                        1: FlexColumnWidth()
                      },
                      border: TableBorder.all(color: Colors.black),
                      children: rowOfWidget
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      );
  }

  Future<void> getRowsForFutureBuilder(String date, String user_id) async {
    final pdfLogo = MemoryImage(
      (await rootBundle.load('assets/pdf_logo.jpeg')).buffer.asUint8List(),
    );

    List<List<String>> tableRows = [
      ['1', 'Introduction of Project'],
      ['1.1', 'RFP for DTC Bus Project '],
      ['1.2', 'Project Purchase Order or LOI or LOA '],
      ['1.3', 'Project Governance Structure'],
      ['1.4', 'Site Location Details'],
      ['1.5', 'Final  Site Survey Report'],
      ['1.6', 'BOQ (Bill of Quantity)']
    ];

    for (int i = 0; i < tableRows.length; i++) {
      List<Widget> url = [];
      rowOfWidget.add(customTableTextRow(tableRows[i][0], tableRows[i][1]));

      final path = 'ClosureReport/${widget.cityName}/${widget.depoName}/$user_id/$date/${tableRows[i][0]}';

      ListResult result = await FirebaseStorage.instance.ref()
          .child(path)
          .listAll();

      if(result.items.isNotEmpty){
        for (var img in result.items) {
          final downloadUrl = await img.getDownloadURL();
          if (img.name.endsWith('.pdf')) {
            url.add(
                 IconButton(
                   hoverColor: Colors.transparent,
                      iconSize: 130,
                        onPressed: (){
                          openPdf(downloadUrl);
                    }, icon: Image(
                      image: pdfLogo,
                    ),
                    )
            );
          }
          else {
            url.add(
                IconButton(
                      hoverColor: Colors.transparent,
                      iconSize: 200,
                      onPressed: (){
                      openPdf(downloadUrl);
                    },
                        icon: Image(
                          image: NetworkImage(downloadUrl),
                        ),
                    )
            );
          }
        }
      }
       rowOfWidget.add(customTableImageRow(url));
    }
  }

  customTableTextRow(String srNo, String row) {
    return TableRow(
        children: [
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  srNo,
                  style: const TextStyle(
                      fontSize: 16
                  ),
                ),
              )
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  row,
                  style: const TextStyle(
                      fontSize: 16
                  ),
                ),
              )
          )
        ]
    );
  }

  customTableImageRow(List<Widget> url) {
    return TableRow(
        children: [
          const TableCell(
              child: Text('')
          ),
         TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Row(
                    children: url
                )
            ),
        ]
    );
  }


  openPdf(var url){
      if (kIsWeb) {
        html.window.open(url, '_blank');
        final encodedUrl = Uri.encodeFull(url);
        html.Url.revokeObjectUrl(encodedUrl);
      } else {
        const Text('Sorry it is not ready for mobile platform');
      }

  }


}