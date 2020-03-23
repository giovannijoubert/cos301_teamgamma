import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget optionSection = new Container (
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(Icons.arrow_back_ios),
          new Text(
            'Edit', 
            textAlign: TextAlign.center,
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
      margin: EdgeInsets.only(top: 60.0),
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

    Widget preferencesSection = new Container (
      margin: EdgeInsets.only(left: 20, right: 20, top: 110),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Row(
                children: <Widget> [
                  Padding(child: new Icon(Icons.format_list_bulleted), padding: EdgeInsets.only(right: 10),),
                  new Text(
                  'Preferences', 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontFamily: 'Helvetica', color: Color(0xFF303030))),
                ]
              ),
              new Icon(Icons.arrow_forward_ios),
            ],
          ), 
          divider,
          new Row(
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
          divider,
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Row(
                children: <Widget> [
                  Padding(child: new Icon(Icons.settings), padding: EdgeInsets.only(right: 10)),
                  new Text(
                  'More Settings', 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontFamily: 'Helvetica', color: Color(0xFF303030))),
                ]
              ),
              new Icon(Icons.arrow_forward_ios),
            ],
          ),
          divider
        ],
      ),

    );

    Widget signOutButton = new Container (
      alignment: Alignment.bottomCenter,
      width: 130,
      margin: EdgeInsets.only(bottom: 30, left: 110),
      child: RawMaterialButton(
        onPressed: () {},
        padding: EdgeInsets.all(15),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(6.0)
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

    return Scaffold(
      body: Stack(
        children: <Widget>[
          optionSection,
          profileSection,
          preferencesSection,
          signOutButton
        ]
      ),
    );
  }
}