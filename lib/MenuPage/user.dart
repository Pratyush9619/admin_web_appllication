import 'dart:async';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/provider/menuUserPageProvider.dart';
import 'package:web_appllication/widgets/custom_appbar.dart';
import '../provider/filteration_provider.dart';
import '../style.dart';
import 'menu_screen/assigned_user.dart';
import 'menu_screen/totalUser.dart';
import 'menu_screen/unAssignedUserPage.dart';

class MenuUserPage extends StatefulWidget {
  static const String id = 'user-page';
  const MenuUserPage({super.key});

  @override
  State<MenuUserPage> createState() => _MenuUserPageState();
}

class _MenuUserPageState extends State<MenuUserPage> {
  final TextEditingController _controllerForReportingManager =
      TextEditingController();
  final TextEditingController _controllerForUser = TextEditingController();
  List<dynamic> cardFunction = [const AssignedUser()];
  String selectedUserId = '';
  List<String> searchedList = [];
  List<String> assignedUserList = [];
  int assignedUsers = 0;
  int totalUsers = 0;
  List<dynamic> unAssignedUserList = [];
  int unAssignedUser = 0;
  String selectedUserName = '';
  String selectedReportingManager = '';
  List<bool> changeColorForDepo = [];
  List<String> selectedDepo = [];
  List<String> selecteddesignation = [];
  List<String> selectedCity = [];
  List<String> role = [];
  List<bool> changeColorForRole = [];
  List<bool> changeColorForCity = [];
  List<bool> isRemoveDepo = [];
  List<String> cityData = [];
  Stream? _stream;
  bool showError = false;
  String errorMessage = '';
  bool isLoading = true;
  bool getDepooData = false;

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
    Colors.green,
    Colors.blue,
    const Color.fromARGB(255, 236, 100, 100),
  ];

  List<dynamic> depodata = [];

  List<String> _testList = [];
  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    getCityName()
        .whenComplete(() => {isLoading = false, getCityLen(), setState(() {})});
    getDesigationLen();
    getTotalUsers();

    _stream = FirebaseFirestore.instance
        .collection('User')
        .orderBy('FirstName')
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuUserPageProvider>(context, listen: false);
    return Scaffold(
      body: isLoading
          ? LoadingPage()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: Consumer<MenuUserPageProvider>(
                      builder: (context, providerValue, child) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UserCard(context, totalUsers, cardTitle[0],
                                  cardColor[0], const TotalUsers()),
                              const SizedBox(
                                width: 20,
                              ),
                              UserCard(context, assignedUsers, cardTitle[1],
                                  cardColor[1], const AssignedUser()),
                              const SizedBox(
                                width: 20,
                              ),
                              UserCard(context, unAssignedUser, cardTitle[2],
                                  cardColor[2], const UnAssingedUsers()),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: StreamBuilder(
                      stream: _stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(left: 10.0),
                              child: getDepooData
                                  ? LoadingPage()
                                  : Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              blue)),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    'Reporting Manager :',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  color: Colors.white70,
                                                  width: 200,
                                                  child: SingleChildScrollView(
                                                    child: TypeAheadField(
                                                      hideOnLoading: true,
                                                      textFieldConfiguration:
                                                          TextFieldConfiguration(
                                                        style: const TextStyle(
                                                            fontSize: 13),
                                                        controller:
                                                            _controllerForReportingManager,
                                                        decoration: const InputDecoration(
                                                            labelText:
                                                                'Select Reporting Manager',
                                                            labelStyle: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                color: Colors
                                                                    .black),
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                      itemBuilder: (context,
                                                          suggestion) {
                                                        return ListTile(
                                                            title: Text(suggestion
                                                                .toString()));
                                                      },
                                                      onSuggestionSelected:
                                                          (suggestion) {
                                                        _controllerForReportingManager
                                                                .text =
                                                            suggestion
                                                                .toString();
                                                        selectedReportingManager =
                                                            suggestion
                                                                .toString();
                                                      },
                                                      suggestionsCallback:
                                                          (String
                                                              pattern) async {
                                                        return await getUserdata(
                                                            pattern);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 100,
                                              ),
                                              TextButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            blue)),
                                                onPressed: () {},
                                                child: const Text(
                                                  'Select User : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    color: Colors.white70,
                                                    width: 200,
                                                    child: Consumer<
                                                        MenuUserPageProvider>(
                                                      builder: (context,
                                                          providerValue,
                                                          child) {
                                                        return TypeAheadField(
                                                          hideOnLoading: true,
                                                          textFieldConfiguration:
                                                              TextFieldConfiguration(
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13),
                                                            controller:
                                                                _controllerForUser,
                                                            decoration: const InputDecoration(
                                                                labelText:
                                                                    'Select a User',
                                                                labelStyle: TextStyle(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    color: Colors
                                                                        .black),
                                                                border:
                                                                    OutlineInputBorder()),
                                                          ),
                                                          itemBuilder: (context,
                                                              suggestion) {
                                                            return ListTile(
                                                              title: Text(
                                                                  suggestion
                                                                      .toString()),
                                                            );
                                                          },
                                                          onSuggestionSelected:
                                                              (suggestion) async {
                                                            await getDataId(
                                                                    suggestion
                                                                        .toString())
                                                                .whenComplete(
                                                                    () {
                                                              print(
                                                                  selectedUserId);
                                                            });

                                                            _controllerForUser
                                                                    .text =
                                                                suggestion
                                                                    .toString();
                                                            selectedUserName =
                                                                suggestion
                                                                    .toString();
                                                            checkUserAlreadyExist(
                                                                    selectedUserName)
                                                                .then((value) {
                                                              providerValue
                                                                  .setLoadWidget(
                                                                      true);
                                                            });
                                                          },
                                                          suggestionsCallback:
                                                              (String
                                                                  pattern) async {
                                                            return await getUserdata(
                                                                pattern);
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 230,
                                              ),
                                              SizedBox(
                                                height: 30,
                                                width: 130,
                                                child: ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.green)),
                                                    onPressed: () async {
                                                      bool isDefined = false;

                                                      for (int i = 0;
                                                          i < assignedUsers;
                                                          i++) {
                                                        if (assignedUserList[
                                                                i] ==
                                                            selectedUserName) {
                                                          isDefined = true;
                                                        }
                                                      }

                                                      if (selectedUserName !=
                                                          selectedReportingManager) {
                                                        if (isDefined ==
                                                            false) {
                                                          role.isEmpty
                                                              ? customAlertBox(
                                                                  'Please Select Designation')
                                                              : selectedUserName
                                                                      .isEmpty
                                                                  ? customAlertBox(
                                                                      'Please Select a User')
                                                                  : depodata
                                                                          .isEmpty
                                                                      ? customAlertBox(
                                                                          'Please Select City')
                                                                      : selectedDepo
                                                                              .isEmpty
                                                                          ? customAlertBox(
                                                                              'Please Select Depot')
                                                                          : selectedReportingManager.isEmpty
                                                                              ? customAlertBox('Please Select Reporting Manager')
                                                                              : storeAssignData();
                                                          getTotalUsers()
                                                              .whenComplete(() {
                                                            DocumentReference
                                                                documentReference =
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'unAssignedRole')
                                                                    .doc(
                                                                        selectedUserName);
                                                            documentReference
                                                                .delete();

                                                            _controllerForReportingManager
                                                                .text = '';
                                                            _controllerForUser
                                                                .text = '';
                                                            selectedDepo
                                                                .clear();
                                                            selectedCity
                                                                .clear();
                                                            role.clear();
                                                            depodata.clear();
                                                            getDesigationLen();
                                                            getCityLen();
                                                            getDepoLen();
                                                            getCityName();
                                                            selectedReportingManager =
                                                                '';
                                                            selectedUserName =
                                                                '';
                                                            provider
                                                                .setLoadWidget(
                                                                    true);
                                                          });
                                                        } else {
                                                          customAlertBox(
                                                              '$selectedUserName is Already Assigned a Role');
                                                        }
                                                      } else if (selectedUserName
                                                              .isEmpty &&
                                                          selectedReportingManager
                                                              .isEmpty) {
                                                        customAlertBox(
                                                            'Please Select Reporting Manager and User');
                                                      } else {
                                                        customAlertBox(
                                                            'Reporting Manager and User cannot be same');
                                                      }
                                                    },
                                                    child: const Text(
                                                        'Assign Role')),
                                              )
                                            ],
                                          ),
                                        ),
                                        Consumer<MenuUserPageProvider>(
                                          builder: (context, value, child) {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 560),
                                                  child: showError
                                                      ? Text(
                                                          errorMessage,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                        )
                                                      : const Text(''),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              top: 10.0,
                                              bottom: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: SizedBox(
                                                  width: 130,
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                blue)),
                                                    onPressed: () {},
                                                    child: const Text(
                                                      'Designation :',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Consumer<MenuUserPageProvider>(
                                                builder: (BuildContext context,
                                                    providerValue,
                                                    Widget? child) {
                                                  return SizedBox(
                                                    height: 80,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: GridView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            designation.length,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    7,
                                                                crossAxisSpacing:
                                                                    12.0,
                                                                mainAxisSpacing:
                                                                    10.0,
                                                                mainAxisExtent:
                                                                    32,
                                                                childAspectRatio:
                                                                    MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width),
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(changeColorForRole[
                                                                            index]
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .blue)),
                                                            onPressed: () {
                                                              if (designation[
                                                                      index] ==
                                                                  'Others') {
                                                              } else {
                                                                changeColorForRole[
                                                                        index] =
                                                                    !changeColorForRole[
                                                                        index];
                                                                insertSelectedRole(
                                                                    index);
                                                                providerValue
                                                                    .setLoadWidget(
                                                                        true);
                                                              }
                                                            },
                                                            child: Text(
                                                              designation[
                                                                  index],
                                                              style: TextStyle(
                                                                  color: changeColorForRole[
                                                                          index]
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white,
                                                                  fontSize: 11),
                                                            ),
                                                          );
                                                        }),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              top: 10.0,
                                              bottom: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: SizedBox(
                                                  width: 130,
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                blue)),
                                                    onPressed: () {},
                                                    child: const Text(
                                                      'Cities :',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Consumer<MenuUserPageProvider>(
                                                builder: (BuildContext context,
                                                    providerValue,
                                                    Widget? child) {
                                                  return SizedBox(
                                                    height: 30,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          cityData.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: ElevatedButton(
                                                            style: ButtonStyle(
                                                                shadowColor:
                                                                    const MaterialStatePropertyAll(
                                                                        Colors
                                                                            .black),
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(changeColorForCity[
                                                                            index]
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .blue)),
                                                            onPressed: () {
                                                              changeColorForCity[
                                                                      index] =
                                                                  !changeColorForCity[
                                                                      index];
                                                              insertSelectedCity(
                                                                  index);

                                                              if (isRemoveDepo[
                                                                  index]) {
                                                                isRemoveDepo[
                                                                        index] =
                                                                    false;
                                                                selectedDepo
                                                                    .clear();
                                                                getDepoNames(
                                                                        cityData[
                                                                            index])
                                                                    .then((_) {
                                                                  getDepoLen();
                                                                  provider
                                                                      .setLoadWidget(
                                                                          true);
                                                                });
                                                              } else {
                                                                isRemoveDepo[
                                                                        index] =
                                                                    true;
                                                                removeSelectedDepo(
                                                                        cityData[
                                                                            index])
                                                                    .then(
                                                                        (_) => {
                                                                              provider.setLoadWidget(true)
                                                                            });
                                                              }
                                                            },
                                                            child: Text(
                                                              cityData[index],
                                                              style: TextStyle(
                                                                  color: changeColorForCity[
                                                                          index]
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Consumer(
                                          builder: (BuildContext context,
                                              providerValue, Widget? child) {
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  top: 10.0,
                                                  bottom: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: SizedBox(
                                                      width: 130,
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    blue)),
                                                        onPressed: () {},
                                                        child: const Text(
                                                          'Depots :',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Consumer<
                                                      MenuUserPageProvider>(
                                                    builder:
                                                        (BuildContext context,
                                                            providerValue,
                                                            Widget? child) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .blue
                                                                    .withOpacity(
                                                                        0.3),
                                                              )
                                                            ],
                                                                border: Border
                                                                    .all()),
                                                        height: 150,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child:
                                                              GridView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      depodata
                                                                          .length,
                                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          7,
                                                                      crossAxisSpacing:
                                                                          12.0,
                                                                      mainAxisSpacing:
                                                                          10.0,
                                                                      mainAxisExtent:
                                                                          34,
                                                                      childAspectRatio: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width),
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return ElevatedButton(
                                                                        style:
                                                                            ButtonStyle(
                                                                                backgroundColor:
                                                                                    MaterialStatePropertyAll(
                                                                          changeColorForDepo[index]
                                                                              ? Colors.white
                                                                              : Colors.blue,
                                                                        )),
                                                                        onPressed:
                                                                            () {
                                                                          changeColorForDepo[index] =
                                                                              !changeColorForDepo[index];
                                                                          insertSelectedDepo(
                                                                              index);
                                                                          providerValue
                                                                              .setLoadWidget(true);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          depodata[
                                                                              index],
                                                                          style: TextStyle(
                                                                              color: changeColorForDepo[index] ? Colors.black : Colors.white,
                                                                              fontSize: 12),
                                                                        ));
                                                                  }),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        } else {
                          return LoadingPage();
                        }
                      },
                    ),
                  ),
                ],
              )),
    );
  }

  //Calculating Total users for additional screen
  Future<void> getTotalUsers() async {
    await getAssignedUsers();
    List<dynamic> tempList1 = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('User').get();
    tempList1 = querySnapshot.docs.map((doc) => doc.id).toList();
    totalUsers = querySnapshot.docs.length;

    await getUnAssignedUser();
  }

