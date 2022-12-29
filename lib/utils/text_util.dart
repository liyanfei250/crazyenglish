
import 'package:crazyenglish/utils/object_util.dart';

class TextUtil{

  /**
   * 匹配
   */
  static bool isRealName(String text){
    if(ObjectUtil.isEmpty(text)){
      return false;
    }
    RegExp regExp = RegExp("([\u4E00-\u9FA5]{2,6})");
    return regExp.hasMatch(text);
  }

  /**
   * 用户昵称
   * 中英文字符 | 2-16位 | 不能以数字开头
   */
  static bool isNickName(String username) {
    if (ObjectUtil.isEmpty(username)) {
      return false;
    }
    if (username.codeUnitAt(0) <= '9'.codeUnitAt(0) && username.codeUnitAt(0) >= '0'.codeUnitAt(0))
    {
      return false;
    }
    if (username.length > 16 || username.length < 2) {
      return false;
    }
    RegExp regExp = RegExp("^[0-9a-zA-Z\\u4e00-\\u9fa5_-]*\$");
    return regExp.hasMatch(username);
  }


  static String weekDetail = "<!DOCTYPE html>\n" +
      "<!-- saved from url=(0041)https://101.42.97.189:10001/article?id=27 -->\n" +
      "<html lang=\"\">\n" +
      "\n" +
      "<head>\n" +
      "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n" +
      "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n" +
      "    <meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">\n" +
      "    <link rel=\"icon\" href=\"https://101.42.97.189:10001/favicon.ico\">\n" +
      "    <title>weekly-phone</title>\n" +
      "    <script defer=\"defer\" src=\"https://101.42.97.189:10001/js/chunk-vendors.694cded7.js\"></script>\n" +
      "    <script defer=\"defer\" src=\"https://101.42.97.189:10001/js/app.13ffa959.js\"></script>\n" +
      "    <link href=\"https://101.42.97.189:10001/css/chunk-vendors.505add5d.css\" rel=\"stylesheet\">\n" +
      "    <link href=\"https://101.42.97.189:10001/css/app.b6efa8d9.css\" rel=\"stylesheet\">\n" +
      "</head>\n" +
      "\n" +
      "<body style=\"\">\n" +
      "    <div id=\"app\" data-v-app=\"\">\n" +
      "        <div class=\"wrapper\" data-v-2c8e5ba5=\"\">\n" +
      "            <p class=\"content\" data-v-2c8e5ba5=\"\">\n" +
      "                ###content###\n" +
      "            </p>\n" +
      "        </div>\n" +
      "    </div>\n" +
      "</body>\n" +
      "\n" +
      "</html>";

}