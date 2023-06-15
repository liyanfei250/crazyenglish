import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/r.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;

import '../../../base/AppUtil.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../week_test/week_test_detail/week_test_detail_logic.dart';
import 'preview_exam_paper_logic.dart';
import '../../../entity/test_paper_look_response.dart' as paper;
import 'package:crazyenglish/base/common.dart' as common;

// 作业模式
class PaperMode{
  // 纯预览模式
  static const int Preview = 1;
  // 学生答题模式
  static const int StudentAnswerHomework = 2;
  // 老师批改模式
  static const int TeacherCorrect = 3;
  // 学生结果页模式
  static const int StudentHomeworkResult = 4;
}

/**
 * 试卷预览
 */
class PreviewExamPaperPage extends BasePage {
  static const String PaperType = "PaperType";
  static const String Papermode = "paperMode";
  static const String PaperId = "OperationId";
  static const String ShowAssignHomework = "isShowAssignHomework";
  static const String StudentOperationId = "StudentOperationId";
  static const String OperationClassId = "OperationClassId";
  static const String PaperName = "PaperName";
  late int paperType;
  late int paperMode;
  late int paperId;
  late String paperName = '';
  late bool isShowAssignHomework;
  int? studentOperationId;
  int? operationClassId;
  int? operationId;


  PreviewExamPaperPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      paperType = Get.arguments[PaperType];
      paperMode = Get.arguments[Papermode] ?? PaperMode.Preview;
      paperId = Get.arguments[PaperId];
      isShowAssignHomework = Get.arguments[ShowAssignHomework] ?? false;
      studentOperationId = Get.arguments[StudentOperationId] ?? 0;
      operationClassId = Get.arguments[OperationClassId] ?? 0;
      paperName = Get.arguments[PaperName] ?? '已选试卷';
    } else {
      Get.back();
    }
  }

  @override
  BasePageState<PreviewExamPaperPage> getState() =>
      _PreviewExamPaperPageState();
}

