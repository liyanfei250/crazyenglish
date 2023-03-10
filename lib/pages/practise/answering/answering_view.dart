import 'dart:async';

import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/commit_request.dart';
import 'package:crazyenglish/pages/practise/question/choise_question.dart';
import 'package:crazyenglish/pages/practise/question/fix_article_question.dart';
import 'package:crazyenglish/pages/practise/question/listen_question.dart';
import 'package:crazyenglish/pages/practise/question/read_question.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/week_detail_response.dart' as detail;
import '../../../entity/week_test_detail_response.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../question/base_question.dart';
import '../question/gap_question.dart';
import 'answering_logic.dart';

class AnsweringPage extends BasePage {
  detail.WeekDetailResponse? testDetailResponse;
  var uuid;

  AnsweringPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      testDetailResponse = Get.arguments["detail"];
      uuid = Get.arguments["error_uuid"];
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
  final state = Get
      .find<AnsweringLogic>()
      .state;
  bool isCountTime = true;
  late Timer _timer;
  var countTime = 0.obs;

  List<BaseQuestion> pages = <BaseQuestion>[];

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  var _selectedIndex = 0.obs;
  final PageController pageController = PageController(keepPage: true);

  var canPre = false.obs;
  var canNext = true.obs;
  String initPageNum = "";
  bool isUseData = true;

  @override
  void onCreate() {
    startTimer();
    logic.addListenerId(GetBuilderIds.answerPageInitNum, () {
      initPageNum = state.pageChangeStr;
    });

    logic.addListenerId(GetBuilderIds.commitAnswer, () {
      RouterUtil.offAndToNamed(
          AppRoutes.ResultPage,arguments: {"detail":state.commitRequest});
    });
  }

  @override
  Widget build(BuildContext context) {
    pages = buildQuestionList(widget.testDetailResponse!);
    bool isTitleNull = false;
    if (widget.testDetailResponse?.data == null ||
        widget.testDetailResponse?.data?.length! == 0) {
      isTitleNull = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isTitleNull ? "" :widget.testDetailResponse!.data![0].title.toString(),
          style: TextStyle(
              color: AppColors.c_FF32374E,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        leading: Util.buildBackWidget(context),
        actions: [
          Visibility(
              visible: isCountTime,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    R.imagesPractiseCountTimeIcon,
                    width: 18.w,
                    height: 18.w,
                  ),
                  Padding(padding: EdgeInsets.only(left: 6.w)),
                  Obx(() =>
                      Text(
                        "$countTime",
                        style: TextStyle(
                            fontSize: 14.w, color: AppColors.c_FF353E4D),
                      ))
                ],
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery
                  .of(context)
                  .size
                  .height -
                  AppBar().preferredSize.height -
                  MediaQuery
                      .of(context)
                      .padding
                      .top),
          child: isUseData ? useDataArray(pages[0]) : useOptionArray(pages),
        ),
      ),
    );
  }

  Widget useDataArray(BaseQuestion page) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            child: page,
          ),
        ),
        Container(
          margin:
          EdgeInsets.only(left: 66.w, right: 66.w, top: 10.w, bottom: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  canPre.value = page.pre();
                  if (canPre.value) {
                    canNext.value = true;
                  }
                },
                child: Obx(() =>
                    Image.asset(
                      canPre.value
                          ? R.imagesPractisePreQuestionEnable
                          : R.imagesPractisePreQuestionUnable,
                      width: 40.w,
                      height: 40.w,
                    )),
              ),
              GetBuilder<AnsweringLogic>(
                  id: GetBuilderIds.answerPageNum,
                  builder: (logic) {
                    return Text(
                      logic.state.pageChangeStr ?? " ",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.c_FF353E4D),
                    );
                  }),
              InkWell(
                onTap: () {
                  canNext.value = page.next();
                  if (canNext.value) {
                    canPre.value = true;
                  } else {
                    RouterUtil.toNamed(AppRoutes.ResultPage,
                        arguments: {"detail": widget.testDetailResponse});
                  }
                },
                child: Obx(() =>
                    Image.asset(
                      canNext.value
                          ? R.imagesPractiseNextQuestionEnable
                          : R.imagesPractiseNextQuestionUnable,
                      width: 40.w,
                      height: 40.w,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget useOptionArray(List<BaseQuestion> pages) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            child: pages[0],
          ),
        ),
        Container(
          margin:
          EdgeInsets.only(left: 66.w, right: 66.w, top: 10.w, bottom: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  bool beforeCan = canPre.value;
                  canPre.value = pages[0].pre();
                  if (beforeCan && !canPre.value) {
                    canNext.value = true;
                  }
                },
                child: Obx(() =>
                    Image.asset(
                      canPre.value
                          ? R.imagesPractisePreQuestionEnable
                          : R.imagesPractisePreQuestionUnable,
                      width: 40.w,
                      height: 40.w,
                    )),
              ),
              GetBuilder<AnsweringLogic>(
                  id: GetBuilderIds.answerPageNum,
                  builder: (logic) {
                    return Text(
                      logic.state.pageChangeStr ?? " ",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.c_FF353E4D),
                    );
                  }),
              InkWell(
                onTap: (){
                  if(canNext.value == false){
                    Get.defaultDialog(
                      title: "",
                      textConfirm: "确定",
                      textCancel: "取消",
                      content: Text("是否确定提交答案"),
                      onConfirm:(){
                        CommitRequest commitRequest = CommitRequest(
                            muchTime: "2023-02-23 02:20:01",
                            name: "测试",
                            directory: "1cddffb0-bcef-11ed-8e11-530450f105f5",
                            directory_uuid: "1cddffb0-bcef-11ed-8e11-530450f105f5",
                          exercises: widget.testDetailResponse!.data
                        );
                        logic.uploadWeekTest(commitRequest);
                        Get.back();
                      }
                    );
                  }else{
                    canNext.value = pages[0].next();
                    canPre.value = true;
                  }
                },
                child: Obx(() =>
                    Image.asset(
                      canNext.value
                          ? R.imagesPractiseNextQuestionEnable
                          : R.imagesPractiseNextQuestionUnable,
                      width: 40.w,
                      height: 40.w,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }

  List<BaseQuestion> buildQuestionList(
      detail.WeekDetailResponse weekTestDetailResponse) {
    List<BaseQuestion> questionList = [];
    if (weekTestDetailResponse.data != null) {
      int length = weekTestDetailResponse.data!.length;

      for (detail.Data element in weekTestDetailResponse.data!) {
        switch (element.type) {
          case 1: // 听力题
            questionList.add(ListenQuestion(data: element));
            isUseData = false;
            break;
          case 2: // 阅读题
            if (element.typeChildren == 7) {
              // 写作题
              isUseData = false;
            } else {
              questionList.add(ReadQuestion(data: element));
              isUseData = false;
            }
            break;
          case 3: // 语言综合训练
            if (element.typeChildren == 1) {
              // 单项选择题
              questionList
                  .add(ChoiseQuestion(datas: weekTestDetailResponse.data!));
              isUseData = true;
              return questionList;
            } else if (element.typeChildren == 2) {
              // 补全对话
              questionList.add(ReadQuestion(data: element));
              isUseData = false;
            } else if (element.typeChildren == 3){
              // 完型填空
              questionList.add(ReadQuestion(data: element));
              isUseData = false;
            }
            break;
          case 4: // 写作题
            if (element.typeChildren == 7) {
              // 写作题
              isUseData = false;
            }
            break;
        }
        if (!isUseData) {
          break;
        }
      }
    }
    return questionList;
  }

  startTimer() {
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
