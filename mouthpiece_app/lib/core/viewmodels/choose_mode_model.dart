import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import '../../locator.dart';

class ChooseModeModel extends BaseModel {

  static bool isSet = true;

  void setIsVolSet(bool value) {
    isSet = value;
  }

  bool getIsVolSet() {
    return isSet;
  }


  setUserMode(String mode) async {
    // Duplicate function
  }

  void updateUserMode(String newMode) async {
    // Update in .db  as well
    if(newMode=="Volume") 
    setIsVolSet(true);
    else
    setIsVolSet(false);
  }
  void setVolumeBased(){
  
    print("Volume chosen!"); 
    updateUserMode("Volume");

     }
  Color getModeIconColorVol(){
      if(isSet==true)
      return Colors.blue;
      else
      return Colors.black;
  }
  Color getModeIconColorFor(){
     if(isSet==false)
      return Colors.blue;
      else
      return Colors.black;
      
  }
  void setFormantBased(){
  
    print("Formant chosen!"); 
    updateUserMode("Formant");
     }
}