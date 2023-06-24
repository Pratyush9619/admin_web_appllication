import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

import '../FirebaseApi/firebase_api.dart';
import '../style.dart';
import 'image_page.dart';

class ViewAllPdf extends StatefulWidget {
  String title;
  String cityName;
  String depoName;
  String? userId;
  String docId;
  ViewAllPdf(
      {super.key,
      required this.title,
      required this.cityName,
      required this.depoName,
      this.userId,
      required this.docId});

  @override
  State<ViewAllPdf> createState() => _ViewAllPdfState();
}

class _ViewAllPdfState extends State<ViewAllPdf> {
  late Future<List<FirebaseFile>> futureFiles;
  List<String> pdfFiles = [];

  @override
  void initState() {
    futureFiles = FirebaseApi.listAll(
        '${widget.title}/${widget.cityName}/${widget.depoName}/${widget.userId}/${widget.docId}');
    super.initState();
  }

// /DetailedEngRFC/Bengaluru/BMTC KR Puram-29/ ZW3210
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF List'),
        backgroundColor: blue,
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(child: Text('Some error occurred!'));
              } else {
                final files = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(files.length),
                    const SizedBox(height: 12),
                    Expanded(
                        child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5),
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];
                        return buildFile(context, file);
                      },
                    )
                        //  ListView.builder(
                        //   itemCount: files.length,
                        //   itemBuilder: (context, index) {
                        //     final file = files[index];

                        //     return buildFile(context, file);
                        //   },
                        // ),
                        ),
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        // leading: ClipOval(
        //   child: Image.network(
        //     file.url,
        //     width: 52,
        //     height: 52,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        title: Text(
          file.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
}
