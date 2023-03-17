import 'package:flutter/material.dart';

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final String x;
  final double y;
  final Color y1;
}

class PieChartData {
  PieChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
