import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/getx_ids.dart';
import '../../utils/Util.dart';
import '../../utils/colors.dart';
import 'week_test_detail_logic.dart';

class WeekTestDetailPage extends BasePage {
  String? id;
  String? name;
  WeekTestDetailPage({Key? key}) : super(key: key) {
    if(Get.arguments!=null &&
        Get.arguments is Map){
      id = Get.arguments["id"];
      name = Get.arguments["name"];
    }
  }

  @override
  BasePageState<BasePage> getState() => _WeekTestDetailPageState();
}

class _WeekTestDetailPageState extends BasePageState<WeekTestDetailPage> {
  final logic = Get.put(WeekTestDetailLogic());
  final state = Get.find<WeekTestDetailLogic>().state;


  @override
  void onCreate() {
    // TODO: implement onCreate
    logic.getWeekTestDetail(widget.id!);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text(widget.name??"",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        // bottom: ,
        elevation: 0,),
      body: GetBuilder<WeekTestDetailLogic>(
        id: GetBuilderIds.weekTestDetailList,
        builder: (logic){
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<WeekTestDetailLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}