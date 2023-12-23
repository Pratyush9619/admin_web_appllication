import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart' as pdfx;
import '../style.dart';

class PdfSummary extends StatefulWidget {
  const PdfSummary({super.key});

  @override
  State<PdfSummary> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PdfSummary> {
  late pdfx.PdfControllerPinch pdfcontroller;

  Future<Uint8List> createPdf() async {
    List<pw.TableRow> rowitem = [];
    // pdf.
    var pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Column(children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  _card1('TPNo'),
                  _spacebar(5, 0),
                  _card1('Rev:() Date:29.11.2022'),
                  pw.Column(children: [
                    _card1('name'),
                    _spacebar(0, 5),
                    _card1('name'),
                    _spacebar(0, 5),
                    _card1('name'),
                  ])
                ],
              ),
            ])
          ];
        },
      ),
    );
    return pdf.save();
  }

  @override
  void initState() {
    super.initState();
    pdfcontroller = pdfx.PdfControllerPinch(
        document: pdfx.PdfDocument.openData(createPdf()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Summary'),
        backgroundColor: blue,
      ),
      body: pdfx.PdfViewPinch(controller: pdfcontroller),
    );
  }

  pw.Container _card1(String name) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColor.fromHex('#0000FF'), width: 1.0),
        borderRadius: pw.BorderRadius.circular(10.0),
      ),
      width: 150,
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        child: pw.Text(
          name,
        ),
      ),
    );
  }

  pw.Container _card2(String name) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColor.fromHex('#0000FF'), width: 1.0),
        borderRadius: pw.BorderRadius.circular(10.0),
      ),
      width: 200,
      child: pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        child: pw.Text(
          name,
        ),
      ),
    );
  }

  pw.SizedBox _spacebar(int width, int height) {
    return pw.SizedBox(width: 10, height: 10);
  }
}
