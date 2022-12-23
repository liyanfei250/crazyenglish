/// code : 0
/// msg : "String"
/// data : {"id":0,"titleCn":"","titleEn":"String","content":"String","largeFile":"String","audioFile":"String","videoFile":"String","updateTime":"DateTime","viewsCount":0}

class PaperDetail {
  Data? _data;

  Data? get data => _data;

  PaperDetail({
      Data? data}){
    _data = data;
}

  PaperDetail.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 0
/// titleCn : ""
/// titleEn : "String"
/// content : "String"
/// largeFile : "String"
/// audioFile : "String"
/// videoFile : "String"
/// updateTime : "DateTime"
/// viewsCount : 0

class Data {
  int? _id;
  String? _titleCn;
  String? _titleEn;
  String? _content;
  String? _largeFile;
  String? _audioFile;
  String? _videoFile;
  String? _updateTime;
  int? _viewsCount;

  int? get id => _id;
  String? get titleCn => _titleCn;
  String? get titleEn => _titleEn;
  String? get content => _content;
  String? get largeFile => _largeFile;
  String? get audioFile => _audioFile;
  String? get videoFile => _videoFile;
  String? get updateTime => _updateTime;
  int? get viewsCount => _viewsCount;

  Data({
      int? id, 
      String? titleCn, 
      String? titleEn, 
      String? content, 
      String? largeFile, 
      String? audioFile, 
      String? videoFile, 
      String? updateTime, 
      int? viewsCount}){
    _id = id;
    _titleCn = titleCn;
    _titleEn = titleEn;
    _content = content;
    _largeFile = largeFile;
    _audioFile = audioFile;
    _videoFile = videoFile;
    _updateTime = updateTime;
    _viewsCount = viewsCount;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _titleCn = json['titleCn'];
    _titleEn = json['titleEn'];
    _content = json['content'];
    _largeFile = json['largeFile'];
    _audioFile = json['audioFile'];
    _videoFile = json['videoFile'];
    _updateTime = json['updateTime'];
    _viewsCount = json['viewsCount'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['titleCn'] = _titleCn;
    map['titleEn'] = _titleEn;
    map['content'] = _content;
    map['largeFile'] = _largeFile;
    map['audioFile'] = _audioFile;
    map['videoFile'] = _videoFile;
    map['updateTime'] = _updateTime;
    map['viewsCount'] = _viewsCount;
    return map;
  }

}