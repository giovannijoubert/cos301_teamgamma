import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';

import '../../locator.dart';

class MouthSelectionModel extends BaseModel {
  var test;
  static final List<String> images = [];
  static final List<bool> selected = List.generate(25, (i) => false);
  static final List<String> colours = List.generate(25, (i) => '0xFF303030');
  static int mouthIndex;
  
  void createImageList() {
    images.clear();
    for (var i = 1; i < 25; i++) {
      images.add("assets/images/mouth-packs/mouth-"+ i.toString() +".png");
    }
  }

  void clearSelectedList() {
    for (var i = 0; i < selected.length; i++) {
      selected[i] = false;
    }
  }

  // final List<String> colours = [
  //   '0xFF8acdef',
  //   '0xFFb1b4e5',
  //   '0xFFf2929c',
  //   '0xFF61a3ee',
  //   '0xFFff8a8a',
  //   '0xFFb1b4e5',
  //   '0xFF8acdef',
  //   '0xFFd2d2d3',
  //   '0xFF303030',
  //   '0xFF8acdef',
  //   '0xFFb1b4e5',
  //   '0xFFf2929c',
  //   '0xFF61a3ee',
  //   '0xFFff8a8a',
  //   '0xFFb1b4e5',
  //   '0xFF8acdef',
  //   '0xFFd2d2d3',
  //   '0xFF303030',
  //   '0xFF8acdef',
  //   '0xFFb1b4e5',
  //   '0xFFf2929c',
  //   '0xFF61a3ee',
  //   '0xFFff8a8a',
  //   '0xFFb1b4e5',
  //   '0xFF8acdef',
  //   '0xFFd2d2d3',
  //   '0xFF303030',
  // ];

  final List<String> bgColours = [
    '0xFFFFFFFF',
    '0xFFD2D2D3',
    '0xFFFF8A8A',
    '0xFFB1B4E5',
    '0xFF8ACDEF',
    '0xFFFBB03B',
    '0xFF303030',
    '0xFF61A3EE',
    '0xFF5AC9BA',
    '0xFFFB9B71',
    '0xFFD26AA9',
    '0xFF6FD5DC',
  ];

  List<String> getImageList() {
    return images;
  }

  List<String> getColourList() {
    return colours;
  }

  bool getSelectedListAtIndex(int index) {
    return selected[index];
  }

  void setSelectedListAtIndex(int index, bool value) {
    selected[index] = value;
  }

  String getColoursListAtIndex(int index) {
    return colours[index];
  }

  void setColoursListAtIndex(int index, String value) {
    colours[index] = value;
  }

  List<String> getBgColourList() {
    return bgColours;
  }

  void setMouthIndex(int index) {
    mouthIndex = index;
  }

  int getMouthIndex() {
    return mouthIndex;
  }
}