//Function for changing designation roles button color on tap
  void getDesigationLen() {
    List<bool> tempBool = [];
    for (int i = 0; i < designation.length; i++) {
      tempBool.add(true);
    }
    changeColorForRole = tempBool;
  }

  void getCityLen() {
    List<bool> tempBool = [];
    for (int i = 0; i < cityData.length; i++) {
      tempBool.add(true);
    }
    changeColorForCity = tempBool;
  }

//Function for changing depo name button color on tap
  void getDepoLen() {
    List<bool> tempListForDepo = [];
    for (int i = 0; i < depodata.length; i++) {
      tempListForDepo.add(true);
    }
    changeColorForDepo = tempListForDepo;
  }

  void insertSelectedRole(int currentIndex) {
    if (changeColorForRole[currentIndex] == false) {
      role.add(designation[currentIndex]);
      print('Role Added - $role');
    } else if (changeColorForRole[currentIndex] == true) {
      role.remove(designation[currentIndex]);
      print('Role Removed - $role');
    }
  }

  void insertSelectedDepo(int currentIndex) {
    if (changeColorForDepo[currentIndex] == false) {
      selectedDepo.add(depodata[currentIndex]);
      print('Depo Added - $selectedDepo');
    } else if (changeColorForDepo[currentIndex] == true) {
      selectedDepo.remove(depodata[currentIndex]);
      print('Depo Removed - $selectedDepo');
    }
  }

  void insertSelectedCity(int currentIndex) {
    if (changeColorForCity[currentIndex] == false) {
      selectedCity.add(cityData[currentIndex]);
      print('City Added - $selectedCity');
    } else if (changeColorForCity[currentIndex] == true) {
      selectedCity.remove(cityData[currentIndex]);
      print('City Removed - $selectedCity');
    }
  }

