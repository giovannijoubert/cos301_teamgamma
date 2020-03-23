import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/authentication/authentication_service.dart';
import 'locator.dart';
import 'ui/router.dart';

import 'core/models/user.dart';

void main() {
  setupLocator();
  runApp(MouthPiece());
}

class MouthPiece extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<User>(
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
