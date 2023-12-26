import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:web_appllication/style.dart';

class MyDrawerList extends StatefulWidget {
  const MyDrawerList({super.key});

  @override
  State<MyDrawerList> createState() => _MyDrawerListState();
}

class _MyDrawerListState extends State<MyDrawerList> {
  List<String> pageNames = [
    'EV Dashboard Project',
    'O & M Dashboard',
    'Cities',
    'User'
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getDrawerItem(Icons.dashboard_outlined, pageNames[0]),
          getDrawerItem(Icons.dashboard_customize_sharp, pageNames[1]),
          getDrawerItem(Icons.home_max, pageNames[2]),
          getDrawerItem(Icons.verified_user, pageNames[3])
        ],
      ),
    );
  }

  Widget getDrawerItem(IconData icon, String title) {
    return InkWell(
      onTap: () {},
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
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(color: blue),
                ))
          ],
        ),
      ),
    );
  }
}
