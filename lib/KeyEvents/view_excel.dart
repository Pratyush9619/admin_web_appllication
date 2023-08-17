import 'dart:io';
import 'dart:typed_data';
import 'package:excel/excel.dart' as exp;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../style.dart';

class ViewExcel extends StatefulWidget {
  Reference path;
  ViewExcel({super.key, required this.path});

  @override
  State<ViewExcel> createState() => _ViewExcelState();
}

class _ViewExcelState extends State<ViewExcel> {
  List<List<List>> sheets = [];
  List<List> sheetsForTitle = [];
  bool isLoad = true;
  List<List<List>> sheetData = [];
  List sub = [];

  int sheetNumber = 0;
  @override
  void initState() {
    // sheetsForTitle = getFile();
    getFile().whenComplete(() {
      deleteRow();

      setState(() {
        isLoad = false;
        // sheetsForTitle = sheetData;
        // sheets = sheetData;
      });
    });
    super.initState();
  }

  // Future<List> getFile() async {
  //   const oneMegabyte = 10240 * 1024;
  //   var excel = exp.Excel.decodeBytes(
  //       (await widget.path.getData(oneMegabyte)) as List<int>);

  //   for (var table in excel.tables.keys) {
  //     List columns = [];
  //     for (var row in excel.tables[table]!.rows) {
  //       List rows = [];
  //       for (var cell in row) {
  //         rows.add(cell!.value);
  //       }
  //       columns.add(rows);
  //     }
  //     sheetData.add(columns);
  //   }
  //   return sheets;
  // }

  Future getFile() async {
    print(widget.path);
    const oneMegabyte = 10240 * 1024;
    var excel =
        exp.Excel.decodeBytes((await widget.path.getData()) as List<int>);

    for (var table in excel.tables.keys) {
      List<List> columns = [];
      for (var row in excel.tables[table]!.rows) {
        List rows = [];
        for (var cell in row) {
          rows.add(cell!.value);
        }
        columns.add(rows);
      }
      sheetData.add(columns);
    }

    sheets = sheetData;
    sheetsForTitle = sheetData;
  }

  deleteRow() {
    for (int i = 1; i < sheets[sheetNumber].length; i++) {
      print("Printing Columns " + sheets[sheetNumber][i].toString());
      sub.add(sheets[sheetNumber][i]);
    }
    print("Final Sublist    " + sub.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: isLoad
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: sheetsForTitle[sheetNumber].length == 0
                        ? Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Sheet is empty",
                              style: title16,
                            ),
                          )
                        : Column(
                            children: [
                              Row(
                                children: List.generate(
                                  sheetsForTitle[sheetNumber][0].length,
                                  (index) => Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width /
                                        sheetsForTitle[sheetNumber][0].length,
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                      vertical: 5.0,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.white,
                                          width: 0.5,
                                        ),
                                        right: BorderSide(
                                          color: Colors.white,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      sheetsForTitle[sheetNumber][0][index]
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: tableheaderwhitecolor,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        // sheetsForTitle[sheetNumber][0].length,
                                        sheets[sheetNumber].length - 1,
                                    itemBuilder: (context, col) {
                                      print(sheets[sheetNumber].length);
                                      print(col);
                                      List data__ = sub;
                                      List rows = [];
                                      for (int i = 0; i < data__.length; i++) {
                                        rows.add(data__[i]);
                                      }

                                      // .skip(1).toList();

                                      return Row(
                                        children: List.generate(
                                            //rows.length,
                                            // sheetsForTitle[sheetNumber][0]
                                            //     .length,
                                            sheets[sheetNumber][col].length,
                                            (index) {
                                          // sheets[sheetNumber][0][index] = null;
                                          // print('rows length${rows.length}');
                                          // print(rows[index][col]);

                                          return Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                sheetsForTitle[sheetNumber][0]
                                                    .length,
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     .05,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 5.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: white,
                                              border: const Border(
                                                  left: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.2,
                                                  ),
                                                  right: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.2,
                                                  ),
                                                  bottom: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.2,
                                                  )),
                                            ),
                                            child: Text(
                                              rows[col][index].toString(),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }),
                                      );
                                    }),
                              ),
                            ],
                          ),
                  ),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Row(
                      children: List.generate(sheetData.length, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              // sheets.clear();
                              // sheetsForTitle.clear();
                              sheetNumber = index;
                              // getFile();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 15,
                              right: 8,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Text(
                              "Sheet ${index + 1}",
                              style: tableheaderwhitecolor,
                            ),
                          ),
                        );
                      }),
                    )),
              ],
            ),
    ));
  }
}

List<List<dynamic>> convertSubstringsToStrings(
    List<List<dynamic>> listOfLists) {
  List<List<dynamic>> result = [];

  for (List<dynamic> sublist in listOfLists) {
    List<dynamic> convertedSublist =
        sublist.map((item) => item.toString()).toList();
    result.add(convertedSublist);
  }
  return result;
}

Widget TitleWidget(value) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
      width: 2.0,
      color: Colors.black,
    )),
    child: Text(value),
  );
}

Widget CellWidget() {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
      width: 2.0,
      color: Colors.black,
    )),
  );
}
