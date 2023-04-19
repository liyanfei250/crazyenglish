
class BaseConstant{
  static const String Sid = "sid";
  static const String loginUser = "loginUser";
  static const String userId = "userId";
  static const String umengToken = "umengToken";
  static String UA = "";

  /**
   * 引导页key
   */
  ///闪屏广告
  static const String key_splash_ad = "key_splash_ad";
  ///首次安装
  static const String key_first_installation = "key_first_installation";
  ///首次同意隐私权限
  static const String key_agree_policy = "key_agree_policy";
  ///用户隐私协议更新时间
  static const String key_privacy_agreement_time_tamp = "key_privacy_agreement_time_tamp";

  // 口语 写作 入口期数引导
  static const String spoken_tips_guide = "spoken_tips_guide";
  static const String write_tips_guide = "write_tips_guide";


  // 苹果审核模式字段
  static const String appleauditStatus = "appleauditStatus";

  static const String routeMain = 'route_main';
  static const String routeLogin = 'route_login';

  static const String NOTICE_PERMISSION = "notice_permission";
  static const String ISLOGING = "is_login";
  static const String IS_CHOICE_ROLE = "is_choice_role";
  static const String IS_CHOICE_ROLE_STUDENT = "is_choice_role_student";
  static const String IS_CHOICE_ROLE_GRADE = "is_choice_role_grade";
  static const String loginTOKEN = "loginTOKEN";
  static const String IS_TEACHER_LOGIN = "is_TEacher_login";

}

class LoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 1;
  static const int empty = 2;
}

class DataGroup{
  static Map<String,String> questionType = {};
}

// 题型
class QuestionType {

  static const int single_choice = 1; /// 单选题
  static const int multi_choice = 2;  /// 多选题
  static const int judge_choice = 3;  /// 判断题
  static const int normal_gap = 4;  /// 常规填空题
  static const int translate_filling = 5;  /// 翻译填空题
  static const int completion_filling = 6;  /// 补全填空题
  static const int complete_filling = 7;  /// 完型填空题
  static const int select_words_filling = 8;  /// 选词填空
  static const int select_filling = 9;  /// 选择填空
  static const int normal_reading = 10;  /// 常规阅读题
  static const int question_reading = 11;  /// 简单阅读题
  static const int translate_question = 12;  /// 中英文互译
  static const int writing_question = 13;  /// 写作题
  static const int correction_question = 14;  /// 短文改错题

}

// 题型分类
class QuestionTypeClassify {

  static const int listening = 1;  /// 听力
  static const int reading = 2;  /// 阅读
  static const int writing = 3;  /// 写作
  static const int spoken = 4;  /// 口语
  static const int vocabulary = 5;  /// 词汇
  static const int phrase = 6;  /// 短语
  static const int grammer = 7;  /// 语法
  static const int sentence = 8;  /// 句子
  static const int others = 9;  /// 其它
}


class PayType{
  static const String APPLE = "apple";
  static const String WX = "wx";
  static const String WXWAP = "wxWap";
  static const String Ali = "ali";
  static const String AliWap = "aliWap";
}

class C{
  static const String APPNAME = "英语周报";
  static const String COMPANY = "太原东方盛慧科技有限公司";
  static const String APP_DESC = "太原东方盛慧科技有限公司";
  static const String APP_DOWNLOAD_URL = "https://ps-1252082677.cos.ap-beijing.myqcloud.com/apk/money_make.apk";

  /**
   * 第三方登录参数
   */
  static const String UID = "uid";
  static const String USERNAME = "userName";
  static const String ACCESS_TOKEN = "accessToken";

  static const String QQ = "QQ";
  static const String QQ_APP_ID = "1109734864";

  static const String WEIBO = "sinaweibo";
  static const String WEIBO_APP_KEY = "1571175609";
  static const String WEIBO_URL = "http://sns.whalecloud.com/sina2/callback";

  /**
   * 微信分享的参数
   */
  static const String WX = "WeiXin";
  static const String WX_APP_ID = "wx816e8a97d374aa75";
  static const String WX_APP_SECRET = "1b83bd73adfc6962731eeea1d5eb1050";
//    static const String WX_APP_TEMPLATE_ID = "wQ90gKAb6bYZiUwTSclrQ_EgVIPK1-U9794qeYVTlKY";
  static const String WX_APP_TEMPLATE_ID = "ryy4JUW1mRkrk2-LZw4m1W75pvwGPAZexYG-NZepVCg";


  static const String BAIDU = "baidu";
  static const String BAIDU_APP_KEY = "xnA14dMjxEFsuSdRXlKdz1vH";
  static const String BAIDU_URL = "http://www.crazyenglish.com";

  static const int SID_INVALID = 9708;
  //领取资料的文案（2.0弃用）
  static const String pageHomeWechatUrI = "pageHomeWechatUrI";
  //领取资料的url
  static const String pageHomeWechatContext = "pageHomeWechatContext";
  //口语题库tag文案
  static const String oralSeasonShadow = "oralSeasonShadow";
  //写作新题tag文案
  static const String writingSubheadingShadow = "writingSubheadingShadow";
  //水平测试文案
  static const String levelJudge = "levelJudge";

  //用户协议
  static const String REGISTER_LAW = "https://geeklei.cn:8443/user/agreement/"; // 注册条款
  static const String REGISTER_PRIVACY_POLICY_LAW = "https://geeklei.cn:8443/user/policy"; // 隐私与政策


}

class HTTP_CODE{
  static const int OK = 0;
  static const int ERROR = 1;
}