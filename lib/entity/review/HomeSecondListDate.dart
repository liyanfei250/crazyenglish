/// code : 0
/// message : "系统正常"
/// obj : [{"journalId":1647898280209838082,"journalName":"ceshi","catalogueMergeVo":[{"catalogueMergeName":"测试01-03","catalogueRecordVoList":[{"catalogueId":1648160805898784769,"pid":1648157810093125634,"catalogueName":"测试01-04","questionCount":17,"correctCount":0}]}]}]
/// p : null

class HomeSecondListDate {
  HomeSecondListDate({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
}

  HomeSecondListDate.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      json['obj'].forEach((v) {
        _obj?.add(Obj.fromJson(v));
      });
    }
    _p = json['p'];
  }
  num? _code;
  String? _message;
  List<Obj>? _obj;
  dynamic _p;
HomeSecondListDate copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
}) => HomeSecondListDate(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
);
  num? get code => _code;
  String? get message => _message;
  List<Obj>? get obj => _obj;
  dynamic get p => _p;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.map((v) => v.toJson()).toList();
    }
    map['p'] = _p;
    return map;
  }

}

/// journalId : 1647898280209838082
/// journalName : "ceshi"
/// catalogueMergeVo : [{"catalogueMergeName":"测试01-03","catalogueRecordVoList":[{"catalogueId":1648160805898784769,"pid":1648157810093125634,"catalogueName":"测试01-04","questionCount":17,"correctCount":0}]}]

class Obj {
  Obj({
      num? journalId, 
      String? journalName, 
      List<CatalogueMergeVo>? catalogueMergeVo,}){
    _journalId = journalId;
    _journalName = journalName;
    _catalogueMergeVo = catalogueMergeVo;
}

  Obj.fromJson(dynamic json) {
    _journalId = json['journalId'];
    _journalName = json['journalName'];
    if (json['catalogueMergeVo'] != null) {
      _catalogueMergeVo = [];
      json['catalogueMergeVo'].forEach((v) {
        _catalogueMergeVo?.add(CatalogueMergeVo.fromJson(v));
      });
    }
  }
  num? _journalId;
  String? _journalName;
  List<CatalogueMergeVo>? _catalogueMergeVo;
Obj copyWith({  num? journalId,
  String? journalName,
  List<CatalogueMergeVo>? catalogueMergeVo,
}) => Obj(  journalId: journalId ?? _journalId,
  journalName: journalName ?? _journalName,
  catalogueMergeVo: catalogueMergeVo ?? _catalogueMergeVo,
);
  num? get journalId => _journalId;
  String? get journalName => _journalName;
  List<CatalogueMergeVo>? get catalogueMergeVo => _catalogueMergeVo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['journalId'] = _journalId;
    map['journalName'] = _journalName;
    if (_catalogueMergeVo != null) {
      map['catalogueMergeVo'] = _catalogueMergeVo?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// catalogueMergeName : "测试01-03"
/// catalogueRecordVoList : [{"catalogueId":1648160805898784769,"pid":1648157810093125634,"catalogueName":"测试01-04","questionCount":17,"correctCount":0}]

class CatalogueMergeVo {
  CatalogueMergeVo({
      String? catalogueMergeName, 
      List<CatalogueRecordVoList>? catalogueRecordVoList,}){
    _catalogueMergeName = catalogueMergeName;
    _catalogueRecordVoList = catalogueRecordVoList;
}

  CatalogueMergeVo.fromJson(dynamic json) {
    _catalogueMergeName = json['catalogueMergeName'];
    if (json['catalogueRecordVoList'] != null) {
      _catalogueRecordVoList = [];
      json['catalogueRecordVoList'].forEach((v) {
        _catalogueRecordVoList?.add(CatalogueRecordVoList.fromJson(v));
      });
    }
  }
  String? _catalogueMergeName;
  List<CatalogueRecordVoList>? _catalogueRecordVoList;
CatalogueMergeVo copyWith({  String? catalogueMergeName,
  List<CatalogueRecordVoList>? catalogueRecordVoList,
}) => CatalogueMergeVo(  catalogueMergeName: catalogueMergeName ?? _catalogueMergeName,
  catalogueRecordVoList: catalogueRecordVoList ?? _catalogueRecordVoList,
);
  String? get catalogueMergeName => _catalogueMergeName;
  List<CatalogueRecordVoList>? get catalogueRecordVoList => _catalogueRecordVoList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['catalogueMergeName'] = _catalogueMergeName;
    if (_catalogueRecordVoList != null) {
      map['catalogueRecordVoList'] = _catalogueRecordVoList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// catalogueId : 1648160805898784769
/// pid : 1648157810093125634
/// catalogueName : "测试01-04"
/// questionCount : 17
/// correctCount : 0

class CatalogueRecordVoList {
  CatalogueRecordVoList({
      num? catalogueId, 
      num? pid, 
      String? catalogueName, 
      num? questionCount, 
      num? correctCount,}){
    _catalogueId = catalogueId;
    _pid = pid;
    _catalogueName = catalogueName;
    _questionCount = questionCount;
    _correctCount = correctCount;
}

  CatalogueRecordVoList.fromJson(dynamic json) {
    _catalogueId = json['catalogueId'];
    _pid = json['pid'];
    _catalogueName = json['catalogueName'];
    _questionCount = json['questionCount'];
    _correctCount = json['correctCount'];
  }
  num? _catalogueId;
  num? _pid;
  String? _catalogueName;
  num? _questionCount;
  num? _correctCount;
CatalogueRecordVoList copyWith({  num? catalogueId,
  num? pid,
  String? catalogueName,
  num? questionCount,
  num? correctCount,
}) => CatalogueRecordVoList(  catalogueId: catalogueId ?? _catalogueId,
  pid: pid ?? _pid,
  catalogueName: catalogueName ?? _catalogueName,
  questionCount: questionCount ?? _questionCount,
  correctCount: correctCount ?? _correctCount,
);
  num? get catalogueId => _catalogueId;
  num? get pid => _pid;
  String? get catalogueName => _catalogueName;
  num? get questionCount => _questionCount;
  num? get correctCount => _correctCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['catalogueId'] = _catalogueId;
    map['pid'] = _pid;
    map['catalogueName'] = _catalogueName;
    map['questionCount'] = _questionCount;
    map['correctCount'] = _correctCount;
    return map;
  }

}