

import 'package:flutter/cupertino.dart';
import 'package:mouthpiece_app/ui/views/home_view.dart';
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


class VoiceTrainingModel extends BaseModel {

  
  var test;
  
  Color wordColour = Colors.red;
  var arr = ["Apples", "Pears", "Peaches","New fruit"];   // Add words as required
  var index = 0;

  bool changeMode(bool mode) {
    test = !mode;
    return !mode;
  }
String getWord(){
  test = arr[index];
  return arr[index];
}
  String changeToNextWord(){
    String word = arr[index];
    index++;

    if (index > arr.length-1) 
      index = 0;
    
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
  io.Directory tempDir;
  FlutterAudioRecorder _recorder;
  final String folderPath = '/TrainingAudio/';
  final String _prefix = 'Recorder Manager:';
  String currentPath;
  String errorMessage;
  int i=0;

  void RecordAudio() async{
  print("Entered RecordAudio . . .");
      isRecording=true;
    record(arr[index]);
  }


  void StopRecordingAudio(){
    
    print("Entered StopRecord . . .");
    isRecording=false;
    stopRecorder();
  }




Future<String> record(String word) async {
    try {
          bool StoragePermission = await requestStoragePermission();
          
          bool Microphonepermission = await requestMicrophonePermission();
         
         if(Microphonepermission && StoragePermission){

         // print("Entered record . . .");
      if (await FlutterAudioRecorder.hasPermissions) {

      //print("Permission granted");
      tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path + folderPath + word + i.toString();  // temp solution of file naming 
      //until Deleting of files in folder is implemented by converter team.
      i++;
      final io.Directory recordingDirectory = io.Directory(tempDir.path + folderPath);
      if (!recordingDirectory.existsSync()) 
        await recordingDirectory.create(recursive:true);
       _recorder = FlutterAudioRecorder(tempPath, audioFormat: AudioFormat.WAV);
        await _recorder.initialized;

      await _recorder.start();
      return folderPath + word + '.wav';
      }
    } }catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

void stopRecorder() async {
    try {
      
      if (await FlutterAudioRecorder.hasPermissions) {
      print("Entered stopRecorder . . .");
     
      
      print('$_prefix Recorder ending and saving recording...');
      var result = await _recorder.stop();
    print('$_prefix Recorder ended successfully!');
    print('$_prefix Recording saved to: ' + result.path);

      /*
        TODO:
          Add code for passing the audio wave file to the spectogram generator
          Add code for deleting recorded wave files
      */

    } }catch (e) {
      print('$_prefix Recorder was unable to save recording!');
      print(e.toString());
    }
  }








}