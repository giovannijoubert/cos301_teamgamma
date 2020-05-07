import 'dart:math';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file/file.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:mouthpiece/ui/views/mouth_selection_view.dart';
import 'package:mouthpiece/ui/views/mouthpack_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:mouthpiece/ui/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/viewmodels/collection_model.dart';
import 'base_view.dart';
import '../widgets/bottom_navigation.dart';
import 'dart:convert';
import 'package:image_downloader/image_downloader.dart';
import 'package:http/http.dart' as http;
import '../../core/data/defaultmouthpacks.dart';


class CollectionView extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<CollectionView> {
  int _currentTabIndex = 1;

  @override
   Widget build(BuildContext context) {
    BottomNavigation bottomNavigation = new BottomNavigation();
    // bottomNavigation.setIndex(_currentTabIndex);

    return BaseView<CollectionModel>(
      builder: (context, model, child) => Scaffold(
        body: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MouthNavigationBar(),
              // CollectionTitle(),
              Expanded(child: CollectionSearchBar(this)),
              /* MouthCard(),
              MouthCard(),
              MouthCard(), */
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
    final theme = Provider.of<ThemeChanger>(context);
    return Container(
      color: (theme.getTheme() == lightTheme) ? Color(0xFF303030) : Color(0xFAFFFFFF),
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
                      color: Color(0xFF8ACDEF),
                      fontFamily: 'Arciform',  // Text colour here
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
                  child: Text(
                    "Customise Mouth",
                    style: TextStyle(
                      fontSize: 18,
                      color: (theme.getTheme() == darkTheme) ? Color(0xFF303030) : Color(0xEFFFFFFF),
                      fontFamily: 'Arciform',  // Text colour here
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Expanded(child: CollectionSearchBar()),
        ],
      ),
    );
  }
}

class SearchItem {  
  final String imgSrc;
  final String title;
  final String description;
  final String date;
  final int totalImages;
  final String rating;
  final String bgColour;
  final List<dynamic> images;
  final bool defaultMouthpack;
  final int mouthpackIndex;

  SearchItem(this.imgSrc, this.title, this.description, this.date, this.totalImages, this.rating, this.bgColour, this.images, this.defaultMouthpack, this.mouthpackIndex);
}

class CollectionSearchBar extends StatefulWidget {
  _CollectionState parent;
  CollectionSearchBar(this.parent);

  @override
  _CollectionSearchBarState createState() => _CollectionSearchBarState(parent);
}

List<MouthCard> packs = <MouthCard>[];

class _CollectionSearchBarState extends State<CollectionSearchBar> {
  _CollectionState parent;
  _CollectionSearchBarState(this.parent);

  final SearchBarController<SearchItem> _searchBarController = SearchBarController();
  CollectionModel collectionModel = new CollectionModel();

  

  /* List<MouthCard> packs = <MouthCard>[
    MouthCard('assets/images/mouth-packs/mouth-1.png', "Vampire Pack 1", "Peter Davie", "2020/03/01", 24, "4.5"), 
    MouthCard('assets/images/mouth-packs/mouth-1.png', "Dog Pack 1", "Peter Davie", "2020/03/01", 24, "4.5"),
    MouthCard('assets/images/mouth-packs/mouth-1.png', "Dog Pack 2", "Peter Davie", "2020/03/01", 24, "4.5"),
    MouthCard('assets/images/mouth-packs/mouth-1.png', "Dog Pack 3", "Peter Davie", "2020/03/01", 24, "4.5"),
  ]; */

  

  void initialize(_CollectionSearchBarState parent){
    for(int i = 0; i < packs.length; i++){
      packs[i].setParent(parent);
    }
  }

  Future<void> createCollection() async {
    packs.clear();
    
    List<String> bgColour = collectionModel.bgColourList();    
    String rating = "";

    int bgColourindex = 0;
    int mouthpackIndex = 0;
      
    for (int i = 0; i < defaultMouthpacks.length; i++) {
      packs.add(MouthCard(defaultMouthpacks[i]["images"][0], (defaultMouthpacks[i]["name"] + "*"), defaultMouthpacks[i]["description"], defaultMouthpacks[i]["date"], defaultMouthpacks[i]["images"].length, "4/5", bgColour[bgColourindex], defaultMouthpacks[i]["images"], true, mouthpackIndex, parent));
      bgColourindex++;
      mouthpackIndex++;
    }
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("loggedIn") ?? false) {
      List<dynamic> collection = await collectionModel.getCollection();
      for (int i = 0; i < collection.length; i++) {
        if (collection[i][0]["ratings"].length == 0) {
          rating = "No rating";
        } else {
          rating = collection[i][0]["ratings"][0]["total"].round().toString()  + '/5';
        }

        setState(() {
          packs.add(MouthCard(collection[i][0]["images"][0], collection[i][0]["name"], collection[i][0]["description"], collection[i][0]["date"], collection[i][0]["images"].length, rating, bgColour[bgColourindex], collection[i][0]["images"], false, mouthpackIndex, parent));
        });
        bgColourindex++;
        mouthpackIndex++;
      }
    }

    initialize(this);
  }

  List<SearchItem> getSearched(String text){
    List<SearchItem> searchItems = [];
    print(text);
    for(int i = 0; i < packs.length ; i++){      
      if((packs[i].getTitle().toLowerCase()).contains(text)){
        searchItems.add(SearchItem(packs[i].getImgSrc(), packs[i].getTitle(),  packs[i].getdescription(),  packs[i].getDate(),  packs[i].getImages(),  packs[i].getRating(), packs[i].getBgColour(), packs[i].getImageList(), packs[i].getIsDefaultMouthpack(), packs[i].getMouthpackIndex()));
      }
      else if((packs[i].getdescription().toLowerCase()).contains(text)){
          searchItems.add(SearchItem(packs[i].getImgSrc(), packs[i].getTitle(),  packs[i].getdescription(),  packs[i].getDate(),  packs[i].getImages(),  packs[i].getRating(), packs[i].getBgColour(), packs[i].getImageList(), packs[i].getIsDefaultMouthpack(), packs[i].getMouthpackIndex()));
      }
      else if(packs[i].getDate().contains(text)){
        searchItems.add(SearchItem(packs[i].getImgSrc(), packs[i].getTitle(),  packs[i].getdescription(),  packs[i].getDate(),  packs[i].getImages(),  packs[i].getRating(), packs[i].getBgColour(), packs[i].getImageList(), packs[i].getIsDefaultMouthpack(), packs[i].getMouthpackIndex()));
      }
      else if((packs[i].getRating().toLowerCase()).contains(text)){
        searchItems.add(SearchItem(packs[i].getImgSrc(), packs[i].getTitle(),  packs[i].getdescription(),  packs[i].getDate(),  packs[i].getImages(),  packs[i].getRating(), packs[i].getBgColour(), packs[i].getImageList(), packs[i].getIsDefaultMouthpack(), packs[i].getMouthpackIndex()));
      } 
    }
    return searchItems;
  }

  void delete(String title) {
    print(title);
    for(int i = 0; i < packs.length; i++) {      
      if(packs[i].getTitle() == title) {
        packs.removeAt(i);
        setState(() {
        });
        break;
      }
    }
  }

  Future<List<SearchItem>> _getAllSearchItems(String text) async {
    // await Future.delayed(Duration(seconds: text.length == 1 ? 3 : 1));
    return getSearched(text.toLowerCase());
  }

    @override
  void initState() {
    // TODO: implement initState
    createCollection();
    super.initState();
    
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<SearchItem>(
          minimumChars: 1,
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 0),
          onSearch: _getAllSearchItems,
          searchBarController: _searchBarController,
          hintText: "Search...",
          placeHolder: ListView.builder(
            itemCount: packs.length,
            itemBuilder: (BuildContext context, int index){
                return Column(children: <Widget>[
                  packs[index]
                ]
              );
            }
          ),
          emptyWidget: Text("No results"),
          // indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          crossAxisCount: 1,
          onItemFound: (SearchItem searchItem, int index) {
            return MouthCard(searchItem.imgSrc, searchItem.title, searchItem.description, searchItem.date, searchItem.totalImages, searchItem.rating, searchItem.bgColour, searchItem.images, searchItem.defaultMouthpack, searchItem.mouthpackIndex, parent);
          },
        ),
      ),
    );
  }
}

