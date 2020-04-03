import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioPlayerManager {
  //underscores indicate that a variable is private
  static AudioPlayer _audioPlayer = new AudioPlayer();
  AudioCache _audioCache = new AudioCache(fixedPlayer: _audioPlayer);
  String _filePath;

   AudioPlayerManager() {
     _filePath = "";
    debugPrint("APM: Created!");
  }

  void setFilePath(String path) {
    //TODO: Potential add a throw
    if (path != "") {
      _filePath = path;
    }

    debugPrint("APM: Setting File Path:" + _filePath);
  }

  //Play audio file
  void play(String tempString) async {
    if (tempString != null) {
      //_audioPlayer.play(tempString, isLocal: true);
      Directory dir = await getApplicationDocumentsDirectory();
      _audioPlayer.play(dir.path + tempString, isLocal: true);
      debugPrint("APM: Playing audio...");
    } else {
      debugPrint('Attempted null uri');
    }
  }


  void pause() async {
    _audioPlayer.pause();
    debugPrint("APM: Pausing audio...");
  }

  void stop() async {
     _audioPlayer.stop();
     debugPrint("APM: Stoppig audio...");
  }

  void delete(String temp) {
    var file = new File(temp);
    file.deleteSync();
    debugPrint("APM: Deleted audio file...");
  }

}