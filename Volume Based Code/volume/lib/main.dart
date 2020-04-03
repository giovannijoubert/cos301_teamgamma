import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volume Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Converter Volume Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> _colors = [
    Colors.blue,
    Colors.red
  ];

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
        this._isRecording = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                  Image.asset(
                    mouthIndex,
                    width: 300,
                    height: 300,
                    fit: BoxFit.fill,
                    gaplessPlayback: true,
                  ),
                  Text(numRead),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          //----------------------------
                          setState(() {
                            _currIndex = 1;
                          });
                          //----------------------------
                          try{
                            _noiseMeter = new NoiseMeter();
                            _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
                          } on NoiseMeterException catch (exception) {
                            print(exception);
                          }
                          //----------------------------
                        },
                        child: new Icon(Icons.fiber_manual_record),
                        color: _colors[_currIndex],
                        textColor: Colors.white,
                        elevation: 5,
                      ),
                      Container(
                        width: 10,
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          //----------------------------
                          setState(() {
                            _currIndex = 0;
                          });
                          //----------------------------
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
                          }
                          //----------------------------
                        },
                        child: Icon(Icons.stop),
                        color: Colors.blue,
                        textColor: Colors.white,
                        elevation: 5,
                      ),
                    ],
                  ),
              ],
        ),
      ),
      
    );
  }
}
