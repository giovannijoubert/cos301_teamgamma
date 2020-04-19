package com.longjikang.fft_test;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.view.View;
import android.util.Log;

import com.longjikang.fft_test.mainfiles.Recorder;

public class MainActivity extends AppCompatActivity {

    private static final int RECORD_REQUEST_CODE = 101;
    private static final int WRITE_REQUEST_CODE = 101;
    Recorder mainRecorder = new Recorder(this);

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
    }

    public void RecordPressed(View view) {
        mainRecorder.startRecording("testing");
    }

    public void StoppedPressed(View view) {
        mainRecorder.stopRecording();
    }

    public void DeletePressed(View view) {
        mainRecorder.deleteFile();
    }
}
