import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../base/widgetPage/dialog_manager.dart';
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
                        getType(answer,choseItem.value,e.logoAnswer??"K"),
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

  static ChoiceRadioItemType getType(String rightAnswer,String choseItemValue,String myLabel){
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
                  style: TextStyle(color: getInputColor(correctType.value)),
                  decoration: InputDecoration(
                    isDense:true,
                    contentPadding: EdgeInsets.all(0.w),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.w,
                          color: getInputColor(correctType.value),
                          style: BorderStyle.solid
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.w,
                          color: getInputColor(correctType.value),
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

  static Color getInputColor(int type){
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


}