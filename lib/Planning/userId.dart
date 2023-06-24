// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/style.dart';
import 'package:web_appllication/widgets/custom_appbar.dart';

import 'overview.dart';

class UserId extends StatefulWidget {
  String? userid;
  String? cityName;
  String? depoName;
  UserId({super.key, required this.cityName, required this.depoName});

  @override
  State<UserId> createState() => _UserIdState();
}

class _UserIdState extends State<UserId> {
  Stream? _stream;
  @override
  void initState() {
    _stream = FirebaseFirestore.instance.collection('User').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: CustomAppBar(
          userid: widget.userid,
          text: 'All User ID',
          // icon: Icons.logout,
          haveSynced: false,
        ),
        preferredSize: const Size.fromHeight(50),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.all(5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 3),
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyOverview(
                                // userid: snapshot.data.docs[index]
                                //     ['Employee Id'],
                                depoName: widget.depoName!,
                                cityName: widget.cityName!),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        backgroundColor: blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              18,
                            ),
                            side: BorderSide(color: white))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.data.docs[index]['FirstName'] +
                            ' ' +
                            snapshot.data.docs[index]['LastName']),
                        Text('Employee ID : ' +
                            snapshot.data.docs[index]['Employee Id']),
                      ],
                    ));
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: GestureDetector(
                //     onTap: () => Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => MyOverview(
                //               userid: snapshot.data.docs[index]['Employee Id'],
                //               depoName: widget.depoName!,
                //               cityName: widget.cityName!),
                //         )),
                //     child: Container(
                //       height: 250,
                //       width: 150,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           border: Border.all(color: blue)),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text('First Name : ' +
                //               snapshot.data.docs[index]['FirstName']),
                //           Text('Employee ID : ' +
                //               snapshot.data.docs[index]['Employee Id']),
                //         ],
                //       ),
                //     ),
                //   ),
                // );
              },
            );
          } else {
            return LoadingPage();
          }
        },
      ),
    );
  }
}
