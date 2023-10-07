import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_appllication/datasource/employee_statutory.dart';
import 'package:web_appllication/model/monthly_projectModel.dart';
import 'package:web_appllication/model/safety_checklistModel.dart';
import 'package:web_appllication/model/user_model.dart';

import '../Authentication/auth_service.dart';
import '../model/employee_statutory.dart';

List<String> dataList = [];
List docss = [];
late EmployeeDataStatutory _employeeDataStatutory;

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
  }

  static Future getAllId() async {
    await FirebaseFirestore.instance.collection('User').get().then((value) {
      value.docs.forEach((element) {
        // print(element.data()['Employee Id']);
        dataList.add(element.data()['Employee Id']);
      });
    });
  }

  Future getTableData(String clnname, String deponame, String clnname1) async {
    await FirebaseFirestore.instance
        .collection(clnname)
        .doc(deponame)
        .collection(clnname1)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        String documentId = element.id;
        print('Document ID: $documentId');
        docss.add(documentId);

        // nestedTableData(docss);
      });
    });
  }

  Future<void> nestedTableData(docss, String clnname, String deponame,
      String clnname1, String clnname2, List statutory, String id) async {
    for (int i = 0; i < docss.length; i++) {
      await FirebaseFirestore.instance
          .collection(clnname)
          .doc(deponame)
          .collection(clnname1)
          .doc(docss[i])
          .collection(clnname2)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print('after');
          for (int i = 0; i < element.data()['data'].length; i++) {
            if (id == 'Safety') {
              statutory.add(
                  SafetyChecklistModel.fromJson(element.data()['data'][i]));
              print(statutory);
            } else {
              statutory
                  .add(MonthlyProjectModel.fromjson(element.data()['data'][i]));
              print(statutory);
            }
          }
        });
      });
    }
  }
}

class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}
