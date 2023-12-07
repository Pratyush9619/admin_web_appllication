import 'package:flutter/material.dart';
import 'package:web_appllication/MenuPage/project_planning.dart';
import 'package:web_appllication/MenuPage/user.dart';
import 'package:web_appllication/style.dart';

import 'admin.dart';
import 'home.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<IconData> screenIcons = [
    Icons.dashboard,
    Icons.home_max_outlined,
    Icons.person,
    Icons.location_city_outlined
  ];

  List<Widget> selectedScreens = [
    DashBoardScreen(),
    MenuHomePage(),
    ProjectPanning(),
    MenuUserPage()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  NavigationWidget(
                    icon: screenIcons[0],
                    title: 'EV Dashboard Project',
                    index: 0,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                  ),
                  NavigationWidget(
                    icon: screenIcons[1],
                    title: 'O & M Dashboard',
                    index: 1,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                  NavigationWidget(
                    icon: screenIcons[2],
                    title: 'User',
                    index: 2,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                  ),
                  NavigationWidget(
                    icon: screenIcons[3],
                    title: 'Cities',
                    index: 3,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Flexible(flex: 8, child: selectedScreens[selectedIndex]),
        ],
      ),
    );
  }
}

class NavigationWidget extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final Function onTap;
  final IconData icon;

  NavigationWidget(
      {required this.title,
      required this.index,
      required this.selectedIndex,
      required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 40,
        color: index == selectedIndex
            ? const Color.fromARGB(255, 201, 227, 248)
            : null,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Icon(
                icon,
                size: 16,
                color: index == selectedIndex ? black : blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title,
                style: TextStyle(
                    color: index == selectedIndex ? black : blue, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
