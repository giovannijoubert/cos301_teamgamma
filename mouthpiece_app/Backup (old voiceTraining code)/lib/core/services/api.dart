import 'dart:convert';
import 'dart:async';
import '../models/user.dart';
import '../data/db.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {

      Future<User> fetchUser(String email, String password) async {
      final response = await http.get('https://jsonplaceholder.typicode.com');

      if(response.statusCode == 200)
      {
          return User.fromJson(json.decode(response.body));
      }
      else{
          throw Exception('User does not exist');
      }
  }

      Future<User> createUser(String userName, String email, String password) async{
      final http.Response response = await http.post(
        'https://jsonplaceholder.typicode.com/albums',
        headers: <String, String>{
            'Content-Type' : 'application/json; charset=UTF-8', 
        },
        body: jsonEncode(<String, String>{
            'userName' : userName,
            'email' : email,
            'password' : password
        }),
      );

      if(response.statusCode == 201){
          return User.fromJson(json.decode(response.body));
      }else{
          throw Exception('Failed to create user.');
      }
  }
}