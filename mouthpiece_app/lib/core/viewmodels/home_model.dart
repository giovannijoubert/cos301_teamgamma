import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mouthpiece/core/enums/viewstate.dart';
import 'package:mouthpiece/ui/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../viewmodels/collection_model.dart';

import '../../ui/views/home_view.dart';
import '../data/defaultmouthpacks.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  var test;
  CollectionModel collectionModel = new CollectionModel();
  static String listeningModeImg;
  static bool updateVal;
  Timer timer;

  HomeModel() {
    if (collectionModel.getImageList().length == 0 || updateVal) {
      createCollection(); 
    //   updateVal = false;
      // if (collectionModel.getImageList().length == 0 || getUpdateVal()) {
        // timer = Timer.periodic(Duration(seconds: 20), (Timer t) { if (state == ViewState.Busy) { createCollection(); }}); 
        setUpdateVal(false);
      // }
    }
  }

 

  setUpdateVal(bool val) {
    updateVal = val;
  }

  getUpdateVal() {
    return updateVal;
  }

  setNavVal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("navVal", true);
  }  

  createCollection() async {
    setState(ViewState.Busy);
    await collectionModel.createCollection(); 
    setState(ViewState.Idle);
  }

  static List<Uint8List> listeningModeImgList = List<Uint8List>();
  static String listeningModeColour;
  static int index = 0;

  void createListeningModeImgList() {
    listeningModeImgList.clear();
    int length = defaultMouthpacks[0]["images"].length;
    for (int i = 0; i < length; i++) {
      if (getIndex() < defaultMouthpacks.length)
        listeningModeImgList.add(base64.decode(defaultMouthpacks[getIndex()]["images"][i])); 
      else {
        int index = getIndex() - defaultMouthpacks.length;
        listeningModeImgList.add(base64.decode(collectionModel.getCollection()[index][0]["images"][i]));  
      }
    }

    test = "got image";
  }

  List<Uint8List> getListeningModeImgList() {
    return listeningModeImgList;
  }

  String getListeningModeImg() {
    test = "got image";
    return listeningModeImg;
  }

  void setListeningModeImg(String img) {
    test = "image set";
    listeningModeImg = img;
  }
  

  void setListeningModeColour(String colour) {
    test = "colour set";
    listeningModeColour = colour;
  }

  String getListeningModeColour() {
    test = "got colour";
    return listeningModeColour;
  }

  void setIndex(int i) {
    index = i;
  }

  int getIndex() {
    return index;
  }

}