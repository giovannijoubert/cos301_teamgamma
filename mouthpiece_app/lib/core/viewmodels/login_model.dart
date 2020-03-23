import '../enums/viewstate.dart';
import '../services/authentication/authentication_service.dart';
import '../viewmodels/base_model.dart';

import '../../locator.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _loginAuthenticationService = locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String email, String pass) async {
    setState(ViewState.Busy);

    /* var userEmail = int.tryParse(email);

    // Not a number
    if(userEmail == null) {
      errorMessage = 'Value entered is not a number';
      setState(ViewState.Idle);
      return false;
    }

    var success = await _loginAuthenticationService.login(userEmail); */

    setState(ViewState.Idle);
    return true;
  }
}
