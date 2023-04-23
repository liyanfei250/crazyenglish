import 'package:crazyenglish/pages/practise/question/base_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../entity/week_detail_response.dart';
import '../../../utils/colors.dart';
import '../question_factory.dart';

/**
 * Time: 2023/4/19 13:48
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 选择填空题
 */
class SelectFillingQuestion extends BaseQuestion {

  SelectFillingQuestion(SubjectVoList data,{Key? key}) : super(data:data,key: key);

  @override
  BaseQuestionState<SelectFillingQuestion> getState() => _SelectFillingQuestionState();

}

class _SelectFillingQuestionState extends BaseQuestionState<SelectFillingQuestion> {

  late SubjectVoList element;

  int questionNum = 0;
  @override
  void onCreate() {
    element = widget.data;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.w,right: 18.w,top: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildQuestionDesc("原文"),
          Visibility(
              visible: element.stem!=null && element.stem!.isNotEmpty,
              child: Text(element.stem??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          Expanded(child: getDetail(0))
        ],
      ),
    );
  }

  Widget getDetail(int defaultIndex){
    // 判断是否父子题
    // 普通阅读 常规阅读题 是父子题
    questionNum = element.subtopicVoList!.length;
    if(logic!=null){
      logic.updateCurrentPage(defaultIndex,totalQuestion: questionNum);
      jumpToQuestion(defaultIndex);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildQuestionType("选择填空题"),
          QuestionFactory.buildSelectFillingQuestion(element,makeFocusNodeController),
          QuestionFactory.buildSelectOptionQuestion(element.optionsList!)
        ],
      ),
    );
  }


  @override
  void next() {
    // int currentKey = -1;
    // bool canNext = false;
    // selectGapGetxController.hasFocusMap.value.forEach((key, value) {
    //   if(value){
    //     if(questionNum == key){
    //       canNext = false;
    //     }
    //
    //   }
    // });
    // if(canNext){
    //   selectGapGetxController.hasFocusMap.value.clear();
    //   selectGapGetxController.hasFocusMap.value["${logci+1}"] = true;
    // }else{
    //
    // }

  }

  @override
  void pre() {

  }

  @override
  void jumpToQuestion(int index) {
// 默认聚焦第几个空
    selectGapGetxController.hasFocusMap.value.clear();
    selectGapGetxController.hasFocusMap.value["${index+1}"] = true;
  }

  @override
  getAnswers() {
    // TODO: implement getAnswers
    throw UnimplementedError();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }


}
