import 'package:flutter/material.dart';
import 'package:mouthpiece/ui/shared/theme.dart';
import 'package:mouthpiece/ui/views/collection_view.dart';
import 'package:mouthpiece/ui/views/home_view.dart';
import 'package:mouthpiece/ui/views/profile_view.dart';
import 'package:provider/provider.dart';


class BottomNavigation extends StatefulWidget {
  static int _currentTabIndex = 0;
  void setIndex(int index) {
    _currentTabIndex = index;
  }
  
  @override
  BottomNavigationState createState() => BottomNavigationState(_currentTabIndex);
}

class BottomNavigationState extends State<BottomNavigation> {
  int _currentTabIndex;
  BottomNavigationState(this._currentTabIndex);
  BottomNavigation model = new BottomNavigation();

  
  @override
  Widget build(BuildContext context) {
    
    _onTap(int selectedIndex) {
      if (_currentTabIndex != selectedIndex) {
      setState(() {
        model.setIndex(selectedIndex);
    
        switch (selectedIndex) {
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
      
       });
       }
    }
    final theme = Provider.of<ThemeChanger>(context);
    return Container(
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home', 
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Helvetica',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download),
            title: Text('Collection', 
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Helvetica',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile', 
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Helvetica',
              ),
            ),
          ),
        ],
        selectedItemColor: Color(0xFFF2929C),
        unselectedItemColor: (theme.getTheme() == lightTheme) ? Color(0xFF303030) : Colors.white,
        onTap: _onTap,
        currentIndex: _currentTabIndex,
        backgroundColor: (theme.getTheme() == darkTheme) ? Color(0x11FFFFFF) : Color(0xFFFFFFFF),
        elevation: 3,
      ),
    );
  }
}