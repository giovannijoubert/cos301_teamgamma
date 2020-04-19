import 'package:flutter/material.dart';
import 'package:test_app/Player/AudioPlayerManager.dart';
import 'package:test_app/Recorder/RecorderManager.dart';

void main() {
  runApp(new MaterialApp(home: new MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayerManager apm = new AudioPlayerManager();
  RecorderManager rm = new RecorderManager();
  String tempString;

  @override
  void initState() {
    super.initState();
    apm.setFilePath("farawaydemo.wav");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Player Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Team Converter Player Test'),
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child:
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:
                <Widget> [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                      <Widget>[
                        RaisedButton(
                          onPressed: () {
                              apm.play(tempString);
                          },
                          child: new Icon(Icons.play_arrow),
                          color: Colors.blue,
                          textColor: Colors.white,
                          elevation: 5,
                        ),

                        Container(
                          width: 10,
                          height: 10,
                        ),

                        RaisedButton(
                          onPressed: () {
                            apm.pause();
                          },
                          child: new Icon(Icons.pause),
                          color: Colors.blue,
                          textColor: Colors.white,
                          elevation: 5,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                        ),

                        RaisedButton(
                          onPressed: () {
                            apm.stop();
                          },
                          child: new Icon(Icons.stop),
                          color: Colors.blue,
                          textColor: Colors.white,
                          elevation: 5,
                        ),
                      ]
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          await rm.checkPermission();
                          tempString = await rm.record('abc');
                        },
                        child: new Icon(Icons.fiber_manual_record),
                        color: Colors.blue,
                        textColor: Colors.white,
                        elevation: 5,
                      ),
                      Container(
                        width: 10,
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          rm.stopRecorder();
                        },
                        child: new Icon(Icons.stop),
                        color: Colors.blue,
                        textColor: Colors.white,
                        elevation: 5,
                      ),
                      Container(
                        width: 10,
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          apm.delete(tempString);
                        },
                        child: new Icon(Icons.delete),
                        color: Colors.blue,
                        textColor: Colors.white,
                        elevation: 5,
                      ),
                    ],
                  ),
              ],
            ),
        ),
      ),
    );
  }
}