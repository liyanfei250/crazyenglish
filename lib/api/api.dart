import '../config.dart';

class Api {
  static String getUser = Config.ApiHost + "/user.site";
  static String getLogin = Config.ApiHost + "/crazy-basic-auth/oauth/token";
  static String getPsdLoginNew = "http://192.168.0.155/app/user/login";
  static String getLoginNew = "http://192.168.0.155/app/user/login/sms";
  static String getResetPsdNew = "http://192.168.0.155/app/user/reset/sms";

  static String getSendAuthCodeNew = "http://192.168.0.155/config/sms/put";

  //修改年级信息
  static String getChangeGrade = "http://192.168.0.155/app/user/put";

  //获取用户信息
  static String getUserIofo = "http://192.168.0.155/app/user/info";
  static String getSendCode = Config.ApiHost + "/crazy-basic-core/sms/";

  static String getWeekPaperList =
      Config.ApiHost + "/crazy-weekly/periodical/app/page";

  //{periodicaId}
  static String getWeekPaperCategory =
      Config.ApiHost + "/crazy-weekly/periodicalContent/app/list/";

  //{id}
  static String getWeekPaperDetail =
      Config.ApiHost + "/crazy-weekly/periodicalContent/app/selectById/";

  static String getWeekTestList =
      Config.ApiHost + "/crazy-question/exercisePeriodical/app/page";

  static String getWeekTestCategoryList =
      Config.ApiHost + "/crazy-question/exerciseCatalogue/app/list/";

  //{periodicaId}
  static String getWeekTestDetail = Config.ApiHost +
      "/crazy-question/exerciseQuestionRequire/selectAppRequireListVo/";

  // static String getAppVersion = Config.ApiHost +"/crazy-basic-core/appVersion/app/version/";
  static String getAppVersion =
      Config.ApiHost + "/crazy-basic-core/appVersion/app/version/";

  /// CLASS_GRADE 年级
  /// QUESTION_TYPE 题型
  /// QUESTION_DIFFICULTY 题目难度
  /// LISTENING_TYPE 题目类型
  /// LISTENING_MODE 听力类型
  static String getDataGroupDetail =
      Config.ApiHost + "/crazy-basic-core/dataGroupDetail/";

  static String getWeiXinPay = Config.ApiHost + "/weixinpay.site";
  static String getPush = Config.ApiHost + "/push_record.site";
  static String getMobile =
      "https://api.verification.jpush.cn/v1/web/loginTokenVerify";


  // 胡一旭接口
  // 周报列表
  static String getWeeklyList = Config.ApiHost+"/app/weekly/list";
  // 周报目录
  static String getWeeklyDirectory = Config.ApiHost+"/app/weekly/directory/tree";
  // 周报详情
  static String getWeekDetail = Config.ApiHost+ "/app/weekly/associate";
  // 提交答案接口
  static String postWeekCommit = Config.ApiHost+ "/app/weekly/commit";
  //根据用户错题本
  static String getErrotList = Config.ApiHost+ "/app/exercises/error/weekly";
  //错题本item详情
  static String getErrotListDetail = Config.ApiHost+ "/app/exercises/error";

}