class MouthCard extends StatefulWidget {
  final String imgSrc;
  final String title;
  final String description;
  final String date;
  final int totalImages;
  final String rating;
  final String bgColour;
  final List<dynamic> images;
  final bool defaultMouthpack;
  final int mouthpackIndex;
  _CollectionSearchBarState parent;
  _CollectionState stateParent;

  MouthCard(this.imgSrc, this.title, this.description, this.date, this.totalImages, this.rating, this.bgColour, this.images, this.defaultMouthpack, this.mouthpackIndex, this.stateParent);

  void setParent(_CollectionSearchBarState par){
    this.parent = par;
  }

  String getTitle(){
    return title;
  }

  String getdescription(){
    return description;
  }

  String getDate(){
    return date;
  }

  String getRating(){
    return rating;
  }

  String getImgSrc(){
    return imgSrc;
  }

  int getImages(){
    return totalImages;
  }

  String getBgColour(){
    return bgColour;
  }

  List<dynamic> getImageList(){
    return images;
  }

  bool getIsDefaultMouthpack(){
    return defaultMouthpack;
  }

  int getMouthpackIndex(){
    return mouthpackIndex;
  }
  
  
  @override
  _MouthCardState createState() => _MouthCardState(this.imgSrc, this.title, this.description, this.date, this.totalImages, this.rating, this.bgColour, this.images, this.defaultMouthpack, this.mouthpackIndex, this.parent, this.stateParent);
}

