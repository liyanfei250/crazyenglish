import 'dart:async';
import 'dart:ui' as ui;
import 'package:crazyenglish/pages/practtise_history/CustomDecoration.dart';
import 'package:crazyenglish/pages/practtise_history/MyDecoration.dart';
import 'package:crazyenglish/pages/practtise_history/XFDashedLine.dart';
import 'package:crazyenglish/utils/time_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../base/AppUtil.dart';
import '../../entity/practice_list_response.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import 'LeftLineWidget.dart';
import 'practtise_history_logic.dart';

class PracttiseHistoryPage extends BasePage {
  const PracttiseHistoryPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToPracttiseHistoryPageState();
}

class _ToPracttiseHistoryPageState extends BasePageState<PracttiseHistoryPage> {
  final logic = Get.put(Practtise_historyLogic());
  final state = Get.find<Practtise_historyLogic>().state;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;
  String totalNum = "";

  List<Rows> weekPaperList = [];
  final int pageStartIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.theme_bg,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 250.w,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.imagesPracticeBlackBg),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 60.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 14.w, right: 14.w),
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            R.imagesIconBackBlack,
                            fit: BoxFit.fill,
                            color: Colors.white,
                            width: 18.w,
                            height: 18.w,
                          )),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          '练习记录',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 116.w,
                  margin: EdgeInsets.only(top: 42.w, left: 26.w, right: 26.w),
                  padding: EdgeInsets.only(left: 22.w, right: 22.w),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(R.imagesPracticeGoldTop),
                        fit: BoxFit.scaleDown),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                          child: Image.asset(
                        R.imagesShopImageLogoTest,
                        width: 42.w,
                        height: 42.w,
                      )),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: InkWell(
                          onTap: () {
                            //logic.getPracCords(1, 10);
                          },
                          child: Text('练习训练：' + totalNum + ' 次'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 214.w,
              ),
              padding: EdgeInsets.only(
                  left: 14.w, right: 14.w, top: 20.w, bottom: 10.w),
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  /*boxShadow: [
                        BoxShadow(
                          color: AppColors.c_FFFFEBEB.withOpacity(0.5),
                          // 阴影的颜色
                          offset: Offset(10, 20),
                          // 阴影与容器的距离
                          blurRadius: 45.0,
                          // 高斯的标准偏差与盒子的形状卷积。
                          spreadRadius: 10.0,
                        )
                      ],*/
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.w),
                      topRight: Radius.circular(12.w)),
                  color: Colors.white),
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("");
                    } else if (mode == LoadStatus.canLoading) {
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
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        buildItem,
                        childCount: weekPaperList.length,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getPracticeListDetail, () {

      RouterUtil.toNamed(AppRoutes.ResultPage,
          arguments: {"detail": state.weekTestDetailResponse});
    });

    logic.addListenerId(GetBuilderIds.getPracticeList, () {
      hideLoading();
      if (state.list != null && state.list != null) {
        totalNum = state.totalNum.toString();
        if (state.pageNo == currentPageNo + 1) {
          weekPaperList = state.list;
          currentPageNo++;
          weekPaperList.addAll(state!.list!);
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
          weekPaperList.addAll(state.list!);
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
    _onRefresh();
    showLoading("");
  }

  @override
  void onDestroy() {}

  Widget listitemBigBgNew(Rows value, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // 圆和线
              height: 35,
              child: LeftLineWidget(
                  showTop: index == 0 ? false : true,
                  showBottom: true,
                  isLight: false),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                value.date ?? '',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ))
          ],
        ),
        //这里需要自定义虚线BoxDecoration
        Container(
          decoration: MyDecoration(),
          margin: EdgeInsets.only(left: 24),
          padding: EdgeInsets.fromLTRB(22, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: value.list!.map((value) {
              return listitem(value);
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget listitem(ListBean value) {
    return Container(
      child: InkWell(
          onTap: () {
            logic.getPracCordsDetail(value.uuid!);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: EdgeInsets.only(top: 20.w)),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.weeklyName ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff353e4d)),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 48.w,
                              height: 17.w,
                              margin: EdgeInsets.only(top: 7.w),
                              padding: EdgeInsets.only(
                                  top: 2.w, bottom: 2.w, left: 5.w, right: 5.w),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.w)),
                                  color: Color(0xfff3f3f6)),
                              child: Text(
                                  TimeUtil.getFormatTimeHHmm(
                                      value.createdAt.toString()),
                                  style: TextStyle(
                                      color: Color(0xff656d8f),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 7.w, left: 13.w),
                              child: Text(
                                value.exercisesSuccess.toString() +
                                    "/" +
                                    value.exercisesTotal.toString() +
                                    '正确率',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff898a93)),
                              ),
                            )
                          ])
                    ],
                  ),
                  Expanded(child: Text('')),
                  Image.asset(
                    R.imagesNextThreeIcon,
                    fit: BoxFit.cover,
                    width: 10.w,
                    height: 10.w,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10.w)),
            ],
          )),
    );
  }

  Widget newLayout() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: weekPaperList.length,
      itemBuilder: (BuildContext context, int index) {
        return listitemBigBgNew(weekPaperList[index], index);
      },
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          //RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,arguments: weekPaperList![index]);
        },
        child: listitemBigBgNew(weekPaperList[index], index));
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getPracCords(pageStartIndex, pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getPracCords(currentPageNo, pageSize);
  }

  @override
  void dispose() {
    Get.delete<Practtise_historyLogic>();
    _refreshController.dispose();
    super.dispose();
  }
}
