import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../utils/colors.dart';
import 'class_message_logic.dart';

class Class_messagePage extends  BasePage {
  const Class_messagePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToClassMessagePageState();
}

class _ToClassMessagePageState extends BasePageState<Class_messagePage> {
  final logic = Get.put(Class_messageLogic());
  final state = Get.find<Class_messageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("班级信息"),
      backgroundColor: AppColors.theme_bg,
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
