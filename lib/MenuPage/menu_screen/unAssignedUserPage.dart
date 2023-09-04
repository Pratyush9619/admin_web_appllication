import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/widgets/custom_appbar.dart';

import '../../components/Loading_page.dart';
import '../../provider/filteration_provider.dart';
import 'LoadingForMenuUser.dart';

class UnAssingedUsers extends StatefulWidget {
  const UnAssingedUsers({super.key});

  @override
  State<UnAssingedUsers> createState() => _UnAssingedUsersState();
}

class _UnAssingedUsersState extends State<UnAssingedUsers> {
  bool isLoading = true;
  List<bool> selectedDesign = [];
  String selectedAlphabet = 'All';
  bool showAll = true;
  String alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  @override
  void initState() {
    setColor();
    selectedDesign[26] = !selectedDesign[26];
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterProvider>(context, listen: true);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: CustomAppBar(
            text: 'UnAssigned Users',
          ),
        ),
        body: Column(
          children: [
            Consumer<FilterProvider>(
              builder: (context, value, child) {
                return Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 5.0),
                  width: MediaQuery.of(context).size.width * 0.97,
                  height: 50,
                  child: Row(
                    children: [
                      Card(
                        elevation: selectedDesign[26] ? 5 : 0,
                        shadowColor: Colors.black,
                        child: SizedBox(
                          height: 32,
                          width: 60,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                selectedDesign[26]
                                    ? Colors.blue[900]
                                    : Colors.blue,
                              )),
                              onPressed: () {
                                setColor();
                                selectedDesign[26] = !selectedDesign[26];
                                selectedAlphabet = 'All';
                                showAll = true;
                                provider.setReloadWidget(true);
                              },
                              child: const Text(
                                'All',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: alpha.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: selectedDesign[index] ? 5 : 0,
                            child: SizedBox(
                              width: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                  selectedDesign[index]
                                      ? Colors.blue[900]
                                      : Colors.blue,
                                )),
                                onPressed: () {
                                  setColor();
                                  selectedDesign[index] =
                                      !selectedDesign[index];
                                  selectedAlphabet = alpha[index];
                                  showAll = false;
                                  provider.setReloadWidget(true);
                                },
                                child: Text(
                                  alpha[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            StreamBuilder(
                stream: showAll
                    ? FirebaseFirestore.instance
                        .collection('unAssignedRole')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('unAssignedRole')
                        .where('alphabet', isEqualTo: selectedAlphabet)
                        .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingForMenuUser();
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error Occured'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No Data Available'),
                    );
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    List<dynamic> user = data!.docs.map((e) => e.id).toList();

                    return SingleChildScrollView(
                      child: Consumer<FilterProvider>(
                        builder: (context, value, child) {
                          return Container(
                            padding: const EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.39,
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 240,
                                      childAspectRatio: 6,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 270),
                              itemCount: user.length,
                              itemBuilder: (context, index) {
                                storeAssginedUser(user[index]);
                                return customCard(user[index], index);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                })),
          ],
        ));
  }

  Widget customCard(String user, int index) {
    return Card(
      elevation: 15,
      child: Container(
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/unAssigned_background2.jpeg'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(5.0),
        height: 200,
        width: 170,
        child: Column(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                user,
                style: GoogleFonts.average(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.person_2_sharp,
                  color: Colors.blue[900],
                  size: 14,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: const Text(
                    'Designation',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                )
              ],
            ),
            customRowBuilder(['', '', '']),
            Container(
              padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
              child: Row(
                children: [
                  Icon(
                    Icons.person_4_sharp,
                    color: Colors.blue[900],
                    size: 14,
                  ),
                  const Text(
                    'Reporting Manager',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: const [Text('')],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.house_sharp,
                    color: Colors.black,
                    size: 14,
                  ),
                  Text(
                    'Cities',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  Text(
                    'No Role is Assigned',
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customRowBuilder(List<String> data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: [
                Text(
                  data[index],
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        });
  }

//Function for storing name first letter for filteration
  Future<void> storeAssginedUser(String name) async {
    await FirebaseFirestore.instance
        .collection('unAssignedRole')
        .doc(name)
        .set({
      'alphabet': name[0][0].toUpperCase(),
      'position': 'unAssigned',
    }).whenComplete(() {
      print('Operation Complete');
    });
  }

  void setColor() {
    List<bool> elevation = [];
    List<bool> tempBool = [];
    for (int i = 0; i < 27; i++) {
      tempBool.add(false);
    }
    selectedDesign = tempBool;
  }
}