//Function to fetch depo name when any city name is clicked on the pag Ce
  Future getDepoNames(String selectedCity) async {
    List<dynamic> tempDepo = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('DepoName')
        .doc(selectedCity)
        .collection('AllDepots')
        .get();

    List<dynamic> temp = querySnapshot.docs.map((e) => e.id).toList();

    for (int i = 0; i < temp.length; i++) {
      depodata.add(temp[i]);
    }
  }

  Future<void> removeSelectedDepo(String selectedCity) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('DepoName')
        .doc(selectedCity)
        .collection('AllDepots')
        .get();

    List<dynamic> temp = querySnapshot.docs.map((e) => e.id).toList();
    for (int i = 0; i < temp.length; i++) {
      depodata.remove(temp[i]);
    }
  }

  getUserdata(String input) async {
    searchedList.clear();
    FirebaseFirestore.instance.collection('User').get().then((value) {
      value.docs.forEach((element) {
        var data = element['FirstName'];
        var data1 = element['LastName'];

        _testList.add('${data.toString().trim()} $data1');
      });
    });

    for (int i = 0; i < _testList.length; i++) {
      if (_testList[i].toUpperCase().startsWith(input.toUpperCase())) {
        searchedList.add(_testList[i]);
      }
    }
    _testList.clear();
    return searchedList;
  }

  Future<void> getUnAssignedUser() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('unAssignedRole').get();

    unAssignedUserList = querySnapshot.docs.map((e) => e.id).toList();
    unAssignedUser = querySnapshot.docs.length;
  }

  //Storing data in firebase
  Future<void> storeAssignData() async {
    await FirebaseFirestore.instance
        .collection('AssignedRole')
        .doc(selectedUserName)
        .set({
      'username': selectedUserName.trim(),
      'userId': selectedUserId,
      'alphabet': selectedUserName[0][0].toUpperCase(),
      'position': 'Assigned',
      'roles': role,
      'depots': selectedDepo,
      'reportingManager': selectedReportingManager,
      'cities': selectedCity,
    }).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.blue,
        content: Text('Role Assigned Successfully'),
      ));
    });

    await FirebaseFirestore.instance
        .collection('TotalUsers')
        .doc(selectedUserName)
        .set({
      'userId': selectedUserId,
      'alphabet': selectedUserName[0][0].toUpperCase(),
      'position': 'Assigned',
      'roles': role,
      'depots': selectedDepo,
      'reportingManager': selectedReportingManager,
      'cities': selectedCity,
    });
  }

  Future<List<dynamic>> getAssignedUsers() async {
    assignedUserList.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('AssignedRole').get();

    assignedUserList = querySnapshot.docs.map((e) => e.id).toList();
    assignedUsers = querySnapshot.docs.length;
    return assignedUserList;
  }

  UserCard(BuildContext context, int number, String title, Color color,
      Widget name) {
    final menuProvider =
        Provider.of<MenuUserPageProvider>(context, listen: true);
    return Container(
      width: 350,
      height: 200,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '$number',
              style: TextStyle(fontSize: 18, color: white),
            ),
            Text(title, style: TextStyle(fontSize: 18, color: white)),
          ]),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MultiProvider(providers: [
                      ChangeNotifierProvider(
                          create: (context) => MenuUserPageProvider()),
                      ChangeNotifierProvider(
                        create: (context) => FilterProvider(),
                      )
                    ], child: name);
                  })).then((value) {
                    getTotalUsers().whenComplete(() {
                      _controllerForReportingManager.text = '';
                      _controllerForUser.text = '';
                      selectedDepo.clear();
                      selectedCity.clear();
                      role.clear();
                      depodata.clear();
                      getDesigationLen();
                      getCityLen();
                      getDepoLen();
                      getCityName();
                      selectedReportingManager = '';
                      selectedUserName = '';
                      menuProvider.setLoadWidget(true);
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                ),
                child: const Text('More Info'),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.forward),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> checkUserAlreadyExist(String username) async {
    showError = false;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('AssignedRole').get();
    List<dynamic> assignedUsers = querySnapshot.docs.map((e) => e.id).toList();
    for (int i = 0; i < assignedUsers.length; i++) {
      if (assignedUsers[i].toString().toUpperCase().trim() ==
          username.toUpperCase().trim()) {
        showError = true;
        errorMessage = 'Selected User Already Assigned role';
      }
    }
  }

  Future<void> getCityName() async {
    List<bool> tempBool = [];
    List<String> tempCityName = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('CityName').get();

    List<dynamic> tempList = querySnapshot.docs.map((e) => e.id).toList();

    for (int i = 0; i < tempList.length; i++) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('CityName')
          .doc(tempList[i])
          .get();

      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      // cityData.add(data['CityName']);
      tempCityName.add(data['CityName']);
      tempBool.add(true);
    }
    cityData = tempCityName;
    isRemoveDepo = tempBool;
  }

  customAlertBox(String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            icon: const Icon(
              Icons.warning_amber,
              size: 45,
              color: Colors.red,
            ),
            title: Text(
              message,
              style: const TextStyle(
                  color: Colors.blue, fontSize: 14, letterSpacing: 2),
            ),
          );
        });
  }

  Future<String> getSelectedUserId(String username) async {
    // DocumentSnapshot documentSnapshot =
    //     await FirebaseFirestore.instance.collection('User').doc(username).get();
    // if (documentSnapshot.exists) {
    //   Map<String, dynamic> userDataMap =
    //       documentSnapshot.data() as Map<String, dynamic>;
    //   selectedUserId = userDataMap['Employee Id'];
    // }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('FirstName', isEqualTo: username)
        .get();

    List<dynamic> tempData = querySnapshot.docs.map((e) => e.data()).toList();
    Map<String, dynamic> data = tempData[0];

    selectedUserId = data['Employee Id'];
    print(selectedUserId);

    return selectedUserId;
  }

  Future<void> getDataId(String username) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('User').get();

    List<dynamic> tempList = querySnapshot.docs.map((e) => e.id).toList();
    for (int i = 0; i < tempList.length; i++) {
      if (username
          .toString()
          .toUpperCase()
          .trim()
          .startsWith(tempList[i].toUpperCase().trim())) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('User')
            .doc('${tempList[i]}')
            .get();

        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        selectedUserId = data['Employee Id'];
        print('userId - ${data['FirstName']}');
      }
    }
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
