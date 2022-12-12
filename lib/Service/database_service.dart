import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('CityName');

  final CollectionReference depocollectionReference =
      FirebaseFirestore.instance.collection('DepoName');
  Future uploadCityData(String cityName, String imageUrl) async {
    await collectionReference.add({
      'CityName': cityName,
      'ImageUrl': imageUrl,
    });
  }

  Future uploadDepoData(String cityName, String imageUrl) async {
    await depocollectionReference.add({
      'DepoName': cityName,
      'DepoUrl': imageUrl,
    });
  }
}
