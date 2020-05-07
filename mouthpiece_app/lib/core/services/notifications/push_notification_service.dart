import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mouthpiece/ui/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isAndroid) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    
    _fcm.configure(
    // Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        Fluttertoast.showToast(
          msg: message['notification']['title'] + ": " + message['notification']['body'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Color(0xff303030),
          textColor: Colors.white,
          fontSize: 16.0
        );
      },
      // Called when the app has been closed comlpetely and it's opened
      // from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        // _serialiseAndNavigate(message);
      }, 
      // Called when the app is in the background and it's opened
      // from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        // _serialiseAndNavigate(message);
      },
    );
  }
}