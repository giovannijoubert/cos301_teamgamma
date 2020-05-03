package com.example.mouthpiece.mainfiles;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.media.AudioFormat;
import android.media.AudioRecord;
import android.media.MediaRecorder;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Environment;
import android.util.Log;
import android.widget.Toast;

import androidx.core.content.ContextCompat;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.LinkedList;

public class Recorder {
    private final static FFTProcessor fftProcessor = new FFTProcessor();

    private final static int SAMPLE_RATE = 44100;
    private final static int CHANNELS = AudioFormat.CHANNEL_IN_STEREO;
    private final static int AUDIO_ENCODING = AudioFormat.ENCODING_PCM_16BIT;

    private int bufferSize = AudioRecord.getMinBufferSize(SAMPLE_RATE, CHANNELS, AUDIO_ENCODING);

    private String word = "";
    private final String OUTPUT_DIR = "/MouthPiece/Training";

    private boolean isRecording = false;

    private AudioRecord recorder;

    private Context tempContext;

    LinkedList<double[]> dataArray = new LinkedList();

    public Recorder(Context context) {
        tempContext = context;
    }

    public void startRecording(String word) {
        if (hasInternetConnection()) {
            Thread recorderThread;

            recorder = new AudioRecord(MediaRecorder.AudioSource.MIC, SAMPLE_RATE, CHANNELS, AUDIO_ENCODING, bufferSize);
            this.word = word;

            recorder.startRecording();
            isRecording = true;

            Log.i("Training Recorder", "Recorder started!");

            recorderThread = new Thread(
                new Runnable() {
                    @Override
                    public void run() {
                        audioProcessing();
                    }
                }, "AudioRecorder Thread"
            );

            recorderThread.start();
        } else {
            //Handle no internet connection issue
            Toast.makeText(tempContext.getApplicationContext(),
                    "Cannot record training data without internet access",
                    Toast.LENGTH_SHORT).show();
        }
    }

    public void stopRecording() {
        Thread imageThread;

        if (recorder != null) {
            isRecording = false;

            recorder.stop();
            recorder.release();
            recorder = null;

            imageThread = new Thread(
                new Runnable() {
                    @Override
                    public void run() {
                        createImage();
                    }
                }, "AudioRecorder Thread"
            );

            imageThread.start();
        }
    }

    public void deleteFile() {
        File delete = new File(Environment.getExternalStorageDirectory() + OUTPUT_DIR, word + ".png");
        if (!delete.delete()) {
            Toast.makeText(tempContext.getApplicationContext(),
                    word + ".png was not successfully deleted",
                    Toast.LENGTH_SHORT).show();
        }
    }

    private void audioProcessing() {
        byte[] data = new byte[bufferSize];
        double[] normalizedSignal;

        int read = 0;

        while (isRecording) {
            read = recorder.read(data, 0, bufferSize);
            if (read > 0) {
                normalizedSignal = fftProcessor.calculateFFT(data);
                dataArray.add(normalizedSignal);
            }
        }
    }

    private void createImage() {
        Bitmap graphImage = Bitmap.createBitmap(dataArray.size(), getMaxArray(), Bitmap.Config.RGB_565);
        for (int i = 0; i < dataArray.size(); i++) {
            double[] tempData = dataArray.get(i);
            for (int j = 0; j < tempData.length; j++) {
                int alpha = 255;
                int red = Math.abs((int)(tempData[j] * 10000));
            int green = Math.abs((int)(tempData[j] * 100));
                int blue = (int)(tempData[j] * 10000) % 25;

                graphImage.setPixel(i, j, Color.rgb(red, green, blue));
            }
        }

        try {
            File outputDirectory = new File(OUTPUT_DIR);

            if (!outputDirectory.exists()) {
                outputDirectory.mkdirs();
            }

            File outputFile = new File (Environment.getExternalStorageDirectory() + OUTPUT_DIR, word + ".png");
            File directory = new File(Environment.getExternalStorageDirectory() + OUTPUT_DIR);

            if (!directory.exists()) {
                if (!directory.mkdirs()) {
                    //TODO Add error handling
                    Toast.makeText(tempContext.getApplicationContext(),
                            "Some error occurred while trying to create data directory",
                            Toast.LENGTH_SHORT).show();
                    return;
                }
            }

            Log.i("Path: " + Environment.getExternalStorageDirectory() + OUTPUT_DIR, word + ".png");
            FileOutputStream outputFileStream = new FileOutputStream(outputFile);

            /* Resize */
            Bitmap resized = Bitmap.createScaledBitmap(graphImage, 500, 500, false);
            resized.compress(Bitmap.CompressFormat.PNG, 100, outputFileStream);

            if (outputFileStream != null) {
                outputFileStream.flush();
                outputFileStream.close();
            }
            graphImage.recycle();

            /*Todo Add code to send the image to NN server

            */

            //deleteFile();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //Get maximum elements in any double[] in the dataArray
    private int getMaxArray() {
        int count = 0;

        for (int i = 0; i < dataArray.size(); i++) {
            double[] temp = dataArray.get(i);
            if (temp.length > count) {
                count = temp.length;
            }
        }

        return count;
    }

    //Check for internet connection
    private boolean hasInternetConnection() {
        ConnectivityManager cm = (ConnectivityManager)tempContext.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE);

        NetworkInfo activeNetwork = cm.getActiveNetworkInfo();
        boolean isConnected = (activeNetwork != null && activeNetwork.isConnectedOrConnecting());

        return isConnected;
    }
}