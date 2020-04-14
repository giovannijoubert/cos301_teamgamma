import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';

import '../../locator.dart';

class ChooseModeModel extends BaseModel {

  static bool isSet = false;

  void setIsVolSet(bool value) {
    isSet = value;
  }

  bool getIsVolSet() {
    return isSet;
  }

  //String modeIconColorVol = '0xff61A3EE'; // Blue - Black = '0xff303030';
  //String modeIconColorFor = '0xff303030';

  setUserMode(String mode) async {
    
  }

  void updateUserMode(String newMode) async {
    // Update in .db ? 
  }
  void setVolumeBased(){
  
    print("Volume chosen!"); 
    // Add function to set and update in .db this 
    
     }
  String getModeIconColorVol(){
      if(isSet==true)
      return "0xff61A3EE";
      else
      return "0xff303030";
  }
  String getModeIconColorFor(){
     if(isSet==false)
      return "0xff61A3EE";
      else
      return "0xff303030";
  }
  void setFormantBased(){
  
    print("Formant chosen!"); 
    // Add function to set and update in .db this 
     }
}