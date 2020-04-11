import 'dart:async';
import '../../models/user.dart';
import '../../../locator.dart';
import '../api.dart';

class AuthenticationService {
  Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

 Future<bool> login(String email, String pass) async {
    User fetchedUser;
    fetchedUser = await _api.fetchUser(email, pass);

    // var hasUser = fetchedUser != null;
    // if(hasUser) {
    //   userController.add(fetchedUser);
    // }

    //return hasUser;
  }

    Future<bool> register(String userName, String email , String password) async {
      User fetchedUser;
      fetchedUser = await _api.createUser(userName, email, password);

      // var hasUser = fetchedUser != null;
      // if(hasUser) {
      //   userController.add(fetchedUser);
      // }

      //return hasUser;
  }
}