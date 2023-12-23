import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/provider/demandEnergyProvider.dart';
import 'package:web_appllication/style.dart';

class BarGraphScreen extends StatefulWidget {
  const BarGraphScreen({super.key});

  @override
  State<BarGraphScreen> createState() => _BarGraphScreenState();
}

class _BarGraphScreenState extends State<BarGraphScreen> {
  int _selectedIndex = 0;

  List<bool> choiceChipBoolList = [true, false, false, false];

  List<List<dynamic>> barData = [
    [1000, 2500, 100, 1200],
    ['4:00-10:00', '10:00-16:00', '16:00-22:00', '22:00-2:00']
  ]; // Y-axis data and time intervals

  List<String> choiceChipLabels = ['Day', 'Monthly', 'Quaterly', 'Yearly'];

  final double candleWidth = 25;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<DemandEnergyProvider>(
                builder: (context, providerValue, child) {
                  return Container(
                    margin:
                        const EdgeInsets.only(left: 30, bottom: 20, top: 20),
                    height: 30,
                    width: 400,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: choiceChipLabels.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 30,
                            child: ChoiceChip(
                              label: Text(
                                choiceChipLabels[index],
                              ),
                              selected: choiceChipBoolList[index],
                              selectedColor:
                                  const Color.fromRGBO(33, 243, 156, 1),
                              backgroundColor:
                                  const Color.fromARGB(255, 103, 216, 245),
                              onSelected: (value) {
                                switch (index) {
                                  case 0:
                                    _selectedIndex = 0;
                                    break;
                                  case 1:
                                    _selectedIndex = 1;
                                    break;
                                  case 2:
                                    _selectedIndex = 2;
                                    break;
                                  case 3:
                                    _selectedIndex = 3;
                                    break;
                                  default:
                                    _selectedIndex = 0;
                                }
                                print('Selected index: $_selectedIndex');
                                choiceChipBoolList[index] = value;
                                resetChoiceChip(index);
                                providerValue.reloadWidget(true);
                              },
                            ),
                          );
                        })),
                  );
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'Energy Consumed (in kW)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 350,
            width: 600,
            child: BarChart(
              swapAnimationCurve: Curves.bounceInOut,
              swapAnimationDuration: const Duration(milliseconds: 1000),
              BarChartData(
                backgroundColor: const Color.fromARGB(255, 236, 252, 255),
                barTouchData: BarTouchData(
                  enabled: true,
                  allowTouchBarBackDraw: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipRoundedRadius: 5,
                    tooltipBgColor: Colors.transparent,
                    tooltipMargin: 5,
                  ),
                ),
                minY: 0,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          barData[1][value.toInt()],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
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
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          barData[0][value.toInt()].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  drawHorizontalLine: false,
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  border: const Border(
                    left: BorderSide(),
                    bottom: BorderSide(),
                  ),
                ),
                maxY: 3000,
                barGroups: getBarGroups(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    return List.generate(
      barData[0].length,
      (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              borderSide: BorderSide(color: blue),
              backDrawRodData: BackgroundBarChartRodData(
                toY: 3000,
                fromY: barData[0][index],
                show: true,
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 200, 255, 247),
                    Color.fromARGB(255, 151, 255, 226)
                  ],
                ),
              ),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 16, 81, 231),
                  Color.fromARGB(255, 111, 150, 249)
                ],
              ),
              width: candleWidth,
              borderRadius: BorderRadius.circular(2),
              toY: barData[0][index],
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
}
