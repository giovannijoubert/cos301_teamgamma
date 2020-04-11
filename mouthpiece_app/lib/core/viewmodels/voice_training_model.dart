import 'package:mouthpiece_app/ui/views/voice_training_view.dart';

import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';
import '../../locator.dart';
import 'dart:io' as io;
import 'package:file/file.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:file/local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceTrainingModel extends BaseModel {


  final LocalFileSystem localFileSystem;
  VoiceTrainingModel({localFileSystem}):
  this.localFileSystem = localFileSystem ?? LocalFileSystem();

 String wordColour = "0xff54ff33";
  String errorMessage;

  var arr = ["Apples", "Pears", "Peaches"];
  var index = 0;

  bool changeMode(bool mode) {
    return !mode;
  }

  String changeToNextWord(){
    String word = arr[index];
    index++;

    if (index > 2) 
      index = 0;
    
    return word;
  }
  

  String changeWordStart(){
    return 'Start';
  }

    final PermissionHandler _permissionHandler = PermissionHandler();
    // Template code to access permissions
    Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }    return false;
  }
  // Important note: permissions listed below are just for android, need to do 
  // Platform.isAndroid ? : to sort out for iOS
  // Specific code to request permissions if !hasPermission
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
    return permissionStatus == PermissionStatus.granted;
  }
// Specific code to check hasPermission
  Future<bool> hasMicrophonePermission() async {
    return hasPermission(PermissionGroup.microphone);
  }

  Future<bool> hasStoragePermission() async {
    return hasPermission(PermissionGroup.storage);
  }

  Recording globalRecording=  new Recording();
  bool globalIsRecording = false; 



int i=0;

start() async {
    try {
         bool Microphonepermission = await requestMicrophonePermission();
         bool StoragePermission = await requestStoragePermission();
      if (await AudioRecorder.hasPermissions) {
        print("Permission granted");

            final io.Directory appDocDirectory =
                await getApplicationDocumentsDirectory();
            final String path = '${appDocDirectory.path}/TrainingFiles';
            await new io.Directory(path).create(recursive:true);
            String filePath = '$path/${DateTime.now().toUtc().millisecondsSinceEpoch.toString()}';
           // i++;
           // filePath+='newFile'+i.toString();
          print("Start recording: $filePath");
          
          await AudioRecorder.start(
              path: filePath, audioOutputFormat: AudioOutputFormat.AAC);
          wordColour="0xff0d72e7";
          bool isRecording = await AudioRecorder.isRecording;
          globalRecording = new Recording(duration: new Duration(), path: "");
          globalIsRecording = isRecording;
        
      } else {
          // Something here to update UI to say permission not granted and thereafter request again
          print("Permission not granted!");
           
      }
    } catch (e) {
      print(e);
    }
  }



  stop() async{ // Stopping requires 2 button taps, fix. Also there is interference from rawButton
    wordColour = "0xffe7110d";
  print("Entered _Stop");
  var recording = await AudioRecorder.stop();
  print("Stop recording: ${recording.path}");
  bool isRecording = await AudioRecorder.isRecording;
    File file = localFileSystem.file(recording.path);
    print("  File length: ${await file.length()}");
      //setState(()) ...
      globalRecording = recording;
      globalIsRecording = isRecording;
      
    }


}