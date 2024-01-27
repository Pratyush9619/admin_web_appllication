import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:web_appllication/widgets/custom_appbar.dart';

import '../Authentication/auth_service.dart';

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
  List<String> pages = [];
  late SharedPreferences _sharedPreferences;
  // List<void Function(BuildContext)> pages = [];
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
  void initState() {
    setSharePrefence();
    super.initState();
  }

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
      'login/EVDashboard/Cities/EVBusDepot/OverviewPage/DepotOverview',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/ProjectPlanning',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/MaterialProcurement',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/DailyProgress',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/MonthlyProgress',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/DetailedEngineering',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/Jmr',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/SafetyChecklist',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/QualityChecklist',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/DepotInsightes',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/ClosureReport',
      'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/DemandEnergy',
    ];
    // List<void Function(BuildContext)> pages = [
    //   (context) => Navigator.pushNamed(context, 'login'),
    //   (context) => Navigator.pushNamed(context, 'login/EVDashboard'),

    //   (context) =>
    //       Navigator.pushNamed(context, 'login/EVDashboard/EVBusDepot/Cities'),
    //   (context) => Navigator.pushNamed(context, 'login/EVDashboard/EVBusDepot/Cities/Depots'),
    //   (context) => Navigator.pushNamed(
    //       context, 'login/EVDashboard/EVBusDepot/overviewpage'),
    //   (context) => Navigator.pushNamed(
    //       context, 'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement/DailyProgress'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement/DailyProgress/MonthlyProgress'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement/DailyProgress/MonthlyProgress/DetailedEngineering'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement/DailyProgress/MonthlyProgress/DetailedEngineering/Jmr'),

    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement/DailyProgress/MonthlyProgress/DetailedEngineering/Jmr/SafetyChecklist'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement/DailyProgress/MonthlyProgress/DetailedEngineering/Jmr/SafetyChecklist/QualityChecklist'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement/DailyProgress/MonthlyProgress/DetailedEngineering/Jmr/SafetyChecklist/QualityChecklist/DepotInsightes'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement/DailyProgress/MonthlyProgress/DetailedEngineering/Jmr/SafetyChecklist/QualityChecklist/DepotInsightes/ClosureReport'),
    //   (context) => Navigator.pushNamed(context,
    //       'login/EVDashboard/EVBusDepot/OverviewPage/DepotOverview/ProjectPlanning/MaterialProcurement/DailyProgress/MonthlyProgress/DetailedEngineering/Jmr/SafetyChecklist/QualityChecklist/DepotInsightes/ClosureReport/DemandEnergy'),

    //   // Add other functions or widgets as needed
    // ];
    // // pages = [
    // //   DepotOverview(
    // //     userid: widget.userId,
    // //     // userid: widget.userid,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //   ),
    // //   KeyEventsUser(
    // //     userId: widget.userId,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //   ),
    // //   MaterialProcurement(
    // //     userId: widget.userId,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //   ),
    // //   DailyProject(
    // //     userId: widget.userId,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //   ),
    // //   MonthlySummary(
    // //     userId: widget.userId,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //   ),
    // //   DetailedEng(
    // //     userId: widget.userId,
    // //     // userId: widget.userid,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //   ),
    // //   Jmr(
    // //     userId: widget.userId,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //   ),
    // //   SafetySummary(
    // //     userId: widget.userId,
    // //     depoName: widget.depoName,
    // //     cityName: widget.cityName,
    // //     id: 'Safety Report',
    // //   ),
    // //   QualityChecklist(
    // //     userId: widget.userId,
    // //     // userId: widget.userid,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //   ),
    // //   ViewAllPdf(
    // //       title: 'Overview Page',
    // //       cityName: widget.cityName,
    // //       depoName: widget.depoName,
    // //       docId: 'OverviewepoImages'),
    // //   ClosureSummaryTable(
    // //     userId: widget.userId,
    // //     // userId: widget.userid,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //     id: 'Closure Report',
    // //   ),
    // //   // EasyMonitoring(
    // //   //   userId: widget.userId,
    // //   //   cityName: widget.cityName,
    // //   //   depoName: widget.depoName,
    // //   // ),
    // //   EnergyManagement(
    // //     // userId: widget.userId,
    // //     cityName: widget.cityName,
    // //     depoName: widget.depoName,
    // //   )
    // // ];

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
        Navigator.pushNamed(context, pages[index]);
      }),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.height / 4,
          child: Card(
            elevation: 25,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(img, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setSharePrefence() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString('depotName', widget.depoName);
  }
}
