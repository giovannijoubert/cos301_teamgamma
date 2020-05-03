// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';
import '../lib/core/viewmodels/login_model.dart';
import '../lib/core/viewmodels/register_model.dart';
import '../lib/core/viewmodels/home_model.dart';
import '../lib/core/viewmodels/choose_mode_model.dart';
import '../lib/core/viewmodels/mouth_selection_model.dart';
import '../lib/core/viewmodels/voice_training_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('Login', () {
    test('testing empty string', () {
      final test = LoginModel();

      test.login(null,null);

      expect(test.test, false);
    });

    test('testing string', () {
      final test = LoginModel();

      test.login("test_email","test_pass");

      expect(test.test, true);
    });
  });

  group('Register', () {
    test('testing empty string', () {
      final test = RegisterModel();

      test.register(null,null,null);

      expect(test.test, false);
    });

    test('testing string', () {
      final test = RegisterModel();

      test.register("test_name","test_email","test_pass");

      expect(test.test, true);
    });
  });

  group('Home', () {
    /* test('setting listening mode image', () {
      final test = HomeModel();

      test.setListeningModeImgList("image");

      expect(test.test, "image set");
    }); */

    test('getting listening mode image', () {
      final test = HomeModel();

      test.getListeningModeImgList();

      expect(test.test, "got image list");
    });

    test('setting listening mode colour', () {
      final test = HomeModel();

      test.setListeningModeColour("Red");

      expect(test.test, "colour set");
    });

    test('getting listening mode colour', () {
      final test = HomeModel();

      test.getListeningModeColour();

      expect(test.test, "got colour");
    });

    test('testing set and get index', () {
      final test = HomeModel();
      int index = 1;

      test.setIndex(index);

      expect(test.getIndex(), index);
    });
  });

  group('Choose mode', () {
    test('testing vol set true', () {
      final test = ChooseModeModel();

      test.setIsVolSet(true);

      expect(test.test, "vol set");
    });

    test('testing vol set false', () {
      final test = ChooseModeModel();

      test.setIsVolSet(false);

      expect(test.test, "vol not set");
    });

    test('testing vol getter', () async {
      final test = ChooseModeModel();

      test.setIsVolSet(true);
      await test.getIsVolSet();

      expect(test.test, true);
    });

    test('testing update user mode - string volume', () {
      final test = ChooseModeModel();

      test.updateUserMode("Volume");

      expect(test.test, "volume string");
    });

    test('testing update user mode - string null', () {
      final test = ChooseModeModel();

      test.updateUserMode("test");

      expect(test.test, "no volume string");
    });

    test('testing volume colour - default', () {
      final test = ChooseModeModel();

      test.getModeIconColorVol();

      expect(test.test, Colors.black);
    });

    test('testing formant colour - default', () {
      final test = ChooseModeModel();

      test.getModeIconColorFor();

      expect(test.test, Colors.black);
    });

    test('testing volume colour - selected', () {
      final test = ChooseModeModel();

      test.setVolumeBased();
      test.getModeIconColorVol();

      expect(test.test, Colors.blue);
    });

    test('testing formant colour - selected', () {
      final test = ChooseModeModel();

      test.setFormantBased();
      test.getModeIconColorFor();

      expect(test.test, Colors.blue);
    });
  });

  group('Mouth selection', () {
    test('testing image list creation strings', () {
      final test = MouthSelectionModel();

      // test.updateCollectionLists();

      // expect(test.getImageList()[0], "assets/images/mouth-packs/mouth-1.png");
    });

    test('testing clear selected list', () {
      final test = MouthSelectionModel();

      // test.clearSelectedList();

      // expect(test.getSelectedListAtIndex(1), false);
    });

    test('testing selected list index', () {
      final test = MouthSelectionModel();

      // test.setSelectedListAtIndex(1, true);

      // expect(test.getSelectedListAtIndex(1), true);
    });

    test('testing colour list index', () {
      final test = MouthSelectionModel();

      // expect(test.getColoursListAtIndex(1), "0xFF303030");
    });

    test('testing colour list set', () {
      final test = MouthSelectionModel();

      // test.setColoursListAtIndex(1, test.getBgColourList()[1]);
      
      // expect(test.getColoursListAtIndex(1), "0xFFD2D2D3");
    });

    test('testing mouth index', () {
      final test = MouthSelectionModel();
      int index = 1;

      // test.setMouthIndex(index);
      
      // expect(test.getMouthIndex(), 1);
    });
  });

  group('Voice training', () {
    test('testing mode change', () {
      final test = VoiceTrainingModel();

      test.changeMode(true);

      expect(test.test, false);
    });

    test('testing word get index', () {
      final test = VoiceTrainingModel();

      test.getWord();

      expect(test.test, "Apples");
    });

    test('testing next word', () {
      final test = VoiceTrainingModel();

      test.changeToNextWord();
      test.getWord();

      expect(test.test, "Pears");
    });

    //add recording test

  });
}
