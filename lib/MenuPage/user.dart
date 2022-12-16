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
  @override
  Widget build(BuildContext context) {
    final users = FirebaseFirestore.instance
        .collection('collectionPath')
        .doc('8TfbSgieo2FE8ZMh1njf')
        .snapshots();

    return Scaffold(
        body: Center(
            child: StreamBuilder<DocumentSnapshot>(
      stream: users,
      // future: users.doc('8TfbSgieo2FE8ZMh1njf').get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.data() as Map;
          List<dynamic> newdata = data['data'] as List<dynamic>;
          return ListView.builder(
            itemCount: newdata.length,
            itemBuilder: (context, index) {
              return Text(newdata[index]['Activity']);
            },
          );
        }
        return CircularProgressIndicator();
      },
    )));
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
}
