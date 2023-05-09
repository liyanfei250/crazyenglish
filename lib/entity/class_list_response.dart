/// code : 0
/// message : "系统正常"
/// obj : [{"id":1655395694170124290,"name":"精英班","image":"https://www.baidu.com/img/flexible/logo/pc/result.png","studentSize":2,"teacherUserId":1651539603655626753,"status":1,"isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-08T10:14:24","updateUser":1651539603655626753,"updateTime":"2023-05-08T10:14:24","studentIds":null},{"id":1655395919731404801,"name":"尖子班","image":"https://www.baidu.com/img/flexible/logo/pc/result.png","studentSize":0,"teacherUserId":1651539603655626753,"status":1,"isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-08T10:15:18","updateUser":1651539603655626753,"updateTime":"2023-05-08T10:15:18","studentIds":null},{"id":1655395952644108289,"name":"锤子班","image":"https://www.baidu.com/img/flexible/logo/pc/result.png","studentSize":0,"teacherUserId":1651539603655626753,"status":1,"isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-08T10:15:26","updateUser":1651539603655626753,"updateTime":"2023-05-08T10:15:26","studentIds":null},{"id":1655396107573309442,"name":"一流班","image":"https://flutter.cn/assets/images/cn/flutter-cn-logo.png","studentSize":0,"teacherUserId":1651539603655626753,"status":1,"isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-08T10:16:02","updateUser":1651539603655626753,"updateTime":"2023-05-08T10:16:02","studentIds":null},{"id":1655756629867016194,"name":"学渣班","image":"https://p0.ssl.img.360kuai.com/t01736c309615e3dc19.jpg","studentSize":0,"teacherUserId":1651539603655626753,"status":1,"isDelete":false,"createUser":1651539603655626753,"createTime":"2023-05-09T10:08:38","updateUser":1651539603655626753,"updateTime":"2023-05-09T10:08:38","studentIds":null}]
/// p : null
/// success : true

class ClassListResponse {
  ClassListResponse({
      num? code, 
      String? message, 
      List<Obj>? obj, 
      dynamic p, 
      bool? success,}){
    _code = code;
    _message = message;
    _obj = obj;
    _p = p;
    _success = success;
}

  ClassListResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['obj'] != null) {
      _obj = [];
      json['obj'].forEach((v) {
        _obj?.add(Obj.fromJson(v));
      });
    }
    _p = json['p'];
    _success = json['success'];
  }
  num? _code;
  String? _message;
  List<Obj>? _obj;
  dynamic _p;
  bool? _success;
ClassListResponse copyWith({  num? code,
  String? message,
  List<Obj>? obj,
  dynamic p,
  bool? success,
}) => ClassListResponse(  code: code ?? _code,
  message: message ?? _message,
  obj: obj ?? _obj,
  p: p ?? _p,
  success: success ?? _success,
);
  num? get code => _code;
  String? get message => _message;
  List<Obj>? get obj => _obj;
  dynamic get p => _p;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_obj != null) {
      map['obj'] = _obj?.map((v) => v.toJson()).toList();
    }
    map['p'] = _p;
    map['success'] = _success;
    return map;
  }

}

/// id : 1655395694170124290
/// name : "精英班"
/// image : "https://www.baidu.com/img/flexible/logo/pc/result.png"
/// studentSize : 2
/// teacherUserId : 1651539603655626753
/// status : 1
/// isDelete : false
/// createUser : 1651539603655626753
/// createTime : "2023-05-08T10:14:24"
/// updateUser : 1651539603655626753
/// updateTime : "2023-05-08T10:14:24"
/// studentIds : null

class Obj {
  Obj({
      num? id, 
      String? name, 
      String? image, 
      String? studentSize,
      num? teacherUserId, 
      num? status, 
      bool? isDelete, 
      num? createUser, 
      String? createTime, 
      num? updateUser, 
      String? updateTime, 
      dynamic studentIds,}){
    _id = id;
    _name = name;
    _image = image;
    _studentSize = studentSize;
    _teacherUserId = teacherUserId;
    _status = status;
    _isDelete = isDelete;
    _createUser = createUser;
    _createTime = createTime;
    _updateUser = updateUser;
    _updateTime = updateTime;
    _studentIds = studentIds;
}

  Obj.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _studentSize = json['studentSize'].toString();
    _teacherUserId = json['teacherUserId'];
    _status = json['status'];
    _isDelete = json['isDelete'];
    _createUser = json['createUser'];
    _createTime = json['createTime'];
    _updateUser = json['updateUser'];
    _updateTime = json['updateTime'];
    _studentIds = json['studentIds'];
  }
  num? _id;
  String? _name;
  String? _image;
  String? _studentSize;
  num? _teacherUserId;
  num? _status;
  bool? _isDelete;
  num? _createUser;
  String? _createTime;
  num? _updateUser;
  String? _updateTime;
  dynamic _studentIds;
Obj copyWith({  num? id,
  String? name,
  String? image,
  String? studentSize,
  num? teacherUserId,
  num? status,
  bool? isDelete,
  num? createUser,
  String? createTime,
  num? updateUser,
  String? updateTime,
  dynamic studentIds,
}) => Obj(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  studentSize: studentSize ?? _studentSize,
  teacherUserId: teacherUserId ?? _teacherUserId,
  status: status ?? _status,
  isDelete: isDelete ?? _isDelete,
  createUser: createUser ?? _createUser,
  createTime: createTime ?? _createTime,
  updateUser: updateUser ?? _updateUser,
  updateTime: updateTime ?? _updateTime,
  studentIds: studentIds ?? _studentIds,
);
  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get studentSize => _studentSize;
  num? get teacherUserId => _teacherUserId;
  num? get status => _status;
  bool? get isDelete => _isDelete;
  num? get createUser => _createUser;
  String? get createTime => _createTime;
  num? get updateUser => _updateUser;
  String? get updateTime => _updateTime;
  dynamic get studentIds => _studentIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['studentSize'] = _studentSize;
    map['teacherUserId'] = _teacherUserId;
    map['status'] = _status;
    map['isDelete'] = _isDelete;
    map['createUser'] = _createUser;
    map['createTime'] = _createTime;
    map['updateUser'] = _updateUser;
    map['updateTime'] = _updateTime;
    map['studentIds'] = _studentIds;
    return map;
  }

}