import 'dart:async';

import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/practise/question/choise_question.dart';
import 'package:crazyenglish/pages/practise/question/fix_article_question.dart';
import 'package:crazyenglish/pages/practise/question/listen_question.dart';
import 'package:crazyenglish/pages/practise/question/read_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/week_test_detail_response.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../question/gap_question.dart';
import 'answering_logic.dart';

class AnsweringPage extends BasePage {

  WeekTestDetailResponse? testDetailResponse;

  AnsweringPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      testDetailResponse = Get.arguments["detail"];
    }
  }

  @override
  BasePageState<BasePage> getState() {
    // TODO: implement getState
    return _AnsweringPageState();
  }
}

class _AnsweringPageState extends BasePageState<AnsweringPage> {
  final logic = Get.put(AnsweringLogic());
  final state = Get.find<AnsweringLogic>().state;
  bool isCountTime = true;
  late Timer _timer;
  var countTime = 0.obs;

  List<Widget> pages = <Widget>[];

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  var _selectedIndex = 0.obs;
  final PageController pageController = PageController(keepPage: true);

  @override
  void onCreate() {
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    pages = buildQuestionList(widget.testDetailResponse!);
    return Scaffold(
      appBar: AppBar(
        title: Text("标题",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp,fontWeight: FontWeight.bold),),
        leading: Util.buildBackWidget(context),
        actions: [
          Visibility(
              visible: isCountTime,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(R.imagesPractiseCountTimeIcon,width: 18.w,height: 18.w,),
                  Padding(padding: EdgeInsets.only(left: 6.w)),
                  Obx(()=>Text("$countTime",style: TextStyle(fontSize: 14.w,color: AppColors.c_FF353E4D),))
                ],
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Flexible(
            child: PageView(
              controller: pageController,
              physics: _neverScroll,
              children: pages,
            ),
          )),
          Container(
            margin: EdgeInsets.only(left: 66.w,right: 66.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){

                  },
                  child: Image.asset(R.imagesPractisePreQuestionEnable,width: 40.w,height: 40.w,),
                ),
                Text(
                  "1/5",
                  style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold,color: AppColors.c_FF353E4D),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Image.asset(R.imagesPractiseNextQuestionEnable,width: 40.w,height: 40.w,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildQuestionList(WeekTestDetailResponse weekTestDetailResponse){
    List<Widget> questionList = [];
    if(weekTestDetailResponse.data!=null){
      weekTestDetailResponse.data!.forEach((element) {
        switch(element.questionType){
          case 1: // 听力题
            questionList.add(ListenQuestion(data: element,));
            break;
          case 2: // 选择题
            questionList.add(ChoiseQuestion(data: element,));
            break;
          case 3: // 填空题
            questionList.add(GapQuestion(data: element,));
            break;
          case 4: // 阅读题
            questionList.add(ReadQuestion(data: element,));
            break;
          case 5: // 纠错
            questionList.add(FixArticleQuestion(data: element,));
        }
      });
    }
    return questionList;
  }

  startTimer(){
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      countTime++;
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }


  @override
  void onDestroy() {
    cancelTimer();
    Get.delete<AnsweringLogic>();
  }

}