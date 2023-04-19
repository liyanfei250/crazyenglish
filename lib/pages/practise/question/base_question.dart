import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/pages/practise/question_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/common.dart';
import '../../../base/widgetPage/dialog_manager.dart';
import '../../../entity/week_detail_response.dart';
import '../../../utils/colors.dart';
import '../answer_interface.dart';
import '../answering/answering_logic.dart';

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

  BaseQuestion({Key? key}) : super(key: key);

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
  final logic = Get.find<AnsweringLogic>();
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

  Widget getQuestionDetail(SubjectVoList element){
    questionList.clear();


    // 判断是否父子题
    // 普通阅读 常规阅读题 是父子题
    int questionNum = element.subtopicVoList!.length;
    if(questionNum>0){
      for(int i = 0 ;i< questionNum;i++){
        SubtopicVoList question = element.subtopicVoList![i];

        List<Widget> itemList = [];
        itemList.add(Padding(padding: EdgeInsets.only(top: 7.w)));

        if(element.questionType == QuestionType.single_choice
            || element.questionType == QuestionType.normal_reading){
          // 选择题
          itemList.add(buildQuestionType("选择题"));
          itemList.add(Visibility(
            visible: question!.problem != null && question!.problem!.isNotEmpty,
            child: Text(
              question!.problem!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),));
          // TODO 判断是否是图片选择题的逻辑需要修改
          if(question.optionsList![0].content!.isNotEmpty){
            itemList.add(QuestionFactory.buildSingleTxtChoice(question,int.parse(question.answer!.isEmpty?"-1":question.answer!)));
          }else{
            itemList.add(QuestionFactory.buildSingleImgChoice(question,int.parse(question.answer!.isEmpty?"-1":question.answer!)));
          }

        }else if(element.questionType == QuestionType.multi_choice){

        }else if(element.questionType == QuestionType.judge_choice){

        }else if(element.questionType == QuestionType.normal_gap) {
          itemList.add(buildQuestionType("填空题"));
          itemList.add(buildReadQuestion(element.content ?? ""));
          itemList.add(QuestionFactory.buildHuGapQuestion(
              question, 0, makeEditController));
        }else if(element.questionType == QuestionType.question_reading){

        }
        // else if(element.questionType == QuestionType.select_words_filling){
        //   itemList.add(buildQuestionType("选择填空题"));
        //   itemList.add(QuestionFactory.buildSelectGapQuestion(element.optionsList,element!.content!,0,makeFocusNodeController));
        //   itemList.add(QuestionFactory.buildSelectAnswerQuestion(["abc","leix","axxxbc","lddddeix","ddeeeddd","leix","dddddd","lsssseix",])
        //   );
        // }
        // else if(element.questionType == QuestionType.correction_question){
        //   itemList.add(buildQuestionType("纠错题"));
        //   itemList.add(QuestionFactory.buildFixProblemQuestion(element,element!.content!));
        // }

        questionList.add(SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: itemList,
          ),
        ));
      }
    }

    if(logic!=null){
      logic.initPageStr("1/${questionList.length}");
    }
    return PageView(
      controller: pageController,
      physics: _neverScroll,
      onPageChanged: (int value){
        if(logic!=null){
          logic.updatePageStr("${(value+1)}/${questionList.length}");
        }
      },
      children: questionList,
    );
  }


  @override
  int getQuestionCount() {
    return questionList.length;
  }

  Widget buildReadQuestion(String? htmlContent){
    return Container(
      height: 204.w,
      margin: EdgeInsets.only(top: 17.w,bottom: 18.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(color: AppColors.c_FFD2D5DC,width: 0.4.w)
      ),
      child: SingleChildScrollView(
        child:  Html(
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

            "hr":Style(
              margin: Margins.only(left:0,right: 0,top: 10.w,bottom:10.w),
              padding: EdgeInsets.all(0),
              border: Border(bottom: BorderSide(color: Colors.grey)),
            )
          },
          tagsList: Html.tags..addAll(['gap']),
          customRenders: {
          },

        ),
      ),
    );
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
  // 答案 列表
  List<String> indexContentList = [];

  // 填空的 焦点 key-bool
  var hasFocusMap = {}.obs;
  // 填空的内容
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

  updateContent(String key,String contentTxt){
    contentMap.value.addIf(true, key, contentTxt);
    if(contentTxt.isNotEmpty){
      nextFocus = true;
    }else{
      nextFocus = false;
    }
    update([key]);
  }

  resetNextFocus(){
    nextFocus = false;
  }

  updateIndex(String answerIndex,String gapIndex){
    answerIndexToGapIndexMap.value.addIf(true, answerIndex, gapIndex);
    update([answerIndex]);
  }
}
