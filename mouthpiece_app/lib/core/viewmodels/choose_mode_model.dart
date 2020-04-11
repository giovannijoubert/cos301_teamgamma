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

  String modeIconColorVol = '0xff61A3EE'; // Blue - Black = '0xff303030';
  String modeIconColorFor = '0xff303030';

  setUserMode(String mode) async {
    
  }

  void updateUserMode(String newMode) async {
    // Update in .db ? 
  }
  void setVolumeBased(){
    modeIconColorVol='0xff61A3EE';
    modeIconColorFor='0xff303030';
    print("Volume chosen!"); 
    // Add function to set and update in .db this 
    
     }

  void setFormantBased(){
    modeIconColorVol='0xff303030';
    modeIconColorFor='0xff61A3EE';
    print("Formant chosen!"); 
    // Add function to set and update in .db this 
     }
}