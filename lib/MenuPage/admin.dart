import 'package:data_table_2/data_table_2.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/provider/selected_row_index.dart';
import 'package:web_appllication/style.dart';

class DashBoardScreen extends StatefulWidget {
  static const String id = 'admin-page';
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  double totalPlannedChargers = 0;
  double totalChargersCommissioned = 0;
  double totalBalancedCharger = 0;
  double totalTprelBudget = 0;
  double totalTpevslBudget = 0;
  double totalBudget = 0;
  double totalActualExpenseTprel = 0;
  double totalActualExpenseTpevsl = 0;
  double totalActualExpense = 0;
  double totalInfraAmount = 0;
  double totalEvChargerAmount = 0;
  double totalApprovedJmrAmount = 0;
  double totalPendingJmrAmount = 0;
  double totalFinancialProgress = 0;
  double totalPendingJmrPercent = 0;
  double totalTprelAssetCapitalised = 0;
  double totalTpevslAssetCapitalised = 0;
  double totalCumulativeAssetCapitalised = 0;
  double totalPendingAssetCapitlization = 0;

  List<dynamic> evTotalList = [];
  List<dynamic> budgetTotalList = [];
  List<dynamic> actualTotalList = [];
  List<dynamic> tmlTotalList = [];
  List<dynamic> assetTotalList = [];
  List<dynamic> budgetActualTotalList = [];
  List<dynamic> commercialTotalList = [];

  List<Color> colorList = [Colors.blue, Colors.blue[900]!];

  bool isExcelSelected = false;
  int totalForAllCol = 0;
  Map<String, dynamic> evBusProgressPieData = {};
  Map<String, dynamic> budgerPieData = {};
  Map<String, dynamic> actualExpensePieData = {};
  Map<String, dynamic> assetCapitalisedPieData = {};
  Map<String, dynamic> tmlApprovedPieData = {};

  List<String> evProgressLegendNames = [
    'Chargers \n  Commisioned',
    'Balance \n Chargers'
  ];

  List<String> evBottomValue = [
    'Planned Chargers',
    'Chargers Commisioned',
    'Balance Chargers'
  ];

  List<List<String>> budgetLegendNames = [
    ['TPREL\nBudget', 'TPEVSL\nBudget', 'Total\nBuget'],
    ['Actual\nExpense TPREL', 'Actual\nExpense TPEVSL', 'Total\nActual'],
  ];

  List<List<String>> budgetActualBottomValue = [
    ['TPREL Budget', 'TPEVSL Budget', 'Total Buget'],
    ['Actual Expense TPREL', 'Actual Expense TPEVSL', 'Total Actual TPEVSL'],
  ];

  List<String> actualExpenseLegendNames = [
    'Actual Expense \n TPREL',
    'Actual Expense \n TPEVSL',
    'Total Actual \n Expense'
  ];

  List<String> assetCapitalisedLegendNames = [
    'Cumulative Asset \n Capitalised Amount (FY24)',
    'Pending Asset \n Capitalisation Amount'
  ];

  List<String> tmlApprovedLegendNames = [
    'Approved \n JMR Amount',
    'Pending \n JMR Amount'
  ];

  List<String> tmlApprovedBottomValue = [
    'Infra Amount',
    'EV chargers Amount',
    'Approved JMR Amount',
    'Pending JMR Amount'
  ];

  List<String> commercialBottomValue = [
    '% of financial Progress',
    '% of pending JMR Approval'
  ];

  double tableDataFontSize = 0;
  dynamic deviceHeight = 0;
  double fontSize = 0;
  double tableHeadingFontSize = 0;
  double chartRadius = 0;
  bool isLoading = false;

  List<dynamic> projectNameCol = [];
  int projectNameColLen = 0;
  List<dynamic> plannedChargersCol = [];
  List<dynamic> chargersComissioned = [];

  List<dynamic> budgetActualCol = [];

  List<dynamic> tprelBudgetCol = [];
  int tprelBudgetColLen = 0;
  List<dynamic> tpevslBudgetCol = [];
  List<dynamic> budgetCol = [];

  List<dynamic> actualExpenseTprelCol = [];
  List<dynamic> actualExpenseTpevslCol = [];
  List<dynamic> totalActualExpenseCol = [];

  List<dynamic> infraAmountCol = [];
  int infraAmountColLen = 0;
  List<dynamic> evChargersAmountCol = [];
  List<dynamic> totalApprovedJmrAmountCol = [];
  List<dynamic> totalPendingJmrAmountCol = [];

  List<dynamic> financialProgressCol = [];
  int financialProgressLen = 0;
  List<dynamic> pendingJmrApprovalCol = [];

  List<dynamic> assetCapitalisedTprelCol = [];
  int assetCapitalisedTprelLen = 0;
  List<dynamic> assetCapitalisedTpevslCol = [];
  List<dynamic> cumulativeAssetCapitalizedCol = [];
  List<dynamic> pendingAssetCapitalisationCol = [];

