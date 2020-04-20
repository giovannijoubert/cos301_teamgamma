package com.longjikang.fft_test;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.longjikang.fft_test.mainfiles.Recorder;
import com.longjikang.fft_test.mainfiles.SoundList;

public class MainActivity extends AppCompatActivity {
    private TextView soundView;
    private TextView exampleView;

    private String[] currentList;

    private static final int RECORD_REQUEST_CODE = 101;

    Recorder mainRecorder = new Recorder(this);

    SoundList soundList = new SoundList();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        int micPermission = ContextCompat.checkSelfPermission(this,
                Manifest.permission.RECORD_AUDIO);

        if (micPermission != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,
                new String[]{
                    Manifest.permission.RECORD_AUDIO,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                    Manifest.permission.INTERNET,
                    Manifest.permission.ACCESS_NETWORK_STATE
                },
                RECORD_REQUEST_CODE);
        }

        /* Set the text view fields and assign their first values */
        soundView = findViewById(R.id.soundText);
        exampleView = findViewById(R.id.exampleText);

        soundList.reset();
        currentList = soundList.getCurrent();

        refreshTextFields();
    }

    public void RecordPressed(View view) {
        mainRecorder.startRecording(currentList[0]);
    }

    public void StoppedPressed(View view) {
        mainRecorder.stopRecording();
        currentList = soundList.getCurrent();
        refreshTextFields();
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
