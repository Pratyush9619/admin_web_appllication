import 'package:flutter/material.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTable.dart';
import 'package:web_appllication/MenuPage/Planning/cities.dart';

class ProjectPanning extends StatefulWidget {
  static const String id = 'project-panning';
  const ProjectPanning({super.key});

  @override
  State<ProjectPanning> createState() => _ProjectPanningState();
}

class _ProjectPanningState extends State<ProjectPanning> {
  @override
  Widget build(BuildContext context) {
    return CitiesPage();
  }
}
