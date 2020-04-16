/*
*  choose_listening_mode_widget.dart
*  ListeningMode
*
*  Created by Laura.
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:listening_mode/values/values.dart';


class ChooseListeningModeWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 47,
                height: 6,
                margin: EdgeInsets.only(top: 38),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        width: 47,
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: Gradients.primaryGradient,
                          borderRadius: Radii.k1pxRadius,
                        ),
                        child: Container(),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: 47,
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: Gradients.primaryGradient,
                          borderRadius: Radii.k1pxRadius,
                        ),
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 216,
                margin: EdgeInsets.only(top: 18),
                child: Text(
                  "Choose Listening Mode",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Verdana",
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 67,
                height: 26,
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  " Volume",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Lane - Narrow",
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 210,
                margin: EdgeInsets.only(top: 7),
                child: Text(
                  "Transition between 3 different mouths\nbased on the volume of your voice",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Muna",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 1,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 61,
                height: 61,
                margin: EdgeInsets.only(top: 24),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 61,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(191, 255, 184, 184),
                              offset: Offset(0, 0),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/images/ellipse-365.png",
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Image.asset(
                        "assets/images/group-13.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 59,
              margin: EdgeInsets.only(left: 5, top: 33, right: 5),
              child: Image.asset(
                "assets/images/group-17.png",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 70,
                margin: EdgeInsets.only(top: 46),
                child: Text(
                  "Formant",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Lane - Narrow",
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 210,
                margin: EdgeInsets.only(top: 3),
                child: Text(
                  "Transition between 12 different mouths\nbased on different sounds.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Muna",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 1,
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 61,
                height: 61,
                margin: EdgeInsets.only(bottom: 79),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 61,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(191, 255, 184, 184),
                              offset: Offset(0, 0),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/images/ellipse-366.png",
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Image.asset(
                        "assets/images/group-15.png",
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
    );
  }
}