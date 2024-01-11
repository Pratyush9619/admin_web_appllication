import 'package:flutter/material.dart';
import 'package:web_appllication/OverviewPages/ev_dashboard/ev_dashboard.dart';
import 'package:web_appllication/Planning/cities.dart';
import 'package:web_appllication/components/page_routeBuilder.dart';
import 'package:web_appllication/style.dart';

class SplitDashboard extends StatelessWidget {
  String? userId;
  SplitDashboard({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          backgroundColor: blue,
          centerTitle: true,
          title: const Text('Dashboard'),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.height * 0.74,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/nav', arguments: {
                            'userId': userId,
                            'navigationPage': 'evDashBoard'
                          });
                        },
                        child: Card(
                          elevation: 15,
                          child: Container(
                            height: 300,
                            width: 600,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/ev_dashboard.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(blue)),
                            onPressed: () {
                              Navigator.pushNamed(context, '/nav', arguments: {
                                'userId': userId,
                                'navigationPage': 'evDashBoard'
                              });
                            },
                            child: const Text(
                                'EV Bus Project Analysis Dashboard')),
                      )
                    ],
                  ),
                )),
                VerticalDivider(color: blue, thickness: 2),
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/nav', arguments: {
                            'userId': userId,
                            'navigationPage': DrawerSection.oandmDashboard
                          });
                        },
                        child: Card(
                          elevation: 15,
                          child: Container(
                            height: 300,
                            width: 600,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/demand_energy.png'))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(blue)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/demand',
                                arguments: true);
                          },
                          child: const Text('EV Bus Depot Management System'),
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 35,
            width: 150,
            child: ElevatedButton(
              style:
                  ButtonStyle(backgroundColor: MaterialStatePropertyAll(blue)),
              onPressed: () {
                Navigator.push(
                    context, CustomPageRoute(page: const CitiesPage()));
                // Navigator.pushNamed(context, '/cities');
              },
              child: const Text('Proceed to Cities'),
            ),
          ),
        ],
      ),
    );
  }
}
