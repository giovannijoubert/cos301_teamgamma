package com.longjikang.fft_test.mainfiles;

import com.longjikang.fft_test.supportfiles.Complex;
import com.longjikang.fft_test.supportfiles.FFT;

public class FFTProcessor {
    public double[] calculateFFT(byte[] stream) {
        final int pointNumber = 1024;
        final int halfPointNumber = pointNumber/2;

        double maxSamples;
        double temp;
        double[] absSignals = new double[halfPointNumber];

        Complex[] yValues;
        Complex[] complexSignals = new Complex[pointNumber];

        for (int i = 0; i < pointNumber; i++) {
            temp = (double)((stream[2*i] & 0xFF) | (stream[2*i+1] << 8)) / 32768.0F;
            complexSignals[i] = new Complex(temp, 0.0);
        }

        yValues = FFT.fft(complexSignals);

        //maxSamples = 0.0;
        //int peakPos = 0;

        for (int i = 0; i < halfPointNumber; i++) {
            absSignals[i] = Math.sqrt(Math.pow(yValues[i].re(), 2) + Math.pow(yValues[i].im(), 2));
            /*if (absSignals[i] > pointNumber) {
                maxSamples = absSignals[i];
                peakPos = i;
            }*/
        }

        return absSignals;
    }
}
