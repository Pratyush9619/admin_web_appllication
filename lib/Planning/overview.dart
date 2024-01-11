import 'package:flutter/material.dart';
import 'package:web_appllication/KeyEvents/Grid_DataTableA2.dart';
import 'package:web_appllication/OverviewPages/closure_report.dart';
import 'package:web_appllication/OverviewPages/daily_project.dart';
import 'package:web_appllication/OverviewPages/depot_overview.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';
import 'package:web_appllication/OverviewPages/resource_allocation.dart';
import 'package:web_appllication/OverviewPages/safety_summary.dart';
import 'package:web_appllication/style.dart';
import 'package:web_appllication/widgets/custom_appbar.dart';
import '../KeyEvents/key_eventsUser.dart';
import '../KeyEvents/view_AllFiles.dart';
import '../OverviewPages/closure_summary_table.dart';
import '../OverviewPages/detailed_Eng.dart';
import '../KeyEvents/key_events.dart';
import '../OverviewPages/easy_monitoring.dart';
import '../OverviewPages/Jmr_screen/jmr.dart';
import '../OverviewPages/energy_management.dart';
import '../OverviewPages/material_vendor.dart';
import '../OverviewPages/monthly_summary.dart';
import '../OverviewPages/testing_report.dart';

class MyOverview extends StatefulWidget {
  String? userId;
  String depoName;
  String cityName;
  MyOverview(
      {super.key, required this.depoName, required this.cityName, this.userId});

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
    // Icons.monitor_outlined,
  ];
  List imagedata = [
    'assets/overview_image/overview.png',
    'assets/overview_image/project_planning.png',
    'assets/overview_image/resource.png',
    'assets/overview_image/daily_progress.png',
    'assets/overview_image/monthly.png',
    'assets/overview_image/detailed_engineering.png',
    'assets/overview_image/jmr.png',
    // 'assets/overview_image/safety.png',
    'assets/overview_image/safety.png',
    'assets/overview_image/quality.png',
    // 'assets/overview_image/testing_commissioning.png',
    'assets/overview_image/testing_commissioning.png',
    'assets/overview_image/closure_report.png',
    'assets/overview_image/easy_monitoring.jpg',
    // 'assets/overview_image/overview.png',
    // 'assets/overview_image/project_planning.png',
    // 'assets/overview_image/resource.png',
    // 'assets/overview_image/monitor.png',
    // 'assets/overview_image/detailed_engineering.png',
    // 'assets/overview_image/daily_progress.png',
    // 'assets/overview_image/jmr.png',
    // 'assets/overview_image/safety.png',
    // 'assets/overview_image/safety_checklist.jpeg',
    // 'assets/overview_image/checklist_civil.png',
    // 'assets/overview_image/testing_commissioning.png',
    // 'assets/overview_image/closure_report.png',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> desription = [
      'Overview of Project Progress Status of ${widget.depoName} EV Bus Charging Infra',
      'Project Planning & Scheduling Bus Depot Wise [Gant Chart] ',
      'Material Procurement & Vendor Finalization Status',
      'Submission of Daily Progress Report for Individual Project',
      'Monthly Project Monitoring & Review',
      'Detailed Engineering Of Project Documents like GTP, GA Drawing',
      'Online JMR verification for projects',
      'Safety check list & observation',
      'FQP Checklist for Civil,Electrical work & Quality Checklist',
      'Depot Insightes',
      'Closure Report',
      'Depot Demand Energy Management',
    ];
    pages = [
      DepotOverview(
        userid: widget.userId,
        // userid: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      KeyEventsUser(
        userId: widget.userId,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      MaterialProcurement(
        userId: widget.userId,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      DailyProject(
        userId: widget.userId,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      MonthlySummary(
        userId: widget.userId,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      DetailedEng(
        userId: widget.userId,
        // userId: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      Jmr(
        userId: widget.userId,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      SafetySummary(
        userId: widget.userId,
        depoName: widget.depoName,
        cityName: widget.cityName,
        id: 'Safety Report',
      ),
      QualityChecklist(
        userId: widget.userId,
        // userId: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      ViewAllPdf(
          title: 'Overview Page',
          cityName: widget.cityName,
          depoName: widget.depoName,
          docId: 'OverviewepoImages'),
      ClosureSummaryTable(
        userId: widget.userId,
        // userId: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
        id: 'Closure Report',
      ),
      // EasyMonitoring(
      //   userId: widget.userId,
      //   cityName: widget.cityName,
      //   depoName: widget.depoName,
      // ),
      EnergyManagement(
        userId: widget.userId,
        cityName: widget.cityName,
        depoName: widget.depoName,
      )
    ];

    return Scaffold(
      appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: CustomAppBar(
            showDepoBar: true,
            toMainOverview: true,
            cityName: widget.cityName,
            userId: widget.userId,
            text: 'Overview/${widget.cityName}/${widget.depoName}',
            depoName: widget.depoName,
            // userid: widget.userid,
          ),
          preferredSize: const Size.fromHeight(50)),
      body: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.5,
        children: List.generate(desription.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: cards(desription[index], imagedata[index], index),
          );
        }),
      ),
    );
  }

  Widget cards(String desc, String img, int index) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pages[index],
            ));
      }),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: blue,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]),
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
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
