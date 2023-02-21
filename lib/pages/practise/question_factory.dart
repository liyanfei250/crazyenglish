import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../entity/week_test_detail_response.dart';
import '../../widgets/ChoiceRadioItem.dart';

/**
 * Time: 2023/2/20 13:31
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class QuestionFactory{

  Widget buildSingleChoice(List<BankAnswerAppListVos> list){
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

  ChoiceRadioItemType getType(String rightAnswer,String choseItemValue,String myLabel){
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

}