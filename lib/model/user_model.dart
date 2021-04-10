import 'dart:math';

import 'package:flutter/material.dart';

class UserModel {
  String username;
  String photo;
  String profileurl;
  String id;
  String email;
  String name;
  String bio;

  UserModel({this.username, this.photo, this.profileurl, this.id, @required this.email, this.name, this.bio});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    username = json['username'] ?? generateUserName();
    photo = json['photo'] ?? '';
    profileurl = json['profileurl'] ?? '';
    email = json['email'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? '';
    data['name'] = this.name ?? '';
    data['username'] = this.username ?? generateUserName();
    data['photo'] = this.photo ?? '';
    data['profileurl'] = this.profileurl ?? '';
    data['email'] = this.email;
    data['bio'] = this.bio;
    return data;
  }

  String generateUserName() {
    Random _rnd = Random();
    int _numb = _rnd.nextInt(100000);
    return this.email.substring(1, 4) + _numb.toString();
  }
}
