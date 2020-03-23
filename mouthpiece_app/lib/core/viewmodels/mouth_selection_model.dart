import '../enums/viewstate.dart';
import '../viewmodels/base_model.dart';

import '../../locator.dart';

class MouthSelectionModel extends BaseModel {
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
    "assets/images/mouth-packs/mouth-1.png",
    "assets/images/mouth-packs/mouth-2.png",
    "assets/images/mouth-packs/mouth-3.png",
    "assets/images/mouth-packs/mouth-4.png",
    "assets/images/mouth-packs/mouth-5.png",
    "assets/images/mouth-packs/mouth-6.png",
    "assets/images/mouth-packs/mouth-7.png",
    "assets/images/mouth-packs/mouth-8.png",
    "assets/images/mouth-packs/mouth-9.png",
    "assets/images/mouth-packs/mouth-1.png",
    "assets/images/mouth-packs/mouth-2.png",
    "assets/images/mouth-packs/mouth-3.png",
    "assets/images/mouth-packs/mouth-4.png",
    "assets/images/mouth-packs/mouth-5.png",
    "assets/images/mouth-packs/mouth-6.png",
    "assets/images/mouth-packs/mouth-7.png",
    "assets/images/mouth-packs/mouth-8.png",
    "assets/images/mouth-packs/mouth-9.png",
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
    '0xFF8acdef',
    '0xFFb1b4e5',
    '0xFFf2929c',
    '0xFF61a3ee',
    '0xFFff8a8a',
    '0xFFb1b4e5',
    '0xFF8acdef',
    '0xFFd2d2d3',
    '0xFF303030',
    '0xFF8acdef',
    '0xFFb1b4e5',
    '0xFFf2929c',
    '0xFF61a3ee',
    '0xFFff8a8a',
    '0xFFb1b4e5',
    '0xFF8acdef',
    '0xFFd2d2d3',
    '0xFF303030',
  ];

  final List<String> bgColours = [
    '0xFF8acdef',
    '0xFFb1b4e5',
    '0xFFf2929c',
    '0xFF61a3ee',
    '0xFFff8a8a',
    '0xFFb1b4e5',
    '0xFF8acdef',
    '0xFFd2d2d3',
    '0xFF303030',
    '0xFF8acdef',
    '0xFFb1b4e5',
    '0xFFf2929c',
  ];

  List<String> getImageList() {
    return images;
  }

  List<String> getColourList() {
    return colours;
  }

  List<String> getBgColourList() {
    return bgColours;
  }
}
