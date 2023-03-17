import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:web_appllication/style.dart';

class UploadDocument extends StatefulWidget {
  String? activity;
  String? cityName;
  String? depoName;
  UploadDocument({super.key, this.cityName, this.depoName, this.activity});

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload Documents'),
          backgroundColor: blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (result != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Selected file:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: result?.files.length ?? 0,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Text(result?.files[index].name ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            );
                          })
                    ],
                  ),
                ),
              ElevatedButton(
                  onPressed: () async {
                    result = await FilePicker.platform
                        .pickFiles(allowMultiple: false, withData: true);
                    if (result == null) {
                      print("No file selected");
                    } else {
                      setState(() {});
                      result?.files.forEach((element) {
                        print(element.name);
                      });
                    }
                  },
                  child: const Text('Pick file')),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    if (result != null) {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          content: SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: blue,
                              ),
                            ),
                          ),
                        ),
                      );
                      Uint8List? fileBytes = result!.files.first.bytes;
                      // String? fileName = result!.files.first.name;

                      await FirebaseStorage.instance
                          .ref('AwardLetter/' + widget.depoName!)
                          .putData(fileBytes!,
                              SettableMetadata(contentType: 'appllication/pdf'))
                          .whenComplete(() => setState(() => result == null));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Image is Uploaded')));
                    }
                  },
                  child: const Text('Upload file')),
            ],
          ),
        ));
  }
}
