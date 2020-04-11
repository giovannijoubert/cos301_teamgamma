import 'package:flutter/material.dart';
import '../../core/viewmodels/mouthpack_model.dart';
import 'base_view.dart';
import '../widgets/bottom_navigation.dart';

class MouthpackView extends StatefulWidget {
  @override
  _MouthpackState createState() => _MouthpackState();
}

class _MouthpackState extends State<MouthpackView> {
  //int _currentTabIndex = 1;

  @override
   Widget build(BuildContext context) {
    //BottomNavigation bottomNavigation = new BottomNavigation();
    //bottomNavigation.setIndex(_currentTabIndex);

    return BaseView<MouthpackModel>(
      builder: (context, model, child) => Scaffold(
        body: ListView(
        children: <Widget>[
          BackNavigator(),
          TitleSection('Vampire Pack 1', 'Peter Davis', '2020/05/15', '4.5'),
          ImageTitle('12'),
          ImageSection(),
        ],
      ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class TitleSection extends StatefulWidget {
  final String title;
  final String creator;
  final String date;
  final String rating;

  TitleSection(this.title, this.creator, this.date, this.rating);

  @override
  _TitleSectionState createState() => _TitleSectionState(this.title, this.creator, this.date, this.rating);
}

class _TitleSectionState extends State<TitleSection>  {
  final String title;
  final String creator;
  final String date;
  final String rating;

  _TitleSectionState(this.title, this.creator, this.date, this.rating);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      height: 130,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    rating + '/5',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      creator,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ImageTitle extends StatefulWidget {
  final String totalImages;
  //image src list

  ImageTitle(this.totalImages);

  @override
  _ImageTitleState createState() => _ImageTitleState(this.totalImages);
}

class _ImageTitleState extends State<ImageTitle> {
  final String totalImages;
  //image src list

  _ImageTitleState(this.totalImages);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(
            totalImages + ' images',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageSection extends StatefulWidget {
  @override
  _ImageSectionState createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      children: List.generate(12, (index) {
        return Center(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Color(0xFF8ACDEF),
                width: 80,
                height: 80,
                child: new Image.asset(
                  "assets/images/mouth-packs/mouth-"+ (index+1).toString() +".png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      }),
    );



      /*padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                totalImages??'Default total' + ' images',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color(0xFF8ACDEF),
                            width: 90,
                            height: 90,
                            child: new Image.asset(
                              '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),*/
    //);
  }
}

class BackNavigator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.centerLeft,
      child: new GestureDetector(
        onTap: (){
          print('press back');
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
    );
  }
}