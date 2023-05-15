import 'dart:html' as html;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

bool _isLoading = false;

class ViewFile extends StatefulWidget {
  String? title;
  String? cityName;
  String? depoName;
  String? activity;
  dynamic userId;
  String? path;
  ViewFile({super.key, this.cityName, this.depoName, this.activity, this.path});

  @override
  State<ViewFile> createState() => _ViewFileState();
}

class _ViewFileState extends State<ViewFile> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  String? path;

  // final pdfController = PdfController(
  //   document: PdfDocument.openAsset('assets/GIS.pdf'),
  // );
  Uint8List? _documentBytes;
  @override
  void initState() {
    // path =
    //     'https://firebasestorage.googleapis.com/v0/b/tp-zap-solz.appspot.com/o/BOQElectrical%2FBengaluru%2FBMTC%20KR%20Puram-29%2FZW3210%2FGIS.pdf?alt=media&token=6df8f943-b049-45e6-9198-b347b6f7f0d8';

    getPdfBytes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = const Center(child: CircularProgressIndicator());
    if (_documentBytes != null) {
      child = SfPdfViewer.memory(
        _documentBytes!,
      );
    }
    return Scaffold(
      body: child,
    );
  }

  void getPdfBytes() async {
    if (kIsWeb) {
      firebase_storage.Reference pdfRef =
          firebase_storage.FirebaseStorage.instanceFor(
                  bucket: 'tp-zap-solz.appspot.com')
              .refFromURL(widget.path!);
      //size mentioned here is max size to download from firebase.
      await pdfRef.getData(104857600).then((value) {
        _documentBytes = value;
        setState(() {});
      });
    } else {
      HttpClient client = HttpClient();
      final Uri url = Uri.base.resolve(widget.path!);
      final HttpClientRequest request = await client.getUrl(url);
      final HttpClientResponse response = await request.close();
      _documentBytes = await consolidateHttpClientResponseBytes(response);
      setState(() {});
    }
  }

//   void getPdfBytes() async {
//     String? path =
//         'https://firebasestorage.googleapis.com/v0/b/tp-zap-solz.appspot.com/o/checklist%2FJammu%2FDRDO%2Fdepot.pdf?alt=media&token=ca6d1483-c5a6-4216-a46b-98ccd2de0c06';

//     if (kIsWeb) {
//       firebase_storage.Reference pdfRef =
//           firebase_storage.FirebaseStorage.instanceFor(
//                   bucket: 'tp-zap-solz.appspot.com')
//               .refFromURL(path);
//       //size mentioned here is max size to download from firebase.
//       print('khkhkh${pdfRef}');
//       await pdfRef.getData(104857600).then((value) {
//         _documentBytes = value;
//         setState(() {
//           _isLoading = true;
//         });
//       });
//     } else {
//       HttpClient client = HttpClient();
//       final Uri url = Uri.base.resolve(path);
//       final HttpClientRequest request = await client.getUrl(url);
//       final HttpClientResponse response = await request.close();
//       _documentBytes = await consolidateHttpClientResponseBytes(response);
//       setState(() {});
//     }
//   }

//   nodataAvailable() {
//     return Center(
//         child: Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         height: 1000,
//         width: 1000,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: blue)),
//         child: Column(children: [
//           Image.asset(
//             'assets/Tata-Power.jpeg',
//           ),
//           const SizedBox(height: 50),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/sustainable.jpeg',
//                 height: 100,
//                 width: 100,
//               ),
//               SizedBox(width: 50),
//               Image.asset(
//                 'assets/Green.jpeg',
//                 height: 100,
//                 width: 100,
//               )
//             ],
//           ),
//           const SizedBox(height: 50),
//           Center(
//             child: Container(
//               padding: EdgeInsets.all(25),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: blue)),
//               child: const Text(
//                 'No Checklist available yet \n Please wait for upload checklist',
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//             ),
//           )
//         ]),
//       ),
//     )
//         // Text(
//         //   "No Depot Available at This Time....",
//         //   style: TextStyle(color: black),
//         // ),
//         );
//   }
// }

// downloadFileWeb(String url, String fileName) async {
//   final httpsReference =
//       firebase_storage.FirebaseStorage.instance.refFromURL(url);

//   try {
//     const oneMegabyte = 1024 * 1024;
//     final Uint8List? data = await httpsReference.getData(oneMegabyte);
//     // Data for "images/island.jpg" is returned, use this as needed.
//     XFile.fromData(data!, mimeType: "application/pdf", name: fileName + ".pdf")
//         .saveTo("C:/"); // here Path is ignored
//   } on FirebaseException catch (e) {
//     // Handle any errors.
//   }
//   // for other platforms see this solution : https://firebase.google.com/docs/storage/flutter/download-files#download_to_a_local_file
// }

// previewPDFFile(url) {
//   html.window.open(url, "_blank"); //opens pdf in new tab
// }
}
