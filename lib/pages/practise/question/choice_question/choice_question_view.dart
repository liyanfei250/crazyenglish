import 'package:crazyenglish/widgets/ChoiceImageItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../entity/commit_request.dart';
import '../../../../entity/week_detail_response.dart';
import '../../../../widgets/ChoiceRadioItem.dart';
import '../../question_answering/base_question.dart';
import 'choice_question_logic.dart';

class ChoiceQuestionPage extends StatefulWidget {

  late SubtopicVoList subtopicVoList;
  late bool isClickEnable;
  late bool isResultPage;

  String? defaultChooseIndex;
  bool? isCorrect;
  UserAnswerCallback? userAnswerCallback;
  bool? isMulti = false;
  bool? isJudge = false;
  bool? isImgChoice = false;

  ChoiceQuestionPage(this.subtopicVoList,this.isClickEnable,this.isResultPage,{
  this.defaultChooseIndex,this.isCorrect,this.userAnswerCallback,this.isMulti,this.isJudge,this.isImgChoice,Key? key}) : super(key: key);

  @override
  State<ChoiceQuestionPage> createState() => _ChoiceQuestionPageState();
}

class _ChoiceQuestionPageState extends State<ChoiceQuestionPage> {
  final logic = Get.put(ChoiceQuestionLogic());

  late SubtopicVoList subtopicVoList;
  late bool isClickEnable;
  late bool isResultPage;

  String? defaultChooseIndex;
  bool? isCorrect;
  UserAnswerCallback? userAnswerCallback;
  bool isMulti = false;
  bool isJudge = false;
  bool isImgChoice = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subtopicVoList = widget.subtopicVoList;
    isClickEnable = widget.isClickEnable;
    isResultPage = widget.isResultPage;

    defaultChooseIndex = widget.defaultChooseIndex;
    isCorrect = widget.isCorrect;
    userAnswerCallback = widget.userAnswerCallback;
    isMulti = widget.isMulti??false;
    isJudge = widget.isJudge??false;
    List<String> defaultAnswer = [];
    if(defaultChooseIndex!=null){
      defaultAnswer = defaultChooseIndex!.split(",");
    }
    logic.initContent(defaultAnswer,subtopicVoList.id,isMulti:isMulti);
    logic.addListenerId("selectanswer:${subtopicVoList.id}",() {
      if(userAnswerCallback!=null){
        SubtopicAnswerVo subtopicAnswerVo = SubtopicAnswerVo(
            subtopicId:logic.subtopicId,
            optionId:0,
            userAnswer: logic.getUserAnswer(),
            answer: subtopicVoList.answer,
            isCorrect: false);
        userAnswerCallback!.call(subtopicAnswerVo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 12.w)),
          GetBuilder<ChoiceQuestionLogic>(
              id: "selectanswer:${subtopicVoList.id}",
              builder: (_){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: subtopicVoList!.optionsList!.map(
                          (e) => InkWell(
                        onTap: isClickEnable? (){
                          _.updateUserAnswer(e.subtopicId, e.sequence??"");
                        }:null,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.w),
                          child: isImgChoice? ChoiceImageItem(
                              _getSelectedType(isResultPage,isClickEnable,isCorrect??false,_.getUserAnswer(),e.sequence??""),
                              subtopicVoList.answer,
                              e!.sequence??"",
                              e!.content??"",
                              double.infinity,
                              52.w,
                          ):ChoiceRadioItem(
                              _getSelectedType(isResultPage,isClickEnable,isCorrect??false,_.getUserAnswer(),e.sequence??""),
                              subtopicVoList.answer,
                              e!.sequence??"",
                              e!.content??"",
                              double.infinity,
                              52.w,
                              isJudge,
                          ),
                        ),
                      )
                  ).toList(),
                );
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ChoiceQuestionLogic>();
    super.dispose();
  }

  ChoiceRadioItemType _getSelectedType(bool isResult,bool isClickable,bool isCorrect,String choseItemValue,String myLabel){
    if(isResult){
      if(choseItemValue.isNotEmpty){
        if(choseItemValue.contains(myLabel)) {
          if (isCorrect) {
            return ChoiceRadioItemType.RIGHT_SELECTED;
          }else{
            return ChoiceRadioItemType.WRONG_SELECTED;
          }
        }else{
          return ChoiceRadioItemType.DEFAULT;
        }
      }else{
        return ChoiceRadioItemType.DEFAULT;
      }
    }else{
      if(choseItemValue.isNotEmpty){
        if(choseItemValue.contains(myLabel)){
          return ChoiceRadioItemType.SELECTED;
        }else{
          return ChoiceRadioItemType.DEFAULT;
        }
      }else{
        return ChoiceRadioItemType.DEFAULT;
      }
    }

  }

}