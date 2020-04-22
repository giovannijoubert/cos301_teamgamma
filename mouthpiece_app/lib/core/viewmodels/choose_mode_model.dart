import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ui/views/choose_mode_view.dart';
import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import '../../locator.dart';


class ChooseModeModel extends BaseModel  {
  
//bool isSet= getisVolSet();
 static Color volumeMode = Colors.black;
 static Color formantMode = Colors.black;

  void setIsVolSet(bool value) async{
     SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('isVolSet', value);
    if(value){
    volumeMode=Colors.blue;
    formantMode=Colors.black;
    }
    else
{
    volumeMode=Colors.black;
    formantMode=Colors.blue;
}
    //isSet = value;
    
  }

  Future<bool> getIsVolSet() async  {
   SharedPreferences sp= await SharedPreferences.getInstance();
  bool isVSet=sp.getBool('isVolSet');
  print("Value from isVolset in sharedPref is :"+isVSet.toString());
  return isVSet;
  }




  void updateUserMode(String newMode) async {
    // Update in .db  as well
    if(newMode=="Volume") 
    setIsVolSet(true);
    else
    setIsVolSet(false);
    
  }

  Color getModeIconColorVol() {
      
      return volumeMode;
  }
  Color getModeIconColorFor(){
      return formantMode;
  }

  void setVolumeBased(){
  
    print("Volume chosen!"); 
    updateUserMode("Volume");
    volumeMode=Colors.blue;
     }
  void setFormantBased(){
  
    print("Formant chosen!"); 
    formantMode=Colors.blue;
    updateUserMode("Formant");
     }

  

}