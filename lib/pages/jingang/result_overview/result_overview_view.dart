import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import 'result_overview_logic.dart';

/**
 * 结果统计页
 */
class ResultOverviewPage extends BasePage {
  const ResultOverviewPage({Key? key}) : super(key: key);

  @override
  BasePageState<ResultOverviewPage> getState() => _ResultOverviewPageState();
}

class _ResultOverviewPageState extends BasePageState<ResultOverviewPage> {
  final logic = Get.put(ResultOverviewLogic());
  final state = Get.find<ResultOverviewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,//状态栏颜色
        statusBarIconBrightness: Brightness.light, //状态栏图标颜色
        statusBarBrightness: Brightness.dark,  //状态栏亮度
        systemStatusBarContrastEnforced: true, //系统状态栏对比度强制
        systemNavigationBarColor: Colors.white,  //导航栏颜色
        systemNavigationBarIconBrightness: Brightness.light,//导航栏图标颜色
        systemNavigationBarDividerColor: Colors.transparent,//系统导航栏分隔线颜色
        systemNavigationBarContrastEnforced: true,//系统导航栏对比度强制
      ),
      child: Scaffold(
        // extendBody: true,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.imagesReviewTopBg),
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              buildTransparentAppBar("Module 1 Unit3"),
              Util.buildTopIndicator(),
              Expanded(child: Container(
                margin: EdgeInsets.only(top: 8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow:[
                    BoxShadow(
                      color: AppColors.c_26D0C5B4,		// 阴影的颜色
                      offset: Offset(0.w, 0.w),						// 阴影与容器的距离
                      blurRadius: 3.w,							// 高斯的标准偏差与盒子的形状卷积。
                      spreadRadius: 1.w,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 24.w)),
                    Container(
                      padding: EdgeInsets.only(left: 18.w,right: 18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(R.imagesResultAnswerCardTips,width: 18.w,height: 18.w,),
                              Padding(padding: EdgeInsets.only(left: 9.w)),
                              Text("答题卡",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.c_FF1B1D2C),),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Util.buildAnswerState(1),
                              Util.buildAnswerState(2),
                              Util.buildAnswerState(3),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 24.w)),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),);
  }

  @override
  void dispose() {
    Get.delete<ResultOverviewLogic>();
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