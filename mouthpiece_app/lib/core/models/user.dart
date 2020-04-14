import '../../locator.dart';
import 'dart:convert';

class User {
    final String password;
    final String email;

    User({this.email,this.password});

    User.initial()
      : email ='',
        password = '';

    factory User.fromJson(Map<String, dynamic> json)
    {
        return User(         
          email: json['email'],
          password: json['password']
        );

    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['email'] = this.email;
      data['password'] = this.password;
      return data;
  }

}