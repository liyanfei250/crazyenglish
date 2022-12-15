
/// pager : {"back":[1],"current":1,"index":0,"next":1,"pageCount":1,"prev":0,"resultCount":3,"volume":10}
/// list : [{"category":0,"categoryName":"head","fix":0,"id":2,"seq":0,"type":1,"typeName":"phone","url":"18680345492","user_id":259},{"category":0,"categoryName":"head","descr":"哈哈","fix":2,"id":3,"seq":0,"service":"KKK","type":4,"typeName":"qrcode","user_id":259},{"category":0,"categoryName":"head","fix":0,"id":4,"seq":0,"type":0,"typeName":"url","url":"呃呃呃","user_id":259}]

class Template_list {
  Pager? _pager;
  List<TemplateList>? _list;

  Pager? get pager => _pager;

  List<TemplateList>? get list => _list;

  setList(List<TemplateList> value) {
    _list = value;
  } // List<TemplateList>? get list => _list;

  // set _list(List<TemplateList> list){
  //  _list = list;
  // }

  Template_list({
      Pager? pager, 
      List<TemplateList>? list}){
    _pager = pager;
    _list = list;
}

  Template_list.fromJson(dynamic json) {
    _pager = json['pager'] != null ? Pager.fromJson(json['pager']) : null;
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(TemplateList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_pager != null) {
      map['pager'] = _pager?.toJson();
    }
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category : 0
/// categoryName : "head"
/// fix : 0
/// id : 2
/// seq : 0
/// type :
/// 0: 通用广告
/// 1：电话广告
/// 2：二维码广告
/// 3：名片广告
/// 4：朋友圈广告
/// 5：qq广告
/// 6：图文广告
/// 7：优惠券广告
///
/// typeName : "phone"
/// url : "18680345492"
/// user_id : 259

class TemplateList implements Comparable<TemplateList>{
  int? _category;
  String? _categoryName;
  int? _fix;
  int? _id;
  int? _seq;
  int? _type;
  String? _typeName;
  String? _url;
  String? _service;
  String? _descr;
  String? _img;
  String? _serviceUrl;
  String? _descrUrl;
  String? _imgUrl;

  int? _userId;
  bool isEdit = false;

  int? get category => _category;
  String? get categoryName => _categoryName;
  int? get fix => _fix;
  int? get id => _id;
  int? get seq => _seq;
  int? get type => _type;
  String? get typeName => _typeName;
  String? get url => _url;
  String? get service => _service;
  String? get descr => _descr;
  String? get img => _img;
  String? get serviceUrl => _serviceUrl;
  String? get descrUrl => _descrUrl;
  String? get imgUrl => _imgUrl;
  int? get userId => _userId;


  setcategory(int value) {
    _category = value;
  }

  TemplateList({
      int? category, 
      String? categoryName,
      bool? isEdit,
      int? fix, 
      int? id, 
      int? seq, 
      int? type, 
      String? typeName, 
      String? url, 
      String? service,
      String? descr,
      String? img,
      int? userId}){
    _category = category;
    _categoryName = categoryName;
    _fix = fix;
    _id = id;
    _seq = seq;
    _type = type;
    _typeName = typeName;
    _url = url;
    _service = service;
    _descr = descr;
    _img = img;
    _userId = userId;
    this.isEdit = isEdit??false;
}

  TemplateList.fromJson(dynamic json) {
    _category = json['category'];
    _categoryName = json['categoryName'];
    _fix = json['fix'];
    _id = json['id'];
    _seq = json['seq'];
    _type = json['type'];
    _typeName = json['typeName'];
    _url = json['url'];
    _service = json['service'];
    _descr = json['descr'];
    _img = json['img'];
    _serviceUrl = json['serviceUrl'];
    _descrUrl = json['descrUrl'];
    _imgUrl = json['imgUrl'];
    _userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['category'] = _category;
    map['categoryName'] = _categoryName;
    map['fix'] = _fix;
    map['id'] = _id;
    map['seq'] = _seq;
    map['type'] = _type;
    map['typeName'] = _typeName;
    map['url'] = _url;
    map['service'] = _service;
    map['descr'] = _descr;
    map['img'] = _img;
    map['serviceUrl'] = _serviceUrl;
    map['descrUrl'] = _descrUrl;
    map['imgUrl'] = _imgUrl;
    map['user_id'] = _userId;
    return map;
  }

  setcategoryName(String value) {
    _categoryName = value;
  }

  setfix(int value) {
    _fix = value;
  }

  setseq(int value) {
    _seq = value;
  }

  settype(int value) {
    _type = value;
  }

  settypeName(String value) {
    _typeName = value;
  }

  seturl(String value) {
    _url = value;
  }

  setservice(String value) {
    _service = value;
  }

  setdescr(String value) {
    _descr = value;
  }

  setimg(String value) {
    _img = value;
  }
  setserviceUrl(String value) {
    _serviceUrl = value;
  }

  setdescrUrl(String value) {
    _descrUrl = value;
  }

  setimgUrl(String value) {
    _imgUrl = value;
  }

  setuserId(int value) {
    _userId = value;
  }

  @override
  int compareTo(TemplateList other) {
    // TODO: implement compareTo
    if ((seq??0) < (other.seq??0)){
      return -1;
    }else if((seq??0) > (other.seq??0)){
      return 1;
    }else{
      return 0;
    }
  }
}

/// back : [1]
/// current : 1
/// index : 0
/// next : 1
/// pageCount : 1
/// prev : 0
/// resultCount : 3
/// volume : 10

class Pager {
  List<int>? _back;
  int? _current;
  int? _index;
  int? _next;
  int? _pageCount;
  int? _prev;
  int? _resultCount;
  int? _volume;

  List<int>? get back => _back;
  int? get current => _current;
  int? get index => _index;
  int? get next => _next;
  int? get pageCount => _pageCount;
  int? get prev => _prev;
  int? get resultCount => _resultCount;
  int? get volume => _volume;

  Pager({
      List<int>? back, 
      int? current, 
      int? index, 
      int? next, 
      int? pageCount, 
      int? prev, 
      int? resultCount, 
      int? volume}){
    _back = back;
    _current = current;
    _index = index;
    _next = next;
    _pageCount = pageCount;
    _prev = prev;
    _resultCount = resultCount;
    _volume = volume;
}

  Pager.fromJson(dynamic json) {
    _back = json['back'] != null ? json['back'].cast<int>() : [];
    _current = json['current'];
    _index = json['index'];
    _next = json['next'];
    _pageCount = json['pageCount'];
    _prev = json['prev'];
    _resultCount = json['resultCount'];
    _volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['back'] = _back;
    map['current'] = _current;
    map['index'] = _index;
    map['next'] = _next;
    map['pageCount'] = _pageCount;
    map['prev'] = _prev;
    map['resultCount'] = _resultCount;
    map['volume'] = _volume;
    return map;
  }

}