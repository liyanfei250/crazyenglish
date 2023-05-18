import 'package:crazyenglish/pages/practise/question_answering/base_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../utils/colors.dart';
import '../question/question_factory.dart';

/**
 * Time: 2023/4/19 13:44
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 选词填空题
 */
class SelectWordsFillingQuestion extends BaseQuestion {

  SelectWordsFillingQuestion(Map<String,ExerciseLists> subtopicAnswerVoMap,int answerType,SubjectVoList data,int childIndex,{Key? key}) : super(subtopicAnswerVoMap,answerType,childIndex,data:data,key: key);

  @override
  BaseQuestionState<SelectWordsFillingQuestion> getState() => _SelectWordsFillingQuestionState();

}

class _SelectWordsFillingQuestionState extends BaseQuestionState<SelectWordsFillingQuestion> {

  late SubjectVoList element;
  int questionNum = 0;
  int currentNum = 0;
  Widget? sub;
  @override
  void onCreate() {
    element = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    sub ??= QuestionFactory.buildSelectWordsFillingQuestion(element,makeFocusNodeController,makeEditController,widget.subtopicAnswerVoMap,this,userAnswerCallback: userAnswerCallback);

    int focusIndex = getFocusIndex();

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
          Expanded(child: getDetail(focusIndex>=0? focusIndex:widget.childIndex,sub!),)
        ],
      ),
    );
  }


  Widget getDetail(int defaultIndex,Widget sub){
    questionNum = element.subtopicVoList!.length;
    if(logic!=null){
      // 更新底部页码
      currentNum = defaultIndex;
      logic.updateCurrentPage(defaultIndex,totalQuestion: questionNum,isInit: true);
      // 更新空选中状态
      selectGapGetxController.updateFocus("${defaultIndex+1}",true,isInit: true);
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildQuestionType("选词填空题"),
          sub,
          QuestionFactory.buildSelectWordsAnswerQuestion(element.optionsList!)
        ],
      ),
    );
  }



  @override
  void next() {
    bool canNext = false;
    int nextIndex = -1;
    bool hasFound = false;
    selectGapGetxController.gapKeyIndexMap.forEach((key, value) {
      if(value){
        hasFound = true;
        if(questionNum == int.parse(key)){
          canNext = false;
        }else{
          if(int.parse(key)+1 <= questionNum){
            canNext = true;
            nextIndex = int.parse(key);
          }
        }
      }
    });
    if(!hasFound){
      nextIndex = currentNum;
      if(currentNum+1 < questionNum){
        canNext = true;
        nextIndex = currentNum+1;
      }
    }
    if(canNext){
      jumpToQuestion(nextIndex);

    }
  }

  @override
  void pre() {
    bool canPre = false;
    int preIndex = -1;
    bool hasFound = false;
    selectGapGetxController.gapKeyIndexMap.forEach((key, value) {
      if(value){
        hasFound = true;
        if(int.parse(key)-1>0){
          canPre = true;
          preIndex = int.parse(key)-1-1;
        }
      }
    });
    if(!hasFound){
      if(currentNum-1>=0){
        canPre = true;
        preIndex = currentNum-1;

      }
    }
    if(canPre){
      jumpToQuestion(preIndex);
    }
  }

  @override
  void jumpToQuestion(int index) {
    print("jumpToQuestion:${index}");
    // makeFocusNodeController("${index+1}").requestFocus();
    // 更新空选中状态
    selectGapGetxController.updateFocus("${index+1}",true);
    // 更细底部页码
    int currentPage = index;
    currentNum = currentPage;
    logic.updateCurrentPage(currentPage);
  }

  @override
  void clearFocus(){
    selectGapGetxController.clearFocus();
  }

  @override
  void onDestroy() {
  }

  @override
  getAnswers() {
    throw UnimplementedError();
  }
}
