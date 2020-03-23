import '../enums/viewstate.dart';
import '../services/authentication/authentication_service.dart';
import '../viewmodels/base_model.dart';

import '../../locator.dart';

class RegisterModel extends BaseModel {
  final AuthenticationService _registerAuthenticationService = locator<AuthenticationService>();

  String errorMessage;

  Future<bool> register(String username, String email, String pass) async {
    setState(ViewState.Busy);

    /* var userEmail = int.tryParse(email);

    // Not a number
    if(userEmail == null) {
      errorMessage = 'Value entered is not a number';
      setState(ViewState.Idle);
      return false;
    }

    var success = await _authenticationService.login(userEmail);

    // Handle potential error here too.

    setState(ViewState.Idle); */
    return true;
  }
}
