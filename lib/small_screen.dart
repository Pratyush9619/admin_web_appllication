import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_appllication/MenuPage/admin.dart';
import 'package:web_appllication/MenuPage/home.dart';
import 'package:web_appllication/MenuPage/project_planning.dart';
import 'package:web_appllication/MenuPage/user.dart';
import 'package:web_appllication/style.dart';

class SmallScreen extends StatefulWidget {
  bool isDashBoard;
  final VoidCallback? uploadExcel;

  SmallScreen({super.key, this.isDashBoard = false, this.uploadExcel});

  @override
  State<SmallScreen> createState() => _SmallScreenState();
}

class _SmallScreenState extends State<SmallScreen> {
  Widget selectedScreen = const MenuHomePage();

  currentScreen(item) {
    switch (item.route) {
      case MenuHomePage.id:
        setState(() {
          selectedScreen = const MenuHomePage();
        });
        break;
      case DashBoardScreen.id:
        setState(() {
          selectedScreen = const DashBoardScreen();
        });
        break;
      case ProjectPanning.id:
        setState(() {
          selectedScreen = const ProjectPanning();
        });
        break;
      case MenuUserPage.id:
        setState(() {
          selectedScreen = const MenuUserPage();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('EV Bus Project Performance Analysis Dashboard'),
        backgroundColor: blue,
      ),
      sideBar: SideBar(
        width: 150,
        activeBackgroundColor: white,
        backgroundColor: white,
        items: const [
          AdminMenuItem(
            title: 'EV Dashboard',
            route: DashBoardScreen.id,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'O & M Dashboard',
            route: MenuHomePage.id,
            icon: Icons.home_max_outlined,
          ),
          AdminMenuItem(
            title: 'User',
            route: MenuUserPage.id,
            icon: Icons.person,
          ),
          AdminMenuItem(
            title: 'Cities',
            route: ProjectPanning.id,
            icon: Icons.location_city_outlined,
          ),
          // AdminMenuItem(
          //   title: 'Gallery',
          //   route: '/three',
          //   icon: Icons.browse_gallery_outlined,
          // ),
          // AdminMenuItem(
          //   title: 'Cities',
          //   icon: Icons.location_city,
          //   children: [
          //     AdminMenuItem(
          //       title: 'Depots',
          //       route: '/secondLevelItem1',
          //     ),
          //     AdminMenuItem(
          //       title: 'Second Level Item 2',
          //       route: '/secondLevelItem2',
          //     ),
          // AdminMenuItem(
          //   title: 'Third Level',
          //   children: [
          //     AdminMenuItem(
          //       title: 'Third Level Item 1',
          //       route: '/thirdLevelItem1',
          //     ),
          //     AdminMenuItem(
          //       title: 'Third Level Item 2',
          //       route: '/thirdLevelItem2',
          //     ),
          //   ],
          // ),
          // ],
          // ),
        ],
        selectedRoute: MenuHomePage.id,
        onSelected: (item) {
          currentScreen(item);
        },
        // header: Container(
        //   height: 50,
        //   width: double.infinity,
        //   color: const Color.fromARGB(255, 252, 249, 249),
        //   child: const Center(
        //     child: Text(
        //       'Dashboard',
        //       style: TextStyle(color: Colors.black, fontSize: 20),
        //     ),
        //   ),
        // ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Color.fromARGB(255, 252, 249, 249),
          child: const Center(
            child: Text(
              'Get data',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
      ),
      body: selectedScreen,
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Container(
      //           height: 80,
      //           alignment: Alignment.topLeft,
      //           padding: const EdgeInsets.all(10),
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(5), color: blue),
      //           child: Text(
      //             'HomePage',
      //             style: TextStyle(
      //                 fontWeight: FontWeight.w700, fontSize: 20, color: white),
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             Container(
      //               height: 120,
      //               width: 200,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   border: Border.all(color: blue)),
      //             ),
      //             Container(
      //               height: 120,
      //               width: 200,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   border: Border.all(color: blue)),
      //             ),
      //             Container(
      //               height: 120,
      //               width: 200,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   border: Border.all(color: blue)),
      //             ),
      //             Container(
      //               height: 120,
      //               width: 200,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   border: Border.all(color: blue)),
      //             )
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: 15),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             Container(
      //               height: 400,
      //               width: 400,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   border: Border.all(color: blue)),
      //             ),
      //             Container(
      //               height: 400,
      //               width: 400,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   border: Border.all(color: blue)),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: 15),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             Container(
      //               height: 400,
      //               width: 400,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   border: Border.all(color: blue)),
      //             ),
      //             Container(
      //               height: 400,
      //               width: 400,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   border: Border.all(color: blue)),
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
