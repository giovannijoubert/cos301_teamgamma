import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'notifications/password_generator.dart';

class NotificationsApi {
  static const url = 'https://teamgamma.ga/notification/notificationAPI.php';
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

    await http.post(
      url,
      body: map,
    );
  }
  
}

