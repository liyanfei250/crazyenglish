import 'package:bot_toast/bot_toast.dart';
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
typedef UserAnswerCallback = void Function(SubtopicAnswerVo subtopicAnswerVo);

abstract class BaseQuestion extends StatefulWidget{
  late BaseQuestionState baseQuestionState;
  late SubjectVoList data;
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
  late PageController pageController;

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
    pageController = PageController(keepPage: true,initialPage: widget.childIndex);
    tag = tag+curPage;
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

        if(element.questionTypeStr == QuestionType.single_choice
            || element.questionTypeStr == QuestionType.complete_filling
            || element.questionTypeStr == QuestionType.normal_reading
            || element.questionTypeStr == QuestionType.multi_choice
            || element.questionTypeStr == QuestionType.judge_choice){
          // 选择题
          itemList.add(buildQuestionType("选择题"));
          itemList.add(Visibility(
            visible: question!.problem != null && question!.problem!.isNotEmpty,
            child: Text(
              "${question!.problem}",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),));
          bool isClickEnable = true;
          String defaultChooseAnswers = "";
          // 找到上次作答记录 或者 错题本正确题目答案
          num subjectId = element.id??0;
          num subtopicId = question.id??0;
          if(widget.subtopicAnswerVoMap!=null
              && widget.subtopicAnswerVoMap.containsKey("$subjectId:$subtopicId")){
            ExerciseLists exerciseLists = widget.subtopicAnswerVoMap["$subjectId:$subtopicId"]!;
            if(question.optionsList!=null &&
                exerciseLists.answer!=null &&
                exerciseLists.answer!.isNotEmpty){
              for(int i = 0; i< question.optionsList!.length;i++){
                if(exerciseLists.answer!.contains("${question.optionsList![i].sequence}")){
                  defaultChooseAnswers = "$defaultChooseAnswers+${question.optionsList![i].sequence}";
                }
              }
            }
          }
          if(widget.answerType == AnsweringPage.answer_fix_type){
            if(widget.subtopicAnswerVoMap!=null
                && widget.subtopicAnswerVoMap.containsKey("$subjectId:$subtopicId")){
              isClickEnable = false;
            }
          } else if(widget.answerType == AnsweringPage.answer_normal_type){
            defaultChooseAnswers = "";
          }

          if(element.questionTypeStr == QuestionType.multi_choice){
            if((question.optionsList![0].content??"").isNotEmpty){
              itemList.add(ChoiceQuestionPage(question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isMulti:true));
            } else {
              itemList.add(ChoiceQuestionPage(question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isMulti:true,isImgChoice: true,));
            }
          }else if(element.questionTypeStr == QuestionType.judge_choice){
            itemList.add(ChoiceQuestionPage(question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isJudge:true));
          }else{
            // TODO 判断是否是图片选择题的逻辑需要修改
            if((question.optionsList![0].content??"").isNotEmpty){
              itemList.add(ChoiceQuestionPage(question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isMulti:false));
            } else {
              itemList.add(ChoiceQuestionPage(question,isClickEnable,false,userAnswerCallback: userAnswerCallback,defaultChooseIndex: defaultChooseAnswers,isMulti:false,isImgChoice: true));
            }
          }

        }else if(element.questionTypeStr == QuestionType.normal_gap) {
          itemList.add(buildQuestionType("填空题"));
          // itemList.add(buildReadQuestion(element.content ?? ""));
          itemList.add(QuestionFactory.buildNarmalGapQuestion(
              question, 0, makeEditController));
        }else if(element.questionTypeStr == QuestionType.question_reading){
          itemList.add(buildQuestionType("填空"));
          itemList.add(Visibility(
            visible: question!.problem != null && question!.problem!.isNotEmpty,
            child: Text(
              question!.problem!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),));
          itemList.add(Padding(
            padding: EdgeInsets.only(top: 18.w),
          ));
          itemList.add(QuestionFactory.buildShortAnswerQuestion(element.id!.toInt(),question,1,widget.subtopicAnswerVoMap,null,this,userAnswerCallback: userAnswerCallback));
        } else if(element.questionTypeStr == QuestionType.translate_question){
          itemList.add(buildQuestionType("填空"));
          itemList.add(Text("英汉互译",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 18.sp)));
          itemList.add(Padding(padding: EdgeInsets.only(top: 30.w),));
          itemList.add(Row(
            children: [
              Text("原文",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp),),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Expanded(child: Container(
                height: 44.w,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(7.w)),
                  border: Border.all(
                      width: 1.w,
                      color: AppColors.c_FFB4B9C6,
                      style: BorderStyle.solid
                  ),
                ),
                child: Text("${question.problem}",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp),),
              ))
            ],
          ));
          itemList.add(Padding(padding: EdgeInsets.only(top: 16.w),));
          itemList.add(Row(
            children: [
              Text("译文",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp)),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Expanded(child: QuestionFactory.buildShortAnswerQuestion(element.id!.toInt(),question,1,widget.subtopicAnswerVoMap,null,this,userAnswerCallback: userAnswerCallback))
            ],
          ));
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
      print("call updateCurrentPage getQuestionDetail");
      logic.updateCurrentPage(widget.childIndex,totalQuestion:questionList.length,isInit: true);
    }
    selectGapGetxController.disposeId(GetBuilderIds.updateFocus+"isInit");
    selectGapGetxController.disposeId(GetBuilderIds.updateFocus);
    return PageView(
      controller: pageController,
      physics: _neverScroll,
      pageSnapping: false,
      onPageChanged: (int value){
        // if(logic!=null){
        //   logic.updateCurrentPage(value,totalQuestion:questionList.length);
        // }
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
    if(pageController.hasClients){
      pageController.jumpToPage(currentPage);
    }
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

  void userAnswerCallback(SubtopicAnswerVo subtopicAnswerVo){
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
    Get.delete<SelectGapGetxController>();
    if(pageController.hasClients){
      pageController.dispose();
    }
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


