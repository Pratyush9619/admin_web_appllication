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
    Icons.monitor_outlined,
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
      'Depot Insides',
      'Closure Report',
      'Easy monitoring of O & M schedule for all the equipment of depots.',
    ];
    pages = [
      DepotOverview(
        userid: widget.userId,
        // userid: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      // StatutoryAprovalA2(
      //   depoName: widget.depoName,
      //   cityName: widget.cityName,
      // ),
      KeyEventsUser(
        userId: widget.userId,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      // KeyEvents(
      //   depoName: widget.depoName,
      //   cityName: widget.cityName,
      // ),
      MaterialProcurement(
        userId: widget.userId,
        cityName: widget.cityName,
        depoName: widget.depoName,
      ),
      // ResourceAllocation(
      //   depoName: widget.depoName,
      //   cityName: widget.cityName,
      // ),
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
      // MonthlyProject(
      //   cityName: widget.cityName,
      //   depoName: widget.depoName,
      // ),
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
      // SafetyChecklist(
      //   // userId: widget.userid,
      //   cityName: widget.cityName,
      //   depoName: widget.depoName,
      // ),
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
      // TestingReport(
      //   userId: widget.userId,
      //   cityName: widget.cityName,
      //   depoName: widget.depoName,
      // ),
      ClosureSummaryTable(
        userId: widget.userId,
        // userId: widget.userid,
        cityName: widget.cityName,
        depoName: widget.depoName,
        id: 'Closure Report',
      ),

      EasyMonitoring(
        userId: widget.userId,
        cityName: widget.cityName,
        depoName: widget.depoName,
      )
      // KeyEvents(
      //   // userId: widget.userid,
      //   depoName: widget.depoName,
      //   cityName: widget.cityName,
      // ),
    ];

    return Scaffold(
      appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: CustomAppBar(
            showDepoBar: true,
            toMainOverview: true,
            cityName: widget.cityName,
            userId: widget.userId,
            text: 'Overview - ${widget.cityName} - ${widget.depoName}',
            depoName: widget.depoName,
            // userid: widget.userid,
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
