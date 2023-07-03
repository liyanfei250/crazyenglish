/// pager : {"back":[1],"current":1,"index":0,"next":1,"pageCount":1,"prev":0,"resultCount":1,"volume":10}
/// list : [{"ad_footer_id":0,"ad_head_id":0,"click_count":1,"createdAt":"2019-01-13 21:11:42","data_time":1547385102850,"forward_count":0,"id":6550,"path":"http://www.baoke.co/web/ad/2019-01-13/2d4bc3f7-65f4-444a-b417-07fac66acd5b/1.html","prior":0,"read_count":3,"sp":"http://www…","src_add":"https://mp.weixin.qq.com/s/0GfS67QFkITIXoVPsVporw","st":"论中国警察与中国足球…","stat":1,"content":"近日看到一篇警察内部疯传的文章，看完直接笑趴。不得不说，警察蜀黍黑人的功夫顶呱呱，自黑起来也是真狠鸭！ 中国警察和中国足球，都很受国人牵挂，都名气很大，都让人欲罢不能，又给予很多期许，且听笔者给大家以最深度、最科学、最完美、最爆笑的解释： 　　共同点： ","thumbnail":"http://www.baoke.co/web/ad/2019-01-13/bd1baee4-b24e-472a-8e31-26437736cad5/0.jpeg","tid":677,"title":"论中国警察与中国足球，笑趴！","user_id":259}]

class PushMsgList {
  Pager? _pager;
  List<PushMsgDetailList>? _list;

  Pager? get pager => _pager;
  List<PushMsgDetailList>? get list => _list;

  PushMsgList({
      Pager? pager, 
      List<PushMsgDetailList>? list}){
    _pager = pager;
    _list = list;
}

  PushMsgList.fromJson(dynamic json) {
    _pager = json['pager'] != null ? Pager.fromJson(json['pager']) : null;
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(PushMsgDetailList.fromJson(v));
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

/// ad_footer_id : 0
/// ad_head_id : 0
/// click_count : 1
/// createdAt : "2019-01-13 21:11:42"
/// data_time : 1547385102850
/// forward_count : 0
/// id : 6550
/// path : "http://www.baoke.co/web/ad/2019-01-13/2d4bc3f7-65f4-444a-b417-07fac66acd5b/1.html"
/// prior : 0
/// read_count : 3
/// sp : "http://www…"
/// src_add : "https://mp.weixin.qq.com/s/0GfS67QFkITIXoVPsVporw"
/// st : "论中国警察与中国足球…"
/// stat : 1
/// content : "近日看到一篇警察内部疯传的文章，看完直接笑趴。不得不说，警察蜀黍黑人的功夫顶呱呱，自黑起来也是真狠鸭！ 中国警察和中国足球，都很受国人牵挂，都名气很大，都让人欲罢不能，又给予很多期许，且听笔者给大家以最深度、最科学、最完美、最爆笑的解释： 　　共同点： "
/// thumbnail : "http://www.baoke.co/web/ad/2019-01-13/bd1baee4-b24e-472a-8e31-26437736cad5/0.jpeg"
/// tid : 677
/// title : "论中国警察与中国足球，笑趴！"
/// user_id : 259

class PushMsgDetailList {
  int? _userId;
  String? _title;
  int? _time;
  String? _content;
  int? _id;

  int? get time => _time;
  int? get id => _id;
  String? get content => _content;
  String? get title => _title;
  int? get userId => _userId;

  PushMsgDetailList({
      int? time,
      int? id,
      String? content,
      String? title,
      int? userId}){
    _time = time;
    _id = id;
    _content = content;
    _title = title;
    _userId = userId;
}

  PushMsgDetailList.fromJson(dynamic json) {
    _time = json['time'];
    _id = json['id'];
    _content = json['content'];
    _title = json['title'];
    _userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['time'] = _time;
    map['id'] = _id;
    map['content'] = _content;
    map['title'] = _title;
    map['user_id'] = _userId;
    return map;
  }

}

/// back : [1]
/// current : 1
/// index : 0
/// next : 1
/// pageCount : 1
/// prev : 0
/// resultCount : 1
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