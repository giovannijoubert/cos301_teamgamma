import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mouthpiece/core/viewmodels/collection_model.dart';
import 'package:mouthpiece/core/viewmodels/mouth_selection_model.dart';
import 'package:mouthpiece/ui/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/viewmodels/choose_mode_model.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';

import 'base_view.dart';

ChooseModeModel model = new ChooseModeModel();

class ChooseModeView extends StatefulWidget {
  
  @override
  ChooseModeState createState() => ChooseModeState();
}

class ChooseModeState extends State<ChooseModeView> {

  @override
  Widget build(BuildContext context) {
    return BaseView<ChooseModeModel>(
        builder: (context, model, child) => Scaffold(
          // backgroundColor: backgroundColor,
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
      // color: Colors.black,
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
      // color: Colors.black,
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
      // color: Colors.black,
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
          onPressed: ()  async { //onPressed: ()  {
            model.setVolumeBased();
            SharedPreferences prefs = await SharedPreferences.getInstance(); 
            bool check = prefs.getBool('navVal') ?? false; 
            if (!check) {
              Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(pageBuilder: (context, animation1, animation2) => HomeView()), (Route<dynamic> route) => false);
            } else { 
              Navigator.pop(context);
            }
          },
          shape: CircleBorder(),
          child: Container(
            height: 65,
            width: 65,
            child: new Icon(
              Icons.volume_up,
              color:  
               model.getModeIconColorVol()
              ,
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
      // color: Colors.black,
      fontFamily: 'Arciform',
    ),
  ),
);

Widget formantCaptionSection = Container(
  padding: const EdgeInsets.only(left:32, right: 32),
  child: Column(
    children: <Widget>[ 
      Text(
        'Transition between 12 different mouths based on different sounds you make.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          // color: Colors.black,
        ),
      ),
      Text(
        '(Experimental Feature)',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
      ),
    ],
  )
);

Widget formantButtonSection(BuildContext context, model) {
  return Container(
    padding: const EdgeInsets.only(left:32, right: 32, top: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new RawMaterialButton(
          onPressed: () async {
            model.setFormantBased();
        
            SharedPreferences prefs = await SharedPreferences.getInstance(); 
            bool check = prefs.getBool('navVal') ?? false; 
            if (!check) {
              prefs.setBool("navVal", true);
              if (prefs.getBool('loggedIn')) {
                CollectionModel collectionModel = new CollectionModel();
                collectionModel.clearLists();
              }
              Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(pageBuilder: (context, animation1, animation2) => HomeView()), (Route<dynamic> route) => false);
            } else { 
              Navigator.pop(context);
            }
          },
          shape: CircleBorder(),
          child:Container(
            height: 65,
            width: 65,
            child: new Icon(
              Icons.mic_none,
              color: 
              model.getModeIconColorFor()
              ,
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