import 'package:flutter/material.dart';
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

class _HomeViewState extends State<HomeView> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    BottomNavigation bottomNavigation = new BottomNavigation();
    bottomNavigation.setIndex(_currentTabIndex);

    return BaseView<HomeModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: Home(),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget mouthSection = new Container (
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
              },
            ),
          ),
          _activateModeBtn(),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
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
            'Click Me or Swipe', 
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
          // _buildAddButton(context),
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

// _buildAddButton(BuildContext context) {
//   return Container (
//     alignment: FractionalOffset.bottomCenter,
//     margin: new EdgeInsets.only(bottom: 30.0),
//     child: RawMaterialButton(
//       onPressed: () {
//         Navigator.pushNamed(context, 'listening-mode');
//       },
//       child: Container(
//         child: new Icon (Icons.add, color: Color(0xFF303030)),
//         height: 65,
//         width: 65,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xffffb8b8),
//               blurRadius: 5.0,
//               spreadRadius: 0.5
//             )
//           ]
//         ),
//       ),
//       fillColor: Colors.white,
//       shape: CircleBorder(),
//       // elevation: 50,
      
//     ),
//   );
// }

class MouthSelectedBtn extends StatefulWidget {
  @override
  _MouthSelectedBtnState createState() => _MouthSelectedBtnState();
}

class _MouthSelectedBtnState extends State<MouthSelectedBtn> with TickerProviderStateMixin {List<String> images;
  List<String> colours;

  static int index = 0;

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            _controller.reset();
            return ActivateListeningMode();
          }),
        );
      }
    });

    _widthAnimation = Tween(begin: 250.0, end: 40.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = new HomeModel();
    images = homeModel.getImageList();
    colours = homeModel.getBgColourList();
    homeModel.createImageList();
    // homeModel.createColourList();

    return Material(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _controller.forward();
            homeModel.setListeningModeImg(images[index]);
            homeModel.setListeningModeColour(colours[index]);
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
                color: Color(int.parse(colours[index])),
                shape: BoxShape.circle,
              ),
              child: ClipOval (
                child: Image.asset(images[index], 
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
      print('dragged from right to left');
      setState(() {
        index++;
        if (index >= images.length)
          index = 0;
      });
      print(index);
    }
    else {
      print('dragged from left to right');
      setState(() {
        index--;
        if (index < 0)
          index = images.length-1;
        print(index);
      });
    }
  }
}
