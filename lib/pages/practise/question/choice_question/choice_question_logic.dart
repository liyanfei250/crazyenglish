import 'package:get/get.dart';

class ChoiceQuestionLogic extends GetxController {

  Set<String> userAnswer = {};
  bool isMulti = false;
  num? subtopicId;

  initContent(List<String> list,num? subtopicId,{bool isMulti=false}){
    userAnswer.clear();
    this.isMulti = isMulti;
    this.subtopicId = subtopicId;
    if(list!=null && list.length>0){
      list.forEach((element) {
        userAnswer.add(element);
      });
    }
  }

  void updateUserAnswer(num? subtopicId,String sequence){
    this.subtopicId = subtopicId;
    if( isMulti ) {
      if(userAnswer.contains(sequence??"")){
        userAnswer.remove(sequence??"");
      } else {
        userAnswer.add(sequence??"");
      }
    } else {
      userAnswer.clear();
      userAnswer.add(sequence??"");
    }
    update(["selectanswer:${subtopicId}"]);
  }

  String getUserAnswer(){
    if(userAnswer.isNotEmpty){
      String answer = "";
      int length = userAnswer.length;
      List<String> list = userAnswer.toList();
      for(int i = 0;i<length;i++){
        String element = list[i];
        if(i+1 == length){
          answer = "$answer$element";
        }else{
          answer = "$answer$element,";
        }
      }
      return answer;
    }else{
      return "";
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
