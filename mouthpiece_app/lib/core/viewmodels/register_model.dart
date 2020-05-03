import '../enums/viewstate.dart';
import '../services/authentication/authentication_service.dart';
import '../viewmodels/base_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';

class RegisterModel extends BaseModel {
  var test;
  final AuthenticationService _registerAuthenticationService = locator<AuthenticationService>();

  String errorMessage;


  Future<bool> register(String username, String email, String pass) async {
    setState(ViewState.Busy);

     var success = await _registerAuthenticationService.register(username, email, pass);

      if (success) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setBool('registered', true);
        // setState(ViewState.Idle);
        test = true;
        return test;
      } else {
        test = false;
        return test;
      }
  }
}