// import 'dart:io' as io;
// import 'dart:async';
// import 'package:file/file.dart';
// import 'package:file/local.dart';
import 'package:flutter/material.dart';
//import 'package:mouthpiece_app/core/viewmodels/choose_mode_model.dart';
import 'package:mouthpiece/ui/views/choose_mode_view.dart';
import 'package:mouthpiece/ui/views/home_view.dart';
//import 'package:mouthpiece_app/ui/views/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/viewmodels/voice_training_model.dart';
import '../../ui/shared/app_colors.dart';
//import '../../ui/shared/text_styles.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:path_provider/path_provider.dart';
import 'base_view.dart';
//import 'package:flutter/services.dart';

bool check;

class VoiceTrainingView extends StatefulWidget {
  @override
  _VoiceTrainingState createState() => _VoiceTrainingState();
}

class _VoiceTrainingState extends State<VoiceTrainingView> {
  bool trainingMode = false;
  String ins = 'then read the word aloud';
 
  @override
  Widget build(BuildContext context) {
    return BaseView<VoiceTrainingModel>(
        builder: (context, model, child) => Scaffold(
          // backgroundColor: backgroundColor,
          body: ListView(
            children: <Widget>[
              titleSection,
              captionSection,
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                child: Text(
                  model.getWord(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 55,
                    color: model.wordColour,
                    fontFamily: 'Arciform',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:32, right: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Press',
                      style: TextStyle(
                        fontSize: 16,
                        // color: Color(0xff303030),
                      ),
                    ),
                    Icon(
                      model.isRecording ? Icons.mic_off : Icons.mic_none,
                      // color: Color(0xff303030),
                    ),
                    Text(
                      '$ins',
                      style: TextStyle(
                        fontSize: 16,
                        // color: Color(0xff303030),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:32, right: 32, top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new RawMaterialButton(
                      onPressed: (){},
                      shape: CircleBorder(),
                      child: Container(
                        height: 80,
                        width: 112,
                          child: Row(children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.mic_none),
                              color: Color(0xff303030),
                              onPressed:(){ 
                                if(model.isRecording == false) {
                                  setState(() {
                                    model.wordColour=Colors.green;
                                    ins = "when you are done";
                                  });
                                  model.startNativeRec();
                                  //model.recordAudio();
                                 

                                } else {
                                  setState(() {
                                    
                                    ins = "when you are done";
                                  });
                                } 
                              },  
                              // color: Color(0xff303030),
                              iconSize: 40.0, 
                            ),
                            IconButton(
                              icon: Icon(Icons.mic_off),
                              onPressed: (){ if (model.isRecording == true){
                             // model.stopRecordingAudio();
                              model.stopNativeRec();
                              setState(() {
                                model.changeToNextWord();
                                model.wordColour=Colors.red;
                                ins = "then read the word aloud";
                              });}
                               else{
                                print("Not recording, dont press button.");
                              }
                              }
                             ,  
                              color: Color(0xff123456),
                              iconSize: 40.0, 
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffffb8b8),                
                              blurRadius: 4.0,
                              spreadRadius: 3.0,
                              
                            ),
                          ],
                          ),
              
                      ),
                    ),
                  ],
                ),
              ),
              navigationSection(context),
            ],
          ),
        ),
    );
  }
}


Widget titleSection = Container(
  padding: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 16),
  child: Text(
    'Voice Training',
    style: TextStyle(
      fontSize: 26,
      // color: Colors.black87,
    ),
  ),
);

Widget captionSection = Container(
  padding: const EdgeInsets.only(left:32, right: 32),
  child: Text(
    'Please train your voice for better results when using the app.',
    style: TextStyle(
      fontSize: 16,
      // color: Colors.black45,
    ),
  ),
);

Widget navigationSection(BuildContext context) { 
  return FutureBuilder<bool>(
    // future: getCheck(),
    builder: (context, snapshot){
      return Container(
        padding: const EdgeInsets.only(left:32, right: 32, top: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: InkWell(
                    onTap: () => Navigator.pop(context), 
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffb1b4e5),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: InkWell(
                      onTap: () async {
                        Navigator.push(context, PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => ChooseModeView(),
                        ),);
                      },  
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffb1b4e5),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  );
}

Future<bool> getCheck() async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); 
  bool check = prefs.getBool('navVal') ?? false; 
  return check;
}