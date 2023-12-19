import 'package:flutter/material.dart';
import 'package:web_appllication/OverviewPages/ev_dashboard/dashboard.dart';
import 'package:web_appllication/style.dart';

class SplitDashboard extends StatelessWidget {
  const SplitDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: blue,
          centerTitle: true,
          title: const Text('Dashboard'),
        ),
        preferredSize: Size.fromHeight(45),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashBoardScreen(
                                        showAppBar: true,
                                      )));
                        },
                        child: Card(
                          elevation: 15,
                          child: Container(
                            height: 300,
                            width: 600,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/ev_dashboard.png'))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 35,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(blue)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashBoardScreen(
                                            showAppBar: true,
                                          )));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashBoardScreen(
                                        showAppBar: true,
                                      )));
                        },
                        child: Card(
                          elevation: 15,
                          child: Container(
                            height: 300,
                            width: 600,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/onm_dashboard.png'))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 35,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(blue)),
                          onPressed: () {},
                          child: const Text('O & M Analysis Dashboard'),
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
              onPressed: () {},
              child: const Text('Proceed to Cities'),
            ),
          ),
        ],
      ),
    );
  }
}
