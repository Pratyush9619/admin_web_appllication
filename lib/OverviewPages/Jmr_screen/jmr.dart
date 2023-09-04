import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:web_appllication/OverviewPages/Jmr_screen/jmr_home.dart';
import '../../components/Loading_page.dart';
import '../../style.dart';

class Jmr extends StatefulWidget {
  String? cityName;
  String? depoName;
  Jmr({super.key, this.cityName, this.depoName});

  @override
  State<Jmr> createState() => _JmrState();
}

class _JmrState extends State<Jmr> {
  List<int> jmrTabLen = [];
  int _selectedIndex = 0;
  bool isLoading = true;
  List<String> title = ['R1', 'R2', 'R3', 'R4', 'R5'];
  List<String> tabName = ['Civil', 'Electrical'];

  @override
  void initState() {
    generateAllJmrList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('${widget.cityName} / ${widget.depoName} / JMR'),
            backgroundColor: blue,
            bottom: TabBar(
              onTap: (value) {
                _selectedIndex = value;
                generateAllJmrList();
              },
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
          body: TabBarView(
              children: [customRowList('Civil'), customRowList('Electrical')]),
        ));
  }

  Widget customRowList(String nameOfTab) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('JMRCollection')
          .doc(widget.depoName)
          .collection('Table')
          .doc('${tabName[_selectedIndex]}JmrTable')
          .collection('userId')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else if (!snapshot.hasData) {
          return const Center(
              child: Text(
            'No Data Available',
          ));
        } else if (snapshot.hasError) {
          return const Center(
              child: Text(
            'Error fetching data',
          ));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          List<dynamic> userList = data.docs.map((e) => e.id).toList();

          return isLoading
              ? LoadingPage()
              : ListView.builder(
                  itemCount: userList.length, //Length of user ID
                  itemBuilder: (context, index) {
                    // generateJmrListLen(userList[index]);
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 20.0, bottom: 3.0, top: 3.0),
                      child: ExpansionTile(
                        backgroundColor: Colors.blue[500],
                        trailing: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        collapsedBackgroundColor: Colors.blue[400],
                        title: Text(
                          'User ID - ${userList[index]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index2) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 10.0, bottom: 10.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 32,
                                          child: TextButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.blue[900])),
                                              child: Text(
                                                title[index2],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 30.0,
                                        ),
                                        jmrTabList(userList[index], index2),
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    );
                  },
                );
        }
        return Container();
      },
    );
  }

  jmrTabList(String currentUserId, int currentIndex) {
    return SizedBox(
      height: 30,
      width: 1200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jmrTabLen[currentIndex], // Length from list of jmr items
        shrinkWrap: true,
        itemBuilder: (context, index3) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JMRPage(
                          title:
                              '${tabName[_selectedIndex]}-$title-JMR${index3 + 1}',
                          jmrTab: title[currentIndex],
                          cityName: widget.cityName,
                          depoName: widget.depoName,
                          showTable: true,
                          dataFetchingIndex: index3 + 1,
                          tabName: tabName[_selectedIndex],
                          userId: currentUserId,
                        ),
                      ));
                },
                child: Text(
                  'JMR${index3 + 1}',
                  style: TextStyle(color: Colors.blue[900]),
                )),
          );
        },
      ),
    );
  }

  // Function to calculate Length of JMR all components with ID

  Future<List<dynamic>> generateAllJmrList() async {
    if (isLoading == false) {
      setState(() {
        isLoading = true;
      });
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('JMRCollection')
        .doc(widget.depoName)
        .collection('Table')
        .doc('${tabName[_selectedIndex]}JmrTable')
        .collection('userId')
        .get();

    List<dynamic> userListId =
        querySnapshot.docs.map((data) => data.id).toList();

    List<int> tempList = [];

    for (int i = 0; i < userListId.length; i++) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('JMRCollection')
          .doc(widget.depoName)
          .collection('Table')
          .doc('${tabName[_selectedIndex]}JmrTable')
          .collection('userId')
          .doc(userListId[i])
          .collection('jmrTabName')
          .get();

      List<dynamic> jmrTabList =
          querySnapshot.docs.map((data) => data.id).toList();

      for (int j = 0; j < jmrTabList.length; j++) {
        QuerySnapshot jmrLen = await FirebaseFirestore.instance
            .collection('JMRCollection')
            .doc(widget.depoName)
            .collection('Table')
            .doc('${tabName[_selectedIndex]}JmrTable')
            .collection('userId')
            .doc(userListId[i])
            .collection('jmrTabName')
            .doc(jmrTabList[j])
            .collection('jmrTabIndex')
            .get();

        int jmrLength = jmrLen.docs.length;

        tempList.add(jmrLength);
      }
      jmrTabLen = tempList;
    }

    if (jmrTabLen.length < 5) {
      int tempJmrLen = jmrTabLen.length;
      int loop = 5 - tempJmrLen;
      for (int k = 0; k < loop; k++) {
        tempList.add(0);
      }
      jmrTabLen = tempList;
    }
    setState(() {
      isLoading = false;
    });

    return jmrTabLen;
  }
}
