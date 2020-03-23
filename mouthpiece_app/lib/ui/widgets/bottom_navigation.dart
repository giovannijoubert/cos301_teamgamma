import 'package:flutter/material.dart';
int _currentTabIndex = 0;

class BottomNavigation extends StatefulWidget {
  void setIndex(int index) {
    _currentTabIndex = index;
  }

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    _onTap(int tabIndex) {
      switch (tabIndex) {
        case 0:
          Navigator.pushNamed(context, '/');
          break;
        case 1:
          Navigator.pushNamed(context, 'collection');
          break;
        /* case 2:
          Navigator.pushNamed(context, 'mouth-selection');
          break; */
        case 2:
          Navigator.pushNamed(context, 'profile');
          break;
      }
      setState(() {
        _currentTabIndex = tabIndex;
      });
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