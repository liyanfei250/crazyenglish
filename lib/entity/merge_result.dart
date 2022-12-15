/// result : "success"
/// summary : "我是一名模特在工作中认识比我大19岁的老公的，他是我的老板，当我们结婚不到3个月时，就发现自己真的是嫁错了！原来找男人不是有钱就行的， 他根本满足不了我，开始时每次都是草草了事，没多久干脆放进去就结束了，后来连硬起来都费劲，我俩想尽办法，试过好多方法，去"
/// src_add : "https://mp.weixin.qq.com/s/givOdFP55g2cmewkSFIFEQ"
/// thumbnail : "http://192.168.1.7/ad/web/ad/2022-10-10/882b10d2-b712-4e9d-8140-8a3d29a63faa/0.jpeg"
/// id : 464474
/// title : "一个长期吃鹿产品的男人，后来竟变成这个样子"
/// url : "http://192.168.1.7/ad/web/ad/2022-10-10/882b10d2-b712-4e9d-8140-8a3d29a63faa/1.html"
/// tid : "0"

class MergeResult {
  String? _result;
  String? _summary;
  String? _srcAdd;
  String? _thumbnail;
  int? _id;
  String? _title;
  String? _url;
  String? _tid;

  String? get result => _result;
  String? get summary => _summary;
  String? get srcAdd => _srcAdd;
  String? get thumbnail => _thumbnail;
  int? get id => _id;
  String? get title => _title;
  String? get url => _url;
  String? get tid => _tid;

  MergeResult({
      String? result, 
      String? summary, 
      String? srcAdd, 
      String? thumbnail, 
      int? id, 
      String? title, 
      String? url, 
      String? tid}){
    _result = result;
    _summary = summary;
    _srcAdd = srcAdd;
    _thumbnail = thumbnail;
    _id = id;
    _title = title;
    _url = url;
    _tid = tid;
}

  MergeResult.fromJson(dynamic json) {
    _result = json['result'];
    _summary = json['summary'];
    _srcAdd = json['src_add'];
    _thumbnail = json['thumbnail'];
    _id = json['id'];
    _title = json['title'];
    _url = json['url'];
    _tid = json['tid'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['result'] = _result;
    map['summary'] = _summary;
    map['src_add'] = _srcAdd;
    map['thumbnail'] = _thumbnail;
    map['id'] = _id;
    map['title'] = _title;
    map['url'] = _url;
    map['tid'] = _tid;
    return map;
  }

}