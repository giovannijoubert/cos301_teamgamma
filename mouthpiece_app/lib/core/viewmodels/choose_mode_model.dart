import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';

import '../../locator.dart';

class ChooseModeModel extends BaseModel {
  static bool isSet = false;

  void setIsSet(bool value) {
    isSet = value;
  }

  bool getIsSet() {
    return isSet;
  }
  
  setUserMode(String mode) async {

  }

  void updateUserMode(String newMode) async {

  }
}
