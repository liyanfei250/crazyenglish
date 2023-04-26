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
  Map<String,bool> hasFocusMap = {};
  // 填空的内容  填空索引-内容：用于储存空中 用户作答洗洗
  Map<String,String> contentMap = {};
  // 答案索引-填空索引
  Map<String,String> answerIndexToGapIndexMap = {};

  bool nextFocus = false;

  // 填空索引 - 是否高亮显示空
  Map<String,bool> gapKeyIndexMap = {};

  initContent(List<String> list){
    indexContentList.clear();
    indexContentList.addAll(list);
  }

  updateFocus(String key,bool hasFocus,{bool isInit = false}){
    print("updateFocus: ${key}:${hasFocus}:isInit:${isInit}");
    if(hasFocus){
      if(!isInit){
        hasFocusMap.addIf(true, key, hasFocus);
        gapKeyIndexMap.addIf(true, key, hasFocus);
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


  updateGapKeyContent(String gapKey,String contentTxt){
    contentMap.addIf(true, gapKey, contentTxt);
    if(contentTxt.isNotEmpty){
      nextFocus = true;
    }else{
      nextFocus = false;
    }
    print("updateGapKeyContent: $gapKey, $contentTxt");
    update([gapKey]);
  }

  resetNextFocus(){
    nextFocus = false;
  }

  updateAnswerIndexToGapKey(String answerIndex,String gapKey){
    print("updateAnswerIndexToGapKey: $answerIndex, $gapKey");
    answerIndexToGapIndexMap.addIf(true, answerIndex, gapKey);
    update([answerIndex]);
  }
}