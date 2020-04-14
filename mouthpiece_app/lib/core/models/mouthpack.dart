class MouthPack {
  final int id;
  final String title;
  final String mainSrc;
  final String bgColour;

  MouthPack({this.id, this.title, this.mainSrc, this.bgColour});

  factory MouthPack.fromJson(Map<String, dynamic> json) {
    return MouthPack(
      id: json['id'] as int,
      title: json['title'] as String,
      mainSrc: json['mainSrc'] as String,
      bgColour: json['bgColour'] as String,
    );
  }
}
