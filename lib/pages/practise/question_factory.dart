import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/entity/commit_request.dart';
import 'package:crazyenglish/widgets/ChoiceImageItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../base/widgetPage/dialog_manager.dart';
import '../../entity/week_detail_response.dart';
import '../../utils/colors.dart';
import '../../widgets/ChoiceRadioItem.dart';
import 'question/base_question.dart';

/**
 * Time: 2023/2/20 13:31
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class QuestionFactory{

  static Widget buildSingleTxtChoice(SubtopicVoList subtopicVoList,bool isClickEnable,bool isResultPage,{
    int? defaultChooseIndex,UserAnswerCallback? userAnswerCallback}){

    var choseItem = (-1).obs;
    choseItem.value = defaultChooseIndex??-1;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 12.w)),
          Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: subtopicVoList!.optionsList!.map(
                    (e) => InkWell(
                  onTap: isClickEnable? (){
                    choseItem.value = subtopicVoList!.optionsList!.indexOf(e);
                    if(userAnswerCallback!=null){
                      SubtopicAnswerVo subtopicAnswerVo = SubtopicAnswerVo(subtopicId:e.subtopicId,
                          optionId:e.id,
                          userAnswer: e.sequence,
                          answer: subtopicVoList.answer,
                          isCorrect: subtopicVoList.answer== e.sequence);
                      userAnswerCallback.call(subtopicAnswerVo);
                    }
                  }:null,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.w),
                    child: ChoiceRadioItem(
                        _getSelectedType(isResultPage,isClickEnable,subtopicVoList!.optionsList!.indexOf(e) == choseItem.value,choseItem.value,subtopicVoList!.optionsList!.indexOf(e)),
                        subtopicVoList.answer,
                        e!.sequence!,
                        e!.content!,
                        double.infinity,
                        52.w
                    ),
                  ),
                )
            ).toList(),
          ))
        ],
      ),
    );
  }


  static Widget buildSingleOptionsTxtChoice(SubtopicVoList subtopicVoList,int answerIndex,bool isClickEnable,bool isResultPage,{int? defaultChooseIndex}){

    var choseItem = (-1).obs;
    choseItem.value = defaultChooseIndex??-1;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 12.w)),
          Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: subtopicVoList!.optionsList!.map(
                    (e) => InkWell(
                  onTap: (){
                    choseItem.value = subtopicVoList!.optionsList!.indexOf(e);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.w),
                    child: ChoiceRadioItem(
                        _getSelectedType(isResultPage,isClickEnable,subtopicVoList!.optionsList!.indexOf(e) == choseItem.value,choseItem.value,subtopicVoList!.optionsList!.indexOf(e)),
                        "",
                        e.sequence!,
                        e.content!,
                        double.infinity,
                        52.w
                    ),
                  ),
                )
            ).toList(),
          ))
        ],
      ),
    );
  }



  static Widget buildSingleImgChoice(SubtopicVoList subtopicVoList,bool isClickEnable,bool isResultPage,{int? defaultChooseIndex, UserAnswerCallback? userAnswerCallback}){
    var choseItem = (-1).obs;
    choseItem.value = defaultChooseIndex??-1;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 12.w)),
          Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: subtopicVoList!.optionsList!.map(
                    (e) => InkWell(
                  onTap: isClickEnable?(){
                    choseItem.value = subtopicVoList!.optionsList!.indexOf(e);
                    if(userAnswerCallback!=null){
                      SubtopicAnswerVo subtopicAnswerVo = SubtopicAnswerVo(subtopicId:e.subtopicId,
                          optionId:e.id,
                          userAnswer: e.sequence,
                          answer: subtopicVoList.answer,
                          isCorrect: subtopicVoList.answer== e.sequence);
                      userAnswerCallback.call(subtopicAnswerVo);
                    }
                  }:null,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.w),
                    child: ChoiceImageItem(
                      _getSelectedType(isResultPage,isClickEnable,subtopicVoList!.optionsList!.indexOf(e) == choseItem.value,choseItem.value,subtopicVoList!.optionsList!.indexOf(e)),
                        subtopicVoList!.answer,
                        e!.sequence!,
                        e.img,
                        140.w,
                        140.w,
                    ),
                  ),
                )
            ).toList(),
          ))
        ],
      ),
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

  static Widget buildNarmalGapQuestion(SubtopicVoList subtopicVoList,int gapKey,GetEditingControllerCallback getEditingControllerCallback){
    FocusScopeNode _scopeNode = FocusScopeNode();
    int max = 0;
    String gap = "____";

    int gapIndex = -1;
    String htmlContent = "";
    // for(Options option in list!){
    //   htmlContent = htmlContent+(option.name??"")+gap;
    // }
    while(htmlContent.contains(gap)){
      gapKey++;
      gapIndex++;
      print("gapKey: $gapKey gapIndex:$gapIndex");
      htmlContent = htmlContent.replaceFirst(gap, '<gap value="$gapKey" index="$gapIndex"></gap>');

    }
    return FocusScope(
      node: _scopeNode,
      child: Html(
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
                  style: TextStyle(color: _getInputColor(correctType.value)),
                  decoration: InputDecoration(
                    isDense:true,
                    contentPadding: EdgeInsets.all(0.w),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.w,
                          color: _getInputColor(correctType.value),
                          style: BorderStyle.solid
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.w,
                          color: _getInputColor(correctType.value),
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
                    if(num < max){
                      _scopeNode.nextFocus();
                    }else{
                      _scopeNode.unfocus();
                    }

                  },
                  controller: getEditingControllerCallback(key))),

            );
          })
        },

      ),
    );
  }

  static Widget buildShortAnswerQuestion(String value,int gapKey,GetEditingControllerCallback getEditingControllerCallback){
    var correctType = 0.obs;
    TextEditingController controller = TextEditingController();
    return SizedBox(
      width: 50.w,
      child: Obx(()=>TextField(
          keyboardType: TextInputType.name,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(color: _getInputColor(correctType.value)),
          decoration: InputDecoration(
            isDense:true,
            contentPadding: EdgeInsets.all(0.w),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.w,
                  color: _getInputColor(correctType.value),
                  style: BorderStyle.solid
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.w,
                  color: _getInputColor(correctType.value),
                  style: BorderStyle.solid
              ),
            ),
          ),
          onChanged: (text){

          },
          onSubmitted: (text){

          },
          onEditingComplete: (){
          },
          controller: controller)),
    );
  }

  /// 选词填空 题干部分
  /// gapKey 默认空的索引号
  static Widget buildSelectWordsFillingQuestion(SubjectVoList subjectVoList,GetFocusNodeControllerCallback getFocusNodeControllerCallback,GetEditingControllerCallback getEditingControllerCallback,{int gapKey = 0,int defaultIndex = 0}){
    FocusScopeNode _scopeNode = FocusScopeNode();
    int max = 0;
    String gap = "____";

    int gapIndex = -1;
    String htmlContent = subjectVoList.content??"";
    while(htmlContent.contains(gap)){
      gapKey++;
      gapIndex++;
      print("gapKey: $gapKey gapIndex:$gapIndex");
      htmlContent = htmlContent.replaceFirst(gap, '<gap value="$gapKey" index="$gapIndex"></gap>');

    }
    return FocusScope(
      node: _scopeNode,
      child: Html(
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

              // if(list!=null && num< list!.length){
              //   content = list![num].content!;
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
                  style: TextStyle(color: _getInputColor(correctType.value)),
                  decoration: InputDecoration(
                    isDense:true,
                    contentPadding: EdgeInsets.all(0.w),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.w,
                          color: _getInputColor(correctType.value),
                          style: BorderStyle.solid
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.w,
                          color: _getInputColor(correctType.value),
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
                    if(num < max){
                      _scopeNode.nextFocus();
                    }else{
                      _scopeNode.unfocus();
                    }

                  },
                  controller: getEditingControllerCallback(key))),

            );
          })
        },

      ),
    );
  }

  /// 选择填空题 题干部分
  /// gapKey 默认空的索引号
  static Widget buildSelectFillingQuestion(SubjectVoList subjectVoList,GetFocusNodeControllerCallback getFocusNodeControllerCallback,{int gapKey = 0}){
    FocusScopeNode _scopeNode = FocusScopeNode();
    int max = 0;
    String gap = "____";

    int gapIndex = -1;
    String htmlContent = subjectVoList.content??"";

    while(htmlContent.contains(gap)){
      num subtopicId = -1;
      String subtopicAnswer = "";
      if(subjectVoList.subtopicVoList!=null && subjectVoList.subtopicVoList!.length>gapKey){
        subtopicId = subjectVoList.subtopicVoList![gapKey].subjectId!;
        subtopicAnswer = subjectVoList.subtopicVoList![gapKey].answer!;
      }else{
        print("试题空和答案不匹配");
      }
      if(subtopicId<0){
        print("试题答案id获取失败");
      }
      gapKey++;
      gapIndex++;
      print("gapKey: $gapKey gapIndex:$gapIndex");
      // gapKey 内部通知使用采用按空排序的方式 index: 展示使用 subtopicId: 此空对应的正确答案的subtopicId ,subtopicAnswer:
      htmlContent = htmlContent.replaceFirst(gap, '<gap value="$gapKey" index="$gapIndex" subtopicId="$subtopicId" answer="$subtopicAnswer"></gap>');
    }


    return FocusScope(
      node: _scopeNode,
      child: Html(
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

              // if(list!=null && num< list!.length){
              //   content = list![num].content!;
              // }else{
                content = "";
              // }
              print("num: $num content: $content");
            } catch (e) {
              e.printError();
            }

            return SizedBox(
              width: 80.w,
              height: 17.w,
              child: GetBuilder<SelectGapGetxController>(
                id:key,
                builder: (_){

                  if(_.nextFocus){
                    _.resetNextFocus();
                    _scopeNode.nextFocus();
                  }
                  return Container(
                    width: 70.w,
                    height: 17.w,
                    margin: EdgeInsets.only(left:3.w,right:3.w),
                    color: Colors.white,
                    child: InkWell(
                      onTap: (){
                        _.updateFocus(key, !(_.hasFocusMap.value[key]??false));
                      },
                      focusNode: getFocusNodeControllerCallback(key),
                      onFocusChange:(focused){
                        _.updateFocus(key, focused);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            color: (_.hasFocusMap.value[key]??false)? AppColors.c_FFD2D5DC : Colors.white,
                            width: double.infinity,
                            height: 13.w,
                            child: Center(
                              child: Text((_.contentMap.value[key]??"").isEmpty? "${key}":_.contentMap.value[key]??""),
                            ),
                          ),
                          Container(
                            color: AppColors.c_FF353E4D,
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

      ),
    );
  }

  static Color _getInputColor(int type){
    switch(type){
      case 0: // 默认 未作答
        return AppColors.c_FF101010;
      case -1:  // 作答错误
        return AppColors.c_FFEC9D4E;
      case 1: // 作答正确
        return AppColors.c_FF58BC6D;
      default:
        return AppColors.c_FF101010;
    }
  }

  /// 选择填空的选项
  static Widget buildSelectOptionQuestion(List<OptionsList> answers){
    return Wrap(
      children: answers.map((e) => _colorAnswerOption(answers.indexOf(e),e)).toList(),
    );
  }

  /// 选词填空的词
  static Widget buildSelectAnswerQuestion(List<OptionsList> answers){
    return Wrap(
      children: answers.map((e) => _colorAnswerItem(answers.indexOf(e),e)).toList(),
    );
  }



  /// 选择填空 选项显示部分
  /// answerIndex 选项的索引
  /// answer 选项的内容
  static Widget _colorAnswerOption(int answerIndex,OptionsList answer) {
    return GetBuilder<SelectGapGetxController>(
      id: "answer:${answerIndex}",
      builder: (_){
        return GestureDetector(
          onTap: () {
            String gapKey = "";
            _.hasFocusMap.value.forEach((key, value) {
              if(value){
                gapKey = key;
              }
            });
            // 去掉之前的选项 选择状态
            String findBeforeAnswerIndex = "";
            _.answerIndexToGapIndexMap.value.forEach((answerIndex, value) {
              if(value == gapKey){
                findBeforeAnswerIndex = answerIndex;
              }
            });
            if(findBeforeAnswerIndex.isNotEmpty){
              _.updateAnswerIndexToGapKey("${findBeforeAnswerIndex}","");
            }

            // 修改当前选中状态 当前选项 answerIndex 映射到 空
            _.updateAnswerIndexToGapKey("answer:${answerIndex}", gapKey);
            // 别的空对应的此选项内容 清空
            // 别的空对应的 anserIndex 清空
            _.contentMap.value.forEach((key, value) {
              if(value == answer.sequence){
                _.updateGapKeyContent(key, "");
              }
            });
            _.updateGapKeyContent(gapKey, answer.sequence??"");

          },
          child: Container(
                margin: EdgeInsets.only(top: 6.w,bottom: 6.w),
                child: ChoiceRadioItem(
                    (_.answerIndexToGapIndexMap.value["answer:${answerIndex}"]??"").isNotEmpty ? ChoiceRadioItemType.SELECTED : ChoiceRadioItemType.DEFAULT,
                    "",
                    answer!.sequence!,
                    answer!.content!,
                    double.infinity,
                    52.w
                ),
              )
          );
      },
    );
  }

  /// answerIndex 选项的索引
  /// answer 选项的内容
  static Widget _colorAnswerItem(int answerIndex,OptionsList answer) {
    return GetBuilder<SelectGapGetxController>(
      id: "answer:${answerIndex}",
      builder: (_){
        return GestureDetector(
          onTap: () {
            String gapKey = "";
            _.hasFocusMap.value.forEach((key, value) {
              if(value){
                gapKey = key;
              }
            });
            if((_.answerIndexToGapIndexMap.value["answer:${answerIndex}"]??"").isEmpty){
              _.updateAnswerIndexToGapKey("answer:${answerIndex}", gapKey);
              _.updateGapKeyContent(gapKey, answer.content??"");
            }else{
              _.updateAnswerIndexToGapKey("answer:${answerIndex}", "");
              _.updateGapKeyContent(gapKey, "");
            }
          },
          child: Container(
            height: 22.w,
            padding: EdgeInsets.only(left: 13.w,right: 13.w),
            margin: EdgeInsets.only(right: 11.w,bottom: 10.w),
            decoration: BoxDecoration(
              color: (_.answerIndexToGapIndexMap.value["answer:${answerIndex}"]??"").isNotEmpty ? AppColors.c_FFD2D5DC : AppColors.c_FFF5F7FB,
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

  static ChoiceRadioItemType _getSelectedType(bool isResult,bool isClickable,bool isCorrect,int choseItemValue,int myLabel){
    if(isResult){
      if(choseItemValue>=0){
        if(choseItemValue == myLabel) {
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
      if(choseItemValue>=0){
        if(choseItemValue == myLabel){
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