import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/entity/commit_request.dart';
import 'package:crazyenglish/pages/practise/question/question_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/common.dart';
import '../../../base/widgetPage/dialog_manager.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../answer_interface.dart';
import '../answering/answering_logic.dart';
import '../answering/answering_view.dart';
import '../answering/page_getxcontroller.dart';
import '../answering/select_gap_getxcontroller.dart';
import '../question/choice_question/choice_question_view.dart';

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
typedef UserAnswerCallback = void Function(SubtopicAnswerVo subtopicAnswerVo,{int indexPage});
typedef CloseKeyBoardCallback = void Function();

abstract class BaseQuestion extends StatefulWidget{
  late BaseQuestionState baseQuestionState;
  late SubjectVoList data;
  // key subjectId:subtopicId
  late Map<String,ExerciseLists> subtopicAnswerVoMap;
  late int answerType;
  late int childIndex;
  BaseQuestion(this.subtopicAnswerVoMap,this.answerType,this.childIndex,{required this.data,Key? key}) : super(key: key);

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
}

abstract class BaseQuestionState<T extends BaseQuestion> extends State<T> with AnswerMixin{
  String curPage = "";
  String tag = "BaseQuestionState_";

  final Map<String,TextEditingController> gapEditController = {};
  final Map<String,FocusNode> gapFocusNodeController = {};
  Map<String,String> gapAnswerController = {};

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  List<Widget> questionList = [];
  final selectGapGetxController = Get.find<SelectGapGetxController>();
  final logic = Get.find<AnsweringLogic>();
  final pagLogic = Get.find<PageGetxController>();

  // 用于选择填空 草稿，纠错 已选中
  final Set<String> answerIndexSet = {};
  // 用于纠错模式不能更新空
  final Set<String> gapKeIndexSet = {};
  @override
  void initState(){
    super.initState();
    onCreate();

    tag = tag+curPage;
    if(widget.answerType != AnsweringPage.answer_normal_type
        && widget.answerType != AnsweringPage.answer_homework_type){
      Map<String,String>  contentMap = getLastAnswer();
      selectGapGetxController.initLastAnswer(contentMap,answerIndexSet: answerIndexSet);
    }
    selectGapGetxController.updateFocus("${widget.childIndex+1}",true,isInit: true);

    print(tag + "initState\n");
    pagLogic.addListenerId(GetBuilderIds.answerPrePage,() {
      pre();
    });
    pagLogic.addListenerId(GetBuilderIds.answerNextPage,() {
      print(tag + "listener Next Page\n");
      next();
    });
    selectGapGetxController.addListenerId(GetBuilderIds.updateFocus+"isInit", () {
      selectGapGetxController.hasFocusMap.forEach((key, value) {
        if(value){
          int index = int.parse(key) -1;
          if(index >-1 ){
            print("更新空位置 $index");
            logic.updateCurrentPage(index,totalQuestion:questionList.length,isInit: true);
          }
        }
      });
    });
    selectGapGetxController.addListenerId(GetBuilderIds.updateFocus, () {
      selectGapGetxController.hasFocusMap.forEach((key, value) {
        if(value){
          int index = int.parse(key) -1;
          if(index >-1 ){
            print("更新空位置 $index");
            logic.updateCurrentPage(index,totalQuestion:questionList.length,isInit: false);
          }
        }
      });

    });
  }

  int getFocusIndex(){
    int returnIndex = -1;
    selectGapGetxController.hasFocusMap.forEach((key, value) {
      if(value){
        int index = int.parse(key) -1;
        if(index >-1 ){
          returnIndex = index;
        }
      }
    });
    return returnIndex;
  }


  @override
  bool get mounted {
    print(tag + "mounted\n");
    return super.mounted;
  }

