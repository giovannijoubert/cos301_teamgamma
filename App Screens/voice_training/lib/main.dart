/*
*  main.dart
*  VoiceTraining
*
*  Created by Laura.
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:voice_training/voice_training_widget/voice_training_widget.dart';

void main() => runApp(App());


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      home: VoiceTrainingWidget(),
    );
  }
}