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
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../week_test/week_test_detail/week_test_detail_logic.dart';
import '../question/others_question.dart';
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
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;


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
              Expanded(child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [SliverToBoxAdapter(
                      child: Util.buildTopIndicator(),
                    )];
                  },
                  body: Container(
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
                        Expanded(child: buildQuestionResult(widget.testDetailResponse!.data![widget.parentIndex]),)
                      ],
                    ),
                  ))),

              buildSeparatorBuilder(1),
            ],
          ),
        ),
      ),);
  }

  Widget buildSeparatorBuilder(num question){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 18.w,right: 18.w,bottom: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  // 开始作答逻辑
                  // RouterUtil.offAndToNamed(AppRoutes.AnsweringPage,
                  //     arguments: {"detail": widget.testDetailResponse,
                  //       "uuid":"dd",
                  //       "parentIndex":widget.parentIndex,
                  //       "childIndex":0,
                  //     });
                  logicDetail.getDetailAndStartExam("0");
                  showLoading("");
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
              InkWell(
                onTap: (){
                  // 开始作答逻辑 跳转到下一题
                  if(widget.testDetailResponse!.data!.length > widget.parentIndex+1){
                    // RouterUtil.offAndToNamed(AppRoutes.AnsweringPage,
                    //     arguments: {"detail": widget.testDetailResponse,
                    //       "uuid":"dd",
                    //       "parentIndex":widget.parentIndex+1,
                    //       "childIndex":0,
                    //     });
                    logicDetail.getDetailAndStartExam("0");
                  }else{
                    Util.toast("已经是最后一题");
                  }

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
                  child: Text("下一章",style: TextStyle(fontSize: 14.sp,color:AppColors.c_FFFFFFFF),),
                ),
              ),
            ],
          ),

        ],
      ),
    );
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


  @override
  void onDestroy() {
    Get.delete<ResultLogic>();
    Get.delete<WeekTestDetailLogic>();
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