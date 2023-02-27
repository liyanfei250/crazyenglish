import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import 'result_logic.dart';

class ResultPage extends BasePage{
  const ResultPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends BasePageState<ResultPage> {
  final logic = Get.put(ResultLogic());
  final state = Get.find<ResultLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    Get.delete<ResultLogic>();
  }
}