import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/authentication/authentication_service.dart';
import 'locator.dart';
import 'ui/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/models/user.dart';

void main() {
  setupLocator();
  runApp(MouthPiece());
}

class MouthPiece extends StatefulWidget {
  @override
  _MouthPieceState createState() => _MouthPieceState();
}

class _MouthPieceState extends State<MouthPiece> {
    
  @override
  void initState() {
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getLoggedIn(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          print(snapshot.error);
        }
        if(snapshot.hasData){
          if(snapshot.data == true){
            return StreamProvider<User>(
                initialData: User.initial(),
                builder: (context) => locator<AuthenticationService>().userController,
                child: MaterialApp(
                  title: 'Mouthpiece',
                  theme: ThemeData(),
                  initialRoute: '/',
                  onGenerateRoute: Router.generateRoute,
            ),
            );
          }
          else {
            return StreamProvider<User>(
                initialData: User.initial(),
                builder: (context) => locator<AuthenticationService>().userController,
                child: MaterialApp(
                  title: 'Mouthpiece',
                  theme: ThemeData(),
                  initialRoute: 'login',
                  onGenerateRoute: Router.generateRoute,
                ),
            );
          }
        }
        else {
          return new Center(
            child: new CircularProgressIndicator()
          );
        }    
      },
    );
  }
}

Future<bool> getLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = await prefs.getBool('loggedIn') ?? false;
  return loggedIn;
}
