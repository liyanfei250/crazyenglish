import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:get/get.dart';

/**
 * Time: 2023/4/24 09:53
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class SelectGapGetxController extends GetxController{
  // 答案 列表
  List<String> indexContentList = [];

  // 填空的 焦点 key-bool  : 用于焦点切换
  // 只允许一个为true
  Map<String,bool> hasFocusMap = {};

  // gapKey 大于
  // 填空索引 - 是否高亮显示空
  // 只允许一个为true?
  Map<String,bool> gapKeyIndexMap = {};

  // 填空的内容  填空索引-内容：用于储存空中 用户作答洗洗
  Map<String,String> contentMap = {};
  Map<String,num> optionIdMap = {};

  // 答案索引-填空索引
  Map<String,String> answerIndexToGapIndexMap = {};





  initContent(List<String> list){
    indexContentList.clear();
    indexContentList.addAll(list);
  }

  initLastAnswer(Map<String,String> lastAnswer,{Set<String>? answerIndexSet}){
    contentMap.addAll(lastAnswer);
    if(answerIndexSet!=null){
      answerIndexSet.forEach((element) {
        answerIndexToGapIndexMap.addAllIf(true, {"answer:$element": "-1"});
      });
    }

  }

  // 1. 只允许一个空的焦点为true
  // 2. 初始化的时候不发送update
  updateFocus(String key,bool hasFocus,{bool isInit = false}){
    print("updateFocus: ${key}:${hasFocus}:isInit:${isInit}");
    if(hasFocus){
      hasFocusMap.keys.toList().forEach((element) {
        hasFocusMap.addIf(true, element, false);
      });
      hasFocusMap.addIf(true, key, hasFocus);
      gapKeyIndexMap.keys.toList().forEach((element) {
        gapKeyIndexMap.addIf(true, element, false);
      });
      gapKeyIndexMap.addIf(true, key, hasFocus);
      update([GetBuilderIds.updateFocus+(isInit? "isInit":"")]);
      if(!isInit){
        hasFocusMap.keys.toList().forEach((element) {
          update([element]);
        });
      }
      hasFocusMap.keys.toList().forEach((element) {
        print("hasFocusMap: ${element}:${hasFocusMap[element]}");
      });
      // update([key]);
    } else {
      hasFocusMap.addIf(true, key, hasFocus);
      gapKeyIndexMap.addIf(true, key, hasFocus);
      if(!isInit){
        update([key]);
      }
    }
  }


  clearFocus(){
    hasFocusMap.keys.toList().forEach((element) {
      hasFocusMap.addIf(true, element, false);
      update([element]);
    });
  }


  updateGapKeyContent(String gapKey,String contentTxt,{num optionId=0}){
    contentMap.addIf(true, gapKey, contentTxt);
    if(optionId>0){
      optionIdMap.addIf(true,gapKey,optionId);
    }
    print("updateGapKeyContent: $gapKey, $contentTxt");
    update([gapKey]);
  }

  updateAnswerIndexToGapKey(String answerIndex,String gapKey){
    print("updateAnswerIndexToGapKey: $answerIndex, $gapKey");
    answerIndexToGapIndexMap.addIf(true, answerIndex, gapKey);
    update([answerIndex]);
  }
}