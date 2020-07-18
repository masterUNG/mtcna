class ClipVideoModel {
  String detail;
  String image;
  String nameVideo;
  String time;
  String urlPath;

  ClipVideoModel(
      {this.detail, this.image, this.nameVideo, this.time, this.urlPath});

  ClipVideoModel.fromJson(Map<String, dynamic> json) {
    detail = json['Detail'];
    image = json['Image'];
    nameVideo = json['NameVideo'];
    time = json['Time'];
    urlPath = json['UrlPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Detail'] = this.detail;
    data['Image'] = this.image;
    data['NameVideo'] = this.nameVideo;
    data['Time'] = this.time;
    data['UrlPath'] = this.urlPath;
    return data;
  }
}
