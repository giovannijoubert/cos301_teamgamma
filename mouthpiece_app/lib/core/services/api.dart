import 'dart:convert';
import '../models/user.dart';
import '../data/db.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {
  static const endpoint = 'https://jsonplaceholder.typicode.com';

  var client = new http.Client();

  Future<User> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get('$endpoint/posts/$userId');

    // print(data[0][0]);
    // return User.fromJson(data[0][0]);

    // Convert and return
    return User.fromJson(json.decode(response.body));
  }
}
