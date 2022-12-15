
import '../config.dart';

class Api {

  static String getUser = Config.ApiHost +"/user.site";
  static String getLogin = Config.ApiHost +"/login.site";
  static String getWeiXinPay = Config.ApiHost +"/weixinpay.site";
  static String getAppVersion = Config.ApiHost +"/version.site";
  static String getPush = Config.ApiHost +"/push_record.site";
  static String getMobile = "https://api.verification.jpush.cn/v1/web/loginTokenVerify";
}
