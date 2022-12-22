/// code : 0
/// msg : "String"
/// data : [{"id":0,"periodicaId":0,"catalogueTitle":"String","catalogueTitleImg":"String","viewsCount":0,"likeCount":0,"collectCount":0,"catalogueTitleSubtitle":"String"}]

class PeriodicaId_response {
  List<Data>? _data;

  List<Data>? get data => _data;

  PeriodicaId_response({
      List<Data>? data}){
    _data = data;
}

  PeriodicaId_response.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0
/// periodicaId : 0
/// catalogueTitle : "String"
/// catalogueTitleImg : "String"
/// viewsCount : 0
/// likeCount : 0
/// collectCount : 0
/// catalogueTitleSubtitle : "String"

class Data {
  int? _id;
  int? _periodicaId;
  String? _catalogueTitle;
  String? _catalogueTitleImg;
  int? _viewsCount;
  int? _likeCount;
  int? _collectCount;
  String? _catalogueTitleSubtitle;

  int? get id => _id;
  int? get periodicaId => _periodicaId;
  String? get catalogueTitle => _catalogueTitle;
  String? get catalogueTitleImg => _catalogueTitleImg;
  int? get viewsCount => _viewsCount;
  int? get likeCount => _likeCount;
  int? get collectCount => _collectCount;
  String? get catalogueTitleSubtitle => _catalogueTitleSubtitle;

  Data({
      int? id, 
      int? periodicaId, 
      String? catalogueTitle, 
      String? catalogueTitleImg, 
      int? viewsCount, 
      int? likeCount, 
      int? collectCount, 
      String? catalogueTitleSubtitle}){
    _id = id;
    _periodicaId = periodicaId;
    _catalogueTitle = catalogueTitle;
    _catalogueTitleImg = catalogueTitleImg;
    _viewsCount = viewsCount;
    _likeCount = likeCount;
    _collectCount = collectCount;
    _catalogueTitleSubtitle = catalogueTitleSubtitle;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _periodicaId = json['periodicaId'];
    _catalogueTitle = json['catalogueTitle'];
    _catalogueTitleImg = json['catalogueTitleImg'];
    _viewsCount = json['viewsCount'];
    _likeCount = json['likeCount'];
    _collectCount = json['collectCount'];
    _catalogueTitleSubtitle = json['catalogueTitleSubtitle'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['periodicaId'] = _periodicaId;
    map['catalogueTitle'] = _catalogueTitle;
    map['catalogueTitleImg'] = _catalogueTitleImg;
    map['viewsCount'] = _viewsCount;
    map['likeCount'] = _likeCount;
    map['collectCount'] = _collectCount;
    map['catalogueTitleSubtitle'] = _catalogueTitleSubtitle;
    return map;
  }

}