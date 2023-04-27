import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/entity/commit_request.dart';
import 'package:crazyenglish/pages/practise/question_factory.dart';
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
typedef UserAnswerCallback = void Function(SubtopicAnswerVo subtopicAnswerVo);

abstract class BaseQuestion extends StatefulWidget{
  late BaseQuestionState baseQuestionState;
  late SubjectVoList data;
  late Map<String,ExerciseLists> subtopicAnswerVoMap;
  late int answerType;
  BaseQuestion(this.subtopicAnswerVoMap,this.answerType,{required this.data,Key? key}) : super(key: key);

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
  final PageController pageController = PageController(keepPage: true);

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  List<Widget> questionList = [];
  final selectGapGetxController = Get.put(SelectGapGetxController());
  final logic = Get.find<AnsweringLogic>();
  final pagLogic = Get.find<PageGetxController>();

  @override
  void initState(){
    super.initState();
    onCreate();

    tag = tag+curPage;
    print(tag + "initState\n");
    pagLogic.addListenerId(GetBuilderIds.answerPrePage,() {
      pre();
    });
    pagLogic.addListenerId(GetBuilderIds.answerNextPage,() {
      next();
    });
  }


  @override
  bool get mounted {
    print(tag + "mounted\n");
    return super.mounted;
  }

  Widget buildQuestionType(String name){
    return Container(
      height: 22.w,
      margin: EdgeInsets.only(top:14.w,bottom: 10.w),
      padding: EdgeInsets.only(left:2.w,right:2.w),
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

        if(element.questionTypeStr == QuestionType.single_choice
            || element.questionTypeStr == QuestionType.complete_filling
            || element.questionTypeStr == QuestionType.normal_reading){
          // 选择题
          itemList.add(buildQuestionType("选择题"));
          itemList.add(Visibility(
            visible: question!.problem != null && question!.problem!.isNotEmpty,
            child: Text(
              question!.problem!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),));
          bool isClickEnable = true;
          int defaultChooseIndex = -1;
          // 找到上次作答记录 或者 错题本正确题目答案
          if(widget.subtopicAnswerVoMap!=null
              && widget.subtopicAnswerVoMap.containsKey("${question.id}")){
            ExerciseLists exerciseLists = widget.subtopicAnswerVoMap["${question.id}"]!;
            if(question.optionsList!=null &&
                exerciseLists.answer!=null &&
                exerciseLists.answer!.isNotEmpty){
              for(int i = 0; i< question.optionsList!.length;i++){
                if(exerciseLists.answer == question.optionsList![i].sequence){
                  defaultChooseIndex = i;
                }
              }
            }
          }
          if(widget.answerType == AnsweringPage.answer_fix_type){
            if(widget.subtopicAnswerVoMap!=null
                && widget.subtopicAnswerVoMap.containsKey("${question.id}")){
              isClickEnable = false;
            }
          } else if(widget.answerType == AnsweringPage.answer_normal_type){
            defaultChooseIndex = -1;
          }

          // TODO 判断是否是图片选择题的逻辑需要修改
          if(question.optionsList![0].content!.isNotEmpty){
            itemList.add(QuestionFactory.buildSingleTxtChoice(question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseIndex));
          } else {
            itemList.add(QuestionFactory.buildSingleImgChoice(question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseIndex));
          }
        }else if(element.questionTypeStr == QuestionType.multi_choice){

        }else if(element.questionTypeStr == QuestionType.judge_choice){

        }else if(element.questionTypeStr == QuestionType.normal_gap) {
          itemList.add(buildQuestionType("填空题"));
          itemList.add(buildReadQuestion(element.content ?? ""));
          itemList.add(QuestionFactory.buildNarmalGapQuestion(
              question, 0, makeEditController));
        }else if(element.questionTypeStr == QuestionType.question_reading){

        }
        // else if(element.questionTypeStr == QuestionType.correction_question){
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
      logic.updateCurrentPage(0,totalQuestion:questionList.length);
    }
    return PageView(
      controller: pageController,
      physics: _neverScroll,
      onPageChanged: (int value){
        if(logic!=null){
          logic.updateCurrentPage(value,totalQuestion:questionList.length);
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
  void next() {
    if(logic.state.currentQuestionNum< logic.state.totalQuestionNum){
      int currentPage = logic.state.currentQuestionNum;
      currentPage = currentPage+1;
      jumpToQuestion(currentPage);
    }
  }

  @override
  void pre() {
    int currentPage = logic.state.currentQuestionNum;
    if(currentPage>0){
      currentPage = currentPage-1;
      jumpToQuestion(currentPage);
    }
  }


  @override
  void clearFocus(){

  }


  @override
  void jumpToQuestion(int index) {
    int currentPage = index;
    pageController.jumpToPage(currentPage);
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

  void userAnswerCallback(SubtopicAnswerVo subtopicAnswerVo){
    logic.updateUserAnswer((subtopicAnswerVo.subtopicId??1).toString(), subtopicAnswerVo);
  }

  FocusNode makeFocusNodeController(String key){
    if(gapFocusNodeController[key] == null){
      FocusNode focusNode = FocusNode();
      print("makeFocusNode:$key");
      focusNode.addListener(() {
        if(focusNode.hasFocus){
          print("makeFocusNode:$key has focus");
        }else{
          print("makeFocusNode:$key not has focus");
        }
      });
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


