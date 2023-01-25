// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_appllication/components/loading_page.dart';

import '../style.dart';

class MenuUserPage extends StatefulWidget {
  static const String id = 'user-page';
  const MenuUserPage({super.key});

  @override
  State<MenuUserPage> createState() => _MenuUserPageState();
}

class _MenuUserPageState extends State<MenuUserPage> {
  bool _isfolded = true;
  bool _isfolded2 = false;
  String? userValue;
  int groupValue = 0;
  Stream? _stream;
  Stream? _stream2;

  @override
  void initState() {
    _stream = FirebaseFirestore.instance
        .collection('User')
        .orderBy('FirstName')
        .snapshots();
    _stream2 = FirebaseFirestore.instance
        .collection('CityName')
        .orderBy('CityName')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: blue,
        //   title: const Text('User Page'),
        // ),
        body: Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: blue)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'User',
                        textAlign: TextAlign.start,
                      ),
                      InkWell(onTap: (() {}), child: Icon(Icons.arrow_forward)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data!.docs[index]['FirstName'] +
                                      ' ' +
                                      snapshot.data!.docs[index]['LastName']),
                                ],
                              ),
                            );
                          });
                    } else {
                      return LoadingPage();
                    }
                  },
                ),
              ),
            ]),
      ],
    )

        //     AnimatedContainer(
        //   duration: const Duration(milliseconds: 400),
        //   width: _isfolded ? 250 : 1000,
        //   child: _isfolded2
        //       ? Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   padding: const EdgeInsets.all(8),
        //                   width: 200,
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10),
        //                       border: Border.all(color: blue)),
        //                   child: Row(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       const Text(
        //                         'User',
        //                         textAlign: TextAlign.start,
        //                       ),
        //                       InkWell(
        //                           onTap: (() {
        //                             setState(() {
        //                               _isfolded2 = false;
        //                               // _isfolded = false;
        //                             });
        //                           }),
        //                           child: Icon(Icons.arrow_forward)),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(width: 10),
        //               Expanded(
        //                 child: StreamBuilder(
        //                   stream: FirebaseFirestore.instance
        //                       .collection('User')
        //                       .orderBy('FirstName')
        //                       .snapshots(),
        //                   builder: (context, snapshot) {
        //                     if (snapshot.hasData) {
        //                       return ListView.builder(
        //                           physics: NeverScrollableScrollPhysics(),
        //                           shrinkWrap: true,
        //                           itemCount: snapshot.data!.docs.length,
        //                           itemBuilder: (context, index) {
        //                             return Padding(
        //                               padding: const EdgeInsets.all(8.0),
        //                               child: Container(
        //                                 padding: EdgeInsets.all(8),
        //                                 width: 250,
        //                                 decoration: BoxDecoration(
        //                                     borderRadius: BorderRadius.circular(10),
        //                                     border: Border.all(color: blue)),
        //                                 child: Row(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceBetween,
        //                                   children: [
        //                                     Row(
        //                                       children: [
        //                                         Text(snapshot.data!.docs[index]
        //                                                 ['FirstName'] +
        //                                             ' ' +
        //                                             snapshot.data!.docs[index]
        //                                                 ['LastName']),
        //                                       ],
        //                                     ),
        //                                     InkWell(
        //                                       onTap: () {
        //                                         setState(() {
        //                                           _isfolded = false;
        //                                         });
        //                                       },
        //                                       child: AnimatedContainer(
        //                                           duration:
        //                                               const Duration(seconds: 2),
        //                                           height: 30,
        //                                           width: 40,
        //                                           child: GestureDetector(
        //                                             onTap: (() {}),
        //                                             child: Icon(
        //                                                 Icons.arrow_forward_sharp),
        //                                           )),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             );
        //                           });
        //                     } else {
        //                       return LoadingPage();
        //                     }
        //                   },
        //                 ),
        //               ),
        //               SizedBox(width: 10),
        //               Expanded(
        //                 child: StreamBuilder(
        //                   stream: FirebaseFirestore.instance
        //                       .collection('CityName')
        //                       .orderBy('CityName')
        //                       .snapshots(),
        //                   builder: (context, snapshot) {
        //                     if (snapshot.hasData) {
        //                       return ListView.builder(
        //                           physics: NeverScrollableScrollPhysics(),
        //                           shrinkWrap: true,
        //                           itemCount: snapshot.data!.docs.length,
        //                           itemBuilder: (context, index) {
        //                             return Padding(
        //                               padding: const EdgeInsets.all(8.0),
        //                               child: Container(
        //                                 padding: EdgeInsets.all(8),
        //                                 width: 250,
        //                                 decoration: BoxDecoration(
        //                                     borderRadius: BorderRadius.circular(10),
        //                                     border: Border.all(color: blue)),
        //                                 child: Row(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceBetween,
        //                                   children: [
        //                                     Row(
        //                                       children: [
        //                                         Text(snapshot.data!.docs[index]
        //                                             ['CityName']),
        //                                       ],
        //                                     ),
        //                                     GestureDetector(
        //                                       onTap: () {
        //                                         setState(() {
        //                                           _isfolded = true;
        //                                         });
        //                                       },
        //                                       child: AnimatedContainer(
        //                                           duration:
        //                                               const Duration(seconds: 2),
        //                                           height: 30,
        //                                           width: 40,
        //                                           child: GestureDetector(
        //                                             onTap: (() {}),
        //                                             child: Icon(
        //                                                 Icons.arrow_forward_sharp),
        //                                           )),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             );
        //                           });
        //                     } else {
        //                       return LoadingPage();
        //                     }
        //                   },
        //                 ),
        //               ),
        //             ])
        //       : _isfolded
        //           ? Row(
        //               children: [
        //                 Expanded(
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Container(
        //                         padding: EdgeInsets.all(8),
        //                         decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(10),
        //                             border: Border.all(color: blue)),
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             Text('User'),
        //                             InkWell(
        //                                 onTap: () {
        //                                   _isfolded = !_isfolded;
        //                                   setState(() {});
        //                                 },
        //                                 child: Icon(Icons.arrow_forward)),
        //                           ],
        //                         )),
        //                   ),
        //                 ),
        //               ],
        //             )
        //           : Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Container(
        //                       padding: const EdgeInsets.all(8),
        //                       width: 200,
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(10),
        //                           border: Border.all(color: blue)),
        //                       child: Row(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           const Text(
        //                             'User',
        //                             textAlign: TextAlign.start,
        //                           ),
        //                           InkWell(
        //                               onTap: (() {
        //                                 setState(() {
        //                                   _isfolded = true;
        //                                 });
        //                               }),
        //                               child: Icon(Icons.arrow_forward)),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(width: 10),
        //                   Expanded(
        //                     child: StreamBuilder(
        //                       stream: FirebaseFirestore.instance
        //                           .collection('User')
        //                           .orderBy('FirstName')
        //                           .snapshots(),
        //                       builder: (context, snapshot) {
        //                         if (snapshot.hasData) {
        //                           return ListView.builder(
        //                               physics: NeverScrollableScrollPhysics(),
        //                               shrinkWrap: true,
        //                               itemCount: snapshot.data!.docs.length,
        //                               itemBuilder: (context, index) {
        //                                 return Padding(
        //                                   padding: const EdgeInsets.all(8.0),
        //                                   child: Container(
        //                                     padding: EdgeInsets.all(8),
        //                                     width: 250,
        //                                     decoration: BoxDecoration(
        //                                         borderRadius:
        //                                             BorderRadius.circular(10),
        //                                         border: Border.all(color: blue)),
        //                                     child: Row(
        //                                       mainAxisAlignment:
        //                                           MainAxisAlignment.spaceBetween,
        //                                       children: [
        //                                         Row(
        //                                           children: [
        //                                             Text(snapshot.data!.docs[index]
        //                                                     ['FirstName'] +
        //                                                 ' ' +
        //                                                 snapshot.data!.docs[index]
        //                                                     ['LastName']),
        //                                           ],
        //                                         ),
        //                                         GestureDetector(
        //                                           onTap: () {
        //                                             setState(() {
        //                                               _isfolded = true;
        //                                             });
        //                                           },
        //                                           child: AnimatedContainer(
        //                                               duration: const Duration(
        //                                                   seconds: 2),
        //                                               height: 30,
        //                                               width: 40,
        //                                               child: InkWell(
        //                                                 onTap: (() {
        //                                                   setState(() {
        //                                                     _isfolded2 = true;
        //                                                   });
        //                                                 }),
        //                                                 child: Icon(Icons
        //                                                     .arrow_forward_sharp),
        //                                               )),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 );
        //                               });
        //                         } else {
        //                           return LoadingPage();
        //                         }
        //                       },
        //                     ),
        //                   ),
        //                 ]),
        // )

        //  Center(child: Image.asset('assets/construction.jpeg')),
        );
  }

  citylist() async {
    // Future<List> fetchAllContact() async {
    //   List<dynamic> contactList = [];
    //   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
    //       .collection('collectionPath')
    //       .doc()
    //       .get();
    //   var data = documentSnapshot.data() as Map;
    //   contactList = data['data'] as List<dynamic>;
    //   return contactList;
    // }

    // return FutureBuilder<List<dynamic>>(
    //   future: fetchAllContact(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return ListView.builder(
    //         itemBuilder: (context, index) {
    //           return Text(snapshot.data![index]['Activity']);
    //         },
    //       );
    //     }
    //     return CircularProgressIndicator();
    //   },
    // );
    // return StreamBuilder(
    //     stream:
    //         FirebaseFirestore.instance.collection('collectionPath').doc().snapshots(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return GridView.builder(
    //             itemCount: snapshot.data!.length,
    //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 4),
    //             itemBuilder: (context, index) {
    //               return Padding(
    //                 padding: const EdgeInsets.all(10.0),
    //                 child: GestureDetector(
    //                   // onTap: () => onToScreen(index),
    //                   child: Stack(children: [
    //                     Column(
    //                       children: [
    //                         Container(
    //                           height: 150,
    //                           width: 150,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(20),
    //                             color: blue,
    //                             // image: DecorationImage(
    //                             //     image: NetworkImage(
    //                             //         snapshot.data!.docs[index]['ImageUrl']),
    //                             //     fit: BoxFit.cover),
    //                           ),
    //                         ),
    //                         const SizedBox(
    //                           height: 10,
    //                         ),
    //                         Text(snapshot.data!.docs[index]['Activity']),
    //                         const SizedBox(height: 5),
    //                         ElevatedButton(
    //                             style: ElevatedButton.styleFrom(
    //                                 shape: RoundedRectangleBorder(
    //                                     borderRadius:
    //                                         BorderRadius.circular(10)),
    //                                 backgroundColor: blue),
    //                             onPressed: () {
    //                               // Navigator.push(
    //                               //     context,
    //                               //     MaterialPageRoute(
    //                               //         builder: (context) => Mydepots(
    //                               //               cityName: snapshot.data!
    //                               //                   .docs[index]['CityName'],
    //                               //             )));
    //                             },
    //                             child: const Text('Add Depot'))
    //                       ],
    //                     ),
    //                   ]),
    //                 ),
    //               );
    //             });
    //       } else {
    //         return LoadingPage();
    //       }
    //     });
  }
  cards(String name) {
    bool _isfolded = true;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        // ignore: dead_code
        width: _isfolded ? 250 : 700,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: blue)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isfolded
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name),
                    Icon(Icons.arrow_forward),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('kjdjkwndjwndjwbh'),
                    Icon(Icons.arrow_forward),
                  ],
                ),
        ),
      ),
    );
  }

  // userList() {
  //   int groupValue = 0;
  //   return Row(
  //     children: [
  //       Radio(value: userValue, groupValue: groupValue, onChanged: handlevalue)
  //     ],
  //   );
  // }

  // void handlevalue(int value) {
  //   setState(() {
  //     groupValue = value;
  //   });
  // }
}
