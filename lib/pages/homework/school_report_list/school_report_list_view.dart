import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'school_report_list_logic.dart';

/**
 * 成绩单列表页
 */
class SchoolReportListPage extends BasePage {
  const SchoolReportListPage({Key? key}) : super(key: key);

  @override
  BasePageState<SchoolReportListPage> getState() => _SchoolReportListPageState();
}

class _SchoolReportListPageState extends BasePageState<SchoolReportListPage> {
  final logic = Get.put(SchoolReportListLogic());
  final state = Get.find<SchoolReportListLogic>().state;


  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("成绩单"),
      body: Container(
        margin: EdgeInsets.only(top: 30.w,left: 18.w,right: 18.w),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SchoolReportListLogic>();
    super.dispose();
  }

}