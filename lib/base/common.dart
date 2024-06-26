
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
  static const String IS_CHOICE_ROLE_GRADE = "is_choice_role_grade";
  static const String loginTOKEN = "loginTOKEN";
  static const String IS_TEACHER_LOGIN = "is_TEacher_login";
  static const String USER_NAME = "USER_NAME";
  static const String USER_INFO = "USER_INFO";
  static const String NICK_NAME = "NICK_NAME";
  static const String USER_ID = "USER_ID";

  static const String FIERST_NET_ERROR = "FIERST_NET_ERROR";
  static const String VERSION_NOTIFIY = "VERSION_NOTIFIY";

}

class LoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 1;
  static const int empty = 2;
}

class RoleType{
  static const int teacher = 1;
  static const int student = 2;
}

class DataGroup{
  static Map<String,String> questionType = {};
}

class DictionaryType{
  static const String GradeType = "grade_type";
}

class FeedbackType{
  static const int subtopicType = 1;
  static const int subjectType = 2;
  static const int system = 3;
}

class ScoreListType{
  static const int scoreList = 1;
  static const int waitCorrectingList = 2;
  static const int waitTipsList = 3;
}

// 发布作业类型
class PaperType{
  // 习题类型
  static const int Questions = 1;
  // 期刊类型
  static const int Journals = 2;
  // 试卷库
  static const int exam = 3;
  // 历史作业
  static const int HistoryHomework = 4;
}

// 题型
class QuestionType {

  static const String single_choice = "single_choice"; /// 单选题
  static const String multi_choice = "multi_choice";  /// 多选题
  static const String judge_choice = "judge_choice";  /// 判断题
  static const String normal_gap = "normal_gap";  /// 常规填空题
  static const String translate_filling = "translate_filling";  /// 翻译填空题
  static const String completion_filling = "completion_filling";  /// 补全填空题
  static const String complete_filling = "complete_filling";  /// 完型填空题
  static const String select_words_filling = "select_words_filling";  /// 选词填空
  static const String select_filling = "select_filling";  /// 选择填空
  static const String normal_reading = "normal_reading";  /// 常规阅读题
  static const String question_reading = "question_reading";  /// 简单阅读题
  static const String translate_question = "translate_question";  /// 中英文互译
  static const String writing_question = "writing_question";  /// 写作题
  static const String correction_question = "correction_question";  /// 短文改错题

  static String getName(String questionType){
    switch(questionType){
      case QuestionType.single_choice:
        return "单选题";
      case QuestionType.multi_choice:
        return "多选题";
      case QuestionType.judge_choice:
        return "判断题";
      case QuestionType.normal_gap:
        return "填空题";
      case QuestionType.translate_filling:
        return "翻译填空题";
      case QuestionType.completion_filling:
        return "补全填空题";
      case QuestionType.complete_filling:
        return "完型填空题";
      case QuestionType.select_words_filling:
        return "选词填空";
      case QuestionType.select_filling:
        return "选择填空";
      case QuestionType.normal_reading:
        return "常规阅读题";
      case QuestionType.question_reading:
        return "简答阅读题";
      case QuestionType.translate_question:
        return "中英文互译";
      case QuestionType.writing_question:
        return "写作题";
      case QuestionType.correction_question:
        return "短文改错题";
      default:
        return "题型未知";
    }
  }
}

class SmsCodeType{
  static const int phoneLogin = 1;
  static const int resetPwd = 2;
  static const int changeMobile = 3;
}

class HomeworkStatus{
  // 未开始
  static const int unstart = 1;
  // 进行中
  static const int started = 2;
  // 已完成
  static const int completed = 3;
}

class HistoryHomeworkStatus{
  // 未检查
  static const int not_checked  = 1;
  // 已检查
  static const int checked = 2;
}

class AnswerType{
  static const int no_answer = 0;
  static const int wrong = 1;
  static const int right = 2;
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

  static String getName(int questionType){
    switch(questionType){
      case QuestionTypeClassify.listening:
        return "听力";
      case QuestionTypeClassify.reading:
        return "阅读";
      case QuestionTypeClassify.writing:
        return "写作";
      case QuestionTypeClassify.spoken:
        return "口语";
      case QuestionTypeClassify.vocabulary:
        return "词汇";
      case QuestionTypeClassify.phrase:
        return "短语";
      case QuestionTypeClassify.grammer:
        return "语法";
      case QuestionTypeClassify.sentence:
        return "句子";
      case QuestionTypeClassify.others:
        return "其它";
      default:
        return "题型分类未知";
    }
  }

}


class PayType{
  static const String APPLE = "apple";
  static const String WX = "wx";
  static const String WXWAP = "wxWap";
  static const String Ali = "ali";
  static const String AliWap = "aliWap";
}

class C{
  static const String APPNAME = "数字英语";
  static const String COMPANY = "疯狂英语（山西）数字科技有限公司";
  static const String APP_DESC = "疯狂英语（山西）数字科技有限公司";

  /**
   * 第三方登录参数
   */
  static const String UID = "uid";
  static const String USERNAME = "userName";
  static const String ACCESS_TOKEN = "accessToken";

  static const String QQ = "QQ";
  static const String QQ_APP_ID = "1109734864";

  static const String WEIBO = "sinaweibo";
  static const String WEIBO_APP_KEY = "";
  static const String WEIBO_URL = "";

  /**
   * 微信分享的参数
   */
  static const String WX = "WeiXin";
  static const String WX_APP_ID = "";
  static const String WX_APP_SECRET = "";
//    static const String WX_APP_TEMPLATE_ID = "wQ90gKAb6bYZiUwTSclrQ_EgVIPK1-U9794qeYVTlKY";
  static const String WX_APP_TEMPLATE_ID = "";


  static const String BAIDU = "baidu";
  static const String BAIDU_APP_KEY = "";
  static const String BAIDU_URL = "https://www.crazyenglishweekly.com";

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
  static const String REGISTER_LAW = "https://mp.crazyenglishweekly.com/fkyy/regist/"; // 注册条款
  static const String REGISTER_PRIVACY_POLICY_LAW = "https://mp.crazyenglishweekly.com/fkyy/privacy"; // 隐私与政策


}

class HTTP_CODE{
  static const int OK = 0;
  static const int ERROR = 1;
}