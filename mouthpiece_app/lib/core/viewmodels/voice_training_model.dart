import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';

import '../../locator.dart';

class VoiceTrainingModel extends BaseModel {

  String errorMessage;

  var arr = ["apples", "pears", "peaches"];
  var index = 0;

  bool changeMode(bool mode) {
    return !mode;
  }

  String changeToNextWord(){
    String word = arr[index];
    index++;

    if (index > 2) 
      index = 0;
    
    return word;
  }
  

  String changeWordStart(){
    return 'Start';
  }
}
