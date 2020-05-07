import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/viewmodels/mouthpack_model.dart';
import 'base_view.dart';
import '../widgets/bottom_navigation.dart';

class MouthpackView extends StatefulWidget {
  final String title;
  final String category;
  final String date;
  final int totalImages;
  final String rating;
  final String bgColour;
  final List<dynamic> images;

  MouthpackView(this.title, this.category, this.date, this.totalImages, this.rating, this.bgColour, this.images);

  @override
  _MouthpackState createState() => _MouthpackState(this.title, this.category, this.date, this.totalImages, this.rating, this.bgColour, this.images);
}

class _MouthpackState extends State<MouthpackView> {
  final String title;
  final String category;
  final String date;
  final int totalImages;
  final String rating;
  final String bgColour;
  final List<dynamic> images;

  _MouthpackState(this.title, this.category, this.date, this.totalImages, this.rating, this.bgColour, this.images);

  @override
   Widget build(BuildContext context) { return BaseView<MouthpackModel>(
      builder: (context, model, child) => Scaffold(
        body: ListView(
        children: <Widget>[
          BackNavigator(),
          TitleSection(title, category, date, rating),
          ImageTitle(totalImages.toString()),
          ImageSection(images, bgColour),
        ],
      ),
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
                    rating,
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

  ImageTitle(this.totalImages);

  @override
  _ImageTitleState createState() => _ImageTitleState(this.totalImages);
}

class _ImageTitleState extends State<ImageTitle> {
  final String totalImages;

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
  final List<dynamic> images;
  final String bgColour;
  ImageSection(this.images, this.bgColour);

  @override
  _ImageSectionState createState() => _ImageSectionState(this.images, this.bgColour);
}

class _ImageSectionState extends State<ImageSection> {
  final List<dynamic> images;
  final String bgColour;
  _ImageSectionState(this.images, this.bgColour);
  
  @override
  Widget build(BuildContext context) {
    var cardBgColour = int.parse(bgColour);
    
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      children: List.generate(this.images.length, (index) {
        Uint8List decodedImgSrc;
        if (!images[index].contains("http")) {
          decodedImgSrc = base64.decode(this.images[index]);
        } 
        return Center(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(cardBgColour),
                  boxShadow: [
                  BoxShadow (
                      color: Colors.white,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 1.0,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                width: 80,
                height: 80,
                child: (this.images[index].contains("http")) ? 
                CachedNetworkImage(
                  imageUrl: this.images[index],
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
        );
      }),
    );
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