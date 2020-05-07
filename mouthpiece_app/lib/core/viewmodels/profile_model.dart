// import '../enums/viewstate.dart';
import 'dart:convert';

import 'package:file/file.dart';
import 'package:mouthpiece/core/services/notifications_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodels/base_model.dart';
import '../services/api.dart';

import '../../locator.dart';

class ProfileModel extends BaseModel {
  Api _api = locator<Api>();
  NotificationsApi notificationsApi = new NotificationsApi();
  SharedPreferences prefs;

  updateProfileImage(String convertedFile) async {
    prefs = await SharedPreferences.getInstance();
    String url = 'https://teamgamma.ga/api/umtg/update';

    Map map = {
      "option": "image",
      "username" : prefs.getString("username"),
      "jwt" : prefs.getString("jwt"),
      "image" : convertedFile
    };

    await _api.updateImage(url, map);
  }

  Future updateEmailNotification(String email) async {
    await notificationsApi.updateEmail(email);
  }
}
