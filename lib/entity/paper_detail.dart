/// code : 1
/// msg : "系统正常"
/// data : {"id":27,"titleCn":"厉害了，崔宸溪","titleEn":"Bee? Hoverfly?","content":"<p style=\"text-align: left;\"><strong>IN FOCUS</strong></p><p style=\"text-align: center;\"><span style=\"font-size: 24px;\"><strong>Bee? Hoverfly?</strong></span></p><p style=\"text-align: center;\"><span style=\"font-size: 22px; font-family: 宋体;\">厉害了，崔宸溪</span></p><p style=\"text-align: right;\">词数约180 建议用时4'30\"</p><p> </p><p style=\"text-indent: 21pt;\">Cui Chenxi is a middle school student in Shenyang, Liaoning Province. Although he is only 13, he knows more about biology than you may think.</p><p style=\"text-indent: 21pt;\">One day last term, when Cui was reading his English book, he found a mistake in one of its pictures. It was a picture of an <strong>insect</strong>. Below it was the word \"bee”. Cui found that the insect was not a bee, but a <strong>hoverfly</strong>. So he called the <strong>publisher</strong>, and after checking the picture they said he was right. They would change the picture soon.</p><p style=\"text-indent: 21pt;\">It was not difficult for Cui to find the mistake. He can tell different kinds of insects. He said, \"Bees have two pairs of wings, but hoverflies only have one. Bees are fat, but hoverflies are thin.”</p><p style=\"text-indent: 21pt;\">Cui is good at biology because he's interested in it. When he was in primary school, he kept over 10 kinds of ants. He could even tell what they like to do and what they can do. In his home, there are many books and more than 300 of them are about biology.</p><p style=\"text-indent: 21pt;\">Well done, Cui Chenxi!</p><hr/><p style=\"text-align: left;\"><strong>Word Bank</strong></p><p style=\"text-align: left;\">1. biology 英 / baɪˈɒlədʒi/ 美 / baɪˈɑːlədʒi/ n. 生物学</p><p style=\"text-align: left;\">2. insect 英 / ˈɪnsekt/ 美 / ˈɪnsekt/ n. 昆虫</p><p style=\"text-align: left;\">3. hoverfly /'hɒvəflai/ n. 食蚜蝇</p><p style=\"text-align: left;\">4. publisher 英 / ˈpʌblɪʃə(r)/ &nbsp;美 / ˈpʌblɪʃər/ n. <span style=\"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);\">出版商</span></p><p style=\"text-align: left;\">5. wing 英 / wɪŋ/ 美 / wɪŋ/ n. 翅膀</p><hr/><p style=\"text-align: left;\"><strong>Checking Corner</strong></p><p style=\"text-align: left;\">Choose the best answer.</p><p style=\"text-align: left;\">( &nbsp; &nbsp; &nbsp;)1. Which subject is Cui good at?</p><p style=\"text-align: left;\">A. English. </p><p style=\"text-align: left;\">B. Biology. </p><p style=\"text-align: left;\">C. Chinese. </p><p style=\"text-align: left;\"> </p><p style=\"text-align: left;\">( &nbsp; &nbsp; &nbsp;)2. What insect did Cui see in the picture?</p><p style=\"text-align: left;\">A. An ant. </p><p style=\"text-align: left;\">B. A bee. </p><p style=\"text-align: left;\">C. A hoverfly. </p><p style=\"text-align: left;\"> </p><p style=\"text-align: left;\">( &nbsp; &nbsp; &nbsp;)3. To know the differences between bees and hoverflies, you can read</p><p style=\"text-align: left;\">A. Paragraph 2 </p><p style=\"text-align: left;\">B. Paragraph 3 </p><p style=\"text-align: left;\">C. Paragraph 4</p><p style=\"text-align: left;\"> </p><p style=\"text-align: left;\">( &nbsp; &nbsp; &nbsp; )4. Which of the following is TRUE?</p><p style=\"text-align: left;\">A. Cui knows a lot about ants.</p><p style=\"text-align: left;\">B. Cui has 300 books at home.</p><p style=\"text-align: left;\">C. Cui is a primary school student.</p>","largeFile":"","audioFile":"","videoFile":"","createTime":"2022-12-28","viewsCount":0,"voiceContent":""}

class PaperDetail {
  int? _code;
  String? _msg;
  Data? _data;

  int? get code => _code;
  String? get msg => _msg;
  Data? get data => _data;

  PaperDetail({
      int? code, 
      String? msg, 
      Data? data}){
    _code = code;
    _msg = msg;
    _data = data;
}

