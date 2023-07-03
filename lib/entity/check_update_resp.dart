import 'base_resp.dart';

/// code : 1
/// msg : "系统正常"
/// data : {"appId":1011,"version":"1.0.1","versionNum":101,"isUpdate":true,"description":"版本升级","forceUpdate":true,"linkUrl":"https://test-1315843937.cos.ap-beijing.myqcloud.com/apk/crazyenglish.apk"}

class CheckUpdateResponse extends BaseResp{
  CheckUpdateResp? _data;

  CheckUpdateResp? get data => _data;

  CheckUpdateResponse({
      int? code, 
      String? msg,
    CheckUpdateResp? data}):super(code,msg){
    code = code;
    msg = msg;
    _data = data;
}

  CheckUpdateResponse.fromJson(dynamic json):super.fromJson(json) {
    _data = json['obj'] != null ? CheckUpdateResp.fromJson(json['obj']) : null;
  }

}

/// appId : 1011
/// version : "1.0.1"
/// versionNum : 101
/// isUpdate : true
/// description : "版本升级"
/// forceUpdate : true
/// linkUrl : "https://test-1315843937.cos.ap-beijing.myqcloud.com/apk/crazyenglish.apk"

class CheckUpdateResp {
  String? _linkUrl;
  String? _description;
  String? _publishDate;
  int? _forceUpdate;
  int? _apkSize;
  bool? _isUpdate;
  String? _version;

  String? get apkUrl => _linkUrl;
  String? get publishDate => _publishDate;
  String? get newVersion => _version;
  String? get updateDescription => _description;
  int? get forceUpdate => _forceUpdate;
  int? get apkSize => _apkSize;
  bool? get isUpdate => _isUpdate;

  CheckUpdateResp({
    String? apkUrl,
    String? version,
    String? publishDate,
    String? updateDescription,
    int? forceUpdate,
    int? apkSize,
    bool? isUpdate}){
    _linkUrl = apkUrl;
    _publishDate = publishDate;
    _version = newVersion;
    _description = updateDescription;
    _forceUpdate = forceUpdate;
    _apkSize = apkSize;
    _isUpdate = isUpdate;
  }

  CheckUpdateResp.fromJson(dynamic json) {
    _linkUrl = json['linkUrl']??"";
    _version = json['version']??"";
    _publishDate = json['publishDate']??"";
    _description = json['description']??"";
    _forceUpdate = json['forceUpdate']??1;
    _apkSize = json['apkSize']??0;
    _isUpdate = json['isUpdate']??false;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['linkUrl'] = _linkUrl;
    map['version'] = _version;
    map['publishDate'] = _publishDate;
    map['description'] = _description;
    map['forceUpdate'] = _forceUpdate;
    map['apkSize'] = _apkSize;
    map['isUpdate'] = _isUpdate;
    return map;
  }


}