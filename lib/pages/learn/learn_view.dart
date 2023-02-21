import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'learn_logic.dart';

class LearnPage extends BasePage {
  const LearnPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _LearnPageState();

}

class _LearnPageState extends BasePageState<LearnPage> {
  final logic = Get.put(LearnLogic());
  final state = Get.find<LearnLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<LearnLogic>();
    super.dispose();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}