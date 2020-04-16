/*
*  main.dart
*  ListeningMode
*
*  Created by Laura.
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:listening_mode/activate_listening_mode_formant_based_widget/activate_listening_mode_formant_based_widget.dart';

void main() => runApp(App());


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      home: ActivateListeningModeFormantBasedWidget(),
    );
  }
}