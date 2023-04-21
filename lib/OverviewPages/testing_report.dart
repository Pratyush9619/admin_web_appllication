import 'package:flutter/material.dart';
import '../style.dart';

class TestingReport extends StatefulWidget {
  String? cityName;
  String? depoName;
  TestingReport({super.key, required this.cityName, required this.depoName});

  @override
  State<TestingReport> createState() => _TestingReportState();
}

class _TestingReportState extends State<TestingReport> {
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
          'Testing & Commissioning flow \n Under Process',
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
