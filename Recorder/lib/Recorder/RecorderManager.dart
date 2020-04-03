import 'dart:async';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class RecorderManager {
  Directory tempDir;

  FlutterAudioRecorder _recorder;

  final String folderPath = '/TrainingAudio/';
  final String _prefix = 'Recorder Manager:';
  String currentPath;

  Future<void> checkPermission() async {
    bool micPermission = false;
    while (!micPermission) {
      micPermission = await FlutterAudioRecorder.hasPermissions;
    }
  }

  Future<void> init(String word) async {
    try {
      tempDir = await getApplicationDocumentsDirectory();

      String tempPath = tempDir.path + folderPath + word;
      
      //Check if directory exists and create directory if it doesn't
      final Directory recordingDirectory = Directory(tempDir.path + folderPath);
      debugPrint('$_prefix Searching for directory ' + recordingDirectory.path + '...');
      if (!recordingDirectory.existsSync()) {
        await recordingDirectory.create(recursive:true);
        debugPrint('$_prefix Directory ' + recordingDirectory.path + ' was not found and has been created!');
      } else {
        debugPrint('$_prefix Directory ' + recordingDirectory.path + 'was found!');
      }


      debugPrint('$_prefix Recorder initializing for sound $word...');
      _recorder = FlutterAudioRecorder(tempPath, audioFormat: AudioFormat.WAV);
      await _recorder.initialized;
      debugPrint('$_prefix Recorder initialized for sound $word!');
    } catch (e) {
        debugPrint('$_prefix Error initializing recorder!');
        debugPrint(e.toString());
    }
  }

  Future<String> record(String word) async {
    try {
      debugPrint('$_prefix Starting recorder initialization routine...');
      await init(word);
      debugPrint('$_prefix Recorder initialization routine complete...');
      
      debugPrint('$_prefix Recorder starting...');
      await _recorder.start();
      debugPrint('$_prefix Recorder started successfully!');
      
      return folderPath + word + '.wav';
    } catch (e) {
      debugPrint('$_prefix Recorder was unable to start successfully!');
      debugPrint(e.toString());
      return null;
    }
  }

  void stopRecorder() async {
    try {
      debugPrint('$_prefix Recorder ending and saving recording...');
      var result = await _recorder.stop();
      debugPrint('$_prefix Recorder ended successfully!');
      debugPrint('$_prefix Recording saved to: ' + result.path);

      /*
        TODO:
          Add code for passing the audio wave file to the spectogram generator
          Add code for deleting recorded wave files
      */

    } catch (e) {
      debugPrint('$_prefix Recorder was unable to save recording!');
      debugPrint(e.toString());
    }
  }
}