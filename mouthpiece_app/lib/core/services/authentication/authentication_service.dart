import 'dart:async';
import '../../models/user.dart';
import '../../../locator.dart';
import '../api.dart';
import '../../viewmodels/collection_model.dart';

class AuthenticationService {
  Api _api = locator<Api>();
  CollectionModel collectionModel = CollectionModel();

  StreamController<User> userController = StreamController<User>();

  Future<bool> login(String userName, String pass) async {
    Map map = {
      "username": userName,
      "password": pass,
    };
    print(userName);
    print(pass);

    String url = 'https://teamgamma.ga/api/umtg/login';
    bool userExists = await _api.fetchUser(url, map, userName);
    // await collectionModel.createCollection();

    return userExists;
  }

  Future<bool> register(String userName, String email , String password) async {
    Map map = {
      "username": userName,
      "f_name": "n/a",
      "l_name": "n/a",
      "email": email,
      "password": password
    };

    String url = 'https://teamgamma.ga/api/umtg/register';
    User user = await _api.createUser(url, map, userName);

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}