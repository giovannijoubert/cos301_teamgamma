import 'package:shared_preferences/shared_preferences.dart';

import '../enums/viewstate.dart';
import '../services/authentication/authentication_service.dart';
import '../viewmodels/base_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../services/notifications_api.dart';

import '../../locator.dart';

class RegisterModel extends BaseModel {
  var test;
  final AuthenticationService _registerAuthenticationService = locator<AuthenticationService>();
  NotificationsApi notificationsApi = locator<NotificationsApi>();
  SharedPreferences prefs;

  String errorMessage;

  Future<bool> register(String username, String email, String pass) async {
    setState(ViewState.Busy);

     var success = await _registerAuthenticationService.register(username, email, pass);

      if (success) {
        test = true;
        return test;
      } else {
        test = false;
        return test;
      }
  }

  Future sendSuccessfulRegisterNotification(String email) async {
    await notificationsApi.successfulRegistration(email); 
  }
}