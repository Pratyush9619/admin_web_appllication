import 'dart:html';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../style.dart';

bool _isLoading = false;

class ViewFile extends StatefulWidget {
  String? cityName;
  String? depoName;
  String? activity;

  ViewFile({super.key, this.cityName, this.depoName, this.activity});

  @override
  State<ViewFile> createState() => _ViewFileState();
}

class _ViewFileState extends State<ViewFile> {
  Uint8List? _documentBytes;
  @override
  void initState() {
    getPdfBytes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = const Center(child: CircularProgressIndicator());
    if (_isLoading) {
      if (_documentBytes != null) {
        child = SfPdfViewer.memory(
          _documentBytes!,
        );
      } else {
        child = NodataAvailable();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        backgroundColor: blue,
      ),
      body: child,
    );
  }

  void getPdfBytes() async {
    String? path =
        'https://firebasestorage.googleapis.com/v0/b/tp-zap-solz.appspot.com/o/checklist%2F${widget.cityName}%2F${widget.depoName}%2F${widget.activity}?alt=media&token=ca6d1483-c5a6-4216-a46b-98ccd2de0c06';

    if (kIsWeb) {
      firebase_storage.Reference pdfRef =
          firebase_storage.FirebaseStorage.instanceFor(
                  bucket: 'tp-zap-solz.appspot.com')
              .refFromURL(path);
      //size mentioned here is max size to download from firebase.
      print(pdfRef);
      await pdfRef.getData().then((value) {
        _documentBytes = value;
        setState(() {
          _isLoading = true;
        });
      });
    } else {
      HttpClient client = HttpClient();
      final Uri url = Uri.base.resolve(path!);
      final HttpClientRequest request = await client.getUrl(url);
      final HttpClientResponse response = await request.close();
      _documentBytes = await consolidateHttpClientResponseBytes(response);
      setState(() {});
    }
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
                'No Checklist available yet \n Please wait for upload checklist',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
      ),
    )
        // Text(
        //   "No Depot Available at This Time....",
        //   style: TextStyle(color: black),
        // ),
        );
  }
}
