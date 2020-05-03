import '../enums/viewstate.dart';
import '../services/authentication/authentication_service.dart';
import '../viewmodels/base_model.dart';
import '../../locator.dart';

class LoginModel extends BaseModel {
  var test;
  final AuthenticationService _loginAuthenticationService = locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String _userName, String pass) async {
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
}