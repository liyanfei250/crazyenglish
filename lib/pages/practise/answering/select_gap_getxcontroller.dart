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
  var hasFocusMap = {}.obs;
  // 填空的内容  填空索引-内容：用于储存空中 用户作答洗洗
  var contentMap = {}.obs;
  // 答案索引-填空索引
  var answerIndexToGapIndexMap = {}.obs;

  bool nextFocus = false;

  initContent(List<String> list){
    indexContentList.clear();
    indexContentList.addAll(list);
  }

  updateFocus(String key,bool hasFocus){
    if(hasFocus){
      hasFocusMap.value.keys.toList().forEach((element) {
        hasFocusMap.value.addIf(true, element, false);
      });
      hasFocusMap.value.addIf(true, key, hasFocus);
      hasFocusMap.value.keys.toList().forEach((element) {
        update([element]);
      });
      // update([key]);
    } else {
      hasFocusMap.value.addIf(true, key, hasFocus);
      update([key]);
    }
  }

  updateGapKeyContent(String gapKey,String contentTxt){
    contentMap.value.addIf(true, gapKey, contentTxt);
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
    answerIndexToGapIndexMap.value.addIf(true, answerIndex, gapKey);
    update([answerIndex]);
  }
}