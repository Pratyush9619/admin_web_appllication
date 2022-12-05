import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('CityName');

  Future uploadCityData(String cityName, String imageUrl) async {
    await collectionReference.add({
      'CityName': cityName,
      'ImageUrl': imageUrl,
    });
  }

  getcities() async {
    return collectionReference.doc().snapshots();
  }
}
