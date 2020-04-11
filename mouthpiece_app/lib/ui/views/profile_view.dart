import 'package:flutter/material.dart';
import 'package:mouthpiece_app/ui/views/choose_mode_view.dart';
import 'package:mouthpiece_app/ui/views/login_view.dart';
import 'package:mouthpiece_app/ui/views/voice_training_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/viewmodels/profile_model.dart';
import '../../ui/shared/app_colors.dart';
import '../widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';
import '../../ui/shared/app_colors.dart';

import 'base_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _currentTabIndex = 2;

  @override
  Widget build(BuildContext context) {
    BottomNavigation bottomNavigation = new BottomNavigation();
    bottomNavigation.setIndex(_currentTabIndex);

    return BaseView<ProfileModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: ListView(
            children: <Widget>[
              optionSection,
              profileSection,
              PreferencesSection(),
              SignOutButton(),
            ]
          ),
          bottomNavigationBar: BottomNavigation(),
        ),
    );
  }
}

Widget optionSection = new Container (
  margin: EdgeInsets.only(top: 30, left: 20, right: 20),
  child: new Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      // Icon(Icons.arrow_back_ios),
      new Text(
        'Edit', 
        // textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17, fontFamily: 'Helvetica', color: Color(0xFF303030)),
      ),
    ]
  ),
);

Widget divider = new Container(
  child: Divider(color: Colors.black, thickness: 1.2,),
  margin: EdgeInsets.only(top: 5, bottom: 12),
);

Widget profileSection = new Container (
  margin: EdgeInsets.only(top: 20.0),
  child: new Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      RawMaterialButton(
        onPressed: () {},
        fillColor: Colors.white,
        shape: CircleBorder(), 
        child: Container(
          child: ClipOval (child: Image.asset('assets/bill.png', fit: BoxFit.contain, width: double.infinity, height: double.infinity,)),
          width: 100,
          height: 100,
        ),
      ),
      SizedBox(height: 30),
      new Text(
        'Bill Gates', 
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Helvetica', color: Color(0xFF303030)),
        
      ),
      new Text(
        'Pretoria, South Africa', 
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontFamily: 'Helvetica', color: Color(0xFF303030)),
      )
    ],
  )
);

class PreferencesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container (
      margin: EdgeInsets.only(left: 20, right: 20, top: 40),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => ChooseModeView(),
              ),);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  children: <Widget> [
                    Padding(child: new Icon(Icons.mic), padding: EdgeInsets.only(right: 10),),
                    new Text(
                    'Choose Listening Mode', 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontFamily: 'Helvetica', color: Color(0xFF303030))),
                  ]
                ),
                new Icon(Icons.arrow_forward_ios),
              ],
            ), 
          ),
          divider,
          InkWell(
            onTap: () {
              
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  children: <Widget> [
                    Padding(child: new Icon(Icons.brightness_2), padding: EdgeInsets.only(right: 10)),
                    new Text(
                    'Dark Mode', 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontFamily: 'Helvetica', color: Color(0xFF303030))),
                  ]
                ),
                new Icon(Icons.hdr_weak),
              ],
            ),
          ),
          divider,
          InkWell(
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => VoiceTrainingView(),
              ),);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  children: <Widget> [
                    Padding(child: new Icon(Icons.settings_voice), padding: EdgeInsets.only(right: 10)),
                    new Text(
                    'Voice Training', 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontFamily: 'Helvetica', color: Color(0xFF303030))),
                  ]
                ),
                new Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          divider
        ],
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container (
      width: 20,
      height: 50,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.fromLTRB(95, 0, 95, 0),
      child: RawMaterialButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('loggedIn', false);
          prefs.setInt('index', 0);
          Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(pageBuilder: (context, animation1, animation2) => LoginView()), (Route<dynamic> route) => false);
        },
        padding: EdgeInsets.all(15),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        fillColor: Color(0xFF303030),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Padding(child: Icon(Icons.exit_to_app, color: Colors.white,), padding: EdgeInsets.only(right: 5),),
            Text('Sign Out', style: TextStyle(color: Colors.white, fontFamily: 'Helvetica', fontSize: 15),),
          ],
        )
      ),
    );
  }
}