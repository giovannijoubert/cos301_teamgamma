import 'dart:io';

import 'package:flutter/material.dart';
import '../../core/viewmodels/choose_mode_model.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';

import 'base_view.dart';

class ChooseModeView extends StatefulWidget {
  @override
  _ChooseModeState createState() => _ChooseModeState();
}

class _ChooseModeState extends State<ChooseModeView> {

  @override
  Widget build(BuildContext context) {
    return BaseView<ChooseModeModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: ListView(
            children: [
              titleSection,
              volumeSection,
              volumeCaptionSection,
              volumeButtonSection(context, model),
              imageSection,
              formantSection,
              formantCaptionSection,
              formantButtonSection(context, model),
            ],
          ),
        ),
    );
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 16),
  child: Text(
    'Choose listening mode',
    style: TextStyle(
      fontSize: 24,
      color: Color(0xff303030),
    ),
    textAlign: TextAlign.center,
  ),
);

Widget volumeSection = Container(
  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
  child: Text(
    'Volume',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30,
      color: Color(0xff303030),
      fontFamily: 'Arciform',
    ),
  ),
);

Widget volumeCaptionSection = Container(
  padding: const EdgeInsets.only(left:32, right: 32),
  child: Text(
    'Transition between 3 different mouths based on the volume of your voice',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 16,
      color: Color(0xff303030),
    ),
  ),
);

Widget volumeButtonSection(BuildContext context, model) {
  return Container(
    padding: const EdgeInsets.only(left:32, right: 32, top: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new RawMaterialButton(
          onPressed: () async {
            Navigator.pushNamed(context, '/');
            /* var modeSuccessfullySet = await model.setUserMode("Volume");
            if(modeSuccessfullySet){
              Navigator.pushNamed(context, '/');
            } */
          },
          shape: CircleBorder(),
          child:Container(
            height: 65,
            width: 65,
            child: new Icon(
              Icons.mic_none,
              color: Color(0xff61A3EE),
              size: 35.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xffffb8b8),
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget imageSection = Container(
  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  child: Image.asset('assets/images/wave.png')
);

Widget formantSection = Container(
  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  child: Text(
    'Formant',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30,
      color: Color(0xff303030),
      fontFamily: 'Arciform',
    ),
  ),
);

Widget formantCaptionSection = Container(
  padding: const EdgeInsets.only(left:32, right: 32),
  child: Text(
    'Transition between 12 different mouths based on different sounds you make.',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 16,
      color: Color(0xff303030),
    ),
  ),
);

Widget formantButtonSection(BuildContext context, model) {
  return Container(
    padding: const EdgeInsets.only(left:32, right: 32, top: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new RawMaterialButton(
          onPressed: () async {
            Navigator.pushNamed(context, '/');
            /* var modeSuccessfullySet = await model.setUserMode("formant");
            if(modeSuccessfullySet){
              Navigator.pushNamed(context, '/');
            } */
          },
          shape: CircleBorder(),
          child:Container(
            height: 65,
            width: 65,
            child: new Icon(
              Icons.mic_none,
              color: Color(0xff303030),
              size: 35.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xffffb8b8),
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
