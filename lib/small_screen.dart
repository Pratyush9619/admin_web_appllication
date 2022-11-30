import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_appllication/style.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Panel'),
        backgroundColor: blue,
      ),
      sideBar: SideBar(
        backgroundColor: white,
        items: const [
          AdminMenuItem(
            title: 'Home',
            route: '/',
            icon: Icons.home_max_outlined,
          ),
          AdminMenuItem(
            title: 'Admin',
            route: '/first',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'User',
            route: '/second',
            icon: Icons.person,
          ),
          AdminMenuItem(
            title: 'Gallery',
            route: '/three',
            icon: Icons.browse_gallery_outlined,
          ),
          AdminMenuItem(
            title: 'Cities',
            icon: Icons.location_city,
            children: [
              AdminMenuItem(
                title: 'Depots',
                route: '/secondLevelItem1',
              ),
              AdminMenuItem(
                title: 'Second Level Item 2',
                route: '/secondLevelItem2',
              ),
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
            ],
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Color.fromARGB(255, 252, 249, 249),
          child: const Center(
            child: Text(
              'Dashboard',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'HomePage',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
