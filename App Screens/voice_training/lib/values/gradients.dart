/*
*  gradients.dart
*  VoiceTraining
*
*  Created by Laura.
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/rendering.dart';


class Gradients {
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment(0.5, -0.07894),
    end: Alignment(0.5, 1.05295),
    stops: [
      0,
      1,
    ],
    colors: [
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(255, 71, 71, 71),
    ],
  );
}