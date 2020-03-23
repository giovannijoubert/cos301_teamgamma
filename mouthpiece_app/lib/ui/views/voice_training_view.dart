import 'dart:io';

import 'package:flutter/material.dart';
import '../../core/viewmodels/voice_training_model.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';

import 'base_view.dart';

class VoiceTrainingView extends StatefulWidget {
  @override
  _VoiceTrainingState createState() => _VoiceTrainingState();
}

class _VoiceTrainingState extends State<VoiceTrainingView> {

  bool trainingMode = false;

  String word = 'Start';
  String ins = 'then read the word aloud';

  String wordColour = "0xff303030";

  void validateWord(bool correct) {
    if (correct) {
      this.wordColour = '0xff00ff00';
    } else {
      this.wordColour = '0xffff0000';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VoiceTrainingModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: ListView(
            children: <Widget>[
              titleSection,
              captionSection,
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                child: Text(
                  '$word',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 55,
                    color: Color(int.parse(wordColour)),
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
                        color: Color(0xff303030),
                      ),
                    ),
                    Icon(
                      trainingMode ? Icons.crop_square : Icons.mic_none,
                      color: Color(0xff303030),
                    ),
                    Text(
                      '$ins',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff303030),
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
                      onPressed: () {
                        this.trainingMode = model.changeMode(trainingMode);
                        
                        if (trainingMode == true){
                          setState(() {
                            ins = "when you are done";
                          });
                        } else {
                          validateWord(true);
                          setState(() {
                            word = model.changeToNextWord();
                            ins = "then read the word aloud";
                          });
                        }
                      },
                      shape: CircleBorder(),
                      child: Container(
                        height: 80,
                        width: 80,
                        child: new Icon(
                          trainingMode ? Icons.crop_square : Icons.mic_none,
                          color: Color(0xff303030),
                          size: 40.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffffb8b8),                
                              blurRadius: 7.0,
                              spreadRadius: 2.0,
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
      color: Colors.black87,
    ),
  ),
);

Widget captionSection = Container(
  padding: const EdgeInsets.only(left:32, right: 32),
  child: Text(
    'Please train your voice for better results when using the app.',
    style: TextStyle(
      fontSize: 16,
      color: Colors.black45,
    ),
  ),
);

Widget navigationSection(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left:32, right: 32, top: 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      Column(
          crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, 'choose-mode'), 
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
      ],
    ),
  );
}
