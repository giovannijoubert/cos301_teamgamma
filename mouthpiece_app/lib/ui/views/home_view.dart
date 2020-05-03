import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mouthpiece/core/enums/viewstate.dart';
import 'package:mouthpiece/core/viewmodels/collection_model.dart';
import 'package:mouthpiece/core/viewmodels/mouth_selection_model.dart';
import 'package:mouthpiece/ui/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/viewmodels/home_model.dart';
import '../ui/../shared/app_colors.dart';
import 'base_view.dart';
import 'listening_mode_view.dart';
import '../widgets/bottom_navigation.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

List<String> images;
List<String> colours;
HomeModel homeModel = new HomeModel();
MouthSelectionModel mouthSelectionModel = new MouthSelectionModel();
CollectionModel collectionModel = new CollectionModel();

class _HomeViewState extends State<HomeView> {
  
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    // collectionModel.createCollection();
    // precacheImage(AssetImage("assets/bill.png"), context);
    BottomNavigation bottomNavigation = new BottomNavigation();
    bottomNavigation.setIndex(_currentTabIndex);
    homeModel.setNavVal();
    // homeModel.changeTheme(context);
    
    images = collectionModel.getImageList();
    colours = collectionModel.getColourList();  

    
    // return FutureBuilder (
    //   future: changeTheme(context),
    //   builder: (context, snapshot) {
        return BaseView<HomeModel>(
          builder: (context, model, child) => Scaffold(
          // backgroundColor: backgroundColor,
            body: (model.state == ViewState.Busy) ? Center(child: CircularProgressIndicator()) : Home(),
            bottomNavigationBar: BottomNavigation(),
          ),
      //   );
      // }
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    
    Widget mouthSection = new Container (
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  if (homeModel.getIndex() - 1 < 0) {
                    homeModel.setIndex(images.length - 1);
                  } else {
                    homeModel.setIndex(homeModel.getIndex() - 1);
                  }
                });
              },
            ),
          ),
          _activateModeBtn(),
          Expanded(
            child: IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  if (homeModel.getIndex() + 1 >= images.length) {
                    homeModel.setIndex(0);
                  } else {
                    homeModel.setIndex(homeModel.getIndex() + 1);
                  }
                });
              },
            ),
          ),
        ]
      ),
    );

    Widget textSection = new Container (
      margin: EdgeInsets.only(top: 60.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Text(
            'Start Listening Mode', 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontFamily: 'Helvetica'),
            
          ),
          SizedBox(height: 30),
          new Text(
            'Swipe or Click to select', 
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'Arciform'),
          )
        ],
      )
    );

    Widget waveImage = new Container (
      alignment: Alignment(1.0, 0.815),
      child: Image.asset('assets/images/wave.png'),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          textSection,
          mouthSection,
          waveImage,
        ]
      ),
    );
  }

  _activateModeBtn() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      child: MouthSelectedBtn(),
    );
  }
}

class MouthSelectedBtn extends StatefulWidget {
  @override
  _MouthSelectedBtnState createState() => _MouthSelectedBtnState();
}

class _MouthSelectedBtnState extends State<MouthSelectedBtn> with TickerProviderStateMixin {
  // static int index = 0;

  AnimationController _controller;
  Animation _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    )..addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => ListeningModeView(),
        ),);
        _controller.reset();          
      }
    });

    _widthAnimation = Tween(begin: 250.0, end: 40.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    images = collectionModel.getImageList();
    colours = collectionModel.getColourList();

    return Material(
      child: GestureDetector(
        onTap: () {
          setState(() {
            homeModel.createListeningModeImgList();
            homeModel.setListeningModeColour(colours[homeModel.getIndex()]);
            _controller.forward();
            // homeModel.setListeningModeImg(images[homeModel.getIndex()]);
            
          });
        },
        child: Hero(
          tag: '',
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            );
          },
          child: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {              
              _onHorizontalDrag(details); 
            },
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: _widthAnimation.value,
              height: 256.0,
              decoration: BoxDecoration(
                color: Color(int.parse(colours[homeModel.getIndex()])),
                shape: BoxShape.circle,
                boxShadow: [
                BoxShadow (
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: ClipOval (
                child: Image.memory(base64.decode(images[homeModel.getIndex()]), 
                fit: BoxFit.contain, width: double.infinity, height: double.infinity,
                )
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onHorizontalDrag(DragEndDetails details) {
    if(details.primaryVelocity == 0) return;
    if (details.primaryVelocity.compareTo(0) == -1) {
      setState(() {
        if (homeModel.getIndex() + 1 >= images.length) {
          homeModel.setIndex(0);
        } else {
          homeModel.setIndex(homeModel.getIndex() + 1);
        }
      });
    }
    else {
      setState(() {
        if (homeModel.getIndex() - 1 < 0) {
          homeModel.setIndex(images.length - 1);
        } else {
          homeModel.setIndex(homeModel.getIndex() - 1);
        }
      });
    }
  }
}
