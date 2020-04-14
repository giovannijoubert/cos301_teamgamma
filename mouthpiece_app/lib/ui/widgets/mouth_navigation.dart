import 'package:flutter/material.dart';

class MouthNavigationBar extends StatefulWidget {
  @override
  _MouthNavigationBarState createState() => _MouthNavigationBarState();
}

class _MouthNavigationBarState extends State<MouthNavigationBar>  {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF303030),
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, "myRoute");
                  print('pressed my collection');
                },
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 10, // space between underline and text
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: Color(0xFF8ACDEF),  // Text colour here
                        width: 3.0, // Underline width
                      ))
                  ),

                  child: Text(
                    "My Collection",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8ACDEF)  // Text colour here
                    ),
                  ),
                ),
              ),
              new GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, "myRoute");
                  print('pressed select mouth');
                },
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 10, // space between underline and text
                  ),
                  child: Text(
                    "Select Mouth",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,  // Text colour here
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}