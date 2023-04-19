// ignore_for_file: dead_code
import 'package:advanced_search/advanced_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
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
  int _crossaxiscount = 5;
  double _expansionheight = 50;
  String? userValue;
  int groupValue = 0;
  Stream? _stream;
  Stream? _stream2;
  Color? btnColor;
  DepoProvider? _depoProvider;

  List<String> selecteddesignation = [];
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
  List<String> cardTitle = [
    'Total User',
    'Assigned User',
    'Unassigned User',
  ];
  List<Color> cardColor = [
    Colors.blue,
    Colors.green,
    Colors.grey,
    Colors.red,
  ];
  List<String> citydata = [];
  List<String> depodata = [];
  String? designValue;
  String cityValue = 'Jammu';
  var _isinit = true;

  List<String> _testList = [];
  TextEditingController myController = TextEditingController();

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

    super.initState();
    getUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: blue,
      //   title: const Text('User Page'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / .4, crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return UserCard('15', cardTitle[index], cardColor[index]);
                },
              ),
            ),
            Flexible(
              child: StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          return ExpansionTile(
                            title: ListTile(
                              title: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: blue)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data!.docs[index]
                                            ['FirstName'] +
                                        ' ' +
                                        snapshot.data!.docs[index]['LastName']),
                                  ],
                                ),
                              ),
                              leading: CircleAvatar(
                                child: Text(snapshot
                                    .data!.docs[index]['FirstName']
                                    .toString()
                                    .trim()
                                    .split('')
                                    .take(1)
                                    .first),
                              ),
                            ),
                            onExpansionChanged: (value) {},
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        'Designation :',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GroupButton(
                                          options: const GroupButtonOptions(
                                              selectedColor: Colors.green),
                                          buttons: designation,
                                          isRadio: false,
                                          onSelected:
                                              (value, index, isSelected) {
                                            designValue = value;
                                            selecteddesignation
                                                .add(designValue.toString());
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
                                          isRadio: false,
                                          onSelected:
                                              (value, index, isSelected) async {
                                            print(isSelected);
                                            if (isSelected) {
                                              cityValue = value;
                                              await getDepodata(cityValue);
                                              setState(() {});
                                            } else {
                                              depodata.clear();
                                              setState(() {});
                                            }

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
                                      width: 150,
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.all(5),
                                      child: const Text(
                                        'Reporting Manager:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 200,
                                        child: Form(
                                            child: AdvancedSearch(
                                          searchItems: _testList,
                                          maxElementsToDisplay: 10,
                                          singleItemHeight: 50,
                                          borderColor: Colors.grey,
                                          minLettersForSearch: 0,
                                          selectedTextColor: Color(0xFF3363D9),
                                          fontSize: 14,
                                          borderRadius: 12.0,
                                          hintText: 'Search Me',
                                          cursorColor: Colors.blueGrey,
                                          autoCorrect: false,
                                          focusedBorderColor: Colors.blue,
                                          searchResultsBgColor: Color(0xFAFAFA),
                                          disabledBorderColor: Colors.cyan,
                                          enabledBorderColor: Colors.black,
                                          enabled: true,
                                          caseSensitive: false,
                                          inputTextFieldBgColor: Colors.white10,
                                          clearSearchEnabled: true,
                                          itemsShownAtStart: 10,
                                          searchMode: SearchMode.CONTAINS,
                                          showListOfResults: true,
                                          unSelectedTextColor: Colors.black54,
                                          verticalPadding: 10,
                                          horizontalPadding: 10,
                                          hideHintOnTextInputFocus: true,
                                          hintTextColor: Colors.grey,
                                          searchItemsWidget: searchWidget,
                                          onItemTap: (index, value) {
                                            print(
                                                "selected item Index is $index");
                                          },
                                          onSearchClear: () {
                                            print("Cleared Search");
                                          },
                                          onSubmitted: (value, value2) {
                                            print("Submitted: " + value);
                                          },
                                          onEditingProgress: (value, value2) {
                                            print("TextEdited: " + value);
                                            print("LENGTH: " +
                                                value2.length.toString());
                                          },
                                        )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  )
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
                          );
                        } else {
                          return LoadingPage();
                        }
                      },
                    );

                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: snapshot.data!.docs.length,
                    //     itemBuilder: (context, index) {
                    //       if (snapshot.hasData) {
                    //         return Container(
                    //           margin: EdgeInsets.all(5),
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               border: Border.all(color: blue)),
                    //           child: ExpansionTile(
                    //             title: Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(snapshot.data!.docs[index]['FirstName'] +
                    //                     ' ' +
                    //                     snapshot.data!.docs[index]['LastName']),
                    //               ],
                    //             ),
                    //             children: [
                    //               Row(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                       width: 120,
                    //                       padding: EdgeInsets.all(5),
                    //                       child: const Text(
                    //                         'Designation :',
                    //                         style: TextStyle(
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   const SizedBox(width: 15),
                    //                   Flexible(
                    //                     child: Container(
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.all(8.0),
                    //                         child: GroupButton(
                    //                           options: const GroupButtonOptions(
                    //                               selectedColor: Colors.green),
                    //                           buttons: designation,
                    //                           isRadio: false,
                    //                           onSelected: (value, index, isSelected) {
                    //                             designValue = value;
                    //                           },
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //               Row(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                       padding: EdgeInsets.all(5),
                    //                       child: const Text(
                    //                         'Cities :',
                    //                         style: TextStyle(
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   const SizedBox(width: 15),
                    //                   Flexible(
                    //                     child: Container(
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.all(8.0),
                    //                         child: GroupButton(
                    //                           options: const GroupButtonOptions(
                    //                               selectedColor: Colors.green),
                    //                           buttons: citydata,
                    //                           isRadio: true,
                    //                           onSelected:
                    //                               (value, index, isSelected) async {
                    //                             depodata.clear();
                    //                             cityValue = value;
                    //                             await getDepodata(cityValue);
                    //                             setState(() {});
                    //                             // setState(() {
                    //                             //   _inits = false;
                    //                             // });
                    //                           },
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //               Row(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                       width: 120,
                    //                       padding: const EdgeInsets.all(5),
                    //                       child: const Text(
                    //                         'Depots :',
                    //                         style: TextStyle(
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   const SizedBox(width: 15),
                    //                   Flexible(
                    //                     child: Padding(
                    //                         padding: const EdgeInsets.all(8.0),
                    //                         child:
                    //                             // Consumer<DepoProvider>(
                    //                             //     builder: (context, value, child) {
                    //                             GroupButton(
                    //                           options: const GroupButtonOptions(
                    //                               selectedColor: Colors.green),
                    //                           buttons: depodata,
                    //                           isRadio: false,
                    //                           onSelected:
                    //                               (value, index, isSelected) {},
                    //                         )),
                    //                   ),
                    //                   // )
                    //                 ],
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Row(
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: [
                    //                     ElevatedButton(
                    //                         onPressed: () {},
                    //                         child: const Text('Sync'))
                    //                   ],
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         );
                    //       }
                    //       return LoadingPage();
                    //     });
                  } else {
                    return LoadingPage();
                  }
                },
              ),
            ),
          ],
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

  getUserdata() {
    return FirebaseFirestore.instance.collection('User').get().then((value) {
      value.docs.forEach((element) {
        var data = element['FirstName'];
        var data1 = element['LastName'];
        _testList.add(data.toString().trim() + ' ' + data1);
      });
    });
  }

  UserCard(String number, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                number,
                style: TextStyle(fontSize: 18, color: white),
              ),
              Text(title, style: TextStyle(fontSize: 18, color: white)),
            ]),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('More Info'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.forward),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget searchWidget(String text) {
  return ListTile(
    title: Text(
      text.length > 4 ? text.substring(0, 4) : text,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.indigoAccent),
    ),
    subtitle: Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: Colors.black26,
      ),
    ),
  );
}
