import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PdfUploadPage extends StatelessWidget {
  final VoidCallback? fileUploadFun;
  const PdfUploadPage({super.key, required this.fileUploadFun});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: fileUploadFun,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 236, 236),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.upload_outlined),
                Text('Click to upload an Excel File'),
              ],
            ),
          ),
        ));
  }
}
