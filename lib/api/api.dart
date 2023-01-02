
import '../config.dart';

class Api {

  static String getUser = Config.ApiHost +"/user.site";
  static String getLogin = Config.ApiHost +"/crazy-basic-auth/oauth/token";
  static String getSendCode = Config.ApiHost +"/crazy-basic-core/sms/";

  static String getWeekPaperList = Config.ApiHost +"/crazy-weekly/periodical/app/page";
  //{periodicaId}
  static String getWeekPaperCategory = Config.ApiHost +"/crazy-weekly/periodicalContent/app/list/";
  //{id}
  static String getWeekPaperDetail = Config.ApiHost +"/crazy-weekly/periodicalContent/app/selectById/";

  static String getWeekTestList = Config.ApiHost +"/crazy-question/exercisePeriodical/app/page";

  static String getWeekTestCategoryList = Config.ApiHost +"/crazy-question/exerciseCatalogue/app/list/";
  //{periodicaId}
  static String getWeekTestDetail = Config.ApiHost +"/crazy-question/exerciseQuestionRequire/selectAppRequireListVo/";



  static String getWeiXinPay = Config.ApiHost +"/weixinpay.site";
  static String getAppVersion = Config.ApiHost +"/version.site";
  static String getPush = Config.ApiHost +"/push_record.site";
  static String getMobile = "https://api.verification.jpush.cn/v1/web/loginTokenVerify";
}
