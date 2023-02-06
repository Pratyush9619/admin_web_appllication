// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:intl_phone_field/helpers.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/provider/depo_provider.dart';

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
  Color? btnColor;
  DepoProvider? _depoProvider;

  List<String> designation = [
    'Civil Engineer',
    'Electrical Engineer',
    'Project Manager',
    'Head Bussiness Operation',
    'Group Head E-Bus Project & O & M',
    'Group Head E-Bus Project',
    'Group Head Civil EV',
    'Head Civil EV',
    'Vendor',
    'Lead Quality and Safety ',
    'Lead EV- Bus Project',
    'Others'
  ];
  List<String> citydata = [];
  List<String> depodata = [];
  List<String> defaultdata = [];
  String? designValue;
  String cityValue = 'Jammu';
  var _isinit = true;

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
    FirebaseFirestore.instance.collection('CityName').get().then((value) {
      value.docs.forEach((element) {
        var data = element['CityName'];
        citydata.add(data);
      });
    });

    // getDepodata(String deponame){
    //   FirebaseFirestore.instance.collection(deponame).get().then((value) {
    //   value.docs.forEach((element) {
    //     var data = element['DepoName'];
    //     depodata.add(data);
    //   });
    // });
    // }

    // FirebaseFirestore.instance.collection(cityValue!).get().then((value) {
    //   value.docs.forEach((element) {
    //     var data = element['DepoName'];
    //     depodata.add(data);
    //   });
    // });

    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   if (_isinit) {
  //     _depoProvider =
  //         Provider.of(context)<DepoProvider>(context, listen: false);
  //     depodata = _depoProvider!.fetchData(cityValue);
  //     _isinit = false;
  //   }
  //   super.didChangeDependencies();
  // }

  // @override
  // void didChangeDependencies() {
  //   if (_inits) {
  //     FirebaseFirestore.instance.collection('Jammu').get().then((value) {
  //       value.docs.forEach((element) {
  //         var data = element['DepoName'];
  //         depodata.add(data);
  //       });
  //     });
  //   } else {
  //     FirebaseFirestore.instance.collection(cityValue).get().then((value) {
  //       value.docs.forEach((element) {
  //         var data = element['DepoName'];
  //         depodata.add(data);
  //       });
  //     });
  //   }

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // _depoProvider = Provider.of(context)<DepoProvider>(context, listen: false);
    // _depoProvider!.depolist;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: blue,
      //   title: const Text('User Page'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: blue)),
                        child: ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data!.docs[index]['FirstName'] +
                                  ' ' +
                                  snapshot.data!.docs[index]['LastName']),
                            ],
                          ),
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 120,
                                    padding: EdgeInsets.all(5),
                                    child: const Text(
                                      'Designation :',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Flexible(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GroupButton(
                                        options: const GroupButtonOptions(
                                            selectedColor: Colors.green),
                                        buttons: designation,
                                        isRadio: false,
                                        onSelected: (value, index, isSelected) {
                                          designValue = value;
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: const Text(
                                      'Cities :',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Flexible(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GroupButton(
                                        options: const GroupButtonOptions(
                                            selectedColor: Colors.green),
                                        buttons: citydata,
                                        isRadio: true,
                                        onSelected:
                                            (value, index, isSelected) async {
                                          depodata.clear();
                                          cityValue = value;
                                          await getDepodata(cityValue);
                                          setState(() {});
                                          // setState(() {
                                          //   _inits = false;
                                          // });
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 120,
                                    padding: const EdgeInsets.all(5),
                                    child: const Text(
                                      'Depots :',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Flexible(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          // Consumer<DepoProvider>(
                                          //     builder: (context, value, child) {
                                          GroupButton(
                                        options: const GroupButtonOptions(
                                            selectedColor: Colors.green),
                                        buttons: depodata,
                                        isRadio: false,
                                        onSelected:
                                            (value, index, isSelected) {},
                                      )),
                                ),
                                // )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Sync'))
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return LoadingPage();
                  });
            } else {
              return LoadingPage();
            }
          },
        ),
      ),

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

  // firebaseData() {
  //   return StreamBuilder(
  //     stream: _stream,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return ListView.builder(
  //           itemBuilder: (context, index) {
  //             if (snapshot.hasData) {
  //               for (int i = 0; i < snapshot.data.docs.length; i++) {
  //                 var data = snapshot.data['CityName'];
  //                 citydata.add(data);
  //               }
  //             }
  //           },
  //         );
  //       }
  //     },
  //   );
  // }

  getDepodata(String deponame) {
    return FirebaseFirestore.instance.collection(deponame).get().then((value) {
      value.docs.forEach((element) {
        var data = element['DepoName'];
        depodata.add(data);
      });
    });
  }
}
