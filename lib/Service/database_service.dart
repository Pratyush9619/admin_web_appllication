import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DatabaseService {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('CityName');

  final CollectionReference depocollectionReference =
      FirebaseFirestore.instance.collection('DepoName');

  final CollectionReference resourcecollectionReference =
      FirebaseFirestore.instance.collection('ResourceAllocation');

  Future uploadCityData(String cityName, String imageUrl) async {
    await collectionReference.add({
      'CityName': cityName,
      'ImageUrl': imageUrl,
    });
  }

  Future uploadDepoData(String cityName, String imageUrl) async {
    await depocollectionReference.doc().set({
      'DepoName': cityName,
      'DepoUrl': imageUrl,
    });
  }

  Future<String> downloadURLExample() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(
            'gs://tp-zap-solz.appspot.com/checklist/Jammu/DRDO/Initial Survey Of Depot With TML & STA Team.')
        .getDownloadURL();
    print(downloadURL);

    return downloadURL;
    //   PDFDocument doc = await PDFDocument.fromURL(downloadURL);
    //Notice the Push Route once this is done.
  }
}
