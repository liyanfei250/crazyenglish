import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../r.dart';
import '../../../utils/colors.dart';
import 'homework_complete_overview_logic.dart';

/**
 * 作业完成情况概览
 */
class HomeworkCompleteOverviewPage extends BasePage {
  const HomeworkCompleteOverviewPage({Key? key}) : super(key: key);

  @override
  BasePageState<HomeworkCompleteOverviewPage> getState() => _HomeworkCompleteOverviewPageState();
}

class _HomeworkCompleteOverviewPageState extends BasePageState<HomeworkCompleteOverviewPage> {
  final logic = Get.put(HomeworkCompleteOverviewLogic());
  final state = Get.find<HomeworkCompleteOverviewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("作业完成情况"),
      backgroundColor: AppColors.c_FFF8F9FB,
      body: Container(
        margin: EdgeInsets.only(top: 24.w,left: 18.w,right: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 20.w,
                  width: 48.w,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.c_FFFCEFD8,width: 5.w,))
                  ),
                ),
                Container(
                  height: 20.w,
                  child: Text("综合评估（听力|阅读|写作）",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp,fontWeight: FontWeight.w500),),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 24.w),
              padding: EdgeInsets.only(left: 27.w,right: 27.w,top: 13.w,bottom: 19.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(7.w)),
                boxShadow:[
                  BoxShadow(
                    color: Color(0xffe3edff).withOpacity(0.5),		// 阴影的颜色
                    offset: Offset(0.w, 0.w),						// 阴影与容器的距离
                    blurRadius: 10.w,							// 高斯的标准偏差与盒子的形状卷积。
                    spreadRadius: 0.w,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("18",style: TextStyle(fontSize: 24.sp,color: AppColors.c_FF353E4D,fontWeight: FontWeight.w500),),
                              Text("/20",style: TextStyle(fontSize: 12.sp,color: AppColors.c_FF353E4D),),
                            ],
                          ),
                          Text("完成人数",style: TextStyle(fontSize: 12.sp,color: AppColors.c_FF898A93),)
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("98",style: TextStyle(fontSize: 24.sp,color: AppColors.c_FF353E4D,fontWeight: FontWeight.w500),),
                              Text("/100",style: TextStyle(fontSize: 12.sp,color: AppColors.c_FF353E4D),),
                            ],
                          ),
                          Text("平均分",style: TextStyle(fontSize: 12.sp,color: AppColors.c_FF898A93),)
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 0.4.w,
                    margin: EdgeInsets.only(top: 9.w,bottom: 26.w),
                    color: AppColors.c_FFD2D5DC,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(R.imagesIconSchoolReport,width: 20.w,height: 20.w,),
                          Padding(padding: EdgeInsets.only(left:8.w)),
                          Text("成绩单",style: TextStyle(fontSize: 14.w,fontWeight: FontWeight.w500,color: AppColors.c_FF353E4D),),
                        ],
                      ),
                      Container(
                        width: 0.4.w,
                        height: 18.w,
                        color: AppColors.c_FFD2D5DC,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(R.imagesIconPractiseReport,width: 20.w,height: 20.w,),
                          Padding(padding: EdgeInsets.only(left:8.w)),
                          Text("练习报告",style: TextStyle(fontSize: 14.w,fontWeight: FontWeight.w500,color: AppColors.c_FF353E4D),),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24.w),
              padding: EdgeInsets.only(left: 27.w,right: 27.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(7.w)),
                boxShadow:[
                  BoxShadow(
                    color: Color(0xffe3edff).withOpacity(0.5),		// 阴影的颜色
                    offset: Offset(0.w, 0.w),						// 阴影与容器的距离
                    blurRadius: 10.w,							// 高斯的标准偏差与盒子的形状卷积。
                    spreadRadius: 0.w,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildItem("答题情况","查看"),
                  buildItem("听力训练","查看"),
                  buildItem("阅读训练","查看"),
                  buildItem("写作训练","查看"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(String title, String name) {
    return Container(
      height: 44.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff353e4d)),
          ),
          Container(
            width: 44.w,
            height: 15.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffec8a6b),
                    Color(0xffeea47b),
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(2.w)),
            ),
            child: Text(name,style: TextStyle(fontSize: 8.sp,color: AppColors.c_FFFFFFFF,),),
          )
        ],
      ),
    );
  }


  @override
  void dispose() {
    Get.delete<HomeworkCompleteOverviewLogic>();
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