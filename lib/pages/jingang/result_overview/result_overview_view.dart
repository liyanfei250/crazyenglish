import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:grouped_list/sliver_grouped_list.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../entity/QuestionListResponse.dart';
import '../../../entity/review/HomeSecondListDate.dart';
import '../../../entity/start_exam.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../../week_test/week_test_detail/week_test_detail_logic.dart';
import 'result_overview_logic.dart';

/**
 * 结果统计页
 */
class ResultOverviewPage extends BasePage {

  static const exerciseOverView = "exerciseOverview";
  static const listCatalogueMergeVo = "catalogueRecordVoList";

  List<CatalogueRecordVoList> catalogueRecordVoList = [];
  JouralResultResponse jouralResultResponse = JouralResultResponse();

  ResultOverviewPage({Key? key}) : super(key: key){
    if (Get.arguments != null && Get.arguments is Map) {
      jouralResultResponse = Get.arguments[exerciseOverView];
      catalogueRecordVoList = Get.arguments[listCatalogueMergeVo];
    }
  }

  @override
  BasePageState<ResultOverviewPage> getState() => _ResultOverviewPageState();
}

class _ResultOverviewPageState extends BasePageState<ResultOverviewPage> {
  final logic = Get.put(ResultOverviewLogic());
  final state = Get.find<ResultOverviewLogic>().state;
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;

  final int pageSize = 20;
  int currentPageNo = 1;
  List<CatalogueRecordVoList> questionList = [];
  final int pageStartIndex = 1;

  Map<num,List<ExerciseVos>?> mapExerciseVos ={};
  num totalCount= 0;
  num totalRightCount = 0;
  num totalTime = 0;
  @override
  void onCreate() {

    int length = widget.jouralResultResponse.data!.length;
    for(int i = 0;i < length;i++){
      Exercise exercise = widget.jouralResultResponse.data![i];
      totalRightCount = exercise.correctCount??0+totalRightCount;
      totalCount = exercise.questionCount??0+totalCount;
      totalTime = exercise.time??0+totalTime;
      mapExerciseVos[exercise.journalCatalogueId??0] = exercise.exerciseVos;
    }
    if(widget.catalogueRecordVoList!=null){
      int total = widget.catalogueRecordVoList!.length;
      for(int i = 0;i<total;i++){
        CatalogueRecordVoList catalogueRecord = widget.catalogueRecordVoList![i];
        catalogueRecord.catalogueMergeName = catalogueRecord.catalogueMergeName;
        if(mapExerciseVos.containsKey(catalogueRecord.catalogueId)){
          questionList.add(catalogueRecord);
        }
      }
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
              buildTransparentAppBar("Module 1 Unit3"),
              Util.buildTopIndicator(totalCount,totalRightCount,totalTime,""),
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
                    Expanded(child: ListView.builder(
                      itemCount: questionList.length,
                        itemBuilder: buildItem)),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),);
  }


  Widget buildGroupHeader(CatalogueRecordVoList question){
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
            child: Text("${question.catalogueMergeName} > ${question.catalogueName}",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 16.sp,fontWeight: FontWeight.w500),),
          ),
        ],
      ),
    );
  }

  Widget buildSeparatorBuilder(CatalogueRecordVoList question){
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
                  List<ExerciseVos>? exerciseVos = mapExerciseVos[question.catalogueId??0];

                  if(exerciseVos!=null && exerciseVos.length>0){
                    logicDetail.addJumpToResultExamListen();
                    logicDetail.getDetailAndEnterResultByCatalogueJournalId(
                        question.catalogueId??0,exerciseVos,0,0);
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
                  child: Text("查看详解",style: TextStyle(fontSize: 14.sp,color:AppColors.c_FFFFFFFF),),
                ),
              ),
              InkWell(
                onTap: (){
                  List<ExerciseVos>? exerciseVos = mapExerciseVos[question.catalogueId??0];
                  if(exerciseVos!=null && exerciseVos.length>0){
                    logicDetail.addJumpToStartExamListen();
                    logicDetail.getDetailAndStartExam(
                        (question.catalogueId??0).toString(),enterResult:false,jumpParentIndex:0,jumpChildIndex:0);
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
                  child: Text("重新练习",style: TextStyle(fontSize: 14.sp,color:AppColors.c_FFFFFFFF),),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    CatalogueRecordVoList question = questionList[index];
    return Container(
      padding: EdgeInsets.only(left: 18.w,right: 18.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildGroupHeader(question),
          getCatalogDetail(question),
          buildSeparatorBuilder(question)
        ],
      ),
    );
  }

  Widget getCatalogDetail(CatalogueRecordVoList question){
    List<ExerciseVos>? exerciseVos = mapExerciseVos[question.catalogueId??0];

    if(exerciseVos!=null && exerciseVos.length>0){
      List<Widget> questionList = [];
      int exerciseVosLength = exerciseVos.length;
      for(int k = 0;k<exerciseVosLength;k++){
        ExerciseVos element = exerciseVos[k];
        String questionTypeStr = element.questionTypeStr??"";
        questionList.add(
          Text(QuestionType.getName(questionTypeStr),style: TextStyle(fontSize: 12.sp,color: AppColors.c_FFB3B7C6,fontWeight: FontWeight.w500),),
        );
        questionList.add(
            Padding(padding: EdgeInsets.only(top: 14.w))
        );
        if(element.exerciseLists!=null){
          int childLenth = element.exerciseLists!.length;
          questionList.add(
              GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: childLenth,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6),
                  itemBuilder: (_, int position) {
                    return InkWell(
                      onTap: (){
                        logicDetail.addJumpToResultExamListen();
                        logicDetail.getDetailAndEnterResultByCatalogueJournalId(
                            question.catalogueId??0,exerciseVos,k,position);
                      },
                      child: buildTab((position+1).toString(), element.exerciseLists![position]),
                    );
                  })
          );
        }else{
          print("未解析的题型");
        }
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: questionList,
      );
    }else{
      return Container();
    }
  }


  Widget buildTab(String e,ExerciseLists exerciseLists){
    int state = AnswerType.no_answer;
    if((exerciseLists!.answer??"").isEmpty){
      state = AnswerType.no_answer;
    }else{
      if(exerciseLists!.isRight??false){
        state =AnswerType.right;
      }else{
        state =AnswerType.wrong;
      }
    }
    BoxDecoration decoration;
    Color textColor = Colors.white;
    if(state == AnswerType.no_answer){
      decoration = BoxDecoration(
          color: AppColors.c_FFF5F7FA,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.c_FFD6D9DB,width: 1.w)
      );
      textColor = AppColors.c_FFD6D9DB;
    }else if(state == AnswerType.right){
      decoration = BoxDecoration(
        color: AppColors.c_FF62C5A2,
        shape: BoxShape.circle,
      );
    }else{
      decoration = BoxDecoration(
        color: AppColors.c_FFEC6560,
        shape: BoxShape.circle,
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
    Get.delete<WeekTestDetailLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}