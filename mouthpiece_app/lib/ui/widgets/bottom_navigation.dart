import 'package:flutter/material.dart';
import 'package:mouthpiece_app/ui/views/collection_view.dart';
import 'package:mouthpiece_app/ui/views/home_view.dart';
import 'package:mouthpiece_app/ui/views/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _currentTabIndex = 0;

class BottomNavigation extends StatefulWidget {
  void setIndex(int index) {
    _currentTabIndex = index;
    
  }

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  // static int index = 0;
  @override
  Widget build(BuildContext context) {
    _onTap(int tabIndex) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      if (prefs.getInt('index') != tabIndex) {
        prefs.setInt('index', tabIndex);
        switch (tabIndex) {
          case 0:
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => HomeView(),
            ),);
            break;
          case 1:
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => CollectionView(),
            ),);
            break;
          case 2:
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ProfileView(),
            ),);
            break;
        }
      }
    }

    return Container(
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home', 
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff303030),
                fontFamily: 'Helvetica',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download),
            title: Text('Collection', 
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff303030),
                fontFamily: 'Helvetica',
              ),
            ),
          ),
          /* BottomNavigationBarItem(
            icon: Icon(Icons.art_track ),
            title: Text('Customise Mouth', 
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff303030),
                fontFamily: 'Helvetica',
              ),
            ),
          ), */
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile', 
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff303030),
                fontFamily: 'Helvetica',
              ),
            ),
          ),
        ],
        selectedItemColor: Color(0xFFF2929C),
        unselectedItemColor: Color(0xFF303030),
        onTap: _onTap,
        currentIndex: _currentTabIndex,
      ),
    );
  }
}