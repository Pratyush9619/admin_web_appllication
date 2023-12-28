import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/provider/demandEnergyProvider.dart';
import 'package:web_appllication/style.dart';

class BarGraphScreen extends StatefulWidget {
  final List<dynamic> timeIntervalList;
  final List<dynamic> monthList;

  const BarGraphScreen({
    super.key,
    required this.timeIntervalList,
    required this.monthList,
  });

  @override
  State<BarGraphScreen> createState() => _BarGraphScreenState();
}

class _BarGraphScreenState extends State<BarGraphScreen> {
  int _selectedIndex = 0;

  List<bool> choiceChipBoolList = [true, false, false, false];

  final Gradient _barRodGradient = const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color.fromARGB(255, 16, 81, 231),
      Color.fromARGB(255, 190, 207, 252)
    ],
  );

  List<String> choiceChipLabels = ['Day', 'Monthly', 'Quaterly', 'Yearly'];
  List<String> quaterlyMonths = ['Mar', 'Jun', 'Sep', 'Dec'];
  List<String> yearlyMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  final double candleWidth = 25;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DemandEnergyProvider>(context, listen: false);

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 234, 243, 250),
                borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.only(bottom: 15, top: 10),
            child: const Text(
              'Energy Consumed (in kW)',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Consumer<DemandEnergyProvider>(
            builder: (context, providerValue, child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30, left: 80),
                        height: 30,
                        width: 320,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: choiceChipLabels.length,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return Container(
                                margin: const EdgeInsets.only(left: 2),
                                height: 30,
                                child: ChoiceChip(
                                  label: Text(
                                    choiceChipLabels[index],
                                    style: TextStyle(color: white),
                                  ),
                                  selected: choiceChipBoolList[index],
                                  selectedColor: Colors.blue,
                                  backgroundColor: blue,
                                  onSelected: provider.isLoadingBarCandle
                                      ? (_) {}
                                      : (value) {
                                          if (provider
                                              .selectedDepo.isNotEmpty) {
                                            switch (index) {
                                              case 0:
                                                _selectedIndex = 0;
                                                provider
                                                    .setLoadingBarCandle(true);
                                                break;
                                              case 1:
                                                _selectedIndex = 1;
                                                provider
                                                    .setLoadingBarCandle(true);
                                                break;
                                              case 2:
                                                _selectedIndex = 2;
                                                provider
                                                    .setLoadingBarCandle(true);
                                                break;
                                              case 3:
                                                _selectedIndex = 3;
                                                provider
                                                    .setLoadingBarCandle(true);
                                                break;
                                              default:
                                                _selectedIndex = 0;
                                            }
                                            choiceChipBoolList[index] = value;
                                            resetChoiceChip(index);
                                            providerValue.reloadWidget(true);
                                            providerValue.setSelectedIndex(
                                                _selectedIndex);
                                          } else {
                                            showCustomAlert();
                                          }
                                        },
                                ),
                              );
                            })),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Container(
            height: 450,
            width: 600,
            child: Consumer<DemandEnergyProvider>(
              builder: (context, value, child) {
                return BarChart(
                  swapAnimationCurve: Curves.easeInOut,
                  swapAnimationDuration: const Duration(
                    milliseconds: 1500,
                  ),
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    // backgroundColor: const Color.fromARGB(
                    //   255,
                    //   236,
                    //   252,
                    //   255,
                    // ),
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipRoundedRadius: 5,
                        tooltipBgColor: Colors.transparent,
                        tooltipMargin: 5,
                      ),
                    ),
                    maxY: (provider.maxEnergyConsumed ?? 0.0) + 5000,
                    minY: 0,

                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              provider.selectedIndex == 1
                                  ? widget.monthList[value.toInt()]
                                  : provider.selectedIndex == 2
                                      ? quaterlyMonths[value.toInt()]
                                      : provider.selectedIndex == 3
                                          ? yearlyMonths[value.toInt()]
                                          : widget
                                              .timeIntervalList[value.toInt()],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: false,
                      drawVerticalLine: false,
                      drawHorizontalLine: true,
                      checkToShowHorizontalLine: (value) => value % 1 == 0,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      border: const Border(
                        left: BorderSide(),
                        bottom: BorderSide(),
                      ),
                    ),
                    barGroups: provider.selectedIndex == 1
                        ? getMonthlyBarGroups()
                        : provider.selectedIndex == 2
                            ? getQuaterlyBarData()
                            : provider.selectedIndex == 3
                                ? getYearlyBarData()
                                : getBarGroups(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    final provider = Provider.of<DemandEnergyProvider>(context, listen: false);
    // print('Daily BarChart Data Extracting');
    return List.generate(
      widget.timeIntervalList.length,
      (index) {
        return BarChartGroupData(
          // groupVertically: true,
          showingTooltipIndicators: [0],
          x: index,
          barRods: [
            BarChartRodData(
              gradient: _barRodGradient,
              width: candleWidth,
              borderRadius: BorderRadius.circular(2),
              toY: provider.dailyEnergyConsumed?[index] ?? 0.0,
            ),
          ],
        );
      },
    ).toList();
  }

  List<BarChartGroupData> getMonthlyBarGroups() {
    final provider = Provider.of<DemandEnergyProvider>(context, listen: false);
    // print('Monthly BarChart Data Extracting');
    return List.generate(
      1,
      (index) {
        return BarChartGroupData(
          showingTooltipIndicators: [0],
          x: index,
          barRods: [
            BarChartRodData(
              gradient: _barRodGradient,
              width: candleWidth,
              borderRadius: BorderRadius.circular(2),
              toY: provider.monthlyEnergyConsumed ?? 0.0,
            ),
          ],
        );
      },
    ).toList();
  }

  List<BarChartGroupData> getQuaterlyBarData() {
    final provider = Provider.of<DemandEnergyProvider>(context, listen: false);
    // print('Quaterly BarChart Data Extracting');
    return List.generate(
      4,
      (index) {
        return BarChartGroupData(
          showingTooltipIndicators: [0],
          x: index,
          barRods: [
            BarChartRodData(
              gradient: _barRodGradient,
              width: candleWidth,
              borderRadius: BorderRadius.circular(2),
              toY: provider.quaterlyEnergyConsumedList?[index] ?? 0.0,
            ),
          ],
        );
      },
    ).toList();
  }

  List<BarChartGroupData> getYearlyBarData() {
    final provider = Provider.of<DemandEnergyProvider>(context, listen: false);

    // print('Yearly BarChart Data Extracting');
    return List.generate(
      12,
      (index) {
        return BarChartGroupData(
          showingTooltipIndicators: [0],
          x: index,
          barRods: [
            BarChartRodData(
              gradient: _barRodGradient,
              width: candleWidth,
              borderRadius: BorderRadius.circular(2),
              toY: provider.yearlyEnergyConsumedList?[index] ?? 0.0,
            ),
          ],
        );
      },
    ).toList();
  }

  void resetChoiceChip(index) {
    for (int i = 0; i < choiceChipBoolList.length; i++) {
      if (index != i) {
        choiceChipBoolList[i] = false;
      }
    }
  }

  Future<void> showCustomAlert() async {
    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 300,
              height: 170,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Icon(
                      Icons.warning,
                      color: Color.fromARGB(255, 240, 222, 67),
                      size: 80,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      'Please Select a Depot First',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 30,
                    margin: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(blue)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