  List<String> dashboardTitle = [
    'Budget',
    'Actual Expense',
    'TML Approved JMR Status'
  ];
  List<List<String?>> secondSheetData = [];

  List<String> assetCapitalisationBottomValue = [
    ' Asset Capitalised (TPREL)',
    'Asset Capitalised (TPEVCSL)',
    'Cumulative Asset Capitalised',
    'Pending Asset Capitalised ',
  ];

  List<String> assetCapitalisation = [
    ' Asset Capitalised\nAmount(TPREL)',
    'Asset Capitalised\nAmount\n(TPEVCSL)',
    'Cumulative Asset\nCapitalised\nAmount(FY24)',
    'Pending Asset \nCapitalisation\nAmount',
  ];

  List<List<String>> dashboardColNames = [
    ['TPREL Budget\n(FY24)', 'TPEVSL Budget\n(FY24)', 'Total Buget\n(FY24)'],
    [
      'Actual Expense\n(TPREL-FY24)',
      'Actual Expense\n(TPEVSL-FY24)',
      'Total Actual\nExpense(FY24)'
    ],
    [
      'Infra Amount\n(TPREL)',
      'EV chargers\nAmount\n(TPEVCSL)',
      'Approved\nJMR Amount',
      'Pending\nJMR Amount'
    ],
    ['Project Name', "Planned Chargers", 'Chargers Commissioned']
  ];

