import 'package:flutter/material.dart';
import '../style.dart';

class EasyMonitoring extends StatefulWidget {
  String? cityName;
  String? depoName;
  EasyMonitoring({super.key, required this.cityName, required this.depoName});

  @override
  State<EasyMonitoring> createState() => _EasyMonitoringState();
}

class _EasyMonitoringState extends State<EasyMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title:
            Text('${widget.cityName} / ${widget.depoName} / Testing Report '),
      ),
      body: const Center(
        child: Text(
          'Easy Monitoring of O & M Are \n Under Process',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
