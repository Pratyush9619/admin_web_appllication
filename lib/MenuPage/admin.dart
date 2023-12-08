import 'dart:math';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/provider/selected_row_index.dart';
import 'package:web_appllication/style.dart';

class DashBoardScreen extends StatefulWidget {
  static const String id = 'admin-page';
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<Color> colorList = [Colors.amber, Colors.orange, Colors.blue];
  List<String> legendNames = ['Rocket', 'Aeroplane', 'Car'];
  List<String> dashboardTitle = [
    'Budget',
    'Actual Expense',
    'TML Approved JMR Values'
  ];

  List<String> budgetVsActuals = [
    'TPREL Budget\n(FY24)',
    'TPEVSL Budget\n(FY24)',
    'Total Buget\n(FY24)',
    'Actual Expense\n(TPREL-FY24)',
    'Actual Expense\n(TPEVSL-FY24)',
    'Total Actual\nExpense(FY24)'
  ];
  List<List<String>> dashboardColNames = [
    ['TPREL Budget\n(FY24)', 'TPEVSL Budget\n(FY24)', 'Total Buget\n(FY24)'],
    [
      'Actual Expense\n(TPREL-FY24)',
      'Actual Expense\n(TPEVSL-FY24)',
      'Total Actual\nExpense(FY24)'
    ],
    [
      'Total Infra Amount\n(TPREL)',
      'Total EV chargers\nAmount(TPEVCSL)',
      'Total Approved\nJMR Amount'
    ]
  ];
  int touchIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5.0, top: 5.0),
          width: MediaQuery.of(context).size.width * 0.98,
          height: 230,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: ((context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.88 / 3,
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 15,
                          left: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.86 / 3,
                            height: 200,
                            child: Card(
                                elevation: 10,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.88,
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: 3,
                                              itemBuilder: ((context, index) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: RichText(
                                                      text: TextSpan(children: [
                                                    WidgetSpan(
                                                        child: Container(
                                                            height: 10,
                                                            width: 10,
                                                            color: colorList[
                                                                index])),
                                                    const WidgetSpan(
                                                        child: SizedBox(
                                                      width: 5,
                                                    )),
                                                    TextSpan(
                                                        text:
                                                            legendNames[index],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12))
                                                  ])),
                                                );
                                              })),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 125,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.81 /
                                              4.42,
                                          child: DataTable2(
                                              headingRowColor:
                                                  MaterialStatePropertyAll(
                                                      blue),
                                              headingTextStyle: TextStyle(
                                                  color: white, fontSize: 8),
                                              headingRowHeight: 25,
                                              dataTextStyle: dashboardStyle,
                                              columnSpacing: 2,
                                              showBottomBorder: false,
                                              dividerThickness: 0,
                                              dataRowHeight: 20,
                                              columns: [
                                                DataColumn2(
                                                    label: Text(
                                                  dashboardColNames[index][0],
                                                  textAlign: TextAlign.center,
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  dashboardColNames[index][1],
                                                  textAlign: TextAlign.center,
                                                )),
                                                DataColumn2(
                                                    label: Text(
                                                  dashboardColNames[index][2],
                                                  textAlign: TextAlign.center,
                                                )),
                                              ],
                                              rows: List.generate(10, (index) {
                                                return DataRow2(
                                                    color: index ==
                                                            Provider.of<SelectedRowIndexModel>(
                                                                    context)
                                                                .selectedRowIndex
                                                        ? const MaterialStatePropertyAll(
                                                            Color.fromARGB(255,
                                                                190, 226, 255))
                                                        : MaterialStatePropertyAll(
                                                            white),
                                                    cells: const [
                                                      DataCell(
                                                          Text('Hellow World')),
                                                      DataCell(
                                                          Text('Hellow World')),
                                                      DataCell(
                                                          Text('Hellow World')),
                                                    ]);
                                              })),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: PieChart(
                                            dataMap: const {
                                              'Rocket': 10,
                                              'Aeroplane': 50,
                                              'Car': 40
                                            },
                                            legendOptions: const LegendOptions(
                                                showLegends: false),
                                            animationDuration: const Duration(
                                                milliseconds: 1500),
                                            chartValuesOptions:
                                                const ChartValuesOptions(
                                              showChartValuesInPercentage: true,
                                            ),
                                            chartRadius: 100,
                                            colorList: colorList,
                                            chartType: ChartType.disc,
                                            totalValue: 100,
                                          ),
                                        )
                                        // AspectRatio(
                                        //   aspectRatio: 1.3,
                                        //   child: AspectRatio(
                                        //     aspectRatio: 1,
                                        //     child: PieChart(
                                        //       PieChartData(
                                        //         pieTouchData: PieTouchData(
                                        //           touchCallback:
                                        //               (FlTouchEvent event,
                                        //                   pieTouchResponse) {
                                        //             setState(() {
                                        //               if (!event
                                        //                       .isInterestedForInteractions ||
                                        //                   pieTouchResponse ==
                                        //                       null ||
                                        //                   pieTouchResponse
                                        //                           .touchedSection ==
                                        //                       null) {
                                        //                 touchIndex = -1;
                                        //                 return;
                                        //               }
                                        //               touchIndex = pieTouchResponse
                                        //                   .touchedSection!
                                        //                   .touchedSectionIndex;
                                        //             });
                                        //           },
                                        //         ),
                                        //         borderData: FlBorderData(
                                        //           show: false,
                                        //         ),
                                        //         sectionsSpace: 0,
                                        //         centerSpaceRadius: 0,
                                        //         sections: showingSections(),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      height: 20,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: 3,
                                          itemBuilder: (contex, index) {
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: 'Total Budget :',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: black)),
                                                const WidgetSpan(
                                                    child: SizedBox(
                                                  width: 5,
                                                )),
                                                TextSpan(
                                                    text: 'Value',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: blue,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ])),
                                            );
                                          }),
                                    )
                                  ],
                                )),
                          )),
                      Positioned(
                          top: 0,
                          left: 20,
                          child: Card(
                              shadowColor: Colors.black,
                              elevation: 5,
                              color: blue,
                              child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dashboardTitle[index],
                                    style: const TextStyle(color: Colors.white),
                                  )))),
                    ],
                  ),
                );
              })),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width * 0.98,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.98 / 3,
                height: 400,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.94 / 3,
                        height: 380,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 10,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 40),
                                height: 340,
                                width: MediaQuery.of(context).size.width *
                                    0.94 /
                                    3,
                                child: DataTable2(
                                    headingRowHeight: 30,
                                    headingRowColor:
                                        MaterialStatePropertyAll(blue),
                                    columnSpacing: 10,
                                    dataTextStyle: dashboardStyle,
                                    dataRowHeight: 20,
                                    headingTextStyle:
                                        TextStyle(color: white, fontSize: 10),
                                    showBottomBorder: false,
                                    dividerThickness: 0,
                                    columns: const [
                                      DataColumn2(
                                          label: Text(
                                        'Project Name',
                                        textAlign: TextAlign.center,
                                      )),
                                      DataColumn2(
                                          label: Text(
                                        'Planned Chargers\n(Nos)',
                                        textAlign: TextAlign.center,
                                      )),
                                      DataColumn2(
                                          label: Text(
                                        'Chargers Commissioned\n(Nos)',
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                    rows: List.generate(10, (index) {
                                      return DataRow2(
                                          color: index ==
                                                  Provider.of<SelectedRowIndexModel>(
                                                          context)
                                                      .selectedRowIndex
                                              ? const MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 190, 226, 255))
                                              : MaterialStatePropertyAll(white),
                                          onTap: () {
                                            Provider.of<SelectedRowIndexModel>(
                                                    context,
                                                    listen: false)
                                                .setSelectedRowIndex(index);
                                          },
                                          // onSelectChanged: (isSelected) {
                                          //   Provider.of<SelectedRowIndexModel>(
                                          //           context,
                                          //           listen: false)
                                          //       .setSelectedRowIndex(index);
                                          // },
                                          cells: const [
                                            DataCell(Text('Hellow World')),
                                            DataCell(Text('Hellow World')),
                                            DataCell(Text('Hellow World')),
                                          ]);
                                    })),
                              ),
                              Divider(
                                thickness: 1,
                                color: blue,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Total Planned Chargers:',
                                        style: TextStyle(
                                            fontSize: 12, color: black)),
                                    const WidgetSpan(
                                        child: SizedBox(
                                      width: 5,
                                    )),
                                    TextSpan(
                                        text: 'Value1',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: blue,
                                            fontWeight: FontWeight.bold))
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Total Chargers Commissioned:',
                                        style: TextStyle(
                                            fontSize: 12, color: black)),
                                    const WidgetSpan(
                                        child: SizedBox(
                                      width: 5,
                                    )),
                                    TextSpan(
                                        text: 'Value2',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: blue,
                                            fontWeight: FontWeight.bold))
                                  ]))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 20,
                        child: Card(
                            shadowColor: Colors.black,
                            elevation: 5,
                            color: blue,
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  'EV Bus Project Progress Status',
                                  style: TextStyle(color: Colors.white),
                                )))),
                  ],
                ),
              ),

              //Asset Capitalised + Commercial Achievement

              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.96 / 2.6,
                    height: 190,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 0,
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.96 / 2.7,
                            height: 180,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 35, left: 10.0),
                                    width: MediaQuery.of(context).size.width *
                                        (0.96 / 2.8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GridView.builder(
                                            itemCount: 4,
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 5),
                                            itemBuilder: ((context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                            color: blue,
                                                            width: 1),
                                                        bottom: BorderSide(
                                                            color: blue,
                                                            width: 1))),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                            budgetVsActuals[
                                                                index],
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13))),
                                                    Container(
                                                      child: Text('Value'),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            left: 20,
                            child: Card(
                                shadowColor: Colors.black,
                                elevation: 5,
                                color: blue,
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Text(
                                      'Asset Capitalised',
                                      style: TextStyle(color: Colors.white),
                                    )))),
                      ],
                    ),
                  ),

                  //Commercial Achievement

                  Container(
                    width: MediaQuery.of(context).size.width * 0.96 / 2.6,
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 0,
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.96 / 2.7,
                            height: 190,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 25),
                                    height: 165,
                                    width: MediaQuery.of(context).size.width *
                                        0.96 /
                                        5.5,
                                    child: DataTable2(
                                        headingRowHeight: 25,
                                        headingRowColor:
                                            MaterialStatePropertyAll(blue),
                                        columnSpacing: 10,
                                        dataTextStyle: dashboardStyle,
                                        dataRowHeight: 20,
                                        headingTextStyle: TextStyle(
                                            color: white, fontSize: 10),
                                        showBottomBorder: false,
                                        dividerThickness: 0,
                                        columns: const [
                                          DataColumn2(
                                              label: Text(
                                            '% of Financial Progress\nof EV Bus Project',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 9),
                                          )),
                                          DataColumn2(
                                              label: Text(
                                            '% of pending JMR\napproval form TML',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 9),
                                          )),
                                        ],
                                        rows: List.generate(10, (index) {
                                          return DataRow2(
                                              color: index ==
                                                      Provider.of<SelectedRowIndexModel>(
                                                              context,
                                                              listen: false)
                                                          .selectedRowIndex
                                                  ? const MaterialStatePropertyAll(
                                                      Color.fromARGB(
                                                          255, 190, 226, 255))
                                                  : MaterialStatePropertyAll(
                                                      white),

                                              // onSelectChanged: (isSelected) {
                                              //   Provider.of<SelectedRowIndexModel>(
                                              //           context,
                                              //           listen: false)
                                              //       .setSelectedRowIndex(index);
                                              // },
                                              cells: const [
                                                DataCell(Text('\$100000')),
                                                DataCell(Text('Hellow World')),
                                              ]);
                                        })),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              '% of Financial Progress\nof EV Bus Project',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 11),
                                            ),
                                            RichText(
                                                text: const TextSpan(children: [
                                              WidgetSpan(
                                                  child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5),
                                                child: Icon(
                                                  Icons.arrow_upward_sharp,
                                                  size: 20,
                                                  color: Colors.green,
                                                ),
                                              )),
                                              TextSpan(
                                                  text: '48%',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15))
                                            ]))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              '% of pending JMR \napproval form TML',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 11),
                                            ),
                                            RichText(
                                                text: const TextSpan(children: [
                                              WidgetSpan(
                                                  child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5),
                                                child: Icon(
                                                  Icons.arrow_downward_sharp,
                                                  size: 20,
                                                  color: Colors.redAccent,
                                                ),
                                              )),
                                              TextSpan(
                                                  text: '48%',
                                                  style: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 15))
                                            ]))
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            left: 20,
                            child: Card(
                                shadowColor: Colors.black,
                                elevation: 5,
                                color: blue,
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Text(
                                      'Commercial Achievement',
                                      style: TextStyle(color: Colors.white),
                                    )))),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.96 / 5.5,
                height: 400,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.96 / 5.6,
                        height: 380,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Center(child: Text('Hello')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 20,
                        child: Card(
                            shadowColor: Colors.black,
                            elevation: 5,
                            color: blue,
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  'Jmr',
                                  style: TextStyle(color: Colors.white),
                                )))),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  // List<PieChartSectionData> showingSections() {
  //   return List.generate(2, (i) {
  //     final isTouch = touchIndex == i;
  //     double fontSize = isTouch ? 15 : 10;
  //     double radius = isTouch ? 80 : 60;

  //     switch (i) {
  //       case 0:
  //         return PieChartSectionData(
  //             color: Colors.amber,
  //             title: 'Hello World',
  //             titleStyle: TextStyle(fontSize: fontSize),
  //             showTitle: true,
  //             value: 10,
  //             radius: radius);
  //       case 1:
  //         return PieChartSectionData(
  //             color: Colors.blue,
  //             title: 'Hello World2',
  //             titleStyle: TextStyle(fontSize: fontSize),
  //             showTitle: true,
  //             value: 90,
  //             radius: radius);
  //     }
  //     return PieChartSectionData();
  //   });
  // }
}
