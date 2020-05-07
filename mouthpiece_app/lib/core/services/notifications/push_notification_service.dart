import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mouthpiece/ui/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  // GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  // GlobalKey<NavigatorState> get navigationKey => _navigationKey;
  
  // final NavigationService _navigationService = locator<NavigationService>();

  Future initialise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String appToken = 'fii_BCZOQoSAIDLWuOtp-z:APA91bFksNC_nqw0UTgFWtSLt25TQ1ZgUPQBwBpjeWaTgjA5ATRVjDQe_pTXOoneDifM6hGAA6ngh8ROSGh1RpDzSGPdl_DQGPpxdjAe96FGGFxI2DFjW6HMUOaQTriIm0l4YHx4-hGX';
    if (Platform.isAndroid) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.getToken().then((String token) {
      if (token == appToken)
      _fcm.configure(
      // Called when the app is in the foreground and we receive a push notification
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
        },
        // Called when the app has been closed comlpetely and it's opened
        // from the push notification.
        onLaunch: (Map<String, dynamic> message) async {
          print('onLaunch: $message');
          print('token: $token');
          // _serialiseAndNavigate(message);
        }, 
        // Called when the app is in the background and it's opened
        // from the push notification.
        onResume: (Map<String, dynamic> message) async {
          print('onResume: $message');
          print('token: $token');
          // _serialiseAndNavigate(message);
        },
      );
    });

    
  }

  /* Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
    .pushNamed(routeName, arguments: arguments);
  } */

  void _serialiseAndNavigate(Map<String, dynamic> message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    var notificationData = message['data'];
    var view = notificationData['home'];
    String fireBaseDeviceId = notificationData['device_id'];
    print(fireBaseDeviceId);
    String deviceId = prefs.getString("deviceid");

    if (view != null) {
      // Navigate to the create post view
      if (fireBaseDeviceId == deviceId) {
        print("success");
        // navigateTo('/');
      }
    }
  }
}