import 'package:intl/intl.dart';

/**
 * Time: 2021/9/4 11:56 上午
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class TimeUtil{
  static String getMiaoFenOptional(int time) {
    int miao = time % 60;
    int fen = (time / 60).toInt();
    int hour = 0;
    if (fen >= 60) {
      hour = (fen / 60).toInt();
      fen = fen % 60;
    }
    String timeString = "";
    String miaoString = "";
    String fenString = "";
    String hourString = "";
    if (miao < 10) {
      miaoString = "0" + miao.toString();
    } else {
      miaoString = miao.toString() + "";
    }
    if (fen < 10) {
      fenString = "0" + fen.toString();
    } else {
      fenString = fen.toString() + "";
    }
    if (hour < 10) {
      hourString = "0" + hour.toString();
    } else {
      hourString = hour.toString() + "";
    }
    if (hour != 0) {
      timeString = hourString + ":" + fenString + ":" + miaoString;
    } else if (fen != 0) {
      timeString = fenString + ":" + miaoString;
    } else {
      timeString = miaoString + "\"";
    }
    return timeString;
  }

  /**
   * @param startDateStr 2019/12/30  字符串格式必须是这一种
   * @return 传进来的日期字符串, 距离今天多少天
   */
  static int getDistanceDay(String startDateStr) {
    DateFormat dateFormat = DateFormat("yyyy/MM/dd");
    DateTime dateTime = dateFormat.parse(startDateStr);
    print(startDateStr+":"+dateTime.toString());
    var now = new DateTime.now();
    var difference = dateTime.difference(now);
    return difference.inDays;
  }

}