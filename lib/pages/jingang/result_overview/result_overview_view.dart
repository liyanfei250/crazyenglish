import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:grouped_list/sliver_grouped_list.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/QuestionListResponse.dart';
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

  final int pageSize = 20;
  int currentPageNo = 1;
  List<Questions> questionList = [];
  final int pageStartIndex = 1;


  @override
  void onCreate() {

  }


  @override
  Widget build(BuildContext context) {
    logic.getQuestionList("1", 1, 15);
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
              Util.buildTopIndicator(0,0,0,""),
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
                    GetBuilder<ResultOverviewLogic>(
                        id: "1",
                        builder: (logic){
                          questionList = state.list;
                          return Expanded(child: GroupedListView<Questions,num>(
                            groupBy: (element) => element.groupId??0,
                            groupSeparatorBuilder: buildSeparatorBuilder,
                            elements: questionList,
                            itemBuilder: buildItem,
                          ),);
                        }
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),);
  }


  Widget buildGroupHeader(Questions question){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.w),topRight: Radius.circular(7.w)),
      ),
      child: Stack(
        children: [
          Container(
            height: 20.w,
            width: 85.w,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.c_FFFCEFD8,width: 3.w,))
            ),
          ),
          Container(
            height: 20.w,
            child: Text("${question.groupName}",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 16.sp,fontWeight: FontWeight.w500),),
          ),
        ],
      ),
    );
  }

  Widget buildSeparatorBuilder(num question){
    return Container(
      padding: EdgeInsets.only(left: 18.w,right: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){

                },
                child: Container(
                  width: 134.w,
                  height: 35.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xfff19e59),
                          Color(0xffec5f2a),
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(18.w)),
                  ),
                  child: Text("查看详解",style: TextStyle(fontSize: 14.sp,color:AppColors.c_FFFFFFFF),),
                ),
              ),
              InkWell(
                onTap: (){

                },
                child: Container(
                  width: 134.w,
                  height: 35.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xfff19e59),
                          Color(0xffec5f2a),
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(18.w)),
                  ),
                  child: Text("重新练习",style: TextStyle(fontSize: 14.sp,color:AppColors.c_FFFFFFFF),),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, Questions question) {
    return Container(
      padding: EdgeInsets.only(left: 18.w,right: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildGroupHeader(question),
          Text("听力训练",style: TextStyle(fontSize: 12.sp,color: AppColors.c_FFB3B7C6,fontWeight: FontWeight.w500),),
          Padding(padding: EdgeInsets.only(top: 14.w)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTab("1", 1),
              buildTab("2", 2),
              buildTab("3", 3),
              buildTab("4", 4),
              buildTab("5", 1),
              buildTab("6", 1),
            ],
          ),
          Text("词语运用",style: TextStyle(fontSize: 12.sp,color: AppColors.c_FFB3B7C6,fontWeight: FontWeight.w500),),
          Padding(padding: EdgeInsets.only(top: 14.w)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTab("1", 1),
              buildTab("2", 2),
              buildTab("3", 3),
              buildTab("4", 4),
              buildTab("5", 1),
              buildTab("6", 1),
            ],
          ),
        ],
      ),
    );
  }


  Widget buildTab(String e,int state){

    BoxDecoration decoration;
    Color textColor = Colors.white;
    if(state == 1){
      decoration = BoxDecoration(
          color: AppColors.c_FFF5F7FA,
          borderRadius: BorderRadius.all(Radius.circular(22.w)),
          border: Border.all(color: AppColors.c_FFD6D9DB,width: 1.w)
      );
      textColor = AppColors.c_FFD6D9DB;
    }else if(state == 2){
      decoration = BoxDecoration(
        color: AppColors.c_FF62C5A2,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    }else{
      decoration = BoxDecoration(
        color: AppColors.c_FFEC6560,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    }

    return Container(
      width: 34.w,
      height: 34.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 9.w),
      decoration: decoration,
      child: Text(e,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: textColor),),
    );
  }

  @override
  void dispose() {
    Get.delete<ResultOverviewLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}