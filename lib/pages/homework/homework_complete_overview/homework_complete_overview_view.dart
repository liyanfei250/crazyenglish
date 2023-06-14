import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/homework/school_report_list/school_report_list_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_detail/week_test_detail_logic.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../entity/HomeworkHistoryResponse.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/colors.dart';
import 'homework_complete_overview_logic.dart';
import 'package:crazyenglish/base/common.dart' as common;
import '../../../entity/test_paper_look_response.dart' as paper;

/**
 * 作业完成情况概览
 */
class HomeworkCompleteOverviewPage extends BasePage {
  static const String HistoryItem = "history";
  static const String Status = "remindCorrectionHistory";
  static const String IsAssignHomework = "isAssignHomework";

  late History history;
  bool isAssignHomework = false;

  HomeworkCompleteOverviewPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      history = Get.arguments[HistoryItem] ?? false;
      isAssignHomework = Get.arguments[IsAssignHomework] ?? false;
    }
  }

  @override
  BasePageState<HomeworkCompleteOverviewPage> getState() =>
      _HomeworkCompleteOverviewPageState();
}

class _HomeworkCompleteOverviewPageState
    extends BasePageState<HomeworkCompleteOverviewPage> {
  final logic = Get.put(HomeworkCompleteOverviewLogic());
  final state = Get.find<HomeworkCompleteOverviewLogic>().state;
  List<paper.Obj> questionList = [];
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("作业完成情况"),
      backgroundColor: AppColors.c_FFF8F9FB,
      body: Container(
        margin: EdgeInsets.only(top: 24.w, left: 18.w, right: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 20.w,
                  width: 48.w,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: AppColors.c_FFFCEFD8,
                    width: 5.w,
                  ))),
                ),
                Container(
                  height: 20.w,
                  child: Text(
                    "${widget.history.name}",
                    style: TextStyle(
                        color: AppColors.c_FF353E4D,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            widget.isAssignHomework
                ? SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.only(top: 24.w),
                    padding: EdgeInsets.only(
                        left: 27.w, right: 27.w, top: 13.w, bottom: 19.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(7.w)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffe3edff).withOpacity(0.5), // 阴影的颜色
                          offset: Offset(0.w, 0.w), // 阴影与容器的距离
                          blurRadius: 10.w, // 高斯的标准偏差与盒子的形状卷积。
                          spreadRadius: 0.w,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${widget.history.studentCompleteSize ?? '0'}",
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          color: AppColors.c_FF353E4D,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "/${widget.history.studentTotalSize ?? '0'}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.c_FF353E4D),
                                    ),
                                  ],
                                ),
                                Text(
                                  "完成人数",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.c_FF898A93),
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${widget.history.accuracy ?? '0'}",
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          color: AppColors.c_FF353E4D,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "%",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.c_FF353E4D),
                                    ),
                                  ],
                                ),
                                Text(
                                  "正确率",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.c_FF898A93),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 0.4.w,
                          margin: EdgeInsets.only(top: 9.w, bottom: 26.w),
                          color: AppColors.c_FFD2D5DC,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                RouterUtil.toNamed(
                                    AppRoutes.SchoolReportListPage,
                                    arguments: {
                                      HomeworkCompleteOverviewPage.HistoryItem:
                                          widget.history,
                                      SchoolReportListPage.listType:SchoolReportListPage.scoreList
                                    });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    R.imagesIconSchoolReport,
                                    width: 20.w,
                                    height: 20.w,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8.w)),
                                  Text(
                                    "成绩单",
                                    style: TextStyle(
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.c_FF353E4D),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 0.4.w,
                              height: 18.w,
                              color: AppColors.c_FFD2D5DC,
                            ),
                            InkWell(
                              onTap: () {
                                RouterUtil.toNamed(
                                    AppRoutes.ClassPractiseReportPage,arguments: {HomeworkCompleteOverviewPage.HistoryItem: widget.history});
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    R.imagesIconPractiseReport,
                                    width: 20.w,
                                    height: 20.w,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8.w)),
                                  Text(
                                    "练习报告",
                                    style: TextStyle(
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.c_FF353E4D),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return listitem(questionList[index], index);
              },
              itemCount: questionList.length,
            )),
            SizedBox(
              height: 20.w,
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(String title, String name) {
    return Container(
      height: 44.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff353e4d)),
          ),
          Container(
            width: 44.w,
            height: 15.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffec8a6b),
                    Color(0xffeea47b),
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(2.w)),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 8.sp,
                color: AppColors.c_FFFFFFFF,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<HomeworkCompleteOverviewLogic>();
    Get.delete<WeekTestDetailLogic>();
    super.dispose();
  }

  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getExamper, () {
      hideLoading();
      questionList.clear();
      questionList.addAll(state.list!);
      if (mounted && state.list != null) {
        setState(() {});
      }
    });
    logic.getPreviewQuestionList(
        common.PaperType.HistoryHomework, widget.history!.operationId!.toInt());
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  Widget listitem(paper.Obj bigList, int index) {
    return Container(
      margin: EdgeInsets.only(top: 24.w),
      padding: EdgeInsets.only(left: 17.w, right: 17.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(7.w)),
        boxShadow: [
          BoxShadow(
            color: Color(0xffe3edff).withOpacity(0.5), // 阴影的颜色
            offset: Offset(0.w, 0.w), // 阴影与容器的距离
            blurRadius: 10.w, // 高斯的标准偏差与盒子的形状卷积。
            spreadRadius: 0.w,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.w,
          ),
          Text(
            bigList.classifyName ?? '',
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff898a93)),
          ),
          SizedBox(
            height: 11.w,
          ),
          Divider(height: 1, color: Color(0xffd2d5dc)),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return listitemSmall(bigList.catalogues![index], index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1, color: Color(0xffd2d5dc));
            },
            itemCount: bigList.catalogues!.length,
          )
        ],
      ),
    );
  }

  Widget listitemSmall(paper.Catalogues smallList, int index) {
    return InkWell(
      onTap: () {
        // if ((widget.studentOperationId ?? 0) > 0) {
        //   // 做作业流程
        //   logicDetail.addJumpToStartHomeworkListen();
        //   logicDetail.getDetailAndStartHomework(value.journalCatalogueId ?? "",
        //       "${widget.studentOperationId}", "${widget.paperId}");
        //   showLoading("");
        // } else {
        // 预览试题流程
        logicDetail.addJumpToBrowsePaperListen();
        logicDetail.getDetailAndEnterBrowsePaperPage(
            smallList.journalCatalogueId ?? "");
        showLoading("");
        // }
      },
      child: Container(
        padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
        child: Text(smallList.catalogueName ?? '',
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff353e4d))),
      ),
    );
  }
}
