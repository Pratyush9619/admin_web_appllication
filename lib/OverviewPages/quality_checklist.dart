import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class QualityChecklist extends StatefulWidget {
  String? depoName;
  String? cityName;
  QualityChecklist({super.key, this.depoName, this.cityName});

  @override
  State<QualityChecklist> createState() => _QualityChecklistState();
}

class _QualityChecklistState extends State<QualityChecklist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
