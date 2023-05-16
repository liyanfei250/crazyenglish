import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/HomeworkExamPaperResponse.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;
import '../../../base/common.dart' as common;
import '../../../base/AppUtil.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../assign_homework/assign_homework_logic.dart';
import '../base_choose_page_state.dart';
import '../choose_logic.dart';
import 'choose_exam_paper_logic.dart';

class ChooseExamPaperPage extends BasePage {
  bool isAssignHomework = false;
  static const String IsAssignHomework = "isAssignHomework";

  ChooseExamPaperPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isAssignHomework = Get.arguments[IsAssignHomework] ?? false;
    }
  }

  @override
  BasePageState<BasePage> getState() => _ChooseExamPaperPageState();
}

class _ChooseExamPaperPageState
    extends BaseChoosePageState<ChooseExamPaperPage, Records> {
  final logic = Get.put(ChooseExamPaperLogic());
  final state = Get.find<ChooseExamPaperLogic>().state;

  pull.RefreshController _refreshController =
      pull.RefreshController(initialRefresh: false);
  AssignHomeworkLogic? assignLogic;

  final int pageSize = 20;
  int currentPageNo = 1;
  List<Records> exampapers = [];
  final int pageStartIndex = 1;

  @override
  void onCreate() {
    if(widget.isAssignHomework){
      assignLogic = Get.find<AssignHomeworkLogic>();
    }
    currentKey.value = "0";

    logic.addListenerId(GetBuilderIds.getExampersList, () {
      hideLoading();
      if (state.list != null) {
        if (state.pageNo == currentPageNo + 1) {
          exampapers.addAll(state!.list!);
          currentPageNo++;
          if (mounted && _refreshController != null) {
            _refreshController.loadComplete();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }

            addData(currentKey.value, state!.list!);
            setState(() {});
          }
        } else if (state.pageNo == pageStartIndex) {
          currentPageNo = pageStartIndex;
          exampapers.clear();
          exampapers.addAll(state.list!);
          if (mounted && _refreshController != null) {
            _refreshController.refreshCompleted();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            resetData(currentKey.value, state!.list!);
            setState(() {});
          }
        }
      }
    });
    _onRefresh();
    showLoading("加载中");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text(
          "个人试卷库",
          style: TextStyle(color: AppColors.c_FF353E4D, fontSize: 18.sp),
        ),
        leading: Util.buildBackWidget(context),
        elevation: 0,
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 18.w),
            child: Visibility(
              visible: widget.isAssignHomework,
              child: InkWell(
                onTap: () {
                  // RouterUtil.toNamed(AppRoutes.IntensiveListeningPage);
                  if (widget.isAssignHomework) {
                    int totalNum = 0;
                    List<Records> historys = [];
                    dataList.forEach((key, value) {
                      if (value != null) {
                        for (Records n in value!) {
                          String id = getDataId(key, n);
                          if (isSelectedMap[key] != null &&
                              (isSelectedMap[key]![id] ?? false)) {
                            historys.add(n);
                          }
                        }
                      }
                    });
                    if (historys.isNotEmpty) {
                      assignLogic!.updateAssignHomeworkRequest(
                          paperType: common.PaperType.exam,
                          paperId: historys[0].id?.toString(),
                          examDesc: "试卷名称："+(historys[0].name ?? ''));
                    } else {
                      assignLogic!.updateAssignHomeworkRequest(
                        paperType: -1,
                      );
                    }
                    Get.back();
                  }
                },
                child: Text(
                  "确定",
                  style:
                      TextStyle(color: AppColors.c_FFED702D, fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ],
      ),
      body: pull.SmartRefresher(
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
            SliverPadding(
              padding: EdgeInsets.only(top: 4.w, bottom: 14.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  buildItem,
                  childCount: exampapers.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getExampersList(SpUtil.getString(BaseConstant.USER_ID),
        pageStartIndex, pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getExampersList(SpUtil.getString(BaseConstant.USER_ID),currentPageNo + 1, pageSize);
  }

  Widget buildItem(BuildContext context, int index) {
    Records exampaper = exampapers[index];

    return Container(
      margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 24.w),
      padding: EdgeInsets.only(left: 27.w, right: 27.w, top: 3.w, bottom: 12.w),
      width: double.infinity,
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
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: widget.isAssignHomework,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.w)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<ChooseLogic>(
                        id: GetBuilderIds.updateCheckBox + currentKey.value,
                        builder: (logic) {
                          return Util.buildCheckBox(() {
                            selectSingle(currentKey.value,exampaper);
                          },
                              chooseEnable:
                                  isDataSelected(currentKey.value, exampaper));
                        },
                      ),
                      InkWell(
                        onTap: () {
                          RouterUtil.toNamed(AppRoutes.PreviewExamPaperPage);
                        },
                        child: Image.asset(
                          R.imagesExamPaperBrowse,
                          width: 51.w,
                          height: 19.w,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 14.w, bottom: 6.w),
                    width: double.infinity,
                    height: 0.2.w,
                    color: AppColors.c_FFD2D5DC,
                  ),
                ],
              )),
          InkWell(
            onTap: () {
              RouterUtil.toNamed(AppRoutes.PreviewExamPaperPage);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLineItem(R.imagesExamPaperName, "试卷名称：${exampaper.name}"),
                buildLineItem(R.imagesExamPaperTiCount, "题目数量：85道"),
                buildLineItem(R.imagesExamPaperTiType, "试题类型：听力、阅读、写作"),
                buildLineItem(R.imagesExamPaperTime, "组卷时间：2023年03月21日"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLineItem(String img, String text) {
    return Container(
      height: 38.w,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            img,
            width: 16.w,
            height: 16.w,
          ),
          Padding(padding: EdgeInsets.only(left: 9.w)),
          Text(
            text,
            style: TextStyle(
              color: AppColors.c_FF353E4D,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ChooseExamPaperLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  String getDataId(String key, Records n) {
    assert(n.id != null);
    return n.id!.toString();
  }
}
