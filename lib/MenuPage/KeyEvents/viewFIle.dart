import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:web_appllication/style.dart';

class ViewFile extends StatefulWidget {
  String? cityName;
  String? depoName;

  ViewFile({super.key, this.cityName, this.depoName});

  @override
  State<ViewFile> createState() => _ViewFileState();
}

class _ViewFileState extends State<ViewFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Checklist File'),
        backgroundColor: blue,
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.delete),
          )
        ],
      ),
      body: SfPdfViewer.asset('assets/Jammu_Smart_City_Limited.pdf'),
    );
  }
}