  int touchIndex = 0;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    if (deviceHeight < 700) {
      tableDataFontSize = 8;
      tableHeadingFontSize = 8;
      chartRadius = 80;
      fontSize = 8;
    } else {
      tableDataFontSize = 8;
      tableHeadingFontSize = 8;
      chartRadius = 90;
      fontSize = 11;
    }
    return Scaffold(
      body: isLoading
          ? LoadingPage()
          : Container(
              color: const Color.fromARGB(255, 219, 239, 255),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width * 0.93 / 3,
                          height: 240,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 10,
                                  left: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.9 /
                                        3,
                                    height: 225,
                                    child: Card(
                                        elevation: 10,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              height: 40,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: 2,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5.0,
                                                                  right: 5.0,
                                                                  top: 5.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                WidgetSpan(
                                                                    child: Container(
                                                                        height:
                                                                            10,
                                                                        width:
                                                                            10,
                                                                        color: colorList[
                                                                            index])),
                                                                const WidgetSpan(
                                                                    child:
                                                                        SizedBox(
                                                                  width: 5,
                                                                )),
                                                                TextSpan(
                                                                    text: evProgressLegendNames[
                                                                        index],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            10))
                                                              ])),
                                                        );
                                                      })),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  height: 150,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.81 /
                                                      3.8,
                                                  child: DataTable2(
                                                      headingRowColor:
                                                          MaterialStatePropertyAll(
                                                              blue),
                                                      headingTextStyle: TextStyle(
                                                          color: white,
                                                          fontSize:
                                                              tableHeadingFontSize),
                                                      headingRowHeight: 25,
                                                      dataTextStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              tableDataFontSize,
                                                          color: black),
                                                      columnSpacing: 2,
                                                      showBottomBorder: false,
                                                      dividerThickness: 0,
                                                      dataRowHeight: 20,
                                                      columns: [
                                                        DataColumn2(
                                                            label: Text(
                                                          dashboardColNames[3]
                                                              [0],
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                        DataColumn2(
                                                            label: Text(
                                                          dashboardColNames[3]
                                                              [1],
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                        DataColumn2(
                                                            label: Text(
                                                          dashboardColNames[3]
                                                              [2],
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                      ],
                                                      rows: List.generate(
                                                          projectNameColLen,
                                                          (index) {
                                                        return DataRow2(
                                                            color: index ==
                                                                    Provider.of<SelectedRowIndexModel>(
                                                                            context)
                                                                        .selectedRowIndex
                                                                ? const MaterialStatePropertyAll(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        190,
                                                                        226,
                                                                        255))
                                                                : MaterialStatePropertyAll(
                                                                    white),
                                                            onTap: () {
                                                              Provider.of<SelectedRowIndexModel>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .setSelectedRowIndex(
                                                                      index);
                                                            },
                                                            // onSelectChanged: (isSelected) {
                                                            //   Provider.of<SelectedRowIndexModel>(
                                                            //           context,
                                                            //           listen: false)
                                                            //       .setSelectedRowIndex(index);
                                                            // },
                                                            cells: [
                                                              DataCell(Text(
                                                                  projectNameCol[
                                                                          index]
                                                                      .toString())),
                                                              DataCell(Text(
                                                                  plannedChargersCol[
                                                                          index]
                                                                      .toString())),
                                                              DataCell(Text(
                                                                  chargersComissioned[
                                                                          index]
                                                                      .toString())),
                                                            ]);
                                                      })),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: PieChart(
                                                    dataMap: {
                                                      dashboardColNames[3][1]:
                                                          isExcelSelected
                                                              ? double.parse(
                                                                  chargersComissioned[
                                                                      totalForAllCol])
                                                              : 0,
                                                      dashboardColNames[3][2]:
                                                          isExcelSelected
                                                              ? totalBalancedCharger
                                                              : 0,
                                                    },
                                                    legendOptions:
                                                        const LegendOptions(
                                                            showLegends: false),
                                                    animationDuration:
                                                        const Duration(
                                                            milliseconds: 1500),
                                                    chartValuesOptions:
                                                        ChartValuesOptions(
                                                      showChartValueBackground:
                                                          false,
                                                      chartValueStyle:
                                                          TextStyle(
                                                              color: white,
                                                              fontSize: 10),
                                                      showChartValuesInPercentage:
                                                          true,
                                                    ),
                                                    chartRadius: chartRadius,
                                                    colorList: colorList,
                                                    chartType: ChartType.disc,
                                                    totalValue: isExcelSelected
                                                        ? double.parse(
                                                            plannedChargersCol[
                                                                totalForAllCol])
                                                        : 0,
                                                  ),
                                                )
                                              ],
                                            ),

                                            //
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.88 /
                                                  3.2,
                                              height: 26,
                                              child: GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 5,
                                                          childAspectRatio: 16),
                                                  itemCount: 3,
                                                  itemBuilder:
                                                      (context, index3) {
                                                    return RichText(
                                                        text:
                                                            TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              '${evBottomValue[index3]}:',
                                                          style: GoogleFonts
                                                              .azeretMono(
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      black)),
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                        width: 5,
                                                      )),
                                                      TextSpan(
                                                          text: isExcelSelected
                                                              ? evTotalList[
                                                                      index3]
                                                                  .toString()
                                                              : '0',
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              color: blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                    ]));
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
                                          child: const Text(
                                            'EV Bus Project Progress Status',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          )))),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width * 0.93 / 3,
                          height: 250,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 10,
                                  left: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.9 /
                                        3,
                                    height: 225,
                                    child: Card(
                                        elevation: 10,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              height: 40,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount: 2,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5.0,
                                                                  right: 5.0,
                                                                  top: 5.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                WidgetSpan(
                                                                    child: Container(
                                                                        height:
                                                                            10,
                                                                        width:
                                                                            10,
                                                                        color: colorList[
                                                                            index])),
                                                                const WidgetSpan(
                                                                    child:
                                                                        SizedBox(
                                                                  width: 5,
                                                                )),
                                                                TextSpan(
                                                                    text: tmlApprovedLegendNames[
                                                                        index],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            8))
                                                              ])),
                                                        );
                                                      })),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  height: 150,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.81 /
                                                      3.8,
                                                  child: DataTable2(
                                                      headingRowColor:
                                                          MaterialStatePropertyAll(
                                                              blue),
                                                      headingTextStyle: TextStyle(
                                                          color: white,
                                                          fontSize:
                                                              tableHeadingFontSize),
                                                      headingRowHeight: 28,
                                                      dataTextStyle: TextStyle(
                                                          fontSize:
                                                              tableDataFontSize,
                                                          color: black),
                                                      columnSpacing: 2,
                                                      showBottomBorder: false,
                                                      dividerThickness: 0,
                                                      dataRowHeight: 20,
                                                      columns: [
                                                        DataColumn2(
                                                            label: Text(
                                                          dashboardColNames[2]
                                                              [0],
                                                          textAlign:
                                                              TextAlign.start,
                                                        )),
                                                        DataColumn2(
                                                            label: Text(
                                                          dashboardColNames[2]
                                                              [1],
                                                          textAlign:
                                                              TextAlign.start,
                                                        )),
                                                        DataColumn2(
                                                            label: Text(
                                                          dashboardColNames[2]
                                                              [2],
                                                          textAlign:
                                                              TextAlign.start,
                                                        )),
                                                        DataColumn2(
                                                            label: Text(
                                                          dashboardColNames[2]
                                                              [3],
                                                          textAlign:
                                                              TextAlign.start,
                                                        )),
                                                      ],
                                                      rows: List.generate(
                                                          infraAmountColLen,
                                                          (index) {
                                                        return DataRow2(
                                                            color: index ==
                                                                    Provider.of<SelectedRowIndexModel>(
                                                                            context)
                                                                        .selectedRowIndex
                                                                ? const MaterialStatePropertyAll(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        190,
                                                                        226,
                                                                        255))
                                                                : MaterialStatePropertyAll(
                                                                    white),
                                                            cells: [
                                                              DataCell(Text(
                                                                  '${MoneyFormatter(amount: double.parse(infraAmountCol[index]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                              DataCell(Text(
                                                                  '${MoneyFormatter(amount: double.parse(evChargersAmountCol[index]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                              DataCell(Text(
                                                                  '${MoneyFormatter(amount: double.parse(totalApprovedJmrAmountCol[index]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                              DataCell(Text(
                                                                  '${MoneyFormatter(amount: double.parse(totalPendingJmrAmountCol[index]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                            ]);
                                                      })),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: PieChart(
                                                    dataMap: {
                                                      tmlApprovedLegendNames[0]:
                                                          isExcelSelected
                                                              ? double.parse(
                                                                  totalApprovedJmrAmountCol[
                                                                      totalForAllCol])
                                                              : 0,
                                                      tmlApprovedLegendNames[1]:
                                                          isExcelSelected
                                                              ? double.parse(
                                                                  totalPendingJmrAmountCol[
                                                                      totalForAllCol])
                                                              : 0,
                                                    },
                                                    legendOptions:
                                                        const LegendOptions(
                                                            showLegends: false),
                                                    animationDuration:
                                                        const Duration(
                                                            milliseconds: 1500),
                                                    chartValuesOptions:
                                                        ChartValuesOptions(
                                                      showChartValueBackground:
                                                          false,
                                                      chartValueStyle:
                                                          TextStyle(
                                                              color: white,
                                                              fontSize: 10),
                                                      showChartValuesInPercentage:
                                                          true,
                                                    ),
                                                    chartRadius: chartRadius,
                                                    colorList: colorList,
                                                    chartType: ChartType.disc,
                                                    totalValue: isExcelSelected
                                                        ? double.parse(
                                                                totalApprovedJmrAmountCol[
                                                                    totalForAllCol]) +
                                                            double.parse(
                                                                totalPendingJmrAmountCol[
                                                                    totalForAllCol])
                                                        : 0,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.88 /
                                                  3.1,
                                              height: 26,
                                              child: GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 5,
                                                          childAspectRatio: 20),
                                                  itemCount: 4,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return RichText(
                                                        text:
                                                            TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              '${tmlApprovedBottomValue[index]}:',
                                                          style: GoogleFonts
                                                              .azeretMono(
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      black)),
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                        width: 5,
                                                      )),
                                                      TextSpan(
                                                          text: isExcelSelected
                                                              ? tmlTotalList[
                                                                      index]
                                                                  .toString()
                                                              : '0',
                                                          style: TextStyle(
                                                              fontSize: 8,
                                                              color: blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                    ]));
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
                                            dashboardTitle[2],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          )))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 240,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: ((context, index1) {
                                return Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.85 /
                                      3,
                                  height: 235,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.82 /
                                                3,
                                            height: 225,
                                            child: Card(
                                                elevation: 10,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.76,
                                                      height: 40,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ListView.builder(
                                                              scrollDirection:
                                                                  Axis
                                                                      .horizontal,
                                                              shrinkWrap: true,
                                                              itemCount: 2,
                                                              itemBuilder:
                                                                  ((context,
                                                                      index) {
                                                                return Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 5.0,
                                                                      right:
                                                                          5.0,
                                                                      top: 5.0),
                                                                  child:
                                                                      RichText(
                                                                          text: TextSpan(
                                                                              children: [
                                                                        WidgetSpan(
                                                                            child: Container(
                                                                                height: 10,
                                                                                width: 10,
                                                                                color: colorList[index])),
                                                                        const WidgetSpan(
                                                                            child:
                                                                                SizedBox(
                                                                          width:
                                                                              5,
                                                                        )),
                                                                        TextSpan(
                                                                            text:
                                                                                budgetLegendNames[index1][index],
                                                                            style: const TextStyle(color: Colors.black, fontSize: 9))
                                                                      ])),
                                                                );
                                                              })),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          height: 150,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.81 /
                                                              4.4,
                                                          child: DataTable2(
                                                              headingRowColor:
                                                                  MaterialStatePropertyAll(
                                                                      blue),
                                                              headingTextStyle:
                                                                  TextStyle(
                                                                      color:
                                                                          white,
                                                                      fontSize:
                                                                          tableHeadingFontSize),
                                                              headingRowHeight:
                                                                  25,
                                                              dataTextStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          tableDataFontSize,
                                                                      color:
                                                                          black),
                                                              columnSpacing: 2,
                                                              showBottomBorder:
                                                                  false,
                                                              dividerThickness:
                                                                  0,
                                                              dataRowHeight: 20,
                                                              columns: [
                                                                DataColumn2(
                                                                    label: Text(
                                                                  dashboardColNames[
                                                                      index1][0],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                )),
                                                                DataColumn2(
                                                                    label: Text(
                                                                  dashboardColNames[
                                                                      index1][1],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                )),
                                                                DataColumn2(
                                                                    label: Text(
                                                                  dashboardColNames[
                                                                      index1][2],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                )),
                                                              ],
                                                              rows: List.generate(
                                                                  tprelBudgetColLen,
                                                                  (index2) {
                                                                return DataRow2(
                                                                    color: index2 ==
                                                                            Provider.of<SelectedRowIndexModel>(context)
                                                                                .selectedRowIndex
                                                                        ? const MaterialStatePropertyAll(Color.fromARGB(
                                                                            255,
                                                                            190,
                                                                            226,
                                                                            255))
                                                                        : MaterialStatePropertyAll(
                                                                            white),
                                                                    cells: [
                                                                      DataCell(Text(
                                                                          '${MoneyFormatter(amount: double.parse(budgetActualCol[index1][0][index2]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                                      DataCell(Text(
                                                                          '${MoneyFormatter(amount: double.parse(budgetActualCol[index1][1][index2]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                                      DataCell(Text(
                                                                          '${MoneyFormatter(amount: double.parse(budgetActualCol[index1][2][index2]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                                    ]);
                                                              })),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: PieChart(
                                                            dataMap: {
                                                              budgetActualBottomValue[
                                                                      index1][0]:
                                                                  isExcelSelected
                                                                      ? index1 ==
                                                                              0
                                                                          ? double.parse(tprelBudgetCol[
                                                                              totalForAllCol])
                                                                          : double.parse(
                                                                              actualExpenseTprelCol[totalForAllCol])
                                                                      : 0,
                                                              budgetActualBottomValue[
                                                                      index1][1]:
                                                                  isExcelSelected
                                                                      ? index1 ==
                                                                              0
                                                                          ? double.parse(tpevslBudgetCol[
                                                                              totalForAllCol])
                                                                          : double.parse(
                                                                              actualExpenseTpevslCol[totalForAllCol])
                                                                      : 0,
                                                            },
                                                            legendOptions:
                                                                const LegendOptions(
                                                                    showLegends:
                                                                        false),
                                                            animationDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        1500),
                                                            chartValuesOptions:
                                                                ChartValuesOptions(
                                                              showChartValueBackground:
                                                                  false,
                                                              chartValueStyle:
                                                                  TextStyle(
                                                                      color:
                                                                          white,
                                                                      fontSize:
                                                                          10),
                                                              showChartValuesInPercentage:
                                                                  true,
                                                            ),
                                                            chartRadius:
                                                                chartRadius,
                                                            colorList:
                                                                colorList,
                                                            chartType:
                                                                ChartType.disc,
                                                            totalValue:
                                                                isExcelSelected
                                                                    ? index1 ==
                                                                            0
                                                                        ? double.parse(tprelBudgetCol[totalForAllCol]) +
                                                                            double.parse(tpevslBudgetCol[
                                                                                totalForAllCol])
                                                                        : index1 ==
                                                                                1
                                                                            ? double.parse(actualExpenseTprelCol[totalForAllCol]) +
                                                                                double.parse(actualExpenseTpevslCol[totalForAllCol])
                                                                            : 0
                                                                    : 0,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.88 /
                                                              3.6,
                                                      height: 26,
                                                      child: GridView.builder(
                                                          shrinkWrap: true,
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      2,
                                                                  crossAxisSpacing:
                                                                      5,
                                                                  childAspectRatio:
                                                                      16),
                                                          itemCount: 3,
                                                          itemBuilder: (context,
                                                              index3) {
                                                            return RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                      text:
                                                                          '${budgetActualBottomValue[index1][index3]} :',
                                                                      style: GoogleFonts.azeretMono(
                                                                          fontSize:
                                                                              8,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              black)),
                                                                  const WidgetSpan(
                                                                      child:
                                                                          SizedBox(
                                                                    width: 5,
                                                                  )),
                                                                  TextSpan(
                                                                      text: isExcelSelected
                                                                          ? budgetActualTotalList[index1][index3]
                                                                              .toString()
                                                                          : '0',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              9,
                                                                          color:
                                                                              blue,
                                                                          fontWeight:
                                                                              FontWeight.bold))
                                                                ]));
                                                          }),
                                                    )
                                                  ],
                                                )),
                                          )),
                                      Positioned(
                                          top: 0,
                                          left: 30,
                                          child: Card(
                                              shadowColor: Colors.black,
                                              elevation: 5,
                                              color: blue,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    dashboardTitle[index1],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  )))),
                                    ],
                                  ),
                                );
                              })),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width *
                                  0.86 /
                                  4.0,
                              height: 240,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 10,
                                    left: 0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.84 /
                                          4.2,
                                      height: 225,
                                      child: Card(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        elevation: 10,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, top: 40),
                                              height: 160,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.83 /
                                                  4.2,
                                              child: DataTable2(
                                                  headingRowHeight: 28,
                                                  headingRowColor:
                                                      MaterialStatePropertyAll(
                                                          blue),
                                                  columnSpacing: 10,
                                                  dataTextStyle: TextStyle(
                                                      fontSize:
                                                          tableDataFontSize,
                                                      color: black),
                                                  dataRowHeight: 20,
                                                  headingTextStyle: TextStyle(
                                                      color: white,
                                                      fontSize:
                                                          tableHeadingFontSize),
                                                  showBottomBorder: false,
                                                  dividerThickness: 0,
                                                  columns: const [
                                                    DataColumn2(
                                                        label: Text(
                                                      '% of Financial Progress\nof EV Bus Project',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 9),
                                                    )),
                                                    DataColumn2(
                                                        label: Text(
                                                      '% of pending JMR\napproval form TML',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 9),
                                                    )),
                                                  ],
                                                  rows: List.generate(
                                                      financialProgressLen,
                                                      (index) {
                                                    return DataRow2(
                                                        color: index ==
                                                                Provider.of<SelectedRowIndexModel>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .selectedRowIndex
                                                            ? const MaterialStatePropertyAll(
                                                                Color.fromARGB(
                                                                    255,
                                                                    190,
                                                                    226,
                                                                    255))
                                                            : MaterialStatePropertyAll(
                                                                white),

                                                        // onSelectChanged: (isSelected) {
                                                        //   Provider.of<SelectedRowIndexModel>(
                                                        //           context,
                                                        //           listen: false)
                                                        //       .setSelectedRowIndex(index);
                                                        // },
                                                        cells: [
                                                          DataCell(Text(
                                                              '${financialProgressCol[index].toString()}%')),
                                                          DataCell(Text(
                                                              '${pendingJmrApprovalCol[index]}%')),
                                                        ]);
                                                  })),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.88 /
                                                  3.1,
                                              height: 40,
                                              child: GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 5,
                                                          childAspectRatio: 5),
                                                  itemCount: 2,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            commercialBottomValue[
                                                                index],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10,
                                                                color: blue),
                                                          ),
                                                          Text(
                                                              isExcelSelected
                                                                  ? '${commercialTotalList[index].toString()}%'
                                                                  : '0%',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 10))
                                                        ],
                                                      ),
                                                    );
                                                  }),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                'Commercial Achievement',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              )))),
                                ],
                              ),
                            ),

                            //Asset Capitalized

                            Container(
                              width: MediaQuery.of(context).size.width *
                                  0.88 /
                                  2.5,
                              height: 240,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 10,
                                    left: 5,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.88 /
                                          2.55,
                                      height: 225,
                                      child: Card(
                                          elevation: 10,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.76,
                                                height: 40,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount: 2,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          return Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0,
                                                                    right: 5.0,
                                                                    top: 5.0),
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  WidgetSpan(
                                                                      child: Container(
                                                                          height:
                                                                              10,
                                                                          width:
                                                                              10,
                                                                          color:
                                                                              colorList[index])),
                                                                  const WidgetSpan(
                                                                      child:
                                                                          SizedBox(
                                                                    width: 5,
                                                                  )),
                                                                  TextSpan(
                                                                      text: assetCapitalisedLegendNames[
                                                                          index],
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              7.8))
                                                                ])),
                                                          );
                                                        })),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    height: 150,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.81 /
                                                            3.2,
                                                    child: DataTable2(
                                                        headingRowColor:
                                                            MaterialStatePropertyAll(
                                                                blue),
                                                        headingTextStyle: TextStyle(
                                                            color: white,
                                                            fontSize:
                                                                tableHeadingFontSize),
                                                        headingRowHeight: 30,
                                                        dataTextStyle: TextStyle(
                                                            fontSize:
                                                                tableDataFontSize,
                                                            color: black),
                                                        columnSpacing: 2,
                                                        showBottomBorder: false,
                                                        dividerThickness: 0,
                                                        dataRowHeight: 20,
                                                        columns: [
                                                          DataColumn2(
                                                              label: Text(
                                                            assetCapitalisation[
                                                                0],
                                                            textAlign:
                                                                TextAlign.start,
                                                          )),
                                                          DataColumn2(
                                                              label: Text(
                                                            assetCapitalisation[
                                                                1],
                                                            textAlign:
                                                                TextAlign.start,
                                                          )),
                                                          DataColumn2(
                                                              label: Text(
                                                            assetCapitalisation[
                                                                2],
                                                            textAlign:
                                                                TextAlign.start,
                                                          )),
                                                          DataColumn2(
                                                              label: Text(
                                                            assetCapitalisation[
                                                                3],
                                                            textAlign:
                                                                TextAlign.start,
                                                          )),
                                                        ],
                                                        rows: List.generate(
                                                            assetCapitalisedTprelLen,
                                                            (index) {
                                                          return DataRow2(
                                                              color: index ==
                                                                      Provider.of<SelectedRowIndexModel>(
                                                                              context)
                                                                          .selectedRowIndex
                                                                  ? const MaterialStatePropertyAll(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          190,
                                                                          226,
                                                                          255))
                                                                  : MaterialStatePropertyAll(
                                                                      white),
                                                              cells: [
                                                                DataCell(Text(
                                                                    '${MoneyFormatter(amount: double.parse(assetCapitalisedTprelCol[index]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                                DataCell(Text(
                                                                    '${MoneyFormatter(amount: double.parse(assetCapitalisedTpevslCol[index]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                                DataCell(Text(
                                                                    '${MoneyFormatter(amount: double.parse(cumulativeAssetCapitalizedCol[index]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                                DataCell(Text(
                                                                    '${MoneyFormatter(amount: double.parse(pendingAssetCapitalisationCol[index]), settings: MoneyFormatterSettings(symbol: '₹')).output.nonSymbol}')),
                                                              ]);
                                                        })),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: PieChart(
                                                        dataMap: {
                                                          assetCapitalisedLegendNames[
                                                                  0]:
                                                              isExcelSelected
                                                                  ? double.parse(
                                                                      cumulativeAssetCapitalizedCol[
                                                                          totalForAllCol])
                                                                  : 0,
                                                          assetCapitalisedLegendNames[
                                                                  1]:
                                                              isExcelSelected
                                                                  ? double.parse(
                                                                      pendingAssetCapitalisationCol[
                                                                          totalForAllCol])
                                                                  : 0,
                                                        },
                                                        legendOptions:
                                                            const LegendOptions(
                                                                showLegends:
                                                                    false),
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    1500),
                                                        chartValuesOptions:
                                                            ChartValuesOptions(
                                                          showChartValueBackground:
                                                              false,
                                                          chartValueStyle:
                                                              TextStyle(
                                                                  color: white,
                                                                  fontSize: 10),
                                                          showChartValuesInPercentage:
                                                              true,
                                                        ),
                                                        chartRadius:
                                                            chartRadius,
                                                        colorList: colorList,
                                                        chartType:
                                                            ChartType.disc,
                                                        totalValue: isExcelSelected
                                                            ? double.parse(
                                                                    cumulativeAssetCapitalizedCol[
                                                                        totalForAllCol]) +
                                                                double.parse(
                                                                    pendingAssetCapitalisationCol[
                                                                        totalForAllCol])
                                                            : 0),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9 /
                                                    2.8,
                                                height: 26,
                                                child: GridView.builder(
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            crossAxisSpacing: 5,
                                                            childAspectRatio:
                                                                20),
                                                    itemCount: 4,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return RichText(
                                                          text: TextSpan(
                                                              children: [
                                                            TextSpan(
                                                                text:
                                                                    assetCapitalisationBottomValue[
                                                                        index],
                                                                style: GoogleFonts.azeretMono(
                                                                    fontSize: 8,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        black)),
                                                            const WidgetSpan(
                                                                child: SizedBox(
                                                              width: 5,
                                                            )),
                                                            TextSpan(
                                                                text: isExcelSelected
                                                                    ? assetTotalList[
                                                                            index]
                                                                        .toString()
                                                                    : '0',
                                                                style: TextStyle(
                                                                    fontSize: 9,
                                                                    color: blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))
                                                          ]));
                                                    }),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      left: 25,
                                      child: Card(
                                          shadowColor: Colors.black,
                                          elevation: 5,
                                          color: blue,
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                'Asset Capitalised',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              )))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickAndProcessFile,
        child: const Icon(Icons.add),
      ),
    );
  }

  void pickAndProcessFile() async {
    List<List<dynamic>> tempList1 = [];
    List<List<dynamic>> tempList2 = [];

    try {
      setState(() {
        isLoading = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        isExcelSelected = true;
        final List<int> bytes = result.files.single.bytes!;
        final excel = Excel.decodeBytes(bytes);
        var sheet1 = excel.tables.keys.elementAt(0);

        for (var row in excel.tables[sheet1]!.rows.skip(2)) {
          projectNameCol.add(row[1]?.value.toString());
          plannedChargersCol.add(row[2]?.value.toString());
          chargersComissioned.add(row[3]?.value.toString());

          tprelBudgetCol.add(double.parse(row[4]?.value.toString() ?? "")
              .toStringAsFixed(2)
              .toString());
          tpevslBudgetCol.add(double.parse(row[5]?.value.toString() ?? "")
              .toStringAsFixed(2)
              .toString());
          budgetCol.add(double.parse(row[6]?.value.toString() ?? "")
              .toStringAsFixed(2)
              .toString());

          actualExpenseTprelCol.add(double.parse(row[7]?.value.toString() ?? "")
              .toStringAsFixed(2)
              .toString());
          actualExpenseTpevslCol.add(
              double.parse(row[8]?.value.toString() ?? "")
                  .toStringAsFixed(2)
                  .toString());
          totalActualExpenseCol.add(double.parse(row[9]?.value.toString() ?? "")
              .toStringAsFixed(2)
              .toString());

          infraAmountCol.add(double.parse(row[10]?.value.toString() ?? "")
              .toStringAsFixed(2)
              .toString());
          evChargersAmountCol.add(double.parse(row[11]?.value.toString() ?? "")
              .toStringAsFixed(2)
              .toString());
          totalApprovedJmrAmountCol.add(
              double.parse(row[12]?.value.toString() ?? "")
                  .toStringAsFixed(2)
                  .toString());

          totalPendingJmrAmountCol.add(
              double.parse(row[13]?.value.toString() ?? "")
                  .toStringAsFixed(2)
                  .toString());

          financialProgressCol.add(double.parse(row[14]?.value.toString() ?? "")
              .toStringAsFixed(2)
              .toString());

          pendingJmrApprovalCol.add(
              double.parse(row[15]?.value.toString() ?? "")
                  .toStringAsFixed(2)
                  .toString());

          assetCapitalisedTprelCol.add(
              double.parse(row[16]?.value.toString() ?? "")
                  .toStringAsFixed(2)
                  .toString());
          assetCapitalisedTpevslCol.add(
              double.parse(row[17]?.value.toString() ?? "")
                  .toStringAsFixed(2)
                  .toString());
          cumulativeAssetCapitalizedCol.add(
              double.parse(row[18]?.value.toString() ?? "")
                  .toStringAsFixed(2)
                  .toString());
          pendingAssetCapitalisationCol.add(
              double.parse(row[19]?.value.toString() ?? "")
                  .toStringAsFixed(2)
                  .toString());
        }

        tempList1.add(tprelBudgetCol);
        tempList1.add(tpevslBudgetCol);
        tempList1.add(budgetCol);

        tempList2.add(actualExpenseTprelCol);
        tempList2.add(actualExpenseTpevslCol);
        tempList2.add(totalActualExpenseCol);

        budgetActualCol.add(tempList1);
        budgetActualCol.add(tempList2);

        totalForAllCol = plannedChargersCol.length - 1;
        projectNameColLen = projectNameCol.length - 1;
        tprelBudgetColLen = tprelBudgetCol.length - 1;
        infraAmountColLen = infraAmountCol.length - 1;
        financialProgressLen = financialProgressCol.length - 1;
        assetCapitalisedTprelLen = assetCapitalisedTprelCol.length - 1;

        totalPlannedChargers = double.parse(plannedChargersCol[totalForAllCol]);
        totalChargersCommissioned =
            double.parse(chargersComissioned[totalForAllCol]);
        totalBalancedCharger = totalPlannedChargers - totalChargersCommissioned;

        evTotalList.add(totalPlannedChargers);
        evTotalList.add(totalChargersCommissioned);
        evTotalList.add(totalBalancedCharger);

        totalTprelBudget = double.parse(tprelBudgetCol[totalForAllCol]);
        totalTpevslBudget = double.parse(tpevslBudgetCol[totalForAllCol]);
        totalBudget = double.parse(budgetCol[totalForAllCol]);

        budgetTotalList.add(totalTprelBudget);
        budgetTotalList.add(totalTpevslBudget);
        budgetTotalList.add(totalBudget);

        totalActualExpenseTprel =
            double.parse(actualExpenseTprelCol[totalForAllCol]);
        totalActualExpenseTpevsl =
            double.parse(actualExpenseTpevslCol[totalForAllCol]);
        totalActualExpense =
            double.parse(totalActualExpenseCol[totalForAllCol]);

        actualTotalList.add(totalActualExpenseTprel);
        actualTotalList.add(totalActualExpenseTpevsl);
        actualTotalList.add(totalActualExpense);

        totalInfraAmount = double.parse(infraAmountCol[totalForAllCol]);
        totalEvChargerAmount =
            double.parse(evChargersAmountCol[totalForAllCol]);
        totalApprovedJmrAmount =
            double.parse(totalApprovedJmrAmountCol[totalForAllCol]);
        totalPendingJmrAmount =
            double.parse(totalPendingJmrAmountCol[totalForAllCol]);

        tmlTotalList.add(totalInfraAmount);
        tmlTotalList.add(totalEvChargerAmount);
        tmlTotalList.add(totalApprovedJmrAmount);
        tmlTotalList.add(totalPendingJmrAmount);

        totalFinancialProgress =
            double.parse(financialProgressCol[totalForAllCol]);
        totalPendingJmrPercent =
            double.parse(pendingJmrApprovalCol[totalForAllCol]);

        commercialTotalList.add(totalFinancialProgress);
        commercialTotalList.add(totalPendingJmrPercent);

        totalTprelAssetCapitalised =
            double.parse(assetCapitalisedTprelCol[totalForAllCol]);
        totalTpevslAssetCapitalised =
            double.parse(assetCapitalisedTpevslCol[totalForAllCol]);
        totalCumulativeAssetCapitalised =
            double.parse(cumulativeAssetCapitalizedCol[totalForAllCol]);
        totalPendingAssetCapitlization =
            double.parse(pendingAssetCapitalisationCol[totalForAllCol]);

        assetTotalList.add(totalTprelAssetCapitalised);
        assetTotalList.add(totalTpevslAssetCapitalised);
        assetTotalList.add(totalCumulativeAssetCapitalised);
        assetTotalList.add(totalPendingAssetCapitlization);

        budgetActualTotalList.add(budgetTotalList);
        budgetActualTotalList.add(actualTotalList);
      } else {
        // User canceled the picker
      }

      setState(() {
        isLoading = false;
      });
    } catch (e, stackTrace) {
      print('Error decoding Excel file: $e');
      print(stackTrace);
      // Handle the error as needed
    }
  }
}
