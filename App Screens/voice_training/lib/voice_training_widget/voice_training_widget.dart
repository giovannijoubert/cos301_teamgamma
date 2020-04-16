/*
*  voice_training_widget.dart
*  VoiceTraining
*
*  Created by Laura.
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:voice_training/values/values.dart';


class VoiceTrainingWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          children: [
            Container(
              width: 47,
              height: 6,
              margin: EdgeInsets.only(top: 38),
              decoration: BoxDecoration(
                gradient: Gradients.primaryGradient,
                borderRadius: BorderRadius.all(Radius.circular(1.78269)),
              ),
              child: Container(),
            ),
            Container(
              width: 149,
              margin: EdgeInsets.only(top: 26),
              child: Text(
                "Voice Training",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Verdana",
                  fontWeight: FontWeight.w400,
                  fontSize: 21,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 251,
                margin: EdgeInsets.only(left: 21, top: 12),
                child: Opacity(
                  opacity: 0.7,
                  child: Text(
                    "Please train your voice for better results when using the app.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Verdana",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 75),
              child: Text(
                "elephant",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Lane - Narrow",
                  fontWeight: FontWeight.w400,
                  fontSize: 50,
                ),
              ),
            ),
            Container(
              width: 191,
              height: 51,
              margin: EdgeInsets.only(top: 81),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    left: -4,
                    right: -1,
                    child: Opacity(
                      opacity: 0.7,
                      child: Text(
                        "Press     then read the word aloud.\n\nPress again to stop recording.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Muna",
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          height: 0.90909,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 32,
                    top: 10,
                    child: Image.asset(
                      "assets/images/group-62.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 308,
                margin: EdgeInsets.only(top: 42, bottom: 121),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 13,
                      child: Image.asset(
                        "assets/images/group-64.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          boxShadow: [
                            Shadows.primaryShadow,
                          ],
                          borderRadius: Radii.k30pxRadius,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 30,
                              child: Image.asset(
                                "assets/images/group-65.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}