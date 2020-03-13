import 'package:flutter/material.dart';



void main() => runApp(MouthPiece());

class MouthPiece extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Helvetica'),
      title: 'MouthPiece',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: AppBar(
            backgroundColor: Color(0xff303030),
            title: Text(
              'Select Your Mouth',
              style: TextStyle(
                  fontSize: 22,
                  color: Color(0xffffffff),
              ),
            )
          ) 
        ),
        body: Stack(
          children: <Widget>[
            ExampleGrid(),
            // titleSection,
          ],
        ), 
      ),
      
    );
  }
}

// Widget titleSection = Container(
//   padding: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 16),
//   // child: new Row(
//   //   crossAxisAlignment: CrossAxisAlignment.start,
//   //   mainAxisAlignment: MainAxisAlignment.center,
//   //   mainAxisSize: MainAxisSize.max,
//     // children: [
//       child: new Text(
//         'Select Your Mouth',
//         style: TextStyle(
//           fontSize: 22,
//           color: Color(0xff303030),
//         ),
//       ),
//       // ExampleGrid()
//     // ],
//   // ),
// );

class ExampleGrid extends StatelessWidget {
  final List<String> images = [
    "assets/images/mouth-packs/mouth-1.png",
    "assets/images/mouth-packs/mouth-2.png",
    "assets/images/mouth-packs/mouth-3.png",
    "assets/images/mouth-packs/mouth-4.png",
    "assets/images/mouth-packs/mouth-5.png",
    "assets/images/mouth-packs/mouth-6.png",
    "assets/images/mouth-packs/mouth-7.png",
    "assets/images/mouth-packs/mouth-8.png",
    "assets/images/mouth-packs/mouth-9.png",
    // "assets/images/mouth-packs/mouth-1.png",
    // "assets/images/mouth-packs/mouth-1.png",
    // "assets/images/mouth-packs/mouth-1.png",
    // "assets/images/mouth-packs/mouth-1.png",
    // "assets/images/mouth-packs/mouth-1.png",
    // "assets/images/mouth-packs/mouth-1.png",
  ];

  final List<String> colours = [
    '0xFF8acdef',
    '0xFFb1b4e5',
    '0xFFf2929c',
    '0xFF61a3ee',
    '0xFFff8a8a',
    '0xFFb1b4e5',
    '0xFF8acdef',
    '0xFFd2d2d3',
    '0xFF303030',
    // '0xFFFFFFFF',
    // '0xFFFFFFFF',
    // '0xFFFFFFFF',
    // '0xFFFFFFFF',
    // '0xFFFFFFFF',
    // '0xFFFFFFFF',
  ];
 

  // @override
  // Widget buildGrid() {
  //   return Scaffold(
  //     body: CustomScrollView(
  //       physics: BouncingScrollPhysics(),
  //       primary: false,
  //       slivers: <Widget>[
  //         SliverPadding(
  //           padding: const EdgeInsets.all(20.0),
  //           sliver: SliverGrid.count(
  //             crossAxisSpacing: 5.0,
  //             crossAxisCount: 3,
  //             children: List.generate(images.length, (index) {
  //               return Card(child: Image.asset(images[index]), color: Color(int.parse(colours[index])),);
  //             }),
  //           ),
  //         ),
  //       ],
  //     )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverGrid.count(
              crossAxisSpacing: 5.0,
              crossAxisCount: 3,
              children: List.generate(images.length, (index) {
                return Card(child: Image.asset(images[index]), color: Color(int.parse(colours[index])),);
              }),
            ),
          ),
        ],
      )
    );
  }
}

