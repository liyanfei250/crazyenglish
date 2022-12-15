/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Description: Widget Util.
 * @Date: 2018/9/29
 */

import 'package:logger/logger.dart';

/// Log Util.
class LogUtil {
  static const String _defTag = "common_utils";
  static bool _debugMode = false; //是否是debug模式,true: log v 不输出.
  static int _maxLen = 128;
  static String _tagValue = _defTag;

  static void init({
    String tag = _defTag,
    bool isDebug = false,
    int maxLen = 128,
  }) {
    _tagValue = tag;
    _debugMode = isDebug;
    _maxLen = maxLen;
  }

  static void e(Object object, {String? tag}) {
    _printLog(tag, ' e ', object);
  }

  static void v(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag, ' v ', object);
    }
  }

  static void _printLog(String? tag, String stag, Object object) {
    String da = object.toString();
    tag = tag ?? _tagValue;
    if (da.length <= _maxLen) {
      print("$tag$stag $da");
      return;
    }
    print(
        '$tag$stag — — — — — — — — — — — — — — — — st — — — — — — — — — — — — — — — —');
    while (da.isNotEmpty) {
      if (da.length > _maxLen) {
        print("$tag$stag| ${da.substring(0, _maxLen)}");
        da = da.substring(_maxLen, da.length);
      } else {
        print("$tag$stag| $da");
        da = "";
      }
    }
    print(
        '$tag$stag — — — — — — — — — — — — — — — — ed — — — — — — — — — — — — — — — —');
  }
}

var _logger = Logger(
  // printer: PrettyPrinter(
  //   methodCount: 0,
  // ),
);

LogV(String msg) {
  _logger.v(msg);
}

LogD(String msg) {
  _logger.d(msg);
}

LogI(String msg) {
  _logger.i(msg);
}

LogW(String msg) {
  _logger.w(msg);
}

LogE(String msg) {
  _logger.e(msg);
}

LogWTF(String msg) {
  _logger.wtf(msg);
}
