import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../style.dart';
import 'jmr_home.dart';

class Jmr extends StatefulWidget {
  String? cityName;
  String? depoName;
  Jmr({super.key, this.cityName, this.depoName});

  @override
  State<Jmr> createState() => _JmrState();
}

class _JmrState extends State<Jmr> {
  List<String> title = ['R1', 'R2', 'R3', 'R4', 'R5'];
  // List imglist = [
  //   'assets/jmr/underconstruction.jpeg',
  //   'assets/jmr/underconstruction2.jpeg',
  //   'assets/jmr/underconstruction3.jpeg',
  //   'assets/jmr/underconstruction4.jpeg',
  //   'assets/jmr/underconstruction.jpeg',
  //   'assets/jmr/underconstruction.jpeg',
  // ];
  List<Widget> screens = [
    JMRPage(),
    JMRPage(),
    JMRPage(),
    JMRPage(),
    JMRPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('${widget.cityName} / ${widget.depoName} / JMR'),
            backgroundColor: blue,
            bottom: TabBar(
              labelColor: white,
              labelStyle: buttonWhite,
              unselectedLabelColor: Colors.black,

              //indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialIndicator(
                  horizontalPadding: 24,
                  bottomLeftRadius: 8,
                  bottomRightRadius: 8,
                  color: white,
                  paintingStyle: PaintingStyle.fill),
              tabs: const [
                Tab(text: 'Civil Engineer'),
                Tab(text: 'Electrical Engineer'),
              ],
            ),
          ),
          body: TabBarView(children: [
            GridView.builder(
                itemCount: title.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 150,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return cardlist(title[index], index, title[index], 'Civil');
                }),
            GridView.builder(
                itemCount: title.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 150,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return cardlist(
                      title[index], index, title[index], 'Electrical');
                }),
          ]),
        ));
  }

  Widget cardlist(String title, int index, String title2, String Designation) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: black)),
        child: ExpansionTile(
          leading: const Icon(Icons.arrow_forward_ios),
          title: Text(title),
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JMRPage(
                        title: '$Designation-$title-JM$title2',
                        title1: title,
                        cityName: widget.cityName,
                        depoName: widget.depoName,
                      ),
                    ));
              },
              child: const Text('Create New JMR'),
              style: ElevatedButton.styleFrom(backgroundColor: blue),
            )
          ],
        ),
      ),
    );
  }

  Widget _space(double i) {
    return SizedBox(
      height: i,
    );
  }
}
