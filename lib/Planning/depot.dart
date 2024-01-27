import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';
import 'package:web_appllication/Planning/overview.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/style.dart';
import '../Authentication/auth_service.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_container.dart';

class Mydepots extends StatefulWidget {
  String? cityName;
  String? userId;

  Mydepots({super.key, required this.cityName, this.userId});

  @override
  State<Mydepots> createState() => _MydepotsState();
}

class _MydepotsState extends State<Mydepots> {
  String depoName = "";
  File? pickedImage;
  // Uint8List? webImage;
  dynamic webImage;
  String? companyName;
  bool isLoading = true;
  late SharedPreferences _sharedPreferences;
  @override
  void initState() {
    super.initState();
    getcompany();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: companyName == 'TATA POWER'
          ? FloatingActionButton(
              onPressed: () {
                PopupDialog(context);
              },
              child: Icon(Icons.add),
              backgroundColor: blue,
            )
          : Container(),
      appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: CustomAppBar(
            toDepots: true,
            text: 'Depots/${widget.cityName}',
            cityName: widget.cityName,
            userId: widget.userId,
            // userid: widget.userid,
          ),
          preferredSize: const Size.fromHeight(50)),

      //  AppBar(
      //   backgroundColor: blue,
      //   title: Text('Depots - ${widget.cityName!}'),
      // ),
      body: isLoading ? LoadingPage() : depolist(),

      // Center(child: Text(widget.cityName!)),
    );
  }

  PopupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text(
                    'Add Depot',
                  ),
                  content: SizedBox(
                    height: 200,
                    width: 250,
                    child: Column(children: [
                      GestureDetector(
                        onTap: () async {
                          if (!kIsWeb) {
                            final ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              var selected = File(image.path);
                              setState(() {
                                pickedImage = selected;
                                isLoading == false;
                              });
                            } else {
                              print('No Image has been picked');
                            }
                          } else if (kIsWeb) {
                            final ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              var f = await image.readAsBytes();
                              setState(() {
                                webImage = f;
                                pickedImage = File('a');
                                isLoading == false;
                              });
                            } else {
                              print('No Image has been picked');
                            }
                          } else {
                            print('Something went wrong!');
                          }
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: pickedImage == null
                              ? const CircleAvatar(
                                  child: Icon(Icons.person),
                                )
                              : kIsWeb
                                  ? Image.memory(
                                      webImage!,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      pickedImage!,
                                      fit: BoxFit.fill,
                                    ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        onChanged: (val) {
                          setState(() {
                            depoName = val;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ),
                    ]),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // setState() {
                        //   pickedImage = File('null');
                        //   Navigator.pop(context);
                        // }
                      },
                      child: Text("CANCEL"),
                      style: ElevatedButton.styleFrom(),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (kIsWeb) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              content: SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: blue,
                                  ),
                                ),
                              ),
                            ),
                          );

                          final ref = FirebaseStorage.instance
                              .ref()
                              .child('DepoImages')
                              .child('/' + depoName);
                          await ref.putData(webImage,
                              SettableMetadata(contentType: 'image/jpeg'));
                          var downloadurl = await ref
                              .getDownloadURL()
                              .whenComplete(() => null);

                          // DatabaseService()
                          //     .uploadDepoData(cityName, downloadurl)
                          //     .whenComplete(() => pickedImage == null);
                          // Navigator.pop(context);
                          FirebaseFirestore.instance
                              .collection('DepoName')
                              .doc(widget.cityName!)
                              .set({
                            'userId': widget.userId,
                          });

                          FirebaseFirestore.instance
                              .collection('DepoName')
                              .doc(widget.cityName!)
                              .collection('AllDepots')
                              .doc(depoName)
                              .set({
                            'DepoName': depoName,
                            'DepoUrl': downloadurl,
                          }).whenComplete(() => pickedImage == null);
                          Navigator.pop(context);
                          pickedImage == null;
                          Navigator.pop(context);
                          // DatabaseService()
                          //     .uploadDepoData(cityName, downloadurl)
                          //     .whenComplete(() {
                          //   Navigator.pop(context);
                          //   pickedImage == null;
                          //   setState() {
                          //     isLoading = false;
                          //   }

                          //   Navigator.pop(context);
                          // });
                        }
                      },
                      child: Text("ADD"),
                      style: ElevatedButton.styleFrom(),
                    ),
                  ],
                );
              },
            ));
  }

  depolist() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('DepoName')
            .doc(widget.cityName!)
            .collection('AllDepots')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              if (snapshot.data!.docs.isNotEmpty) {
                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, childAspectRatio: 1.0),
                    itemBuilder: (context, index) {
                      return
                          //GestureDetector(
                          // onTap: () async {
                          //   _sharedPreferences =
                          //       await SharedPreferences.getInstance();
                          //   _sharedPreferences
                          //       .setString(
                          //           'depotName',
                          //           snapshot.data!.docs[index]
                          //               ['DepoName'])
                          //       .whenComplete(() {
                          //     Navigator.pushNamed(context,
                          //         'login/EVDashboard/Cities/EVBusDepot/overviewpage',
                          //         arguments: {
                          //           'cityName': widget.cityName,
                          //           'depoName': snapshot.data!.docs[index]
                          //               ['DepoName'],
                          //         });
                          //   });
                          // },

                          cards(
                              context,
                              snapshot.data!.docs[index]['DepoName'],
                              snapshot.data!.docs[index]['DepoUrl'],
                              MyOverview(
                                  depoName: snapshot.data!.docs[index]
                                      ['DepoName'],
                                  cityName: widget.cityName!),
                              index);
                    });
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 1000,
                    width: 1000,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: blue)),
                    child: Column(children: [
                      Image.asset(
                        'assets/Tata-Power.jpeg',
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/sustainable.jpeg',
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(width: 50),
                          Image.asset(
                            'assets/Green.jpeg',
                            height: 100,
                            width: 100,
                          )
                        ],
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: blue)),
                          child: const Text(
                            'No depots available yet \n Please add to process',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ]),
                  ),
                )
                    // Text(
                    //   "No Depot Available at This Time....",
                    //   style: TextStyle(color: black),
                    // ),
                    );
              }
            } else {
              return const Center(
                child: Text("No Depot Available at This Time...."),
              );
            }
          } else {
            return LoadingPage();
          }
        });
  }

  Future<void> getcompany() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString('cityName', widget.cityName!);
    await AuthService().getCurrentCompanyName().then((value) {
      companyName = value;
      setState(() {
        isLoading = false;
      });
    });
  }
}
