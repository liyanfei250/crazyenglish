import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/entity/commit_request.dart';
import 'package:crazyenglish/pages/practise/answer_interface.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/widgets/ChoiceImageItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../base/widgetPage/dialog_manager.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../utils/colors.dart';
import '../../../widgets/ChoiceRadioItem.dart';
import '../answering/select_gap_getxcontroller.dart';
import '../question_answering/base_question.dart';

/**
 * Time: 2023/2/20 13:31
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class QuestionFactory{
  static Style getHtml_P_TagStyle(){
    return Style(
        textAlign: TextAlign.justify,
        fontSize:FontSize(14.sp),
        color: const Color(0xff353e4d)
    );
  }
  /// 纠错题 空部分
  static Widget buildFixProblemQuestion(SubjectVoList subjectVoList,String htmlContent){

    TextEditingController? _inputController;
    _inputController = TextEditingController(
      text: htmlContent??"",
    );
    // list!=null && list.length>0 && list[0].content!=null && list[0].content!.isNotEmpty? list[0].content!:""
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: 8.w,right: 5.w),
          child: Text(
            htmlContent,
            style: TextStyle(
              fontSize: 16.sp,),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.w,right: 5.w,top: 10.w),
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.w)),
              color: AppColors.c_4DD9D9D9
          ),
          child: TextField(
            controller: _inputController,
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 20,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16.sp,
                height: 1.5,
                textBaseline: TextBaseline.alphabetic
            ),
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: InputBorder.none,
              hintText: "请输入改正后的文字",
            ),
          ),
        )

      ],
    );
  }

  // 暂时未用着
  static Widget buildNarmalGapQuestion(SubtopicVoList subtopicVoList,int gapKey,GetEditingControllerCallback getEditingControllerCallback,{bool isResult = false,int answerType = AnsweringPage.answer_normal_type,}){
    int max = 0;
    String gap = "____";

    int gapIndex = -1;
    String htmlContent = "";
    while(htmlContent.contains(gap)){
      gapKey++;
      gapIndex++;
      print("gapKey: $gapKey gapIndex:$gapIndex");
      htmlContent = htmlContent.replaceFirst(gap, '<gap value="$gapKey" index="$gapIndex"></gap>');

    }
    return Html(
      data: (htmlContent??"").replaceAll("\t", "&ensp;&ensp;"),
      onImageTap: (url,context,attributes,element,){
        if(url!=null && url!.startsWith('http')){
          DialogManager.showPreViewImageDialog(
              BackButtonBehavior.close, url);
        }
      },
      style: {
        "p": getHtml_P_TagStyle(),
      },
      tagsList: Html.tags..addAll(['gap']),
      customRenders: {
        tagMatcher("gap"):CustomRender.widget(widget: (context, buildChildren){
          String key = context.tree.element!.attributes["value"]??"unknown";
          String gapIndex = context.tree.element!.attributes["index"]??"unknown";
          String content = "";
          int num = 0;
          var correctType = 0.obs;
          try {
            num = int.parse(gapIndex);
            max = num;

            // if(subtopicVoList!=null && num< subtopicVoList!.length){
            //   content = list![num].value!;
            // }else{
            content = "";
            // }
            print("num: $num content: $content");
          } catch (e) {
            e.printError();
          }

          return SizedBox(
            width: 50.w,
            child: Obx(()=>TextField(
                keyboardType: TextInputType.name,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(color: _getFieldInputTxtColor(isResult,answerType,correctType.value)),
                decoration: InputDecoration(
                  isDense:true,
                  contentPadding: EdgeInsets.all(0.w),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.w,
                        color: _getFieldInputTxtColor(isResult,answerType,correctType.value),
                        style: BorderStyle.solid
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.w,
                        color: _getFieldInputTxtColor(isResult,answerType,correctType.value),
                        style: BorderStyle.solid
                    ),
                  ),
                ),
                onChanged: (text){
                  print("intput:"+text+"  content:"+content);
                  if(content.isNotEmpty){
                    if(text.isNotEmpty){
                      if(content.startsWith(text)){
                        correctType.value = 1;
                      }else{
                        correctType.value = -1;
                      }
                    }else{
                      correctType.value = 0;
                    }
                  }else{
                    correctType.value = 0;
                  }

                },
                onSubmitted: (text){

                },
                onEditingComplete: (){

                },
                controller: getEditingControllerCallback(key))),

          );
        })
      },

    );
  }

  static Widget buildShortAnswerQuestion(num subjecId,SubtopicVoList subtopicVoList,int gapKey,Map<String,ExerciseLists> subtopicAnswerVoMap,GetEditingControllerCallback? getEditingControllerCallback,CloseKeyBoardCallback answerMin,{UserAnswerCallback? userAnswerCallback,bool isResult=false,int answerType = AnsweringPage.answer_normal_type,}){
    var correctType = 0.obs;
    TextEditingController controller = TextEditingController();
    num subtopicId = subtopicVoList.id??0;
    if(subtopicId <=0){
      print("buildShortAnswerQuestion: ${subjecId}");
    }

    ExerciseLists? exerciseLists = subtopicAnswerVoMap["$subjecId:$subtopicId"];

    String userAnswer = "";
    int isRight = AnswerType.no_answer;
    if(exerciseLists!=null &&
        (answerType == AnsweringPage.answer_continue_type
            || answerType == AnsweringPage.answer_fix_type
            || answerType == AnsweringPage.answer_homework_draft_type || isResult)){
      userAnswer = exerciseLists.answer??"";
      if(userAnswer.isNotEmpty){
        if(exerciseLists!.isRight??false){
          isRight = AnswerType.right;
        }else{
          isRight = AnswerType.wrong;
        }
      }
    }else{

    }
    controller.text = userAnswer;

    return SizedBox(
      width: double.infinity,
      child: TextField(
          keyboardType: TextInputType.name,
          readOnly: userAnswerCallback==null ||  (answerType == AnsweringPage.answer_fix_type && isRight == AnswerType.right),
          maxLines: 1,
          textAlign: TextAlign.left,
          style: const TextStyle(color: AppColors.c_FF353E4D),
          decoration: InputDecoration(
            filled: true,
            fillColor: _getShotInputBgColor(isResult,isRight),
            isDense:true,
            contentPadding: EdgeInsets.all(10.w),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.w)),
              borderSide: BorderSide(
                  width: 1.w,
                  color: _getShotInputBorderColor(isResult,isRight),
                  style: BorderStyle.solid
              ),
            ),
            focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.w)),
              borderSide: BorderSide(
                  width: 1.w,
                  color: _getShotInputBorderColor(isResult,isRight),
                  style: BorderStyle.solid
              ),
            ),
          ),
          onChanged: (text){
            if(userAnswerCallback!=null){
              SubtopicAnswerVo subtopicAnswerVo = SubtopicAnswerVo(subtopicId:subtopicVoList.id,
                  optionId:0,
                  userAnswer: text,
                  answer: subtopicVoList.answer,
                  isCorrect: text == subtopicVoList.answer);
              userAnswerCallback.call(subtopicAnswerVo);
            }
          },

          onSubmitted: (text){
            print("======+++==onSubmitted====");
            answerMin.call();
          },
          onEditingComplete: (){
            print("=====+++===onEditingComplete====");
            answerMin.call();
          },
          controller: controller),
    );
  }

  /// 常规填空、补全填空、翻译填空 选词填空题干部分
  /// gapKey 默认空的索引号
  /// 客观题
  static Widget buildFillingQuestion(SubjectVoList subjectVoList,GetFocusNodeControllerCallback getFocusNodeControllerCallback,GetEditingControllerCallback getEditingControllerCallback,Map<String,ExerciseLists> subtopicAnswerVoMap,CloseKeyBoardCallback answerMin,{int gapKey = 0,int defaultIndex = 0,
    bool isResult = false,int answerType = AnsweringPage.answer_normal_type,UserAnswerCallback? userAnswerCallback}){
    String gap = "____";

    int gapIndex = -1;
    String htmlContent = subjectVoList.content??"";

    while(htmlContent.contains(gap)){
      num subtopicId = -1;
      String subtopicAnswer = "";
      String userAnswer = "";
      int isRight = AnswerType.no_answer;
      // 填充答案
      if(subjectVoList.subtopicVoList!=null && subjectVoList.subtopicVoList!.length>gapKey){
        subtopicId = subjectVoList.subtopicVoList![gapKey].id!;
        subtopicAnswer = subjectVoList.subtopicVoList![gapKey].answer??"";
        if((isResult || answerType == AnsweringPage.answer_fix_type) && subtopicAnswerVoMap!=null && subtopicAnswerVoMap["${subjectVoList.id}:${subtopicId}"]!=null){
          userAnswer = subtopicAnswerVoMap["${subjectVoList.id}:${subtopicId}"]!.answer??"";
          if(userAnswer.isNotEmpty){
            if(subtopicAnswerVoMap["${subjectVoList.id}:${subtopicId}"]!.isRight??false){
              isRight = AnswerType.right;
            }else{
              isRight = AnswerType.wrong;
            }
          }
        }
      }else{
        print("试题空和答案不匹配");
      }
      if(subtopicId<0){
        print("试题答案id获取失败");
        break;
      }else{
        gapKey++;
        gapIndex++;
        print("gapKey: $gapKey gapIndex:$gapIndex subtopicId: $subtopicId subtopicAnswer: $subtopicAnswer");
        // gapKey 内部通知使用采用按空排序的方式 index: 展示使用 subtopicId: 此空对应的正确答案的subtopicId ,subtopicAnswer:
        htmlContent = htmlContent.replaceFirst(gap, '<gap value="$gapKey" index="$gapIndex" subtopicid="$subtopicId" answer="$subtopicAnswer" userAnswer="$userAnswer" isright="$isRight"></gap>');
      }
    }
    return Html(
      data: (htmlContent??"").replaceAll("\t", "&ensp;&ensp;"),
      onImageTap: (url,context,attributes,element,){
        if(url!=null && url!.startsWith('http')){
          DialogManager.showPreViewImageDialog(
              BackButtonBehavior.close, url);
        }
      },
      style: {
        "p": getHtml_P_TagStyle(),
      },
      tagsList: Html.tags..addAll(['gap']),
      customRenders: {
        tagMatcher("gap"):CustomRender.widget(widget: (context, buildChildren){
          String key = context.tree.element!.attributes["value"]??"unknown";
          String gapIndex = context.tree.element!.attributes["index"]??"unknown";
          String subtopicIdstr = context.tree.element!.attributes["subtopicid"]??"0";
          int subtopicId = int.parse(subtopicIdstr);
          String subtopicAnswer = context.tree.element!.attributes["answer"]??" ";
          String userAnswer = context.tree.element!.attributes["useranswer"]??" ";
          String isRightStr = context.tree.element!.attributes["isright"]??"0";
          int isRight = int.parse(isRightStr)??0;
          String content = "";
          int num = 0;
          print("jiexi: gapKey: $gapKey gapIndex:$gapIndex subtopicId: $subtopicId subtopicAnswer: $subtopicAnswer");

          return GetBuilder<SelectGapGetxController>(
            id: key,
            builder: (_){
              // if(key =="1"){
              //   print("getBuilderddd:${key}");
              //   getFocusNodeControllerCallback(key)!.requestFocus();
              // }
              getFocusNodeControllerCallback(key);
              getEditingControllerCallback(key).text = _.contentMap[key]??"";
              getEditingControllerCallback(key).selection =
                  TextSelection.fromPosition(TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: '${_.contentMap[key]??""}'.length));
              // print("hasFocusMap+++${key}++++${_.hasFocusMap[key]??false}");
              if(isResult){
                getFocusNodeControllerCallback(key);
                getEditingControllerCallback(key).text = userAnswer??"";
                getEditingControllerCallback(key).selection =
                    TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: '${userAnswer??""}'.length));
              }else{
                getFocusNodeControllerCallback(key);
                getEditingControllerCallback(key).text = _.contentMap[key]??"";
                getEditingControllerCallback(key).selection =
                    TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: '${_.contentMap[key]??""}'.length));
              }
              if(userAnswerCallback!=null){
                SubtopicAnswerVo subtopicAnswerVo = SubtopicAnswerVo(subtopicId:subtopicId,
                    optionId:_.optionIdMap[key]??0,
                    userAnswer: _.contentMap[key]??"",
                    answer: subtopicAnswer,
                    isCorrect: getEditingControllerCallback(key).text == subtopicAnswer);
                userAnswerCallback.call(subtopicAnswerVo);
              }
              return ConstrainedBox(
                constraints: BoxConstraints(minWidth: 48),
                child: IntrinsicWidth(
                  child: TextField(
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      readOnly: userAnswerCallback==null ||  (answerType == AnsweringPage.answer_fix_type && isRight == AnswerType.right),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _getFieldInputTxtColor(isResult,answerType,isRight)),
                      // autofocus: _.hasFocusMap[key]??false,
                      focusNode: getFocusNodeControllerCallback(key),
                      onTap: () {
                        print("textfield clicked ${int.parse(key)-1}");
                        _.updateFocus(key, true);
                      },
                      decoration: InputDecoration(
                        isDense:true,
                        fillColor: _getFieldInputBgColor(isResult,_.hasFocusMap[key]??false),
                        filled: true,
                        contentPadding: EdgeInsets.all(0.w),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.w,
                              color: _getFieldInputTxtColor(isResult,answerType,isRight),
                              style: BorderStyle.solid
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.w,
                              color: _getFieldInputTxtColor(isResult,answerType,isRight),
                              style: BorderStyle.solid
                          ),
                        ),
                      ),
                      onChanged: (text){
                        print("intput:"+text+"  content:"+content);
                        // 当前选项内容 映射到 空
                        _.contentMap[key]=text;
                        if(userAnswerCallback!=null){
                          SubtopicAnswerVo subtopicAnswerVo = SubtopicAnswerVo(subtopicId:subtopicId,
                              optionId:_.optionIdMap[key]??0,
                              userAnswer: text,
                              answer: subtopicAnswer,
                              isCorrect: text == subtopicAnswer);
                          userAnswerCallback.call(subtopicAnswerVo);
                        }
                      },

                      onSubmitted: (text){
                        print("======+++==onSubmitted====");
                        answerMin.call();
                        _.updateGapKeyContent(key, text??"");
                        getFocusNodeControllerCallback(key).unfocus();
                        _.updateFocus(key, false,isInit:false);
                      },
                      onEditingComplete: (){
                        print("=====+++===onEditingComplete====");
                        answerMin.call();
                        getFocusNodeControllerCallback(key).unfocus();
                        _.updateFocus(key, false,isInit:false);
                      },
                      controller: getEditingControllerCallback(key)
                  ),
                ),
              );
            },
          );
        })
      },

    );
  }

  /// 选词填空的词
  static Widget buildSelectWordsAnswerQuestion(List<OptionsList> answers,{Set<String>? gapKeySet,bool isResult = false}){
    return Wrap(
      children: answers.map((e) => _colorAnswerItem(answers.indexOf(e),e,gapKeySet,isResult)).toList(),
    );
  }



  /// answerIndex 选项的索引
  /// answer 选项的内容
  static Widget _colorAnswerItem(int answerIndex,OptionsList answer,Set<String>? gapKeySet,bool isResult) {
    return GetBuilder<SelectGapGetxController>(
      id: "answer:${answerIndex}",
      builder: (_){
        return GestureDetector(
          onTap: () {
            if(isResult){
              return;
            }
            String gapKey = "";
            _.hasFocusMap.forEach((key, value) {
              if(value){
                if(gapKeySet==null || !gapKeySet.contains(key)){
                  gapKey = key;
                }
              }
            });
            print("gapKey: $gapKey");
            // 去掉之前的选项 选择状态
            String findBeforeAnswerIndex = "";
            _.answerIndexToGapIndexMap.forEach((answerIndex, value) {
              if(value == gapKey){
                findBeforeAnswerIndex = answerIndex;
              }
            });
            if(findBeforeAnswerIndex.isNotEmpty){
              _.updateAnswerIndexToGapKey("${findBeforeAnswerIndex}","");
            }

            if(gapKey.isNotEmpty){
              // 修改当前选中状态 当前选项 answerIndex 映射到 此空
              _.updateAnswerIndexToGapKey("answer:${answerIndex}", gapKey);
              // 当前选项内容 映射到 空
              _.updateGapKeyContent(gapKey, answer.content??"",optionId: answer.id??0);
            }
          },
          child: Container(
            height: 22.w,
            padding: EdgeInsets.only(left: 13.w,right: 13.w),
            margin: EdgeInsets.only(right: 11.w,bottom: 10.w),
            decoration: BoxDecoration(
              color: (_.answerIndexToGapIndexMap["answer:${answerIndex}"]??"").isNotEmpty ? AppColors.c_FFD2D5DC : AppColors.c_FFF5F7FB,
              border: Border.all(color: AppColors.c_FFD2D5DC,width: 1.w),
              borderRadius: BorderRadius.all(Radius.circular(4.w)),
            ),
            child: Text(
              answer.content??"未获取到内容",
              style: TextStyle(
                  color: AppColors.c_FF353E4D,
                  fontSize: 14.sp,
                  decoration: TextDecoration.none),
            ),
          ),
        );
      },
    );
  }



  /// 选择填空题 题干部分
  /// gapKey 默认空的索引号
  static Widget buildSelectFillingQuestion(SubjectVoList subjectVoList,GetFocusNodeControllerCallback getFocusNodeControllerCallback,Map<String,ExerciseLists> subtopicAnswerVoMap,{int gapKey = 0,UserAnswerCallback? userAnswerCallback,bool isResult = false,int answerType = AnsweringPage.answer_normal_type}){
    int max = 0;
    String gap = "____";

    int gapIndex = -1;
    String htmlContent = subjectVoList.content??"";

    while(htmlContent.contains(gap)){
      num subtopicId = -1;
      String subtopicAnswer = "";
      String userAnswer = "";
      int isRight = AnswerType.no_answer;
      if(subjectVoList.subtopicVoList!=null && subjectVoList.subtopicVoList!.length>gapKey){
        subtopicId = subjectVoList.subtopicVoList![gapKey].id!;
        subtopicAnswer = subjectVoList.subtopicVoList![gapKey].answer??"";
        if((isResult || answerType == AnsweringPage.answer_fix_type) && subtopicAnswerVoMap!=null && subtopicAnswerVoMap["${subjectVoList.id}:${subtopicId}"]!=null){
          userAnswer = subtopicAnswerVoMap["${subjectVoList.id}:${subtopicId}"]!.answer??"";
          if(userAnswer.isNotEmpty){
            if(subtopicAnswerVoMap["${subjectVoList.id}:${subtopicId}"]!.isRight??false){
              isRight = AnswerType.right;
            }else{
              isRight = AnswerType.wrong;
            }
          }
        }
      }else{
        print("试题空和答案不匹配");
      }
      if(subtopicId<0){
        print("试题答案id获取失败");
      }
      gapKey++;
      gapIndex++;
      print("gapKey: $gapKey gapIndex:$gapIndex subtopicId: $subtopicId subtopicAnswer: $subtopicAnswer");
      // gapKey 内部通知使用采用按空排序的方式 index: 展示使用 subtopicId: 此空对应的正确答案的subtopicId ,subtopicAnswer:
      htmlContent = htmlContent.replaceFirst(gap, '<gap value="$gapKey" index="$gapIndex" subtopicid="$subtopicId" answer="$subtopicAnswer" userAnswer="$userAnswer" isright="$isRight"></gap>');
    }


    return Html(
      data: (htmlContent??"").replaceAll("\t", "&ensp;&ensp;"),
      onImageTap: (url,context,attributes,element,){
        if(url!=null && url!.startsWith('http')){
          DialogManager.showPreViewImageDialog(
              BackButtonBehavior.close, url);
        }
      },
      style: {
        "p": getHtml_P_TagStyle(),
      },
      tagsList: Html.tags..addAll(['gap']),
      customRenders: {
        tagMatcher("gap"):CustomRender.widget(widget: (context, buildChildren){
          String key = context.tree.element!.attributes["value"]??"unknown";
          String gapIndex = context.tree.element!.attributes["index"]??"unknown";
          String subtopicIdstr = context.tree.element!.attributes["subtopicid"]??"0";
          int subtopicId = int.parse(subtopicIdstr);
          String subtopicAnswer = context.tree.element!.attributes["answer"]??" ";
          String userAnswer = context.tree.element!.attributes["useranswer"]??" ";
          String isRightStr = context.tree.element!.attributes["isright"]??"0";
          int isRight = int.parse(isRightStr)??0;
          String content = "";
          int num = 0;
          print("jiexi: gapKey: $gapKey gapIndex:$gapIndex subtopicId: $subtopicId subtopicAnswer: $subtopicAnswer");

          return SizedBox(
            width: 80.w,
            height: 17.w,
            child: GetBuilder<SelectGapGetxController>(
              id:key,
              builder: (_){

                if(userAnswerCallback!=null){
                  // 更新作答答案
                  SubtopicAnswerVo subtopicAnswerVo = SubtopicAnswerVo(subtopicId:subtopicId,
                      optionId:0,
                      userAnswer: _.contentMap[key]??"",
                      answer: subtopicAnswer,
                      isCorrect: false);
                  userAnswerCallback.call(subtopicAnswerVo);
                }

                return Container(
                  width: 70.w,
                  height: 17.w,
                  margin: EdgeInsets.only(left:3.w,right:3.w),
                  color: Colors.white,
                  child: InkWell(
                    onTap: (answerType == AnsweringPage.answer_fix_type && isRight == AnswerType.right)? null:(){
                      _.updateFocus(key, true);
                    },
                    focusNode: getFocusNodeControllerCallback(key),
                    // onFocusChange:(focused){
                    //   _.updateFocus(key, focused);
                    // },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          color: isResult? Colors.white:((_.hasFocusMap[key]??false)? AppColors.c_FFD2D5DC : Colors.white),
                          width: double.infinity,
                          height: 13.w,
                          child: Center(
                            child: Text(isResult? userAnswer??"" : (_.contentMap[key]??"").isEmpty? "${key}":_.contentMap[key]??"",style: TextStyle(color: _getFieldInputTxtColor(isResult,answerType,isRight)),),
                          ),
                        ),
                        Container(
                          color: _getFieldInputTxtColor(isResult,answerType,isRight),
                          width: double.infinity,
                          height: 2.w,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),

          );
        })
      },

    );
  }

  static Color _getFieldInputTxtColor(bool isResult,int answerType,int isRight){
    if(isResult){
      switch(isRight){
        case AnswerType.no_answer: // 默认 未作答
          return AppColors.c_FF101010;
        case AnswerType.wrong:  // 作答错误
          return AppColors.c_FFEC9D4E;
        case AnswerType.right: // 作答正确
          return AppColors.c_FF58BC6D;
        default:
          return AppColors.c_FF101010;
      }
    }else{
      // 答题页模式
      return AppColors.c_FF101010;
    }

  }

  static Color _getFieldInputBgColor(bool isResult,bool hasFocus){
    if(isResult){
      return Colors.white;
    }else{
      // 答题页模式
      if(hasFocus){
        return AppColors.c_FFD2D5DC;
      }else{
        return Colors.white;
      }

    }

  }

  static Color _getShotInputTxtColor(int type){
    switch(type){
      case 0: // 默认 未作答
        return AppColors.c_FF353E4D;
      case 1:  // 作答错误
        return AppColors.c_FFEB5447;
      case 2: // 作答正确
        return AppColors.c_FF353E4D;
      default:
        return AppColors.c_FF353E4D;
    }
  }

  static Color _getShotInputBorderColor(bool isResult,int type){
    if(isResult){
      switch(type){
        case AnswerType.no_answer: // 默认 未作答
          return AppColors.c_FFD2D5DC;
        case AnswerType.wrong:  // 作答错误
          return AppColors.c_FFEB5447;
        case AnswerType.right: // 作答正确
          return AppColors.c_FF58BC6D;
        default:
          return AppColors.c_FFD2D5DC;
      }
    }else{
      // 答题页模式
      return AppColors.c_FFD2D5DC;
    }
  }



  static Color _getShotInputBgColor(bool isResult,int type){
    if(isResult){
      switch(type){
        case AnswerType.no_answer: // 默认 未作答
          return AppColors.c_FFF5F7FB;
        case AnswerType.wrong:  // 作答错误
          return AppColors.c_FFFBF5F5;
        case AnswerType.right: // 作答正确
          return AppColors.c_FF58BC6D;
        default:
          return AppColors.c_FFF5F7FB;
      }
    }else{
      return AppColors.c_FFF5F7FB;
    }

  }

  /// 选择填空的选项
  static Widget buildSelectOptionQuestion(List<OptionsList> answers,{isClickEnable = true,Set<String>? gapKeySet}){
    return Wrap(
      children: answers.map((e) => _colorAnswerOption(answers.indexOf(e),e,isClickEnable:isClickEnable)).toList(),
    );
  }



  /// 选择填空 选项显示部分
  /// answerIndex 选项的索引
  /// answer 选项的内容
  static Widget _colorAnswerOption(int answerIndex,OptionsList answer,{isClickEnable = true,Set<String>? gapKeySet}) {
    return GetBuilder<SelectGapGetxController>(
      id: "answer:${answerIndex}",
      builder: (_){
        return GestureDetector(
            onTap: isClickEnable? () {
              String gapKey = "";
              // 找见当下的焦点gapKey
              _.hasFocusMap.forEach((key, value) {
                if(value){
                  if(gapKeySet==null || !gapKeySet.contains(key)){
                    gapKey = key;
                  }
                }

              });

              // 去掉之前的选项 选择状态
              String findBeforeAnswerIndex = "";
              _.answerIndexToGapIndexMap.forEach((answerIndex, value) {
                if(value == gapKey){
                  findBeforeAnswerIndex = answerIndex;
                }
              });
              if(findBeforeAnswerIndex.isNotEmpty){
                _.updateAnswerIndexToGapKey("${findBeforeAnswerIndex}","");
              }

              if(gapKey.isNotEmpty){
                // 修改当前选中状态 当前选项 answerIndex 映射到 空
                _.updateAnswerIndexToGapKey("answer:${answerIndex}", gapKey);
                // 别的空对应的此选项内容 清空
                // 别的空对应的 anserIndex 清空
                _.contentMap.forEach((key, value) {
                  if(value == answer.sequence){
                    if(gapKeySet==null || !gapKeySet.contains(key)){
                      _.updateGapKeyContent(key, "");
                    }
                  }
                });
                _.updateGapKeyContent(gapKey, answer.sequence??"");
              }

            }:null,
            child: Container(
              margin: EdgeInsets.only(top: 6.w,bottom: 6.w),
              child: ChoiceRadioItem(
                  (_.answerIndexToGapIndexMap["answer:${answerIndex}"]??"").isNotEmpty ? ChoiceRadioItemType.SELECTED : ChoiceRadioItemType.DEFAULT,
                  "",
                  answer!.sequence!,
                  answer!.content!,
                  double.infinity,
                  false
              ),
            )
        );
      },
    );
  }


  static ChoiceRadioItemType _getType(String rightAnswer,String choseItemValue,String myLabel){
    if(choseItemValue.isNotEmpty){
      if(choseItemValue == myLabel){
        if(rightAnswer == choseItemValue){
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
  }

  static ChoiceRadioItemType _getSelectedType(bool isResult,bool isClickable,bool isCorrect,String choseItemValue,String myLabel){
    if(isResult){
      if(choseItemValue.isEmpty){
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
      if(choseItemValue.isEmpty){
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