import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';
import '../viewmodels/collection_model.dart';

import '../../locator.dart';

class MouthSelectionModel extends BaseModel {
  var test;
  static int selectedIndex;

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

  int getSelectedIndex() {
    return selectedIndex;
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
  }

  List<String> getBgColourList() {
    return bgColours;
  }
}
