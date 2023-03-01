import 'package:crazyenglish/pages/practise/question_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../entity/week_test_detail_response.dart';
import '../../../utils/colors.dart';
import '../answer_interface.dart';

/**
 * Time: 2023/2/21 14:14
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

typedef GetEditingControllerCallback = TextEditingController Function(String key);
typedef GetFocusNodeControllerCallback = FocusNode Function(String key);
typedef GetAnswerControllerCallback = String Function(String key);
typedef PageControllerListener = TextEditingController Function(String key);


abstract class BaseQuestion extends StatefulWidget with AnswerMixin{
  late BaseQuestionState baseQuestionState;
  final ValueChanged<String> onPageChanged;

  BaseQuestion({required this.onPageChanged,Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  BaseQuestionState createState() {
    baseQuestionState = getState();
    return baseQuestionState;
  }

  BaseQuestionState getState();

  @override
  getAnswers() {
    baseQuestionState.getAnswers();
  }
  bool next(){
    return baseQuestionState.next();
  }
  bool pre(){
    return baseQuestionState.pre();
  }

  int getQuestionCount(){
    return baseQuestionState.getQuestionCount();
  }
}

abstract class BaseQuestionState<T extends BaseQuestion> extends State<T> with AnswerMixin{
  String curPage = "";
  String tag = "BaseQuestionState_";

  Map<String,TextEditingController> gapEditController = {};
  Map<String,FocusNode> gapFocusNodeController = {};
  Map<String,String> gapAnswerController = {};
  final PageController pageController = PageController(keepPage: true);

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  List<Widget> questionList = [];
  int currentPage = 0;
  final selectGapGetxController = Get.put(SelectGapGetxController());
  @override
  void initState(){
    super.initState();
    onCreate();
    tag = tag+curPage;
    print(tag + "initState\n");
  }


  @override
  bool get mounted {
    print(tag + "mounted\n");
    return super.mounted;
  }

  Widget buildQuestionType(String name){
    return Container(
      width: 46.w,
      height: 22.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top:14.w,bottom: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
        border: Border.all(color: AppColors.c_FF898A93,width: 0.4.w)
      ),
      child: Text(name,style: TextStyle(color: AppColors.c_FF898A93,fontSize: 12.sp),),
    );
  }

  Widget buildQuestionDesc(String name){
    return Container(
      width: 66.w,
      height: 22.w,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: 66.w,
            height: 9.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0x78FCB853),
                Color(0x00FDB446),
              ]),
            ),
          ),
          Text(name,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.c_FF353E4D),)
        ],
      ),
    );
  }

  Widget getQuestionDetail(Data element){
    if(element.questionBankAppListVos!=null && element.questionBankAppListVos!.length>0){
      int questionNum = element.questionBankAppListVos!.length;
      for(int i = 0 ;i< questionNum;i++){
        QuestionBankAppListVos question = element.questionBankAppListVos![i];

        List<Widget> itemList = [];
        itemList.add(Padding(padding: EdgeInsets.only(top: 7.w)));

        if(question.type == 2 || (
            (question.type == 1 || question.type ==4)
                && question.listenType == 1)){
          // 选择题
          itemList.add(buildQuestionType("选择题"));
          itemList.add(Visibility(
            visible: question!.title != null && question!.title!.isNotEmpty,
            child: Text(
              question!.title!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),));
          if((question!.bankAnswerAppListVos??[]).length > 0) {
            itemList.add(QuestionFactory.buildSingleChoice(question!.bankAnswerAppListVos??[]));
          }
        }else if(question.type == 3 ){  // 填空题
          itemList.add(buildQuestionType("填空题"));
          itemList.add(QuestionFactory.buildGapQuestion(question!.bankAnswerAppListVos,question!.title!,0,makeEditController));
          itemList.add(QuestionFactory.buildSelectAnswerQuestion(["abc","leix","axxxbc","lddddeix","ddeeeddd","leix","dddddd","lsssseix",])
          );
        }else if(question.type == 5){
          itemList.add(buildQuestionType("纠错题"));
          itemList.add(QuestionFactory.buildFixProblemQuestion(question!.bankAnswerAppListVos,question!.title!));
        }else if(question.type == 12){
          itemList.add(buildQuestionType("选择填空题"));
          itemList.add(QuestionFactory.buildSelectGapQuestion(question!.bankAnswerAppListVos,question!.title!,0,makeFocusNodeController));
        }

        questionList.add(SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: itemList,
          ),
        ));
      }
    }else{
      questionList.add(const SizedBox());
    }
    widget.onPageChanged("1/${questionList.length}");
    return PageView(
      controller: pageController,
      physics: _neverScroll,
      onPageChanged: (int value){
        widget.onPageChanged("${(value+1)}/${questionList.length}");
      },
      children: questionList,
    );
  }

  @override
  int getQuestionCount() {
    return questionList.length;
  }

  @override
  bool next() {
    if(currentPage< questionList.length-1 && currentPage>=0){
      currentPage = currentPage+1;
      pageController.jumpToPage(currentPage);
      if(currentPage< questionList.length-1){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }

  }

  @override
  bool pre() {
    if(currentPage>0){
      currentPage = currentPage-1;
      pageController.jumpToPage(currentPage);
      if(currentPage>0){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  TextEditingController makeEditController(String key){
    if(gapEditController[key] == null){
      TextEditingController controller = TextEditingController();
      gapEditController[key] = controller;
      return controller;
    }else{
      return gapEditController[key]!;
    }
  }

  FocusNode makeFocusNodeController(String key){
    if(gapFocusNodeController[key] == null){
      FocusNode focusNode = FocusNode();
      gapFocusNodeController[key] = focusNode;
      return focusNode;
    }else{
      return gapFocusNodeController[key]!;
    }
  }

  String makeGapAnswerController(String key){
    return "";
  }

  void onCreate();

  void onDestroy();

  @override
  void didUpdateWidget(T oldWidget) {
    print(tag + "didUpdateWidget\n");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    print(tag + "reassemble\n");
    super.reassemble();
  }

  @override
  void deactivate() {
    print(tag + "deactivate\n");
    super.deactivate();
  }

  @override
  void dispose() {
    print(tag + "dispose\n");
    Get.delete<SelectGapGetxController>();
    onDestroy();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print(tag + "didChangeDependencies\n");
    super.didChangeDependencies();
  }


}

class SelectGapGetxController extends GetxController{
  var hasFocusMap = {}.obs;
  var contentMap = {}.obs;

  updateFocus(String key,bool hasFocus){
    hasFocusMap.value.addIf(true, key, hasFocus);
    update([key]);
  }

  updateContent(String key,String contentTxt){
    contentMap.value.addIf(true, key, contentTxt);
    update([key]);
  }
}
