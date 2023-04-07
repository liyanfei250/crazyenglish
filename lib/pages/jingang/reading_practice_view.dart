import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'listening_practice/listening_practice_view.dart';

/**
 * Time: 2023/4/7 13:46
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class ReadingPracticePage extends ListeningPracticePage {
  var type;

  ReadingPracticePage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      type = Get.arguments["type"];
    }
  }

  @override
  BasePageState<BasePage> getState() => ToListeningPracticePageState();
}
