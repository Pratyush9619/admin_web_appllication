import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_appllication/Planning/depot.dart';
import 'package:web_appllication/Service/database_service.dart';
import 'package:web_appllication/components/loading_page.dart';
import 'package:web_appllication/style.dart';
import '../Authentication/auth_service.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  String cityName = "";
  File? pickedImage;
  // Uint8List? webImage;
  var webImage;
  bool? _isLoading = true;
  dynamic userId;

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PopupDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: blue,
      ),
      body: citylist(),
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
                  title: const Text('Add City'),
                  content: Container(
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
                                _isLoading == false;
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
                                _isLoading == false;
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
                            cityName = val;
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
                              .child('CityImages')
                              .child('/' + cityName);
                          await ref.putData(webImage,
                              SettableMetadata(contentType: 'image/jpeg'));
                          var downloadurl = await ref
                              .getDownloadURL()
                              .whenComplete(() => null);

                          DatabaseService()
                              .uploadCityData(cityName, downloadurl)
                              .whenComplete(() {
                            Navigator.pop(context);
                            pickedImage == null;
                            setState() {
                              _isLoading = false;
                            }

                            Navigator.pop(context);
                          });
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

  citylist() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('CityName')
            .orderBy('CityName')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      // onTap: () => onToScreen(index),
                      child: Stack(children: [
                        Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: blue,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data!.docs[index]['ImageUrl']),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Text(snapshot.data!.docs[index]['CityName']),
                            const SizedBox(height: 5),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: blue),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mydepots(
                                                cityName: snapshot.data!
                                                    .docs[index]['CityName'],
                                              )));
                                },
                                child: Text(
                                    snapshot.data!.docs[index]['CityName']))
                          ],
                        ),
                      ]),
                    ),
                  );
                });
          } else {
            return LoadingPage();
          }
        });
  }

  Future<void> getUserId() async {
    await AuthService().getCurrentUserId().then((value) {
      userId = value;
    });
  }
}
