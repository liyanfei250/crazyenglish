
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



}