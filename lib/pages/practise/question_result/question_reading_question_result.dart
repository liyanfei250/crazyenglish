import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../base/common.dart';
import '../../../base/widgetPage/dialog_manager.dart';
import '../../../entity/commit_request.dart';
import '../../../entity/start_exam.dart';
import '../../reviews/collect/collect_practic/collect_practic_logic.dart';
import '../answer_interface.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../entity/week_detail_response.dart';
import '../question/question_factory.dart';
import 'base_question_result.dart';
/**
 * Time: 2023/2/21 14:02
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class QuestionReadingQuestionResult extends BaseQuestionResult {
  SubjectVoList data;

  QuestionReadingQuestionResult(Map<String,ExerciseLists> subtopicAnswerVoMap,{required this.data,Key? key}) : super(subtopicAnswerVoMap,key: key);


  @override
  BaseQuestionResultState<BaseQuestionResult> getState() {
    // TODO: implement getState
    return _QuestionReadingQuestionResultState();
  }

}

class _QuestionReadingQuestionResultState extends BaseQuestionResultState<QuestionReadingQuestionResult> {

  late SubjectVoList element;

  var isFavor = false.obs;
  @override
  getAnswers() {
    // TODO: implement getAnswers
    throw UnimplementedError();
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildQuestionDesc("原文"),
              Visibility(
                  visible: element.questionTypeStr == QuestionType.question_reading,
                  child: GetBuilder<Collect_practicLogic>(
                    id: "${GetBuilderIds.collectState}:${element.id}",
                    builder: (_){
                      return buildFavorAndFeedback(_.state.collectMap["${element.id}"]??false, element.id);
                    },
                  )
              )
            ],
          ),
          Visibility(
              visible: element.stem!=null && element.stem!.isNotEmpty,
              child: Text(element.stem??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          // Visibility(
          //     visible: element.name!=null && element.name!.isNotEmpty,
          //     child: Text(element.name??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          buildReadQuestion(element!.content),
          // Expanded(child: judgeAndGetQuestionDetail(element),),
          judgeAndGetQuestionDetail(element)
        ],
      ),
    );
  }

  Widget judgeAndGetQuestionDetail(SubjectVoList element){
    questionList.clear();

    // 判断是否父子题
    // 普通阅读 常规阅读题 是父子题
    int questionNum = element.subtopicVoList!.length;
    if(questionNum>0){
      for(int i = 0 ;i< questionNum;i++){
        SubtopicVoList question = element.subtopicVoList![i];

        questionList.add(Padding(padding: EdgeInsets.only(top: 7.w)));
        questionList.add(buildQuestionDesc("Question ${i+1}"));
        questionList.add(Visibility(
          visible: question!.problem != null && question!.problem!.isNotEmpty,
          child: Text(
            question!.problem!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
          ),));
        questionList.add(QuestionFactory.buildShortAnswerQuestion(element.id??0,question,1,widget.subtopicAnswerVoMap,null,this));
      }
      collectLogic.queryCollectState(element.id??0);
    }
    return SingleChildScrollView(child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: questionList,
    ),);
  }


  Widget buildReadQuestion(String? htmlContent){
    return Container(
      height: 204.w,
      margin: EdgeInsets.only(top: 17.w,bottom: 18.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(color: AppColors.c_FFD2D5DC,width: 0.4.w)
      ),
      child: SingleChildScrollView(
        child:  Html(
          data: htmlContent??"",
          onImageTap: (url,context,attributes,element,){
            if(url!=null && url!.startsWith('http')){
              DialogManager.showPreViewImageDialog(
                  BackButtonBehavior.close, url);
            }
          },
          style: {
            // "p":Style(
            //     fontSize:FontSize.large
            // ),

            "hr":Style(
              margin: Margins.only(left:0,right: 0,top: 10.w,bottom:10.w),
              padding: EdgeInsets.all(0),
              border: Border(bottom: BorderSide(color: Colors.grey)),
            )
          },
          tagsList: Html.tags..addAll(['gap']),
          customRenders: {
          },

        ),
      ),
    );
  }

  @override
  void onDestroy() {
  }
}