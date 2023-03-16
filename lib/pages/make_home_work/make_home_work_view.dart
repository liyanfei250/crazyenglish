import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import 'make_home_work_logic.dart';

class MakeHomeWorkPage extends BasePage {
  const MakeHomeWorkPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() {
    // TODO: implement getState
    return _MakeHomeWorkPageState();
  }
}

class _MakeHomeWorkPageState extends BasePageState<MakeHomeWorkPage> {
  final logic = Get.put(MakeHomeWorkLogic());
  final state = Get.find<MakeHomeWorkLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("自订试卷"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(R.imagesMake1,width: double.infinity,),
            Image.asset(R.imagesMake2,width: double.infinity),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<MakeHomeWorkLogic>();
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