class _MouthCardState extends State<MouthCard> {
  String imgSrc;
  final String title;
  final String description;
  final String date;
  final int totalImages;
  final String rating;
  final String bgColour;
  final List<dynamic> images;
  final bool defaultMouthpack;
  final int mouthpackIndex;
  final _CollectionSearchBarState parent;
  _CollectionState stateParent;
  _MouthCardState(this.imgSrc, this.title, this.description, this.date, this.totalImages, this.rating, this.bgColour, this.images, this.defaultMouthpack, this.mouthpackIndex, this.parent, this.stateParent);

  @override
  Widget build(BuildContext context) {
    CollectionModel collectionModel = new CollectionModel();

    var cardBgColour = int.parse(bgColour);
    if (imgSrc == null) {
      return new Container();
    }

    Uint8List decodedImgSrc;
    if (title.contains("Default")) {
      decodedImgSrc = base64.decode(imgSrc);
    } 
    

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 3, 10, 3),
      height: 80,
      child: new GestureDetector(
        onTap: (){
          print('pressed card');
          print('length: ${imgSrc.substring(0,3)}');
          Navigator.push(context, PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => MouthpackView(title, description, date, totalImages, rating, bgColour, images),
          ),);
        },
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Color(cardBgColour),
                      width: 80,
                      height: 80,
                      child: (imgSrc.contains("http")) ? 
                      CachedNetworkImage(
                        imageUrl: imgSrc,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ) :
                      Image.memory(
                        decodedImgSrc,
                        fit: BoxFit.contain,
                      )
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10),),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      color: Color(0xDDFFFFFF),
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                          color: Color(0xFF303030),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      description,
                                      style: TextStyle(
                                        color: Color(0xFF303030),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility (
                                visible: !defaultMouthpack,
                                child:  GestureDetector(
                                  onTap: () async {
                                    for (int i = 0; i < totalImages; i++) {
                                      // print(base64.decode(images[0]));
                                      var index = i+1;
                                      String url = await collectionModel.getCollectionURLAtIndex(mouthpackIndex, i);
                                      await ImageDownloader.downloadImage(url,
                                      destination: AndroidDestinationType.directoryDownloads..subDirectory('$title/mouth-$index.png')); 
                                    }
                                  },
                                  child: Icon(
                                    Icons.file_download,
                                    color: Color(0xFF303030),
                                  ),
                                ),
                              ),
                              Visibility (
                                visible: !defaultMouthpack,
                                child: GestureDetector(
                                  onTap: () async {
                                    print('pressed delete');
                                    await collectionModel.removeMouthpack(mouthpackIndex).then((value){
                                      if (value) {
                                        this.stateParent.setState(() {
                                          packs.removeAt(mouthpackIndex);
                                        });
                                      }
                                    });                                    
                                  },
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFF303030),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  date,
                                  style: TextStyle(
                                    color: Color(0xFF303030),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              new BulletPoint(),
                              Container(
                                child: Text(
                                  totalImages.toString() + " images",
                                  style: TextStyle(
                                    color: Color(0xFF303030),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              new BulletPoint(),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                child: Text(
                                  rating,
                                  style: TextStyle(
                                    color: Color(0xFF303030),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: new BoxDecoration(boxShadow: [
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      offset: Offset(
                        4.0, // Move to right 10  horizontally
                        5.0, // Move to bottom 10 Vertically
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}

class BulletPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Text('•', style: TextStyle(color: Color(0xFF303030)));
  }
}
