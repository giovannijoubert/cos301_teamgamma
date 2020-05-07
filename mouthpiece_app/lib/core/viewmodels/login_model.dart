import 'package:mouthpiece/core/services/notifications/push_notification_service.dart';
import 'package:mouthpiece/core/services/notifications_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/viewstate.dart';
import '../services/authentication/authentication_service.dart';
import '../viewmodels/base_model.dart';
import '../../locator.dart';


class LoginModel extends BaseModel {
  var test;
  final AuthenticationService _loginAuthenticationService = locator<AuthenticationService>();
  final PushNotificationService _pushNotificationService = locator<PushNotificationService>();
  SharedPreferences prefs;
  NotificationsApi notificationsApi = locator<NotificationsApi>();
 
  String errorMessage;

  Future<bool> login(String _userName, String pass) async {
    await _pushNotificationService.initialise();
    setState(ViewState.Busy);
    
    var success = await _loginAuthenticationService.login(_userName, pass);

    if (success && _userName  != null && pass != null) {
      setState(ViewState.Idle);
      test = true;
      return test;
    } else {
      test = false;
      return test;
    }
  }

  Future resetPasswordNotification() async {
    prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    String deviceId = prefs.getString("device-id");

    // await notificationsApi.resetPassword("ivas238@gmail.com", deviceId);
    await notificationsApi.resetPassword("cadongernandt@gmail.com");
  }
}