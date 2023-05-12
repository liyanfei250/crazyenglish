import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/pages/reviews/collect/collect_practic/collect_practic_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/common.dart';
import '../../../base/widgetPage/dialog_manager.dart';
import '../../../entity/commit_request.dart';
import '../../../entity/start_exam.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../answer_interface.dart';
import '../../../entity/week_detail_response.dart';
import '../answering/answering_logic.dart';
import '../answering/select_gap_getxcontroller.dart';
import '../question/choice_question/choice_question_view.dart';
import '../question/question_factory.dart';

/**
 * Time: 2023/4/12 15:11
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */


typedef GetFocusNodeControllerCallback = FocusNode Function(String key);
typedef GetAnswerControllerCallback = String Function(String key);
typedef PageControllerListener = TextEditingController Function(String key);


abstract class BaseQuestionResult extends StatefulWidget with AnswerMixin{
  late BaseQuestionResultState baseQuestionResultState;
  late Map<String,ExerciseLists> subtopicAnswerVoMap;
  BaseQuestionResult(this.subtopicAnswerVoMap, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  BaseQuestionResultState createState() {
    baseQuestionResultState = getState();
    return baseQuestionResultState;
  }

  BaseQuestionResultState getState();

  @override
  getAnswers() {
    baseQuestionResultState.getAnswers();
  }
  void next(){
    baseQuestionResultState.next();
  }
  void pre(){
    baseQuestionResultState.pre();
  }

  void clearFocus(){

  }

  void jumpToQuestion(int index) {
    baseQuestionResultState.jumpToQuestion(index);
  }

  int getQuestionCount(){
    return baseQuestionResultState.getQuestionCount();
  }
}

abstract class BaseQuestionResultState<T extends BaseQuestionResult> extends State<T> with AnswerMixin{
  String curPage = "";
  String tag = "BaseQuestionState_";

  Map<String,TextEditingController> gapEditController = {};
  Map<String,FocusNode> gapFocusNodeController = {};
  Map<String,String> gapAnswerController = {};
  // final PageController pageController = PageController(keepPage: true);

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  List<Widget> questionList = [];
  int currentPage = 0;
  final selectGapGetxController = Get.put(SelectGapGetxController());
  final logic = Get.find<AnsweringLogic>();
  final collectLogic = Get.find<Collect_practicLogic>();

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

  Widget buildFavorAndFeedback(bool isFavor,num? subjectId,{num subtopicId = -1}){
    print("更新");
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: (){
            collectLogic.toCollect(subjectId??0,subtopicId: subtopicId>0? subtopicId:-1);
          },
          child: Image.asset(isFavor? R.imagesExercisesNoteHearingCollected:R.imagesExercisesNoteHearing,width: 48.w,height: 17.w,),
        ),
        Padding(padding: EdgeInsets.only(left: 10.w)),
        InkWell(
          onTap: (){
            RouterUtil.toNamed(AppRoutes.QuestionFeedbackPage,
                arguments: {'isFeedback': false});
          },
          child: Image.asset(R.imagesExerciseNoteFeedback,width: 48.w,height: 17.w),
        )
      ],
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
            "p": QuestionFactory.getHtml_P_TagStyle(),
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
    // if(currentPage< questionList.length-1 && currentPage>=0){
    //   currentPage = currentPage+1;
    //   pageController.jumpToPage(currentPage);
    //   if(currentPage< questionList.length-1){
    //     return true;
    //   }else{
    //     return false;
    //   }
    // }else{
    //   return false;
    // }

  }

  @override
  void pre() {
    // if(currentPage>0){
    //   currentPage = currentPage-1;
    //   pageController.jumpToPage(currentPage);
    //   if(currentPage>0){
    //     return true;
    //   }else{
    //     return false;
    //   }
    // }else{
    //   return false;
    // }
  }

  @override
  void clearFocus(){

  }


  @override
  void jumpToQuestion(int index) {
    currentPage = index;
    // pageController.jumpToPage(currentPage);
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
    // Get.delete<SelectGapGetxController>();
    onDestroy();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print(tag + "didChangeDependencies\n");
    super.didChangeDependencies();
  }


}
