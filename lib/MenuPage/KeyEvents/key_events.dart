import 'package:flutter/material.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA10.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA3.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA4.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA5.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA6.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA7.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA8.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTableA9.dart';
import 'package:web_appllication/MenuPage/KeyEvents/upload.dart';
import 'package:web_appllication/MenuPage/KeyEvents/Grid_DataTable.dart';
import 'package:web_appllication/style.dart';

class KeyEvents extends StatefulWidget {
  String? depoName;
  KeyEvents({super.key, this.depoName});

  @override
  State<KeyEvents> createState() => _KeyEventsState();
}

class _KeyEventsState extends State<KeyEvents> {
  List<Widget> menuWidget = [];
  List<String> pointname = [
    'A1',
    'A2',
    'A3',
    'A4',
    'A5',
    'A6',
    'A7',
    'A8',
    'A9',
    'A10'
  ];

  List<String> titlename = [
    'Letter Of Award Received From TML.',
    'Site Survey, Job Scope Finalization & Proposed Layout Submission',
    'Detailed Engineering For Approval Of Civil & Electrical Layout, GA Drawing From TML.',
    'Site Mobilization Activity Completed.',
    'Approval Of Statutory Clearances Of BUS Depot.',
    'Procurement Of Order Finalization Completed.',
    'Receipt Of All Materials At Site',
    'Civil Infra Development Completed At Bus Depot.',
    'Electrical Infra Development Completed At Bus Depot',
    'Bus Depot Work Completed & Handover To TML'
  ];

  @override
  Widget build(BuildContext context) {
    menuWidget = [
      UploadDocument(
        depoName: widget.depoName.toString(),
      ),
      StatutoryAprovalA2(
        depoName: widget.depoName.toString(),
      ),
      StatutoryAprovalA3(
        depoName: widget.depoName.toString(),
      ),
      StatutoryAprovalA4(
        depoName: widget.depoName.toString(),
      ),
      StatutoryAprovalA5(
        depoName: widget.depoName.toString(),
      ),
      StatutoryAprovalA6(
        depoName: widget.depoName.toString(),
      ),
      StatutoryAprovalA7(
        depoName: widget.depoName.toString(),
      ),
      StatutoryAprovalA8(
        depoName: widget.depoName.toString(),
      ),
      StatutoryAprovalA9(
        depoName: widget.depoName.toString(),
      ),
      StatutoryAprovalA10(
        depoName: widget.depoName.toString(),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Events'),
        backgroundColor: blue,
      ),
      body: GridView.count(
        crossAxisCount: 6,
        children: List.generate(pointname.length, (index) {
          return cards(pointname[index], titlename[index], index);
        }),
      ),
    );
  }

  Widget cards(String point, String title, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => menuWidget[index],
              ));
        }),
        child: Container(
          height: 120,
          width: 200,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: blue)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(point),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
