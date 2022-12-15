import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mine_logic.dart';

class MinePage extends BasePage {
  const MinePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _MinePageState();
}

class _MinePageState extends BasePageState<MinePage> {
  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<MineLogic>();
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