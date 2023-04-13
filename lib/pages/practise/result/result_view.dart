import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../entity/week_detail_response.dart' as detail;

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../entity/commit_request.dart';
import '../../../entity/week_detail_response.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../question/choise_question.dart';
import '../question/listen_question.dart';
import '../question/read_question.dart';
import '../question_factory.dart';
import 'result_logic.dart';

class ResultPage extends BasePage{
  CommitRequest? commitResponse;
  detail.WeekDetailResponse? testDetailResponse;
  var uuid;
  int parentIndex = 0;
  int childIndex = 0;

  ResultPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      // commitResponse = Get.arguments["detail"];
      testDetailResponse = Get.arguments["detail"];
      uuid = Get.arguments["uuid"];
      parentIndex = Get.arguments["parentIndex"];
      childIndex = Get.arguments["childIndex"];
    }
  }

  @override
  BasePageState<BasePage> getState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends BasePageState<ResultPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ResultLogic());
  final state = Get.find<ResultLogic>().state;

  late TabController _tabController;

  @override
  void onCreate() {
    if(widget.testDetailResponse!.data![widget.parentIndex].options!=null && widget.testDetailResponse!.data![widget.parentIndex].options!.length>0) {
      int questionNum = widget.testDetailResponse!.data![widget.parentIndex].options!.length;
      _tabController = TabController(vsync: this, length: questionNum);
    }

  }

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
              buildTransparentAppBar("widget.commitResponse!.directory"),
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
                    // _buildTabBar(),
                    Container(
                      height: 0.5.w,
                      width: double.infinity,
                      color: AppColors.c_FFD2D5DC,
                    ),
                    buildQuestionResult(widget.testDetailResponse!.data![widget.parentIndex]),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),);
  }

  // Widget _buildTabBar() => TabBar(
  //   onTap: (value){
  //
  //   },
  //   controller: _tabController,
  //   indicatorColor: AppColors.c_FF353E4D,
  //   isScrollable: true,
  //   labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
  //   indicatorWeight: 2.w,
  //   indicatorSize: TabBarIndicatorSize.label,
  //   labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
  //   unselectedLabelStyle:
  //   TextStyle(fontSize: 14.sp, color: AppColors.TEXT_BLACK_COLOR),
  //   labelColor: AppColors.TEXT_COLOR,
  //   tabs: tabs.map((e) => buildTab(e)).toList(),
  // );
  //
  // Widget buildTab(String e){
  //   int state = tabs.indexOf(e);
  //
  //   BoxDecoration decoration;
  //   Color textColor = Colors.white;
  //   if(state == 1){
  //     decoration = BoxDecoration(
  //       color: AppColors.c_FFF5F7FA,
  //       borderRadius: BorderRadius.all(Radius.circular(22.w)),
  //       border: Border.all(color: AppColors.c_FFD6D9DB,width: 1.w)
  //     );
  //     textColor = AppColors.c_FFD6D9DB;
  //   }else if(state == 2){
  //     decoration = BoxDecoration(
  //       color: AppColors.c_FF62C5A2,
  //       borderRadius: BorderRadius.all(Radius.circular(22.w)),
  //     );
  //   }else{
  //     decoration = BoxDecoration(
  //       color: AppColors.c_FFEC6560,
  //       borderRadius: BorderRadius.all(Radius.circular(22.w)),
  //     );
  //   }
  //
  //   return Container(
  //     width: 34.w,
  //     height: 34.w,
  //     alignment: Alignment.center,
  //     margin: EdgeInsets.only(bottom: 9.w),
  //     decoration: decoration,
  //     child: Text(e,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: textColor),),
  //   );
  // }

  Widget buildQuestionType(String name){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 17.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 7.w,right: 7.w,bottom: 2.w),
          margin: EdgeInsets.only(top:14.w,bottom: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.w)),
              border: Border.all(color: AppColors.c_FF898A93,width: 0.4.w)
          ),
          child: Text(name,style: TextStyle(color: AppColors.c_FF898A93,fontSize: 12.sp),),
        ),
        Padding(padding: EdgeInsets.only(left: 11.w)),
        Image.asset(R.imagesResultFavor,width: 48.w,height: 17.w,),
      ],
    );
  }

  Widget buildQuestionResult(Data element){
    switch (element.type) {
      case 1: // 听力题
        return ListenQuestion(data: element);
      case 2: // 阅读题
      case 3:
        return ReadQuestion(data: element);
      // case 3: // 语言综合训练
      //   if (element.typeChildren == 1) {
      //     // 单项选择题
      //     questionList
      //         .add(ChoiseQuestion(datas: weekTestDetailResponse.data!));
      //     return questionList;
      //   } else if (element.typeChildren == 2) {
      //     // 补全对话
      //     questionList.add(ReadQuestion(data: element));
      //   } else if (element.typeChildren == 3){
      //     // 完型填空
      //     questionList.add(ReadQuestion(data: element));
      //   }
      //   break;
      // case 4: // 写作题
      //   if (element.typeChildren == 7) {
      //     // 写作题
      //   }
    }
    return Container();
  }

  // Widget buildQuestionResult2(Data element){
  //   questionList.clear();
  //   if(element.options!=null && element.options!.length>0){
  //     int questionNum = element.options!.length;
  //     bool isHebing = false;
  //     for(int i = 0 ;i< questionNum;i++){
  //       Options question = element.options![i];
  //
  //       tabs.add("${i+1}");
  //       List<Widget> itemList = [];
  //       itemList.add(Padding(padding: EdgeInsets.only(top: 7.w)));
  //
  //       if(element.type == 1){
  //         if(element.typeChildren == 1){
  //           // 选择题
  //           itemList.add(buildQuestionType("选择题"));
  //           // itemList.add(Visibility(
  //           //   visible: question!.title != null && question!.title!.isNotEmpty,
  //           //   child: Text(
  //           //     question!.title!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
  //           //   ),));
  //           if((question!.list??[]).length > 0) {
  //             itemList.add(QuestionFactory.buildSingleImgChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
  //           }
  //         }else if(element.typeChildren == 2){
  //           // 选择题
  //           itemList.add(buildQuestionType("选择题"));
  //           if((question!.list??[]).length > 0) {
  //             itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
  //           }
  //         }else if(element.typeChildren == 3){
  //           // 选择题
  //           itemList.add(buildQuestionType("选择题"));
  //           itemList.add(Visibility(
  //             visible: question!.name != null && question!.name!.isNotEmpty,
  //             child: Text(
  //               question!.name!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
  //             ),));
  //           if((question!.list??[]).length > 0) {
  //             itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
  //           }
  //         }else if(element.typeChildren ==4){
  //           // 选择题
  //           itemList.add(buildQuestionType("填空题"));
  //         }
  //
  //       }else if(element.type == 2){
  //         if(element.typeChildren == 1){
  //           // 选择题
  //           itemList.add(buildQuestionType("选择题"));
  //           if((question!.list??[]).length > 0) {
  //             itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
  //           }
  //         }else if(element.typeChildren == 2){ // 阅读选项
  //           // 选择题
  //           itemList.add(buildQuestionType("选择题"));
  //           if((question!.list??[]).length > 0) {
  //             itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
  //           }
  //         }else if(element.typeChildren == 3 || element.typeChildren == 6){ // 阅读填空 阅读理解 对话
  //           // 选择题
  //           itemList.add(buildQuestionType("填空题"));
  //           // itemList.add(QuestionFactory.buildHuGapQuestion(element.options??[],0,makeEditController));
  //           isHebing = true;
  //         }
  //       }else if(element.type == 3){
  //         if(element.typeChildren == 1){
  //           // 单项选择题
  //           itemList.add(buildQuestionType("单项选择题"));
  //           if((question!.list??[]).length > 0) {
  //             itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
  //           }
  //         }else if(element.typeChildren == 2){ // 阅读选项
  //           // 选择题
  //           itemList.add(buildQuestionType("补全对话"));
  //           // itemList.add(QuestionFactory.buildHuGapQuestion(element.options??[],0,makeEditController));
  //           isHebing = true;
  //
  //         }else if(element.typeChildren == 3){ // 阅读填空 阅读理解 对话
  //           // 选择题
  //           itemList.add(buildQuestionType("完型填空"));
  //           if((question!.list??[]).length > 0) {
  //             itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
  //           }
  //         }
  //       }
  //
  //       questionList.add(SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: itemList,
  //         ),
  //       ));
  //       if(isHebing){
  //         break;
  //       }
  //     }
  //   }else{
  //     questionList.add(const SizedBox());
  //   }
  //
  //   return Expanded(child: TabBarView(
  //     controller: _tabController,
  //     children: questionList,
  //   ));
  // }


  @override
  void onDestroy() {
    Get.delete<ResultLogic>();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}