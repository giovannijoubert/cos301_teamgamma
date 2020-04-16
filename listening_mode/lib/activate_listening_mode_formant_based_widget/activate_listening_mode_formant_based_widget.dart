/*
*  activate_listening_mode_formant_based_widget.dart
*  ListeningMode
*
*  Created by Laura.
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:listening_mode/values/values.dart';


class ActivateListeningModeFormantBasedWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 48, 48, 48),
          border: Border.all(
            width: 1,
            color: Color.fromARGB(255, 112, 112, 112),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 47,
              height: 6,
              margin: EdgeInsets.only(top: 38),
              decoration: BoxDecoration(
                gradient: Gradients.primaryGradient,
                borderRadius: Radii.k1pxRadius,
              ),
              child: Container(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 14,
                height: 14,
                margin: EdgeInsets.only(left: 34, top: 32),
                child: Image.asset(
                  "assets/images/group-28.png",
                  fit: BoxFit.none,
                ),
              ),
            ),
            Container(
              width: 138,
              height: 391,
              margin: EdgeInsets.only(top: 45),
              child: Image.asset(
                "assets/images/group-27.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}