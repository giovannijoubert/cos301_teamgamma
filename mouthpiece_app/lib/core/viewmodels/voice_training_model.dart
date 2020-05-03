

import 'package:file/record_replay.dart';
import 'package:flutter/cupertino.dart';
import 'package:mouthpiece/ui/views/home_view.dart';
import 'package:permission_handler/permission_handler.dart';
import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';
import 'dart:async';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import '../../locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../ui/views/voice_training_view.dart';

class VoiceTrainingModel extends BaseModel {

  static const platformMethodChannel =const MethodChannel('voiceTrainer');

  Future<String> startNativeRec()async{
    String msg;
    isRecording=true;
    try{
      final String result= await platformMethodChannel.invokeMethod('startRecording');
      msg=result;

    } on PlatformException catch (e)
    {
      msg= "cant run native code ... ${e.message}.";
    }
    print(msg);
   return msg;
  }

Future<String> stopNativeRec()async{
    String msg;
    isRecording=false;
    try{
      final String result= await platformMethodChannel.invokeMethod('stopRecording');
      msg=result;

    } on PlatformException catch (e)
    {
      msg= "cant run native code ... ${e.message}.";
    }
    
   print(msg);
   return msg;
  }







  var test;
  
  Color wordColour = Colors.red;
  var index = 0;

  bool changeMode(bool mode) {
    test = !mode;
    return !mode;
  }
String getWord(){
  test = examples[index];
  return examples[index];
}
  String changeToNextWord(){
    String word = examples[index];
    index++;

    if (index > examples.length-1) {
      index = 0;
      // TODO: Completed voice training -> do not restart rather move onto next app page
      // and in sharedPreference update that voiceTraining was completed
      
    }
    return word;
  }
  

 


 final PermissionHandler _permissionHandler = PermissionHandler();


    // Template code to access permissions
    Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }    return false;
  }

  // Important note: permissions listed below are just for android, need to do something like
  // Platform.isAndroid ? : to sort out for iOS permissions

  // Specific code to request permissions 
   Future<bool> requestMicrophonePermission() async {
    return _requestPermission(PermissionGroup.microphone);
   }

    Future<bool> requestStoragePermission() async {
    return _requestPermission(PermissionGroup.storage);
  }

  Future<bool> requestInternetPermission() async {
    return _requestPermission(PermissionGroup.phone);
  }


   // Template code to check if app hasPermission
    Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    return(permissionStatus == PermissionStatus.granted);
    
  }
  // Specific code to check hasPermission
  Future<bool> hasMicrophonePermission() async {
    return hasPermission(PermissionGroup.microphone);
  }
    
  Future<bool> hasStoragePermission() async {
    return hasPermission(PermissionGroup.storage);
  }




  bool isRecording = false;
 

  void recordAudio() async{
  print("Entered RecordAudio . . .");
      isRecording=true;
   // record(arr[index]);
    startNativeRec();
  }


  void stopRecordingAudio(){
    
    print("Entered StopRecord . . .");
    isRecording=false;
  //  stopRecorder();
    stopNativeRec();
  }


        var sounds = [
            "Ah", "Eh", "I",
            "El",
            "Oh",
            "Ceh", "Deh", "Geh", "Keh", "Neh", "Sss", "Teh", "X", "Yeh", "Zee",
            "Fff", "Vvv",
            "Q(cue)", "Weh",
            "Beh", "Meh", "Peh",
            "Uh",
            "Ee",
            "Reh",
            "Th",
            "Ch", "Jeh", "Sh"];

        var examples = [
            "Apple", "Everyone", "I",
            "Light",
            "Orange",
            "Candle", "Delta", "Get", "Candle", "Night", "Snake", "Terminal", "X-ray", "Yes", "Zebra",
            "Free", "Very",
            "Queue", "Win",
            "Boy", "Maybe", "Pepper",
            "Update",
            "Tree",
            "Red",
            "This",
            "Cheese", "Jam", "Shell"];
        





}