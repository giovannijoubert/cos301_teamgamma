import 'dart:convert';
import '../../ui/views/home_view.dart';

import '../../locator.dart';
import '../models/mouthpack.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  // final List<String> images = [];
  // // final List<String> colours = [];
  
  // void createImageList() {
  //   for (var i = 1; i < 9; i++) {
  //     images.add("assets/images/mouth-packs/mouth-"+ i.toString() +".png");
  //   }
  // }

  // /* void createColourList() {
  //   for (var i = 0; i < 9; i++) {
  //     colours.add("0xFF303030");
  //   }
  // } */

  // final List<String> colours = [
  //   '0xFF303030',
  //   '0xFFb1b4e5',
  //   '0xFFf2929c',
  //   '0xFF61a3ee',
  //   '0xFFff8a8a',
  //   '0xFFb1b4e5',
  //   '0xFF8acdef',
  //   '0xFFd2d2d3',
  //   '0xFF303030',
  // ];

  // List<String> getImageList() {
  //   return images;
  // }

  // List<String> getBgColourList() {
  //   return colours;
  // }

  static String listeningModeImg;
  static String listeningModeColour;
  static int index = 0;

  void setListeningModeImg(String img) {
    listeningModeImg = img;
  }

  String getListeningModeImg() {
    return listeningModeImg;
  }

  void setListeningModeColour(String colour) {
    listeningModeColour = colour;
  }

  String getListeningModeColour() {
    return listeningModeColour;
  }

  void setIndex(int i) {
    index = i;
  }

  int getIndex() {
    return index;
  }

}