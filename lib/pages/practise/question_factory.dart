import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/widgets/ChoiceImageItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../base/widgetPage/dialog_manager.dart';
import '../../entity/week_detail_response.dart';
import '../../entity/week_test_detail_response.dart';
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

  static Widget buildSingleChoice(List<BankAnswerAppListVos> list){
    var choseItem = "".obs;
    String answer = "B";
    list.forEach((element) {
      if(element.isAnswer??false){
        answer = element.logoAnswer??"K";
      }
    });
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 12.w)),
          Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: list.map(
                    (e) => InkWell(
                  onTap: (){
                    choseItem.value = e.logoAnswer??"K";
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.w),
                    child: ChoiceRadioItem(
                        _getType(answer,choseItem.value,e.logoAnswer??"K"),
                        choseItem.value,
                        e.logoAnswer??"K",
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

  static Widget buildSingleTxtChoice(List<TiList> list,int answerIndex,{int? defaultChooseIndex}){

    var choseItem = (-1).obs;
    choseItem.value = defaultChooseIndex??-1;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 12.w)),
          Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: list.map(
                    (e) => InkWell(
                  onTap: (){
                    choseItem.value = list.indexOf(e);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.w),
                    child: ChoiceRadioItem(
                        _getSelectedType(choseItem.value,list.indexOf(e)),
                        answerIndex>=0? list[answerIndex].text:"",
                        e!.text!,
                        e!.text!,
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


  static Widget buildSingleOptionsTxtChoice(List<Options> list,int answerIndex,{int? defaultChooseIndex}){

    var choseItem = (-1).obs;
    choseItem.value = defaultChooseIndex??-1;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 12.w)),
          Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: list.map(
                    (e) => InkWell(
                  onTap: (){
                    choseItem.value = list.indexOf(e);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.w),
                    child: ChoiceRadioItem(
                        _getSelectedType(choseItem.value,list.indexOf(e)),
                        "",
                        e.list![0].text!,
                        e.list![0].text!,
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



  static Widget buildSingleImgChoice(List<TiList> list,int answerIndex,{int? defaultChooseIndex}){
    var choseItem = (-1).obs;
    choseItem.value = defaultChooseIndex??-1;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 12.w)),
          Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: list.map(
                    (e) => InkWell(
                  onTap: (){
                    choseItem.value = list.indexOf(e);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.w),
                    child: ChoiceImageItem(
                      _getSelectedType(choseItem.value,list.indexOf(e)),
                        answerIndex>=0? list[answerIndex].text:"",
                        e!.text!,
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
  static Widget buildFixProblemQuestion(List<BankAnswerAppListVos>? list,String htmlContent){

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

  static Widget buildHuGapQuestion(List<Options>? list,int gapKey,GetEditingControllerCallback getEditingControllerCallback){
    FocusScopeNode _scopeNode = FocusScopeNode();
    int max = 0;
    String gap = "____";

    int gapIndex = -1;
    String htmlContent = "";
    for(Options option in list!){
      htmlContent = htmlContent+(option.name??"")+gap;
    }
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

              if(list!=null && num< list!.length){
                content = list![num].value!;
              }else{
                content = "";
              }
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


  static Widget buildGapQuestion(List<BankAnswerAppListVos>? list,String htmlContent,int gapKey,GetEditingControllerCallback getEditingControllerCallback){
    FocusScopeNode _scopeNode = FocusScopeNode();
    int max = 0;
    String gap = "____";

    int gapIndex = -1;
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

              if(list!=null && num< list!.length){
                content = list![num].content!;
              }else{
                content = "";
              }
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

  /// 选择填空题
  static Widget buildSelectGapQuestion(List<BankAnswerAppListVos>? list,String htmlContent,int gapKey,GetFocusNodeControllerCallback getFocusNodeControllerCallback){
    FocusScopeNode _scopeNode = FocusScopeNode();
    int max = 0;
    String gap = "____";

    int gapIndex = -1;
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

              if(list!=null && num< list!.length){
                content = list![num].content!;
              }else{
                content = "";
              }
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
      case 0:
        return AppColors.c_FF101010;
      case -1:
        return AppColors.c_FFEC9D4E;
      case 1:
        return AppColors.c_FF58BC6D;
      default:
        return AppColors.c_FF101010;
    }
  }

  static Widget buildSelectAnswerQuestion(List<String> answers){
    return Wrap(
      children: answers.map((e) => _colorAnswerItem(answers.indexOf(e),e)).toList(),
    );
  }

  static Widget _colorAnswerItem(int key,String answer) {
    return GetBuilder<SelectGapGetxController>(
      id: "answer:${key}",
      builder: (_){
        return GestureDetector(
          onTap: () {
            String gapIndex = "";
            _.hasFocusMap.value.forEach((key, value) {
              if(value){
                gapIndex = key;
              }
            });
            if((_.answerIndexToGapIndexMap.value["answer:${key}"]??"").isEmpty){
              _.updateIndex("answer:${key}", gapIndex);
              _.updateContent(gapIndex, answer);
            }else{
              _.updateIndex("answer:${key}", "");
              _.updateContent(gapIndex, "");
            }
          },
          child: Container(
            height: 22.w,
            padding: EdgeInsets.only(left: 13.w,right: 13.w),
            margin: EdgeInsets.only(right: 11.w,bottom: 10.w),
            decoration: BoxDecoration(
              color: (_.answerIndexToGapIndexMap.value["answer:${key}"]??"").isNotEmpty ? AppColors.c_FFD2D5DC : AppColors.c_FFF5F7FB,
              border: Border.all(color: AppColors.c_FFD2D5DC,width: 1.w),
              borderRadius: BorderRadius.all(Radius.circular(4.w)),
            ),
            child: Text(
              answer,
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

  static ChoiceRadioItemType _getSelectedType(int choseItemValue,int myLabel){
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