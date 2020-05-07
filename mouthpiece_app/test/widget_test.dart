// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../lib/locator.dart';

import '../lib/core/data/defaultmouthpacks.dart';

import '../lib/core/viewmodels/login_model.dart';
import '../lib/core/viewmodels/register_model.dart';
import '../lib/core/viewmodels/home_model.dart';
import '../lib/core/viewmodels/choose_mode_model.dart';
import '../lib/core/viewmodels/mouth_selection_model.dart';
import '../lib/core/viewmodels/voice_training_model.dart';
import '../lib/core/viewmodels/collection_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SharedPreferences.setMockInitialValues({});
  group('Login', () {
    test('testing empty string', () async {
      //final test = LoginModel();

      //test.login(null,null);

      //expect(test.test, null);

      /*LoginModel test = new LoginModel();    
      Future future = test.login(null, null);
      expect(future, completion(equals(false)));*/

    });

    test('testing string', () async {
      /*final test = LoginModel();

      test.login("test_email","test_pass");

      expect(test.test, null);*/

      /*LoginModel test = new LoginModel();    
      Future future = test.login("test_email", "test_pass");
      expect(future, completion(equals(false)));*/
    });

    /*test('testing reset password notification', () async {
      locator.registerLazySingleton(() => PushNotificationService());
      LoginModel test = new LoginModel();

      SharedPreferences.setMockInitialValues({}); //set values here
      SharedPreferences pref = await SharedPreferences.getInstance();
      String email = "email";
      String deviceId = '1';
      pref.setString('email', email);
      pref.setString('deviceId', deviceId);

      Future future = test.resetPasswordNotification();

      expect(pref.getString('email'), email);
      expect(pref.getString('deviceId'), '1');
    });*/
  });

  group('Register', () {
    test('testing empty string', () async {
      final test = RegisterModel();

      await test.register(null,null,null);

      expect(test.test, false);
    });

    test('testing string', () async {
      final test = RegisterModel();

      await test.register("test_name","test_email","test_pass");

      expect(test.test, false);

      /*final test = RegisterModel();

      await test.register("test_name","test_email","test_pass");

      expect(test.test, true);*/
    });
  });

  group('Home', () {
    test('creating listening mode image list', () {
      final test = HomeModel();

      test.createListeningModeImgList();

      expect(test.test, "got image");
    });

    test('setting and getting update value', () {
      final test = HomeModel();

      test.setUpdateVal(true);

      expect(test.getUpdateVal(), true);
    });

    test('setting nav value', () async {
      final test = HomeModel();

      await test.setNavVal();

      expect(test.test, true);

    });

    test('getting listening mode image list', () {
      final test = HomeModel();

      test.getListeningModeImgList();

      expect(test.test, "got image list");
    });

    test('getting listening mode image', () {
      final test = HomeModel();

      test.getListeningModeImg();

      expect(test.test, "got image");
    });

    test('setting listening mode image', () {
      final test = HomeModel();

      test.setListeningModeImg("test");

      expect(test.test, "test");
    });

    test('setting listening mode colour', () {
      final test = HomeModel();

      test.setListeningModeColour("Red");

      expect(test.test, "Red");
    });

    test('getting listening mode colour', () {
      final test = HomeModel();

      test.setListeningModeColour("Red");
      test.getListeningModeColour();

      expect(test.test, "Red");

    });

    test('testing set and get index', () {
      final test = HomeModel();
      int index = 1;

      test.setIndex(index);

      expect(test.getIndex(), index);
    });

  });

  /*group('Choose mode', () {
    test('testing vol set true', () async {
      final test = ChooseModeModel();

      test.setIsVolSet(true);

      expect(test.test, null/*"vol set"*/);
    });

    test('testing vol set false', () {
      final test = ChooseModeModel();

      test.setIsVolSet(false);

      expect(test.test, null/*"vol not set"*/);
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

      //test.getModeIconColorFor();

      //expect(test.test, <MaterialColor(primary value: Color(0xff2196f3)));
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
  });*/

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

      expect(test.test, "Apple");
    });

    test('testing next word', () {
      final test = VoiceTrainingModel();

      test.changeToNextWord();
      test.getWord();

      expect(test.test, "Everyone");
    });
    
    test('recording', () async {
      
      final test = VoiceTrainingModel();

      //test.recordAudio();

      expect(test.isRecording, false);
    });

    test('stop recording', () async {
      final test = VoiceTrainingModel();

      //test.stopRecordingAudio();

      expect(test.isRecording, false);
    });
  });

   group('Collection', () {
    test('create collection', () async {
      CollectionModel test = CollectionModel();
      expect(test.createCollection(), completes);
    });

    test('create image list', () async {
      SharedPreferences.setMockInitialValues({
        'loggedIn': false,
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();

      CollectionModel test = CollectionModel();
      //expect(await test.createImageList(), completes);

      List<dynamic> collection;
      List<String> imageList = List<String>();

      await test.createCollection();

      imageList.clear();
      for (int i = 0; i < defaultMouthpacks.length; i++) {
        imageList.add(defaultMouthpacks[i]["images"][i]);
      }
      
      if (prefs.getBool("loggedIn") ?? false) {
        for (int i = 0; i < collection.length; i++) {
          imageList.add(collection[i][0]["images"][0]);
        }
      }

      expect(await test.createImageList(), imageList);
    });

    test('clear list', () async {
      final test = CollectionModel();

      await test.createCollection();

      test.clearLists();
      expect(test.test, "clear");

      List<String> colourList = List<String>();
      List<String> imageList = List<String>();

      expect(await test.getImageList(), imageList);
      expect(await test.getColourList(), colourList);
    });

    test('create colour list', () async {
      CollectionModel test = CollectionModel();
      expect(test.createColourList(), completes);
      expect(await test.createColourList(), ['0xFF303030', '0xFF303030', '0xFF303030']);
    });

    test('get colour at index', () async {
      final test = CollectionModel();
      test.getColoursListAtIndex(1);
      expect(test.test, 1);
    });

    test('get image list', () async {
      final test = CollectionModel();
      test.getColourList();
      expect(test.test, true);
    });

    test('get collection', () async {
      final test = CollectionModel();
      test.getCollection();
      expect(test.test, true);
    });

    test('get colour list', () async {
      final test = CollectionModel();
      test.getColourList();
      expect(test.test, true);
    });

    

    test('update mouthpack bg colour', () async {
      CollectionModel test = CollectionModel();
      expect(test.updateMouthpackBgColour(0, "Black"), completes);
    });

    test('remove mouthpack', () async {
      CollectionModel test = CollectionModel();
      //await test.removeMouthpack(1);
      expect(await test.removeMouthpack(1), false);
    });
    
  });
}
