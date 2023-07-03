import 'package:crazyenglish/entity/base_resp.dart';

/// code : 1
/// msg : "系统正常"
/// data : [{"id":27,"periodicaId":26,"catalogueTitle":"Bee? Hoverfly?","catalogueTitleSubtitle":"厉害了，崔宸溪","catalogueTitleImg":"https://test-1315843937.cos.ap-beijing.myqcloud.com/png/0909341672213570242625027720722446582193.png","viewsCount":0,"likeCount":0,"collectCount":0},{"id":28,"periodicaId":26,"catalogueTitle":"Learning English With English Clubs","catalogueTitleSubtitle":"想说一口流利的英语吗？从加入英语俱乐部开始吧。","catalogueTitleImg":"https://test-1315843937.cos.ap-beijing.myqcloud.com/png/5055541672213790029625247507918303727682.png","viewsCount":0,"likeCount":0,"collectCount":0},{"id":29,"periodicaId":26,"catalogueTitle":"Advice From Amy","catalogueTitleSubtitle":"Amy会给Jack 什么建议呢?","catalogueTitleImg":"https://test-1315843937.cos.ap-beijing.myqcloud.com/png/6685231672214573241626030719752756894308.png","viewsCount":0,"likeCount":0,"collectCount":0},{"id":30,"periodicaId":26,"catalogueTitle":"Students Saved Bus Driver's Life","catalogueTitleSubtitle":"面对突发情况，他们沉着、冷静......","catalogueTitleImg":"https://test-1315843937.cos.ap-beijing.myqcloud.com/png/3063471672214716188626173667428642367440.png","viewsCount":0,"likeCount":0,"collectCount":0},{"id":31,"periodicaId":26,"catalogueTitle":"Good Words ","catalogueTitleSubtitle":"老师的话鼓励了他。","catalogueTitleImg":"https://test-1315843937.cos.ap-beijing.myqcloud.com/png/6044971672214853256626310735397592928093.png","viewsCount":0,"likeCount":0,"collectCount":0},{"id":32,"periodicaId":26,"catalogueTitle":"The Olympic Village","catalogueTitleSubtitle":"你了解奥运村吗?","catalogueTitleImg":"https://test-1315843937.cos.ap-beijing.myqcloud.com/png/9399371672214981343626438821994823972085.png","viewsCount":0,"likeCount":0,"collectCount":0},{"id":33,"periodicaId":26,"catalogueTitle":"She Never leave Mom's Side","catalogueTitleSubtitle":"一起走进“全国道德模范”刘羲檬的生活。","catalogueTitleImg":"https://test-1315843937.cos.ap-beijing.myqcloud.com/png/2741431672215099350626556829126559702487.png","viewsCount":0,"likeCount":0,"collectCount":0},{"id":34,"periodicaId":26,"catalogueTitle":"Weekly Collection","catalogueTitleSubtitle":"本期要点","catalogueTitleImg":"https://test-1315843937.cos.ap-beijing.myqcloud.com/png/9305291672215238848626696327205608633425.png","viewsCount":0,"likeCount":0,"collectCount":0}]

class PaperCategory extends BaseResp{
  List<Data>? _data;

  List<Data>? get data => _data;

  PaperCategory({
      int? code, 
      String? msg, 
      List<Data>? data}) : super(code, msg){
    _data = data;
  }

  PaperCategory.fromJson(dynamic json):super.fromJson(json) {
    if (json['obj'] != null) {
      _data = [];
      json['obj'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (_data != null) {
      map['obj'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  fromJson(dynamic) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

}

/// id : 27
/// periodicaId : 26
/// catalogueTitle : "Bee? Hoverfly?"
/// catalogueTitleSubtitle : "厉害了，崔宸溪"
/// catalogueTitleImg : "https://test-1315843937.cos.ap-beijing.myqcloud.com/png/0909341672213570242625027720722446582193.png"
/// viewsCount : 0
/// likeCount : 0
/// collectCount : 0

class Data {
  int? _id;
  int? _periodicaId;
  String? _catalogueTitle;
  String? _catalogueTitleSubtitle;
  String? _catalogueTitleImg;
  int? _viewsCount;
  int? _likeCount;
  int? _collectCount;
  bool? _isVideoFile;

  int? get id => _id;
  int? get periodicaId => _periodicaId;
  String? get catalogueTitle => _catalogueTitle;
  String? get catalogueTitleSubtitle => _catalogueTitleSubtitle;
  String? get catalogueTitleImg => _catalogueTitleImg;
  int? get viewsCount => _viewsCount;
  int? get likeCount => _likeCount;
  int? get collectCount => _collectCount;
  bool? get isVideoFile => _isVideoFile;

  Data({
      int? id, 
      int? periodicaId, 
      String? catalogueTitle, 
      String? catalogueTitleSubtitle, 
      String? catalogueTitleImg, 
      int? viewsCount, 
      int? likeCount, 
      int? collectCount,
      bool? isVideoFile
  }){
    _id = id;
    _periodicaId = periodicaId;
    _catalogueTitle = catalogueTitle;
    _catalogueTitleSubtitle = catalogueTitleSubtitle;
    _catalogueTitleImg = catalogueTitleImg;
    _viewsCount = viewsCount;
    _likeCount = likeCount;
    _collectCount = collectCount;
    _isVideoFile = isVideoFile;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _periodicaId = json['periodicaId'];
    _catalogueTitle = json['catalogueTitle'];
    _catalogueTitleSubtitle = json['catalogueTitleSubtitle'];
    _catalogueTitleImg = json['catalogueTitleImg'];
    _viewsCount = json['viewsCount'];
    _likeCount = json['likeCount'];
    _collectCount = json['collectCount'];
    _isVideoFile = json['isVideoFile'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['periodicaId'] = _periodicaId;
    map['catalogueTitle'] = _catalogueTitle;
    map['catalogueTitleSubtitle'] = _catalogueTitleSubtitle;
    map['catalogueTitleImg'] = _catalogueTitleImg;
    map['viewsCount'] = _viewsCount;
    map['likeCount'] = _likeCount;
    map['collectCount'] = _collectCount;
    map['isVideoFile'] = _isVideoFile;
    return map;
  }

}