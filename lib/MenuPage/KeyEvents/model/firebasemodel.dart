// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

List<FirebaseModel> FirebaseModelFromJson(String str) =>
    List<FirebaseModel>.from(
        json.decode(str).map((x) => FirebaseModel.fromJson(x)));

String FirebaseModelToJson(List<FirebaseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FirebaseModel {
  // String? name;
  dynamic value;
  List<dynamic>? data;

  FirebaseModel({
    // this.name,
    this.value,
    this.data,
  });

  Map<String, dynamic> toJson() => {
        // "name": name,
        "value": value,
        "tabledata": data
      };

  FirebaseModel.fromJson(Map<String, dynamic> json) {
    // name = json["name"];
    value = json["value"];
    data = json["tableData"];
  }
}
