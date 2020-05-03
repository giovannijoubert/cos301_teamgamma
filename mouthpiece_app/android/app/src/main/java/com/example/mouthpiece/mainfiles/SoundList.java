package com.example.mouthpiece.mainfiles;

public class SoundList {
    private String[] sounds =
        {
            "Ah", "Eh", "I",
            "El",
            "Oh",
            "Ceh", "Deh", "Geh", "Keh", "Neh", "Sss", "Teh", "X", "Yeh", "Zee",
            "Fff", "Vvv",
            "Q(cue)", "Weh",
            "Beh", "Meh", "Peh",
            "Uh",
            "Ee",
            "Reh",
            "Th",
            "Ch", "Jeh", "Sh"

        };

    private String[] examples =
        {
            "Apple", "Everyone", "I",
            "Light",
            "Orange",
            "Candle", "Delta", "Get", "Candle", "Night", "Snake", "Terminal", "X-ray", "Yes", "Zebra",
            "Free", "Very",
            "Queue", "Win",
            "Boy", "Maybe", "Pepper",
            "Update",
            "Tree",
            "Red",
            "This",
            "Cheese", "Jam", "Shell"
        };

    private static int current = 0;

    public SoundList() {

    }

    public void reset() {
        current = 0;
    }

    //Will always return a string array of size 2,
    //Index 0: Sound
    //Index 1: Example
    public String[] getCurrent() {
        if (current >= sounds.length) {
            reset();
        }

        String[] set = new String[2];
        set[0] = sounds[current];
        set[1] = examples[current];

        current++;

        return set;
    }
}