import 'package:flutter/material.dart';
import 'package:web_appllication/MenuPage/KeyEvents/progress_page.dart';
import 'package:web_appllication/style.dart';

import '../KeyEvents/key_events.dart';

class MyOverview extends StatefulWidget {
  String depoName;
  String cityName;
  MyOverview({super.key, required this.depoName, required this.cityName});

  @override
  State<MyOverview> createState() => _MyOverviewState();
}

class _MyOverviewState extends State<MyOverview> {
  List<Widget> pages = [];
  List<IconData> icondata = [
    Icons.search_off_outlined,
    Icons.play_lesson_rounded,
    Icons.chat_bubble_outline_outlined,
    Icons.book_online_rounded,
    Icons.notes,
    Icons.track_changes_outlined,
    Icons.domain_verification,
    Icons.list_alt_outlined,
    Icons.electric_bike_rounded,
    Icons.text_snippet_outlined,
    Icons.monitor_outlined,
  ];
  List<String> desription = [
    'Overview of Project Progress Status of Shivaji Nagar EV Bus Charging Infra',
    'Project Planning & Scheduling Bus Depot Wise [Gant Chart] ',
    'Resource Allocation Planning',
    'Monthly Project Monitoring & Review',
    'Submission of Daily Progress Report for Individual Project',
    'Tracking of Individual Project Progress (SI No 2 & 6 S1 No.link)',
    'Online JMR verification for projects',
    'Safety check list & observation',
    'FQP Checklist for Civil & Electrical work',
    'Testing & Commissioning Reports of Equipment',
    'Easy monitoring of O & M schedule for all the equipment of depots.'
  ];
  @override
  Widget build(BuildContext context) {
    pages = [
      const ProgressPage(),
      KeyEvents(
        depoName: widget.depoName,
      ),
      KeyEvents(),
      KeyEvents(),
      KeyEvents(),
      KeyEvents(),
      ProgressPage(),
      KeyEvents(),
      KeyEvents(),
      KeyEvents(),
      KeyEvents(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Overview - ' + widget.cityName + ' - ' + widget.depoName),
        backgroundColor: blue,
      ),
      body: GridView.count(
        crossAxisCount: 6,
        children: List.generate(desription.length, (index) {
          return cards(desription[index], icondata[index], index);
        }),
      ),
    );
  }

  Widget cards(String desc, IconData icons, int index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pages[index],
              ));
        }),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: blue)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icons),
              const SizedBox(height: 10),
              Text(
                desc,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
