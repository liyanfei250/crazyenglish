/**
 * Time: 2022/10/9 21:28
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

import 'package:flutter/services.dart';
import 'package:worker_manager/worker_manager.dart';

//复制粘贴
class ClipboardTool {
  //复制内容
  static setData(String data) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
    }
  }

  //复制内容
  static Future<void> setDataToast(String? data) {
    return Clipboard.setData(ClipboardData(text: data?? " "));
  }

  //复制内容
  static setDataToastMsg(String data, {String toastMsg = '复制成功'}) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
    }
  }

  //获取内容
  static Future<ClipboardData?> getData() {
    return Clipboard.getData(Clipboard.kTextPlain);
  }

}
