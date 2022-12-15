import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'say_logic.dart';

class SayPage extends BasePage {
  const SayPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _SayPageState();

}

class _SayPageState extends BasePageState<SayPage> {
  final logic = Get.put(SayLogic());
  final state = Get.find<SayLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<SayLogic>();
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