package com.example.mouthpiece;

import com.example.mouthpiece.mainfiles.Recorder;
import com.example.mouthpiece.mainfiles.SoundList;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                    (call, result) -> {

                      if (call.method.equals("startRecording")){
                        RecordPressed();
                        result.success("Result returned from startRecording in Main");
                      }
                      else if(call.method.equals("stopRecording")){
                        StoppedPressed();
                        result.success("Result returned from stopRecording in Main");
                      }
                        
                    }
                    
                    
            );
    soundList.reset();
    currentList = soundList.getCurrent();
  }
  private static final String CHANNEL = "voiceTrainer";
  private TextView soundView;
  private TextView exampleView;
  private String[] currentList;
  private static final int RECORD_REQUEST_CODE = 101;
  Recorder mainRecorder = new Recorder(this);
  SoundList soundList = new SoundList();














  /* Set the text view fields and assign their first values */

 // soundView = findViewById(R.id.soundText);
  //exampleView = findViewById(R.id.exampleText);


  public void RecordPressed() {
    Log.i("Entered startPressed inside Main","");
    mainRecorder.startRecording(currentList[0]);
}
// Removed View view from paramters
public void StoppedPressed() {
    Log.i("Entered stopeedPressed inside Main","");
  mainRecorder.stopRecording();
  currentList = soundList.getCurrent();
  //mainRecorder.deleteFile();
  //refreshTextFields();
}
public void DeletePressed(View view) {
  mainRecorder.deleteFile();
}

private void refreshTextFields() {
  soundView.setText(currentList[0]);
  exampleView.setText(currentList[1]);

  Log.i("Test",currentList[0] + "\t||\t" + currentList[1]);
}

}