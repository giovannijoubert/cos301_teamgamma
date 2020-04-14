import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/enums/viewstate.dart';
import '../../core/models/user.dart';
import '../../core/viewmodels/home_model.dart';
import '../ui/../shared/app_colors.dart';
import '../ui/../shared/text_styles.dart';
import 'dart:ui';

import 'base_view.dart';

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



class ActivateListeningMode extends StatelessWidget {
  static String imgSrc;
  static String colour;
  
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = new HomeModel();
    imgSrc = homeModel.getListeningModeImg();
    colour = homeModel.getListeningModeColour();

    Widget mouthText = new Container(
      child: Image.asset(
          imgSrc, 
          width: 900, 
          height: 900,
        ),
    );

    Widget closeIcon = new Visibility (
      child: Container (
        margin: EdgeInsets.only(top: 30, left: 20),
        child: GestureDetector(
          child: Icon(Icons.close, size: 35.0, color: (colour == '0xFFFFFFFF') ? Color(0xFF303030) : Colors.white),
          onTap: () { 
            _isVisible = false;
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