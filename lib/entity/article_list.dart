/// pager : {"back":[1],"current":1,"index":0,"next":1,"pageCount":1,"prev":0,"resultCount":1,"volume":10}
/// list : [{"ad_footer_id":0,"ad_head_id":0,"click_count":1,"createdAt":"2019-01-13 21:11:42","data_time":1547385102850,"forward_count":0,"id":6550,"path":"http://www.baoke.co/web/ad/2019-01-13/2d4bc3f7-65f4-444a-b417-07fac66acd5b/1.html","prior":0,"read_count":3,"sp":"http://www…","src_add":"https://mp.weixin.qq.com/s/0GfS67QFkITIXoVPsVporw","st":"论中国警察与中国足球…","stat":1,"summary":"近日看到一篇警察内部疯传的文章，看完直接笑趴。不得不说，警察蜀黍黑人的功夫顶呱呱，自黑起来也是真狠鸭！ 中国警察和中国足球，都很受国人牵挂，都名气很大，都让人欲罢不能，又给予很多期许，且听笔者给大家以最深度、最科学、最完美、最爆笑的解释： 　　共同点： ","thumbnail":"http://www.baoke.co/web/ad/2019-01-13/bd1baee4-b24e-472a-8e31-26437736cad5/0.jpeg","tid":677,"title":"论中国警察与中国足球，笑趴！","user_id":259}]

class ArticleList {
  Pager? _pager;
  List<ArticleDetailList>? _list;

  Pager? get pager => _pager;
  List<ArticleDetailList>? get list => _list;

  ArticleList({
      Pager? pager, 
      List<ArticleDetailList>? list}){
    _pager = pager;
    _list = list;
}

  ArticleList.fromJson(dynamic json) {
    _pager = json['pager'] != null ? Pager.fromJson(json['pager']) : null;
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(ArticleDetailList.fromJson(v));
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
/// summary : "近日看到一篇警察内部疯传的文章，看完直接笑趴。不得不说，警察蜀黍黑人的功夫顶呱呱，自黑起来也是真狠鸭！ 中国警察和中国足球，都很受国人牵挂，都名气很大，都让人欲罢不能，又给予很多期许，且听笔者给大家以最深度、最科学、最完美、最爆笑的解释： 　　共同点： "
/// thumbnail : "http://www.baoke.co/web/ad/2019-01-13/bd1baee4-b24e-472a-8e31-26437736cad5/0.jpeg"
/// tid : 677
/// title : "论中国警察与中国足球，笑趴！"
/// user_id : 259

class ArticleDetailList {
  int? _adFooterId;
  int? _adHeadId;
  int? _clickCount;
  String? _createdAt;
  int? _dataTime;
  int? _forwardCount;
  int? _id;
  String? _path;
  int? _prior;
  int? _readCount;
  String? _sp;
  String? _srcAdd;
  String? _st;
  int? _stat;
  String? _summary;
  String? _thumbnail;
  int? _tid;
  String? _title;
  String? _uMobile;
  String? _uNick;
  int? _userId;

  int? get adFooterId => _adFooterId;
  int? get adHeadId => _adHeadId;
  int? get clickCount => _clickCount;
  String? get createdAt => _createdAt;
  int? get dataTime => _dataTime;
  int? get forwardCount => _forwardCount;
  int? get id => _id;
  String? get path => _path;
  int? get prior => _prior;
  int? get readCount => _readCount;
  String? get sp => _sp;
  String? get srcAdd => _srcAdd;
  String? get st => _st;
  int? get stat => _stat;
  String? get summary => _summary;
  String? get thumbnail => _thumbnail;
  int? get tid => _tid;
  String? get title => _title;
  String? get mobile => _uMobile;
  String? get nick => _uNick;
  int? get userId => _userId;

  ArticleDetailList({
      int? adFooterId, 
      int? adHeadId, 
      int? clickCount, 
      String? createdAt, 
      int? dataTime, 
      int? forwardCount, 
      int? id, 
      String? path, 
      int? prior, 
      int? readCount, 
      String? sp, 
      String? srcAdd, 
      String? st, 
      int? stat, 
      String? summary, 
      String? thumbnail, 
      int? tid, 
      String? title, 
      String? mobile,
      String? nick,
      int? userId}){
    _adFooterId = adFooterId;
    _adHeadId = adHeadId;
    _clickCount = clickCount;
    _createdAt = createdAt;
    _dataTime = dataTime;
    _forwardCount = forwardCount;
    _id = id;
    _path = path;
    _prior = prior;
    _readCount = readCount;
    _sp = sp;
    _srcAdd = srcAdd;
    _st = st;
    _stat = stat;
    _summary = summary;
    _thumbnail = thumbnail;
    _tid = tid;
    _title = title;
    _uMobile = mobile;
    _uNick = nick;
    _userId = userId;
}

  ArticleDetailList.fromJson(dynamic json) {
    _adFooterId = json['ad_footer_id'];
    _adHeadId = json['ad_head_id'];
    _clickCount = json['click_count'];
    _createdAt = json['createdAt'];
    _dataTime = json['data_time'];
    _forwardCount = json['forward_count'];
    _id = json['id'];
    _path = json['path'];
    _prior = json['prior'];
    _readCount = json['read_count'];
    _sp = json['sp'];
    _srcAdd = json['src_add'];
    _st = json['st'];
    _stat = json['stat'];
    _summary = json['summary'];
    _thumbnail = json['thumbnail'];
    _tid = json['tid'];
    _title = json['title'];
    _uMobile = json['u_mobile'];
    _uNick = json['u_nick'];
    _userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['ad_footer_id'] = _adFooterId;
    map['ad_head_id'] = _adHeadId;
    map['click_count'] = _clickCount;
    map['createdAt'] = _createdAt;
    map['data_time'] = _dataTime;
    map['forward_count'] = _forwardCount;
    map['id'] = _id;
    map['path'] = _path;
    map['prior'] = _prior;
    map['read_count'] = _readCount;
    map['sp'] = _sp;
    map['src_add'] = _srcAdd;
    map['st'] = _st;
    map['stat'] = _stat;
    map['summary'] = _summary;
    map['thumbnail'] = _thumbnail;
    map['tid'] = _tid;
    map['title'] = _title;
    map['u_mobile'] = _uMobile;
    map['u_nick'] = _uNick;
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