class _PreviewExamPaperPageState extends BasePageState<PreviewExamPaperPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(PreviewExamPaperLogic());
  final state = Get.find<PreviewExamPaperLogic>().state;

  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;

  var isChooseName = "".obs;
  pull.RefreshController _refreshController =
      pull.RefreshController(initialRefresh: false);
  List<paper.Obj> questionList = [];

  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getExamper, () {
      hideLoading();
      questionList.clear();
      questionList.addAll(state.list!);
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
        _refreshController.loadNoData();
        setState(() {});
      }
    });
    _onRefresh();
    showLoading("加载中");
  }

  void _onRefresh() async {
    if (SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)) {
      logic.getPreviewQuestionList(widget.paperType, widget.paperId);
    } else {
      logic.getPreviewOperation(widget.paperId);
    }
  }

  void _onLoading() async {
    if (SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)) {
      logic.getPreviewQuestionList(widget.paperType, widget.paperId);
    } else {
      logic.getPreviewOperation(widget.paperId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      body: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.c_FFFFFFFF,
            centerTitle: true,
            title: Text(
              "试卷预览",
              style: TextStyle(color: AppColors.c_FF32374E, fontSize: 18.sp),
            ),
            leading: Util.buildBackWidget(context),
            // bottom: ,
            elevation: 0,
            actions: [
              //如果不是布置作业进去的就带着题去布置作业
              widget.isShowAssignHomework
                  ? SizedBox.shrink()
                  : SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)
                      ? Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 17.w, right: 22.w),
                          child: InkWell(
                            onTap: () {
                              RouterUtil.toNamed(AppRoutes.AssignHomeworkPage,
                                  arguments: {
                                    "paperType": common.PaperType.exam,
                                    "paperId": widget.paperId.toString(),
                                    "examDesc":
                                        "试卷名称：" + (widget.paperName ?? '')
                                  });
                            },
                            child: Text(
                              "布置作业",
                              style: TextStyle(
                                  fontSize: 14.sp, color: AppColors.c_FFED702D),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
            ],
          ),
          Expanded(
              child: pull.SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: pull.WaterDropHeader(),
                footer: pull.CustomFooter(
                  builder: (BuildContext context, pull.LoadStatus? mode) {
                    Widget body;
                    if (mode == pull.LoadStatus.idle) {
                      body = Text("");
                    } else if (mode == pull.LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == pull.LoadStatus.failed) {
                      body = Text("");
                    } else if (mode == pull.LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: CustomScrollView(
                  slivers: [
                    questionList.length > 0
                        ? SliverPadding(
                            padding: EdgeInsets.only(left: 25.w, right: 25.w),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                buildItem,
                                childCount: questionList.length,
                              ),
                            ))
                        : SliverToBoxAdapter(
                            child: PlaceholderPage(
                                imageAsset: R.imagesCommenNoDate,
                                title: '暂无数据',
                                topMargin: 100.w,
                                subtitle: ''),
                          ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
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
            questionList[index].classifyName ?? '',
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
            itemBuilder: (BuildContext context, int indexs) {
              return listitemSmall(
                  questionList[index].catalogues![indexs], indexs);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1, color: Color(0xffd2d5dc));
            },
            itemCount: questionList[index].catalogues!.length,
          )
        ],
      ),
    );
  }

  Widget listitemSmall(paper.Catalogues smallList, int index) {
    return InkWell(
      onTap: () {
        if(widget.paperMode == PaperMode.StudentAnswerHomework){
          if ((widget.studentOperationId ?? 0) > 0) {
            // 做作业流程
            logicDetail.addJumpToStartHomeworkListen();
            logicDetail.getDetailAndStartHomework(
                smallList.journalCatalogueId ?? "",
                "${widget.studentOperationId}",
                "${widget.operationClassId}",
                "${widget.paperId}",
                enterResult: true
            );
            showLoading("");
          }
        }else if(widget.paperMode == PaperMode.TeacherCorrect){
          logicDetail.addJumpToStartTeacherCorrectionListen();
          logicDetail.getDetailAndStartHomework(
              smallList.journalCatalogueId ?? "",
              "${widget.studentOperationId}",
              "${widget.operationClassId}",
              "${widget.paperId}");
          showLoading("");
        }else if(widget.paperMode == PaperMode.StudentHomeworkResult) {
          logicDetail.addJumpToStartHomeworkListen();
          logicDetail.getDetailAndEnterHomeworkResult(
              smallList.journalCatalogueId ?? "",
              "${widget.studentOperationId}",
              "${widget.operationClassId}",
              "${widget.paperId}",
              enterResult: true
          );
          showLoading("");
        }else{
          // 预览试题流程
          logicDetail.addJumpToBrowsePaperListen();
          logicDetail.getDetailAndEnterBrowsePaperPage(
              smallList.journalCatalogueId ?? "");
          showLoading("");
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
        child: Row(
          children: [
            Expanded(
                child: Text(smallList.catalogueName ?? '',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff353e4d)))),
            SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)
                ? SizedBox.shrink()
                : getStatusWidget(
                    smallList.questionCount, smallList.finishQuestionCount)
          ],
        ),
      ),
    );
  }

  Widget buildSeparatorBuilder(num question) {
    return Container(
      height: 24.w,
      color: Colors.transparent,
    );
  }

  @override
  void dispose() {
    Get.delete<PreviewExamPaperLogic>();
    Get.delete<WeekTestDetailLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {}

  @override
  bool get wantKeepAlive => true;

  Widget getStatusWidget(num? questionCount, num? finishQuestionCount) {
    if (questionCount! > 0 && questionCount == finishQuestionCount) {
      return Container(
        alignment: Alignment.center,
        width: 42.w,
        padding: EdgeInsets.only(top: 4.w, bottom: 4.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffec6b6a),
                Color(0xffee7b8a),
              ]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.w), bottomRight: Radius.circular(7.w)),
        ),
        child: Text(
          '已完成',
          style: TextStyle(fontSize: 10.sp, color: Colors.white),
        ),
      );
    } else {
      return getContainer(finishQuestionCount, questionCount);
    }
    return SizedBox.shrink();
  }

  Container getContainer(num? finishQuestionCount, num? questionCount) {
    return Container(
      width: 42.w,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 4.w, bottom: 4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffd2d5dc),
              Color(0xffd2d5dc),
            ]),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.w),
            bottomRight: Radius.circular(2.w),
            bottomLeft: Radius.circular(2.w),
            topRight: Radius.circular(2.w)),
      ),
      child: Text(
        (finishQuestionCount ?? 0).toString() +
            "/" +
            (questionCount ?? 0).toString(),
        style: TextStyle(fontSize: 10.sp, color: Colors.white),
      ),
    );
  }
}
