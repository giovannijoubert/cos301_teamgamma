import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mouthpiece_app/ui/views/home_view.dart';
import 'package:mouthpiece_app/ui/views/choose_mode_view.dart';
import 'package:provider/provider.dart';
import '../../core/enums/viewstate.dart';
import '../../core/models/user.dart';
import '../../core/viewmodels/home_model.dart';
import '../../core/viewmodels/choose_mode_model.dart';
import '../../core/viewmodels/listening_mode_model.dart';
import '../ui/../shared/app_colors.dart';
import '../ui/../shared/text_styles.dart';
import 'dart:ui';
import 'dart:io' as io;
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';
import 'base_view.dart';
import '../../core/services/Permissions/permissionRequest.dart';


class ListeningModeView extends StatefulWidget {
  @override
  _ListeningModeViewState createState() => _ListeningModeViewState();
}
bool _isVisible = false;
class _ListeningModeViewState extends State<ListeningModeView> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        setState((){
          _isVisible = !_isVisible; 
          
        });
      },
      
      child: ActivateListeningMode(),
    );
    
  }
  
}

class ActivateListeningMode extends StatefulWidget{
  final String name; // or Imagesrc
  ActivateListeningMode({this.name});
  @override
  ActivateListeningModeState createState() => ActivateListeningModeState();
}


class ActivateListeningModeState extends State<ActivateListeningMode> {
  bool isVolset = model.getIsVolSet(); // model is from choose mode view
  String imgSrc = homeModel.getListeningModeImg() ;//= homeModel.getListeningModeImg() but not using for now;
   String colour;
   int i=1;
//-------------
  int _currIndex = 0;
  String mouthIndex = 'assets/temp-package/mouth1.png';
  
  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;

  double widthv = 5.0;

  //function that takes in dB reading and returns index
  int chooseMouth(var _db){
    if(_db <= 45)
    {
      return 0; 
    }
    else if( _db < 50 && _db > 45 )
    {
      return 1;
    }
    else if( _db < 60 && _db > 50 )
    {
      return 2; 
    }
    else if( _db < 70 && _db > 60 )
    {
      return 3; 
    }
    else if( _db < 80 && _db > 70 )
    {
      return 4; 
    }
    else if( _db < 90 && _db > 80 )
    {
      return 5; 
    }else{
      return 0;
    }
  }


  String numRead= 'Test';
  void onData(NoiseReading noiseReading){
    this.setState(() {
      widthv = noiseReading.db + 50;
      if(!this._isRecording){
        _isRecording=true;
       
      }
    

    print(noiseReading.toString());
    numRead = noiseReading.toString();
    
  //choose mouth with decibel input
    int mouthImg = chooseMouth(noiseReading.db.round());

  //choose image
    switch (mouthImg) {
      case 0 : mouthIndex = 'assets/temp-package/mouth1.png'; break;
      case 1 : mouthIndex = 'assets/temp-package/mouth2.png'; break;
      case 2 : mouthIndex = 'assets/temp-package/mouth3.png'; break;
      case 3 : mouthIndex = 'assets/temp-package/mouth4.png'; break;
      case 4 : mouthIndex = 'assets/temp-package/mouth5.png'; break;
      case 5 : mouthIndex = 'assets/temp-package/mouth6.png'; break;
    }

  });
  }

  Future<bool> checkPermission() async {
    permissionRequest pR = new permissionRequest();
          try {
          bool StoragePermission = await  pR.requestStoragePermission();
          bool Microphonepermission = await pR.requestMicrophonePermission();
         
         if(Microphonepermission && StoragePermission)
         {
           print("Permission has been granted in ListeningMode");
         }
  } catch(err)
  {
    print ("Permission error"+err);
  }
  
  }


   //-------------------
  @override
  Widget build (BuildContext context) {
     
    //HomeModel homeModel = new HomeModel();
    //imgSrc = homeModel.getListeningModeImg();  // initial
      var permission = checkPermission();
     if(!_isRecording){
        {
      

           print("Recording not on so start");
            setState(() {
                            _currIndex = 1;
                          });
                           try{
                            _noiseMeter = new NoiseMeter();
                            _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
                          } on NoiseMeterException catch (exception) {
                            print(exception);
                          }
         }
          
     
      }
       
    //_update();
    colour = homeModel.getListeningModeColour();
    //isVolSet = modeChosen.getIsVolSet();
   // print("Volume is chosen = "+ isVolSet.toString()); // Test 
     Widget mouthText = new Container(
      child: Image.asset(
          mouthIndex, //model.getImagesrc -> this changes image inside
          width: 600, 
          height: 600,
          gaplessPlayback: true,
      
        ),
        /* RaisedButton(
          onPressed:() async{ //(){//setState(() {
          //  homeModel.setIndex(4);
         //   homeModel.setListeningModeImg("assets/images/mouth-packs/mouth-5.png");
           // imgSrc = homeModel.getListeningModeImg();
         // imgSrc="assets/temp-package/mouth5.png";
          //  print("Within the setState the changed dir = "+imgSrc);
         // });},
         // Some code to request microphone permission
         // print("pressed button");
        /*  if(!_isRecording){
           print("Recording not on so start");
            setState(() {
                            _currIndex = 1;
                          });
                           try{
                            _noiseMeter = new NoiseMeter();
                            _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
                          } on NoiseMeterException catch (exception) {
                            print(exception);
                          }
         } */
         
           /* print("Recording already on so Stop");
             setState(() {
                            _currIndex = 0;
                          });
                           try{                   
                            if(_noiseSubscription != null){
                              _noiseSubscription.cancel();
                              _noiseSubscription = null;
                            }
                            this.setState(() {
                              this._isRecording = false;
                            });
                          } catch (err){
                            print('stopRecorder error: $err');
                          } */
         
       
       
          } */
         /*   , child: Text(
            'Test Update',
            style: TextStyle(fontSize: 20),
          )
          ), */
     
      
  
    
    );

  
    Widget closeIcon = new Visibility (
      child: Container (
        margin: EdgeInsets.only(top: 30, left: 20),
        child: GestureDetector(
          child: Icon(Icons.close, size: 35.0, color: (colour == '0xFFFFFFFF') ? Colors.black : Colors.red),
          onTap: () { 
            print("About to exit Listening mode");
            _isVisible = false;
            //_isRecording=false; <- Memory leak setState called after
                           try{                   
                            if(_noiseSubscription != null){
                               _noiseSubscription.cancel();
                              _noiseSubscription = null;
                            }
                            
                          } catch (err){
                            print('stopRecorder error: $err');
                          } 
            Navigator.pop(context);
          },
        ),
      ),
      visible: _isVisible,
    );

    return Material(
      child: Hero(
        tag: 'blackBox',
        createRectTween: _createRectTween,
        child: Container(
          color: Color(int.parse(colour)),
          alignment: Alignment.center,
          child: Stack (
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: mouthText
              ),
              closeIcon
              
            ]
          ),
        ),
      ),
    );
   
  
  }
  @override
  static RectTween _createRectTween(Rect begin, Rect end) {
    return CircularRectTween(begin: begin, end: end);
  }

}



class CircularRectTween extends RectTween {
  CircularRectTween({Rect begin, Rect end})
      : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final double width = lerpDouble(begin.width, end.width, t);
    double startWidthCenter = begin.left + (begin.width / 2);
    double startHeightCenter = begin.top + (begin.height / 2);

    return Rect.fromCircle(center: Offset(startWidthCenter, startHeightCenter), radius: width * 1.7);
  }
  
}
