import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import '../../locator.dart';
import 'notifications/password_generator.dart';
import 'db.dart';
import 'api.dart';

class NotificationsApi {
  static const url = 'https://teamgamma.ga/notification/notificationAPI.php';
  Api _api = new Api();
  SharedPreferences prefs;

  static HttpClient httpClient = new HttpClient();

  Future successfulRegistration(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString("device-id");
    String username = prefs.getString("username");

    var map = new Map<String, dynamic>();
    map['key'] = '3e30630d-239b-488d-8938-b9305dff3e54';
    map['type'] = 'email';
    map['email'] = email;
    map['deviceID'] = deviceId;
    map['msg'] = 'Congratulations for signing up $username';
    map['heading'] = 'Registration';

    await http.post(
      url,
      body: map,
    );
  }

  Future resetPassword(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = prefs.getString("device-id");
    String _generatedPassword = generatePassword(true, true, true, false, 8);

    var map = new Map<String, dynamic>();
    map['key'] = '3e30630d-239b-488d-8938-b9305dff3e54';
    map['type'] = 'email';
    map['email'] = email;
    map['deviceID'] = deviceId;
    map['msg'] = 'Your password has been reset: Your new password is $_generatedPassword.';
    map['heading'] = 'Reset Password';

    // E#*NqknMYTcy1BYu4ffufjL3BWO23#

    await http.post(
      url,
      body: map,
    );

    // String username;
    var conn = await MySqlConnection.connect(userManagementDb);
    var result = await conn.query('select username from Users where email = "$email"');
    for (var row in result) {
      Map updatePassMap = {
        "username": row[0],
        "password": _generatedPassword,
        "secretkey": "E#*NqknMYTcy1BYu4ffufjL3BWO23#"
      };

      String passURL = 'https://teamgamma.ga/api/umtg/reset';
      await _api.resetPassword(updatePassMap, passURL);
    }    
  }  
}

