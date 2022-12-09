import 'package:flutter/foundation.dart';

class UserListModel {
  int? id;
  String? name;
  int? age;
  String? city;

  UserListModel({
    this.id,
    this.name,
    this.age,
    this.city,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        city: json['city'],
      );
}
