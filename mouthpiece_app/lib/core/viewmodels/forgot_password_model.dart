import 'package:mouthpiece/core/services/api.dart';
import 'package:mouthpiece/core/services/notifications/push_notification_service.dart';
import 'package:mouthpiece/core/services/notifications_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/viewstate.dart';
import '../services/authentication/authentication_service.dart';
import '../viewmodels/base_model.dart';
import '../../locator.dart';


class ForgotPasswordModel extends BaseModel {
  var test;
  // final PushNotificationService _pushNotificationService = locator<PushNotificationService>();
  SharedPreferences prefs;
  NotificationsApi notificationsApi = locator<NotificationsApi>();
  Api api = new Api();
 
  String errorMessage;

  Future<bool> checkForEmail(String _email) async {
    setState(ViewState.Busy);
    bool success = await api.getUserWithEmail(_email);
    setState(ViewState.Idle);
    return success;
  }

  Future resetPasswordNotification(String email) async {
    await notificationsApi.resetPassword(email);
  }
}