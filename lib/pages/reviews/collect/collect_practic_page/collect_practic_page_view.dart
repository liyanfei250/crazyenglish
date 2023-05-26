import 'dart:async';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/blocs/refresh_bloc_bloc.dart';
import 'package:crazyenglish/blocs/refresh_bloc_event.dart';
import 'package:crazyenglish/blocs/refresh_bloc_state.dart';
import 'package:crazyenglish/blocs/update_collect_bloc.dart';
import 'package:crazyenglish/blocs/update_collect_event.dart';
import 'package:crazyenglish/blocs/update_collect_state.dart';
import 'package:crazyenglish/pages/practise/answering/answering_view.dart';
import 'package:crazyenglish/pages/week_test/week_test_detail/week_test_detail_logic.dart';
import 'package:crazyenglish/r.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../entity/review/SearchCollectListDate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'collect_practic_page_logic.dart';

class CollectPracticPageViewPage extends BasePage {
  bool isRecentView = false;
  dynamic classify = null;

  CollectPracticPageViewPage(this.isRecentView, this.classify, {Key? key})
      : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<CollectPracticPageViewPage> {
  final logic = Get.put(Collect_practic_pageLogic());
  final state = Get.find<Collect_practic_pageLogic>().state;
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;
  List<Obj> weekPaperList = [];
  refresh.RefreshController _refreshController =
      refresh.RefreshController(initialRefresh: false);
  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;

  StreamSubscription? refrehUserInfoStreamSubscription;
  @override
  void loginChanged() {
    setState(() {});
  }

  @override
  void onCreate() {
    refrehUserInfoStreamSubscription = BlocProvider.of<UpdateCollectBloc>(context).stream.listen((event) {
      print("Collect ========== bef event");
      if (event is CollectChangeSuccess) {
        print("Collect ========== event");
        if (logic != null && SpUtil.getInt(BaseConstant.USER_ID) > 0) {
          _onRefresh();
        }
      }
    });

    //收藏列表
    logic.addListenerId(
        GetBuilderIds.getCollectListDate +
            widget.isRecentView.toString() +
            widget.classify.toString(), () {
      hideLoading();
      if (state.paperList != null) {
        if (state.pageNo == currentPageNo + 1) {
          weekPaperList = state.paperList!;
          currentPageNo++;
          weekPaperList.addAll(state.paperList!);
          if (mounted && _refreshController != null) {
            _refreshController.loadComplete();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            setState(() {});
          }
        } else if (state.pageNo == pageStartIndex) {
          currentPageNo = pageStartIndex;
          weekPaperList.clear();
          weekPaperList.addAll(state.paperList!);
          if (mounted && _refreshController != null) {
            _refreshController.refreshCompleted();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            setState(() {});
          }
        }
      }
    });

    //收藏
    logic.addListenerId(GetBuilderIds.toCollectDate, () {
      // Util.toast('成功或者取消');
      _onRefresh();
    });
    _onRefresh();
    showLoading('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: refresh.SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: refresh.WaterDropHeader(),
        footer: refresh.CustomFooter(
          builder: (BuildContext context, refresh.LoadStatus? mode) {
            Widget body;
            if (mode == refresh.LoadStatus.idle) {
              body = Text("");
            } else if (mode == refresh.LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == refresh.LoadStatus.failed) {
              body = Text("");
            } else if (mode == refresh.LoadStatus.canLoading) {
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
            weekPaperList.length == 0
                ? SliverToBoxAdapter(
                    child: PlaceholderPage(
                        imageAsset: R.imagesCommenNoDate,
                        title: '暂无数据',
                        topMargin: 100.w,
                        subtitle: '快去做题吧'))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      buildItem,
                      childCount: weekPaperList.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget listitemBigBg(Obj weekPaperList) {
    return Container(
      margin: EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 10.w),
      padding:
          EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 10.w),
      width: double.infinity,
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
              offset: Offset(10, 20), // 阴影与容器的距离
              blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          color: AppColors.c_FFFFFFFF),
      child: listitemBig(weekPaperList),
    );
  }

  Widget listitemBig(Obj weekPaperList) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
                child: Text(
                  weekPaperList.journalName ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
              child: Text(weekPaperList.collectedTime ?? '',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff656d8f),
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 2.w),
                child: Text(
                  weekPaperList.questionTypeName ?? '',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w400),
                )),
            Expanded(child: Text('')),
            GestureDetector(
              onTap: () {
                logic.toCollect(weekPaperList.subjectId ?? 0,
                    subtopicId: weekPaperList.subtopicId);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 2.w),
                child: Image.asset(
                  R.imagesCollecPracIcon,
                  width: 46.w,
                  height: 13.w,
                ),
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
            child: Text(
              weekPaperList.content ?? '',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff353e4d),
                  height: 1.5,
                  fontWeight: FontWeight.w400),
            )),
      ],
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        logicDetail.addJumpToReviewDetailListen(
            resultType: AnsweringPage.result_browse_type,hasResultIndicator: false);
        logicDetail.getDetailAndEnterBrowsePage(
            "${weekPaperList[index].subjectId}",
            "${weekPaperList[index].subtopicId}");
        showLoading("");
      },
      child: listitemBigBg(weekPaperList[index]),
    );
  }

  @override
  void onDestroy() {
    Get.delete<Collect_practic_pageLogic>();
    Get.delete<WeekTestDetailLogic>();
    refrehUserInfoStreamSubscription?.cancel();
    _refreshController.dispose();
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    //int userId, bool isRecentView, dynamic classify,int size,int current
    logic.getCollectList(SpUtil.getInt(BaseConstant.USER_ID),
        widget.isRecentView, widget.classify, pageSize, pageStartIndex);
  }

  void _onLoading() async {
    logic.getCollectList(SpUtil.getInt(BaseConstant.USER_ID),
        widget.isRecentView, widget.classify, pageSize, currentPageNo + 1);
  }
}
