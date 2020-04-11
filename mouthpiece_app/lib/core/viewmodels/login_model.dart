import '../enums/viewstate.dart';
import '../services/authentication/authentication_service.dart';
import '../viewmodels/base_model.dart';
import '../../locator.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _loginAuthenticationService = locator<AuthenticationService>();

  String errorMessage;

Future<bool> login(String email, String pass) async {
    setState(ViewState.Busy);
    
    String userKey;
    //var success = await _loginAuthenticationService.login(email, pass);
     var success = true;
    if(success && email != null && pass != null){
      setState(ViewState.Idle);

      return true;
    }else{
        return false;
    }

  }
}