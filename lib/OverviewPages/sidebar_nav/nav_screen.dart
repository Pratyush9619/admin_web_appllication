import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/MenuPage/user.dart';
import 'package:web_appllication/OverviewPages/ev_dashboard/ev_dashboard.dart';
import 'package:web_appllication/OverviewPages/sidebar_nav/drawer_header.dart';
import 'package:web_appllication/Planning/cities.dart';
import 'package:web_appllication/provider/demandEnergyProvider.dart';
import 'package:web_appllication/screen/demand%20energy%20management/demandScreen.dart';
import 'package:web_appllication/style.dart';

class NavigationPage extends StatefulWidget {
  String userId;
  NavigationPage({super.key, required this.userId});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool showStartEndDatePanel = false;
  var currentPage = DrawerSection.evDashboard;
  var container;
  String title = '';

  List<String> pageNames = [
    'EV Dashboard Project',
    'EV Bus Depot Management System',
    'Cities',
    'User'
  ];

  List<IconData> screenIcons = [
    Icons.dashboard,
    Icons.home_max_outlined,
    Icons.person,
    Icons.location_city_outlined
  ];

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      setState(() {
        switch (currentPage) {
          case DrawerSection.evDashboard:
            showStartEndDatePanel = false;
            title = 'EV BUS Project Performance Analysis Dashboard';
            container = const EVDashboardScreen();
            break;
          case DrawerSection.demandEnergy:
            showStartEndDatePanel = true;
            title = 'EV Bus Depot Management System';
            container = DemandEnergyScreen();
            break;
          case DrawerSection.cities:
            showStartEndDatePanel = false;

            title = 'Cities';
            container = const CitiesPage();
            break;
          case DrawerSection.users:
            showStartEndDatePanel = false;

            title = 'Users';
            container = const MenuUserPage();
            break;
        }
      });
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 45),
          child: AppBar(
            actions: [
              showStartEndDatePanel
                  ? Consumer<DemandEnergyProvider>(
                      builder: (context, providerValue, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20,
                              width: 220,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Start Date - ',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                      text: providerValue.startDate.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              height: 20,
                              width: 220,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'End Date - ',
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: providerValue.endDate.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : Container()
            ],
            title: Text(
              title,
              style: TextStyle(color: white, fontSize: 15),
            ),
            backgroundColor: blue,
            centerTitle: true,
          )),
      drawer: Drawer(
          width: 250,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                MyDrawerHeader(userId: widget.userId),
                MyDrawerList(),
              ],
            ),
          )),
      body: container,
    );
  }

  Widget MyDrawerList() {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          menuItems(1, pageNames[0], Icons.dashboard_outlined,
              currentPage == DrawerSection.evDashboard ? true : false),
          menuItems(2, pageNames[1], Icons.dashboard_sharp,
              currentPage == DrawerSection.demandEnergy ? true : false),
          menuItems(3, pageNames[2], Icons.house_outlined,
              currentPage == DrawerSection.cities ? true : false),
          menuItems(4, pageNames[3], Icons.person_2_outlined,
              currentPage == DrawerSection.users ? true : false),
        ],
      ),
    );
  }

  Widget menuItems(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected
          ? const Color.fromARGB(255, 220, 236, 249)
          : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (mounted) {
            setState(() {
              switch (id) {
                case 1:
                  currentPage = DrawerSection.evDashboard;
                  break;
                case 2:
                  currentPage = DrawerSection.demandEnergy;
                  break;
                case 3:
                  currentPage = DrawerSection.cities;
                  break;
                case 4:
                  currentPage = DrawerSection.users;
                  break;
              }
            });
          }
        },
        child: Container(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Icon(
                icon,
                color: blue,
              )),
              Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    style: TextStyle(color: blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection { evDashboard, demandEnergy, cities, users }
