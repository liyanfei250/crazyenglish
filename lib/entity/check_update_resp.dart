/// apkUrl : "www.baidu.com"
/// updateDescription : "大多数"
/// forceUpdate : false
/// apkSize : 1024
/// isUpdate : false

class CheckUpdateResp {
  String? _apkUrl;
  String? _updateDescription;
  String? _publishDate;
  bool? _forceUpdate;
  int? _apkSize;
  bool? _isUpdate;
  String? _newVersion;

  String? get apkUrl => _apkUrl;
  String? get publishDate => _publishDate;
  String? get newVersion => _newVersion;
  String? get updateDescription => _updateDescription;
  bool? get forceUpdate => _forceUpdate;
  int? get apkSize => _apkSize;
  bool? get isUpdate => _isUpdate;

  CheckUpdateResp({
      String? apkUrl, 
      String? newVersion,
    String? publishDate,
      String? updateDescription,
      bool? forceUpdate, 
      int? apkSize, 
      bool? isUpdate}){
    _apkUrl = apkUrl;
    _publishDate = publishDate;
    _newVersion = newVersion;
    _updateDescription = updateDescription;
    _forceUpdate = forceUpdate;
    _apkSize = apkSize;
    _isUpdate = isUpdate;
}

  CheckUpdateResp.fromJson(dynamic json) {
    _apkUrl = json['apkUrl'];
    _newVersion = json['newVersion'];
    _publishDate = json['publishDate'];
    _updateDescription = json['updateDescription'];
    _forceUpdate = json['forceUpdate'];
    _apkSize = json['apkSize'];
    _isUpdate = json['isUpdate'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['apkUrl'] = _apkUrl;
    map['newVersion'] = _newVersion;
    map['publishDate'] = _publishDate;
    map['updateDescription'] = _updateDescription;
    map['forceUpdate'] = _forceUpdate;
    map['apkSize'] = _apkSize;
    map['isUpdate'] = _isUpdate;
    return map;
  }

}