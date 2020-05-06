import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:mouthpiece/core/viewmodels/choose_mode_model.dart';
import 'package:mysql1/mysql1.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'db.dart';
import 'package:http_client/http_client.dart';

/// The service responsible for networking requests
class Api {
  Future<bool> fetchUser(String url,Map map, String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = jsonEncode(map);
    final http.Response response = await http.post(
      url,
      headers:{'Content-Type': 'application/json'},
      body: body
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      // print("++++++++++++++++++++++++++++++++++++++++++++++");
      prefs.setString('pass', map["password"]);
      var userInfo = jsonEncode(body);
      prefs.setString("userInfo", userInfo);
      await setPref(body['username'], body['email'], body['JWT'], body['theme'], body['listening_mode'], body['profile_image']);
      return true;
    }
    else {
      var stat = response.statusCode;
      return false;
    }
  }

  Future<User> createUser(String url, Map map, String user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = jsonEncode(map);
    final http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body
    );

    if (response.statusCode == 200) {
      Map mapFetchUser = {
        "username": map["username"],
        "password": map["password"],
      };

      String url = 'http://teamgamma.ga/api/umtg/login';
      await prefs.setBool("register", true);
      await fetchUser(url, map, map["username"]);

      User userVar = new User();
      return userVar;
    } else {
      return null;
    }
  }

  setPref(String user, String email, String jwt, String theme, String mode, String image ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('email');
    prefs.remove('jwt');
    prefs.remove('theme');
    prefs.remove('profile_image');
    prefs.remove('loggedIn');
    prefs.remove('isVolSet');
    prefs.remove('navVal');
    // print("----------------------------21");

    Map map = {
      "option": "download",
      "username" : user,
      "jwt" : jwt,
      "location" : image
    };

    String url = 'https://teamgamma.ga/api/umtg/update';
    await getImage(url, map);
   

    ChooseModeModel modeModel = new ChooseModeModel();
    prefs.setString("username", user);
    prefs.setString("email", email);
    prefs.setString("jwt", jwt);
    prefs.setString("theme", theme);
    bool registered = prefs.getBool("register") ?? false;
    print(registered);
    if (!registered) {
      if (mode == "Volume") {
        modeModel.setVolumeBased();
      } else {
        modeModel.setFormantBased();
      }
    }
    prefs.remove("register");
    prefs.setBool("loggedIn", true);
  }
 
  Future logout(String url, Map map) async{
    var body = jsonEncode(map);
    print(body);
    final http.Response response = await http.post(
      url,
      headers:{'Content-Type': 'application/json'},
      body: body
    );

    if (response.statusCode == 200) {
      var body = response.body;
      print("====================$body");

    } else {
      var stat = response.statusCode;
      throw Exception('Failed to load Data ================ $stat');
    }
  }

  Future updateTheme(String url, Map map) async {  
    var body = jsonEncode(map);
    final http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var deez = body['message'];
      print("====================$deez");
    } else {
      var stat = response.statusCode;
      throw Exception('Failed to load Data ================ $stat');
    }
  }

  Future updateMode(String url, Map map) async {  
    var body = jsonEncode(map);
    final http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var deez = body['message'];
      print("====================$deez");
    } else {
      var stat = response.statusCode;
      throw Exception('Failed to load Data ================ $stat');
    }
  }
  
  Future updateImage(String url, Map map) async {  
    var body = jsonEncode(map);
    final http.Response response = await http.post(
      url,
      headers:{'Content-Type': 'application/json'},
      body: body
    );
    if (response.statusCode == 200) {
      var bod = response.body;
      print("------------------------------$bod");
      return response.body;
    } else {
      var stat = response.statusCode;
      throw Exception('Failed to load Data ================ $stat');
    }
  }

  Future getImage(String url, Map map) async {  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = jsonEncode(map);
    // print(body);
    final http.Response response = await http.post(
      url,
      headers:{'Content-Type': 'application/json'},
      body: body
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      prefs.setString("profile_image", body["image"]);
    } else {
      var stat = response.statusCode;
      throw Exception('Failed to load Data ====================================== $stat');
    }
  }

  Future<bool> updateMail(String url, Map map) async {  
    var body = jsonEncode(map);
    final http.Response response = await http.post(
      url,
      headers:{'Content-Type': 'application/json'},
      body: body
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var statusMessage = body['message'];
      print("==================================$statusMessage");
      return true;
    } else {
      return false;
    }
  }

  Future updateBgColours(int id, String bgColour) async {
    var conn = await MySqlConnection.connect(userManagementDb);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");

    var userId = await conn.query('select user_id from Users where username = "$username"');
    for (var row in userId) {
      conn.query('update UserMouthpack set background_colour = "$bgColour" where mouthpack_id = $id and user_id = ${row[0]}');
    }
  }

  Future removeMouthpack(int id) async {
    var conn = await MySqlConnection.connect(userManagementDb);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");

    var userId = await conn.query('select user_id from Users where username = "$username"');
    var result;
    for (var row in userId) {
      result = await conn.query('delete from UserMouthpack where mouthpack_id = $id and user_id = ${row[0]}');
    }
  }
}