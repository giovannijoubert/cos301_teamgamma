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
    String username = prefs.getString("username");

    var map = new Map<String, dynamic>();
    map['key'] = '3e30630d-239b-488d-8938-b9305dff3e54';
    map['type'] = 'email';
    map['email'] = email;
    map['deviceID'] = '0000';
    map['msg'] = "<h2>Congratulations $username for signing up!</h2><p>Welcome to the Mouthpiece family. We hope you have lots of fun using our app!</p><p>Click <a href='https://teamgamma.ga/webfrontend/html/Explore.php'>here</a> to view our collection of mouthpacks.</p>";
    map['heading'] = 'Registration';

    await http.post(
      url,
      body: map,
    );
  }

  Future resetPassword(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _generatedPassword = generatePassword(true, true, true, false, 8);

    var map = new Map<String, dynamic>();
    map['key'] = '3e30630d-239b-488d-8938-b9305dff3e54';
    map['type'] = 'email';
    map['email'] = email;
    map['deviceID'] = '0000';
    map['msg'] = "<h3>Your password has been reset.</h3><p>Your new password is: $_generatedPassword</p><a href='https://teamgamma.ga/webfrontend/html/Login.php'>Follow this link to login</a>";
    map['heading'] = 'Reset Password';

    await http.post(
      url,
      body: map,
    );

    
    Map updatePassMap = {
      "email": email,
      "password": _generatedPassword,
      "secretkey": "E#*NqknMYTcy1BYu4ffufjL3BWO23#"
    };

    String passURL = 'https://teamgamma.ga/api/umtg/reset';
    await _api.resetPassword(updatePassMap, passURL);
  }  

  Future updateEmail(String email) async {
    var map = new Map<String, dynamic>();
    map['key'] = '3e30630d-239b-488d-8938-b9305dff3e54';
    map['type'] = 'email';
    map['email'] = email;
    map['deviceID'] = '0000';
    map['msg'] = "<h3>You have changed your Mouthpiece email.</h3><p>You can now login using this <a href='https://teamgamma.ga/webfrontend/html/Login.php'>link</a>.</p>";
    map['heading'] = 'Email Update:';

    await http.post(
      url,
      body: map,
    );
  }
}