  PaperDetail.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['obj'] != null ? Data.fromJson(json['obj']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _msg;
    if (_data != null) {
      map['obj'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 27
/// titleCn : "厉害了，崔宸溪"
/// titleEn : "Bee? Hoverfly?"
/// content : "<p style=\"text-align: left;\"><strong>IN FOCUS</strong></p><p style=\"text-align: center;\"><span style=\"font-size: 24px;\"><strong>Bee? Hoverfly?</strong></span></p><p style=\"text-align: center;\"><span style=\"font-size: 22px; font-family: 宋体;\">厉害了，崔宸溪</span></p><p style=\"text-align: right;\">词数约180 建议用时4'30\"</p><p> </p><p style=\"text-indent: 21pt;\">Cui Chenxi is a middle school student in Shenyang, Liaoning Province. Although he is only 13, he knows more about biology than you may think.</p><p style=\"text-indent: 21pt;\">One day last term, when Cui was reading his English book, he found a mistake in one of its pictures. It was a picture of an <strong>insect</strong>. Below it was the word \"bee”. Cui found that the insect was not a bee, but a <strong>hoverfly</strong>. So he called the <strong>publisher</strong>, and after checking the picture they said he was right. They would change the picture soon.</p><p style=\"text-indent: 21pt;\">It was not difficult for Cui to find the mistake. He can tell different kinds of insects. He said, \"Bees have two pairs of wings, but hoverflies only have one. Bees are fat, but hoverflies are thin.”</p><p style=\"text-indent: 21pt;\">Cui is good at biology because he's interested in it. When he was in primary school, he kept over 10 kinds of ants. He could even tell what they like to do and what they can do. In his home, there are many books and more than 300 of them are about biology.</p><p style=\"text-indent: 21pt;\">Well done, Cui Chenxi!</p><hr/><p style=\"text-align: left;\"><strong>Word Bank</strong></p><p style=\"text-align: left;\">1. biology 英 / baɪˈɒlədʒi/ 美 / baɪˈɑːlədʒi/ n. 生物学</p><p style=\"text-align: left;\">2. insect 英 / ˈɪnsekt/ 美 / ˈɪnsekt/ n. 昆虫</p><p style=\"text-align: left;\">3. hoverfly /'hɒvəflai/ n. 食蚜蝇</p><p style=\"text-align: left;\">4. publisher 英 / ˈpʌblɪʃə(r)/ &nbsp;美 / ˈpʌblɪʃər/ n. <span style=\"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);\">出版商</span></p><p style=\"text-align: left;\">5. wing 英 / wɪŋ/ 美 / wɪŋ/ n. 翅膀</p><hr/><p style=\"text-align: left;\"><strong>Checking Corner</strong></p><p style=\"text-align: left;\">Choose the best answer.</p><p style=\"text-align: left;\">( &nbsp; &nbsp; &nbsp;)1. Which subject is Cui good at?</p><p style=\"text-align: left;\">A. English. </p><p style=\"text-align: left;\">B. Biology. </p><p style=\"text-align: left;\">C. Chinese. </p><p style=\"text-align: left;\"> </p><p style=\"text-align: left;\">( &nbsp; &nbsp; &nbsp;)2. What insect did Cui see in the picture?</p><p style=\"text-align: left;\">A. An ant. </p><p style=\"text-align: left;\">B. A bee. </p><p style=\"text-align: left;\">C. A hoverfly. </p><p style=\"text-align: left;\"> </p><p style=\"text-align: left;\">( &nbsp; &nbsp; &nbsp;)3. To know the differences between bees and hoverflies, you can read</p><p style=\"text-align: left;\">A. Paragraph 2 </p><p style=\"text-align: left;\">B. Paragraph 3 </p><p style=\"text-align: left;\">C. Paragraph 4</p><p style=\"text-align: left;\"> </p><p style=\"text-align: left;\">( &nbsp; &nbsp; &nbsp; )4. Which of the following is TRUE?</p><p style=\"text-align: left;\">A. Cui knows a lot about ants.</p><p style=\"text-align: left;\">B. Cui has 300 books at home.</p><p style=\"text-align: left;\">C. Cui is a primary school student.</p>"
/// largeFile : ""
/// audioFile : ""
/// videoFile : ""
/// createTime : "2022-12-28"
/// viewsCount : 0
/// voiceContent : ""

class Data {
  int? _id;
  String? _titleCn;
  String? _titleEn;
  String? _content;
  String? _largeFile;
  String? _audioFile;
  String? _videoFile;
  String? _createTime;
  int? _viewsCount;
  String? _voiceContent;

  int? get id => _id;
  String? get titleCn => _titleCn;
  String? get titleEn => _titleEn;
  String? get content => _content;
  String? get largeFile => _largeFile;
  String? get audioFile => _audioFile;
  String? get videoFile => _videoFile;
  String? get createTime => _createTime;
  int? get viewsCount => _viewsCount;
  String? get voiceContent => _voiceContent;

  Data({
      int? id, 
      String? titleCn, 
      String? titleEn, 
      String? content, 
      String? largeFile, 
      String? audioFile, 
      String? videoFile, 
      String? createTime, 
      int? viewsCount, 
      String? voiceContent}){
    _id = id;
    _titleCn = titleCn;
    _titleEn = titleEn;
    _content = content;
    _largeFile = largeFile;
    _audioFile = audioFile;
    _videoFile = videoFile;
    _createTime = createTime;
    _viewsCount = viewsCount;
    _voiceContent = voiceContent;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _titleCn = json['titleCn'];
    _titleEn = json['titleEn'];
    _content = json['content'];
    _largeFile = json['largeFile'];
    _audioFile = json['audioFile'];
    _videoFile = json['videoFile'];
    _createTime = json['createTime'];
    _viewsCount = json['viewsCount'];
    _voiceContent = json['voiceContent'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['titleCn'] = _titleCn;
    map['titleEn'] = _titleEn;
    map['content'] = _content;
    map['largeFile'] = _largeFile;
    map['audioFile'] = _audioFile;
    map['videoFile'] = _videoFile;
    map['createTime'] = _createTime;
    map['viewsCount'] = _viewsCount;
    map['voiceContent'] = _voiceContent;
    return map;
  }

}