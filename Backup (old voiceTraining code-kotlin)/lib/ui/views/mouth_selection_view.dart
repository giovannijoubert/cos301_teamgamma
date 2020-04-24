import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mouthpiece_app/ui/views/collection_view.dart';
import '../../core/viewmodels/mouth_selection_model.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';
import '../widgets/bottom_navigation.dart';

import 'base_view.dart';

class MouthSelectionView extends StatefulWidget {
  @override
  _MouthSelectionState createState() => _MouthSelectionState();
}

class _MouthSelectionState extends State<MouthSelectionView> {
  int _currentTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    BottomNavigation bottomNavigation = new BottomNavigation();
    bottomNavigation.setIndex(_currentTabIndex);

    return BaseView<MouthSelectionModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MouthNavigationBar(),
                selectMouthText,
                Container(
                  height: 300.0,
                  // child: Expanded(child: MouthSelectionGrid()),
                  child: MouthSelectionGrid(),
                ),
                titleSection,
                Expanded(
                  child: ColourSelectionGrid(updateState: () {setState(() {});},),
                ),
              ],
            ), 
          ),
          bottomNavigationBar: BottomNavigation(),
        ),
    );
  }
}

class MouthNavigationBar extends StatefulWidget {
  @override
  _MouthNavigationBarState createState() => _MouthNavigationBarState();
}

class _MouthNavigationBarState extends State<MouthNavigationBar>  {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF303030),
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => CollectionView(),
                  ),);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 10, // space between underline and text
                  ),
                  child: Text(
                    "My Collection",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFFFFFFF),
                      fontFamily: 'Arciform', 
                    ),
                  ),
                ),
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => MouthSelectionView(),
                  ),);
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
                    "Customise Mouth",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8ACDEF),
                      fontFamily: 'Arciform',
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

Widget selectMouthText = Container(
  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
  child: new Text(
    'Select Mouth',
    style: TextStyle(
      fontSize: 20,
      color: Color(0xff303030),
    ),
    textAlign: TextAlign.center,
  ),
);

Widget titleSection = Container(
  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: new Text(
    'Choose Background Colour',
    style: TextStyle(
      fontSize: 20,
      color: Color(0xff303030),
    ),
    textAlign: TextAlign.center,
  ),
);

List<String> images;
List<String> colours;

class MouthSelectionGrid extends StatefulWidget {
  @override
  _MouthSelectionGridState createState() => _MouthSelectionGridState();
}

MouthSelectionModel mouthSelectionModel = new MouthSelectionModel();

class _MouthSelectionGridState extends State<MouthSelectionGrid> {
  @override
  Widget build(BuildContext context) {
    images = mouthSelectionModel.getImageList();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            // height: 330.0,
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(20.0),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 5.0,
                    crossAxisCount: 3,
                      children: List.generate(images.length, (index) {
                        return Card(
                          shape: Border.all(color: (mouthSelectionModel.getSelectedListAtIndex(index)) ? Color(0xffffb8b8) : Colors.transparent, width: 3),
                            child: InkWell(
                              onTap: (() {
                                setState(() {
                                  mouthSelectionModel.setMouthIndex(index);
                                  mouthSelectionModel.clearSelectedList();
                                  mouthSelectionModel.setSelectedListAtIndex(index, true);
                                });
                              }), 
                              child: Image.asset(images[index]), 
                            ),
                          color: Color(int.parse(mouthSelectionModel.getColoursListAtIndex(index)))
                        );
                      }),
                  ),
                ),
              ], 
            ),
          ),
        ]
      ),
    );
  }
}

List<String> bgColours;

class ColourSelectionGrid extends StatefulWidget {
  final Function() updateState;
  ColourSelectionGrid({Key key, @required this.updateState}) : super(key: key);

  @override
  _ColourSelectionGridState createState() => _ColourSelectionGridState();
}

class _ColourSelectionGridState extends State<ColourSelectionGrid> {
  @override
  Widget build(BuildContext context) {
    // MouthSelectionModel mouthSelectionModel = new MouthSelectionModel();
    bgColours = mouthSelectionModel.getBgColourList();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: CustomScrollView(
              // physics: BouncingScrollPhysics(),
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(20.0),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 5.0,
                    crossAxisCount: 6,
                      children: List.generate(bgColours.length, (index) {
                        return Card(
                          color: Color(int.parse(bgColours[index])),
                          child: InkWell(
                            onTap: () { 
                              setState(() {
                                mouthSelectionModel.setColoursListAtIndex(mouthSelectionModel.getMouthIndex(), bgColours[index]);
                                widget.updateState();
                              });
                            },
                          ),
                        );
                      }),
                  ),
                ),
              ], 
            ),
          ),
        ]
      ),
    );
  }
}

