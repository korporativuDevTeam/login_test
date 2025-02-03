import 'package:flutter/material.dart';

class UserModel {
  late int? id=0;
  String email;
  String name;
  String password;
  String token;

  UserModel(

      {this.id,required this.password,
        required this.email,required this.name,
        required this.token});

  factory UserModel.fromMap(Map<String, dynamic> json) {

    return
      UserModel(
      id: json["user"]["id"] as int?,
      email: json["user"]["email"] as String,
      name: json["user"]["name"] as String,
      password: "",
      token: (json["authorisation"]["token"] ?? "") as String,
    );
  }


  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,"name": name,
    "password": password,
    "token": token,
  };

  @override
  String toString() {
    return "\n[ UserModel : id - $id, email- $email, name- $name, password - $password, token - $token ]";
  }
}
