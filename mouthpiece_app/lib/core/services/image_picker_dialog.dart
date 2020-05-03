import 'dart:async';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'image_picker_handler.dart';

class ImagePickerDialog extends StatelessWidget {

  ImagePickerHandler _listener;
  AnimationController _controller;
  BuildContext context;

  ImagePickerDialog(this._listener, this._controller);

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  void initState() {
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => new SlideTransition(
            position: _drawerDetailsPosition,
            child: new FadeTransition(
              opacity: new ReverseAnimation(_drawerContentsOpacity),
              child: this,
            ),
          ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    _controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Material(
        type: MaterialType.transparency,
        child: new Opacity(
          opacity: 1.0,
          child: new Container(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 325,
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child:  RaisedButton(
                      textColor: Colors.white,
                      color: mainTextColor,
                      child: Text(
                      'Camera',
                      style: TextStyle(fontSize: 20,
                      fontFamily: 'Arciform'),
                    ),
                    onPressed: () => _listener.openCamera() ,
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    )
                  )
                ) ,
                Container(
                  height: 50,
                  width: 325,
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child:  RaisedButton(
                      textColor: Colors.white,
                      color: mainTextColor,
                      child: Text(
                      'Gallery',
                      style: TextStyle(fontSize: 20,
                      fontFamily: 'Arciform'),
                    ),
                    onPressed: () => _listener.openGallery() ,
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    )
                  )
                ),
                const SizedBox(height: 15.0),
                Container(
                  height: 50,
                  width: 325,
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child:  RaisedButton(
                      textColor: Colors.white,
                      color: mainTextColor,
                      child: Text(
                      'Cancel',
                      style: TextStyle(fontSize:20 ,
                      fontFamily: 'Arciform'),
                    ),
                    onPressed: () => dismissDialog() ,
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    )
                  )
                )
              ],
            ),
          ),
        ));
  }

  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(100.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }
}