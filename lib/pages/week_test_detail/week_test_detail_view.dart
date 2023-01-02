import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'week_test_detail_logic.dart';

class WeekTestDetailPage extends BasePage {
  const WeekTestDetailPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _WeekTestDetailPageState();
}

class _WeekTestDetailPageState extends BasePageState<WeekTestDetailPage> {
  final logic = Get.put(WeekTestDetailLogic());
  final state = Get.find<WeekTestDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<WeekTestDetailLogic>();
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