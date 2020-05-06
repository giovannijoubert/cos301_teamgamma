import '../viewmodels/base_model.dart';
import 'dart:convert';
import 'dart:async';
import '../../locator.dart';
import '../services/sharing_api.dart';
import '../services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../data/defaultmouthpacks.dart';
import 'home_model.dart';

HomeModel homeModel = new HomeModel();

class CollectionModel extends BaseModel {
  SharingApi _sharingapi = locator<SharingApi>();
  Api _api = locator<Api>();
  SharedPreferences prefs;

  static List<dynamic> collection;
  static List<dynamic> collectionURL= List<dynamic>();
  static List<String> colourList = List<String>();
  static List<String> imageList = List<String>();
  static List<String> idList = List<String>();

  Future<void> createCollection() async {
    prefs = await SharedPreferences.getInstance();
    imageList.clear();
    if (prefs.getBool("loggedIn") ?? false) {
      idList = await getProfileMouthpackIdList();
      List<dynamic> mouthpacks = await getUserMouthpacks(idList);
      // print(mouthpacks);
      collection = jsonDecode(mouthpacks.toString());
      // print(collection);

      await encodeImages();
      await createImageList();
      await createColourList();
    } else {
      await createImageList();
      await createColourList();
    }
  }

  Future<List> createImageList() async {
    prefs = await SharedPreferences.getInstance();
    imageList.clear();
    for (int i = 0; i < defaultMouthpacks.length; i++) {
      imageList.add(defaultMouthpacks[i]["images"][i]);
    }
    
    if (prefs.getBool("loggedIn") ?? false) {
      for (int i = 0; i < collection.length; i++) {
        imageList.add(collection[i][0]["images"][0]);
      }
    }

    return imageList;
  }

  clearLists() {
    colourList.clear();
    imageList.clear();
  }

  Future<List> createColourList() async {
    prefs = await SharedPreferences.getInstance();
    colourList.clear();

    for (int i = 0; i < defaultMouthpacks.length; i++) {
      colourList.add(defaultMouthpacks[i]["bgColour"]);
    }

    if (prefs.getBool("loggedIn") ?? false) {
      var requestInfo = prefs.getString('userInfo');
      var userInfo = jsonDecode(requestInfo);
      for (int i = 0; i < collection.length; i++) {
        colourList.add('0XFF' + userInfo["mouthpacks"][i]["background_colour"]);
      }
    }

    return colourList;
  }

  Future<void> updateColourList(List<String> list) async {
    colourList.clear();
    for (int i = 0; i < list.length; i++) {
      colourList.add(list[i]);
    }
  }

  Future<List> getProfileMouthpackIdList() async {
    prefs = await SharedPreferences.getInstance();
    var requestInfo = prefs.getString('userInfo');
    var userInfo = jsonDecode(requestInfo);

    List<String> idList = List<String>();

    for(int i = 0; i < userInfo["mouthpacks"].length; i++) {
      idList.add(userInfo["mouthpacks"][i]["mouthpack_id"]);
    }

    return idList;
  }

  Future<List> getUserMouthpacks(idList) async {
    List<String> mouthpackCollection = List<String>();

    for (int i = 0; i < idList.length; i++) {
      String mouthpack = await _sharingapi.getMouthpack(idList[i]);
      mouthpackCollection.add(mouthpack);
    }

    return mouthpackCollection;
  }

  Future<void> encodeImages() async {
    for (int i = 0; i < collection.length; i++) {
      collectionURL.add(collection[i][0]["images"]);
      for (int j = 0; j < collection[i][0]["images"].length; j++) {
        print(collection[i][0]["images"][j]);
        await http.get(
          collection[i][0]["images"][j],
        ).then((resp){
          collection[i][0]["images"][j] = base64.encode(resp.bodyBytes);
        });
      }
    }
  }

  Future<String> getCollectionURLAtIndex(int row, int col) async{
    String url = collectionURL[row-defaultMouthpacks.length][col];
    // print(url);
    return url;
  // 
  }

  String getColoursListAtIndex(int index) {
    return colourList[index];
  }

  void setColoursListAtIndex(int index, String value) async {
    colourList[index] = value;

    List<String> updatedColours = List<String>();

    for (int i = 0; i < colourList.length; i++) {
      // updatedColours.add(colourList[i].substring(4, 10));
      updatedColours.add(colourList[i]);
    }

    await updateColourList(updatedColours);
  }

  getImageList()  {
    return imageList;
  }

  getCollection() {
    return collection;
  }

  getColourList()  {
    return colourList;
  }

  List<String> bgColourList() {
    if (colourList.length == 0) {
      return null;
    } else {
      return colourList;
    }
  }

  updateMouthpackBgColour(int index, String bgColour) async {
    prefs = await SharedPreferences.getInstance();
    if (index < defaultMouthpacks.length) {
      defaultMouthpacks[index]["bgColour"] = bgColour;
    } else {
      int id = int.parse(idList[index - defaultMouthpacks.length]);
      await _api.updateBgColours(id, bgColour.substring(4, 10)).then((value) async {
        Map map = {
          "username": prefs.getString("username"),
          "password": prefs.getString("pass"),
        };

        String url = 'https://teamgamma.ga/api/umtg/login';
        await _api.fetchUser(url, map, prefs.getString("username"));
        homeModel.setUpdate(true);
      });
    }
  }

  Future<bool> removeMouthpack(int index) async {
    prefs = await SharedPreferences.getInstance();
    bool result = false;
    if (index >= defaultMouthpacks.length) {
      index = index - defaultMouthpacks.length;
      int id = int.parse(idList[index]);
      await _api.removeMouthpack(id).then((value) async {
        Map map = {
          "username": prefs.getString("username"),
          "password": prefs.getString("pass"),
        };

        String url = 'https://teamgamma.ga/api/umtg/login';
        await _api.fetchUser(url, map, prefs.getString("username"));
        homeModel.setUpdate(true);
        result = true;
      });
    } 
    return result;
  }
}