  Map<String,String> getLastAnswer(){
    Map<String,String> contentMap = {};
    if(widget.data!=null && widget.subtopicAnswerVoMap.isNotEmpty){
      if(widget.data.questionTypeStr == QuestionType.normal_gap
          || widget.data.questionTypeStr == QuestionType.completion_filling
          || widget.data.questionTypeStr == QuestionType.select_filling
          || widget.data.questionTypeStr == QuestionType.complete_filling
          || widget.data.questionTypeStr == QuestionType.translate_filling
          || widget.data.questionTypeStr == QuestionType.select_words_filling){
        int totalLength = (widget.data.subtopicVoList??[]).length;

        num subjectid = widget.data.id??0;
        for(int i = 0;i<totalLength;i++){
          num subtopicId = widget.data.subtopicVoList![i].id??0;
          if(widget.subtopicAnswerVoMap["${subjectid}:${subtopicId}"]!=null){
            String userAnswer = widget.subtopicAnswerVoMap["${subjectid}:${subtopicId}"]!.answer??"";
            if(userAnswer.isNotEmpty){
              contentMap["${i+1}"] = userAnswer;
              // TODO answerIndexSet 逻辑有误
              // answerIndexSet.add("${i}");
              if(widget.answerType == AnsweringPage.answer_fix_type){
                gapKeIndexSet.add("${i+1}");
              }
            }
          }

        }
      }
    }
    return contentMap;
  }

  Widget buildQuestionType(String name){
    return Container(
      height: 17.w,
      margin: EdgeInsets.only(top:14.w,bottom: 10.w),
      padding: EdgeInsets.only(left:2.w,right:2.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
        border: Border.all(color: AppColors.c_FF898A93,width: 0.4.w)
      ),
      child: Text(name,style: TextStyle(color: AppColors.c_FF898A93,fontSize: 10.sp),),
    );
  }

  Widget buildQuestionDesc(String name){
    return Container(
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
          Text(name,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColors.c_FF353E4D),)
        ],
      ),
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
        child:  Util.getHtmlWidget(htmlContent),
      ),
    );
  }

  @override
  void next() {
    if(logic.state.currentQuestionNum< logic.state.totalQuestionNum){
      int currentPage = logic.state.currentQuestionNum;
      currentPage = currentPage+1;
      print("next==${currentPage}");
      jumpToQuestion(currentPage);
    }
  }

  @override
  void pre() {
    int currentPage = logic.state.currentQuestionNum;
    if(currentPage>0){
      currentPage = currentPage-1;
      print("pre==${currentPage}");
      jumpToQuestion(currentPage);
    }
  }


  @override
  void clearFocus(){
    closeKeyBoard();
  }


  @override
  void jumpToQuestion(int index) {
    int currentPage = index;
    // 检测
    print("jumpToQuestion==${currentPage}");
    logic.updateCurrentPage(currentPage);
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

  void userAnswerCallback(SubtopicAnswerVo subtopicAnswerVo,{int indexPage=-1}){
    logic.updateUserAnswer((subtopicAnswerVo.subtopicId??1).toString(), subtopicAnswerVo);
  }

  void userAnswerWritCallback(SubjectAnswerVo subjectAnswerVo){
    logic.updateUserWritAnswer((subjectAnswerVo.subjectId??1).toString(), subjectAnswerVo);
  }

  FocusNode makeFocusNodeController(String key){
    if(gapFocusNodeController[key] == null){
      FocusNode focusNode = FocusNode();
      // print("makeFocusNode:$key");
      focusNode.addListener(() {
        // if(focusNode.hasFocus){
        //   print("makeFocusNode:$key has focus");
        // }else{
        //   print("makeFocusNode:$key not has focus");
        // }
      });
      gapFocusNodeController[key] = focusNode;
      return focusNode;
    }else{
      // print("makeFocusNode:$key");
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
    pagLogic.disposeId(GetBuilderIds.answerPrePage);
    pagLogic.disposeId(GetBuilderIds.answerNextPage);
    onDestroy();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print(tag + "didChangeDependencies\n");
    super.didChangeDependencies();
  }

  // 收回键盘
  void closeKeyBoard() {
    // 触摸收起键盘（方式一）
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus &&currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    // 触摸收起键盘（方式二）
    // FocusScope.of(context).requestFocus(FocusNode());
  }

}


