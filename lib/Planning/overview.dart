import 'package:flutter/material.dart';
import 'package:web_appllication/OverviewPages/closure_report.dart';
import 'package:web_appllication/OverviewPages/daily_project.dart';
import 'package:web_appllication/OverviewPages/depot_overview.dart';
import 'package:web_appllication/OverviewPages/monthly_project.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';
import 'package:web_appllication/OverviewPages/resource_allocation.dart';
import 'package:web_appllication/OverviewPages/safety_checklist.dart';
import 'package:web_appllication/style.dart';
import 'package:web_appllication/widgets/custom_appbar.dart';
import '../OverviewPages/detailed_Eng.dart';
import '../KeyEvents/key_events.dart';

class MyOverview extends StatefulWidget {
  String userid;
  String depoName;
  String cityName;
  MyOverview(
      {super.key,
      required this.userid,
      required this.depoName,
      required this.cityName});

  @override
  State<MyOverview> createState() => _MyOverviewState();
}

class _MyOverviewState extends State<MyOverview> {
  @override
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
  List imagedata = [
    'assets/overview_image/overview.png',
    'assets/overview_image/project_planning.png',
    'assets/overview_image/resource.png',
    'assets/overview_image/monitor.png',
    'assets/overview_image/daily_progress.png',
    'assets/overview_image/detailed_engineering.png',
    'assets/overview_image/jmr.png',
    'assets/overview_image/safety.png',
    'assets/overview_image/safety_checklist.jpeg',
    'assets/overview_image/checklist_civil.png',
    'assets/overview_image/testing_commissioning.png',
    'assets/overview_image/closure_report.png',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> desription = [
      'Overview of Project Progress Status of ${widget.depoName} EV Bus Charging Infra',
      'Project Planning & Scheduling Bus Depot Wise [Gant Chart] ',
      'Resource Allocation',
      'Monthly Project Monitoring & Review',
      'Submission of Daily Progress Report for Individual Project',
      'Detailed Engineering of Project Documents like GTP, GA Drawing',
      'Online JMR verification for projects',
      'Safety check list & observation',
      'Quality check list & observation',
      'FQP Checklist for Civil & Electrical work',
      'Testing & Commissioning Reports of Equipment',
      'Closure Report'
    ];
    pages = [
      DepotOverview(
        userid: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      KeyEvents(
        userId: widget.userid,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      ResourceAllocation(
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      MonthlyProject(
        userid: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      DailyProject(
        userId: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      DetailedEng(
        userId: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      DepotOverview(
        userid: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      SafetyChecklist(
        userId: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      QualityChecklist(
        userId: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      KeyEvents(
        userId: widget.userid,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      KeyEvents(
        userId: widget.userid,
        depoName: widget.depoName,
        cityName: widget.cityName,
      ),
      ClosureReport(
          userId: widget.userid,
          cityName: widget.cityName,
          depoName: widget.depoName)
      // KeyEvents(
      //   userId: widget.userid,
      //   depoName: widget.depoName,
      //   cityName: widget.cityName,
      // ),
    ];

    return Scaffold(
      appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: CustomAppBar(
            text: 'Overview - ${widget.cityName} - ${widget.depoName}',
            userid: widget.userid,
          ),
          preferredSize: const Size.fromHeight(50)),

      // AppBar(
      //   title: Text('Overview - ' + widget.cityName + ' - ' + widget.depoName),

      //   backgroundColor: blue,
      // ),
      body: GridView.count(
        crossAxisCount: 6,
        childAspectRatio: 0.99,
        children: List.generate(desription.length, (index) {
          return cards(desription[index], imagedata[index], index);
        }),
      ),
    );
  }

  Widget cards(String desc, String img, int index) {
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
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: blue)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(img, fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
