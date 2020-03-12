// class to convert sound to volume that inherits from Conversion interface

import 'dart:collection';

class VolumeBased extends Conversion {

  NoiseMeter _noiseMeter;
  bool _isRecording;
  StreamSubscription<NoiseReading> _noiseSubcription;

  // constructor
  VolumeBased() {}

  void startRecorder() {

  }

  void stopRecorder() {

  }

  void onData(NoiseReading nr) {

  }
}