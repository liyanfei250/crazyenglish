import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;

import '../../../../base/widgetPage/base_page_widget.dart';
import '../../../../entity/home/HomeKingDate.dart' as tabDate;
import '../../../../entity/review/SearchCollectListDate.dart';
import '../../../../entity/review/SearchRecordDate.dart';
import '../../../../r.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/colors.dart';
import '../../../week_test/week_test_detail/week_test_detail_logic.dart';
import 'collect_practic_logic.dart';

class ErrorColectPrctePage extends BasePage {
  const ErrorColectPrctePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToErrorColectPrctePageState();
}

class _ToErrorColectPrctePageState extends BasePageState<ErrorColectPrctePage> {
  final logic = Get.put(Collect_practicLogic());
  final state = Get.find<Collect_practicLogic>().state;
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;

  refresh.RefreshController _refreshController =
      refresh.RefreshController(initialRefresh: false);
  bool _showClearButton = false;
  final TextEditingController _searchController = TextEditingController();
  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;
  SearchRecordDate? paperDetail;
  bool isRecentView =false;
  dynamic classify =null;

  List<tabDate.Obj> searchList = [];
  List<Obj> weekPaperList = [];
  tabDate.Obj data1 = tabDate.Obj(id: 0, name: '全部', value: 100);
  tabDate.Obj data2 = tabDate.Obj(id: 1, name: '最近查看', value: 101);

  @override
  void initState() {
    super.initState();
    // 监听输入框内容变化
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
      });
    });

    //获取筛选列表
    logic.addListenerId(GetBuilderIds.getHomeDateList, () {
      if (state.tabList != null) {
        if (state.tabList!.obj != null && state.tabList!.obj!.length > 0) {
          // RouterUtil.toNamed(AppRoutes.ErrorNotePage,
          //     arguments: state.tabList!.obj!);
          setState(() {
            searchList = state.tabList!.obj!;
            searchList.insertAll(0, [data1, data2]);
          });
        }
      }
    });
    //先获取tab接口，用来筛选
    logic.getHomeList('classify_type');

    //收藏列表
    logic.addListenerId(GetBuilderIds.getCollectListDate+isRecentView.toString()+classify.toString(), () {
      hideLoading();
      if (state.paperList != null && state.paperList != null) {
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
            setState(() {

            });
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
            setState(() {

            });
          }
        }
      }
    });

    _onRefresh();
    // showLoading("");
    //收藏
    logic.addListenerId(GetBuilderIds.toCollectDate, () {
      Util.toast('成功或者取消');
    });
  }

// 清空输入框内容
  void _clearSearchText() {
    setState(() {
      _searchController.text = '';
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: refresh.SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: refresh.WaterDropHeader(),
        footer: refresh.CustomFooter(
          builder: (BuildContext context, refresh.LoadStatus? mode) {
            Widget body;
            if (mode == refresh.LoadStatus.idle) {
              body = Text("");
            } else if (mode == LoadStatus.loading) {
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
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                    bottom: 0.w, top: 12.w, left: 33.w, right: 33.w),
                child: Container(
                  height: 28.w,
                  margin: EdgeInsets.only(top: 16.w, bottom: 20.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(14.w))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 7.w)),
                      Image.asset(
                        R.imagesHomeSearch,
                        width: 16.w,
                        height: 16.w,
                      ),
                      Padding(padding: EdgeInsets.only(left: 6.w)),
                      Expanded(
                        child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: '搜索',
                              border: InputBorder.none,
                              isDense: true,
                              hintStyle: TextStyle(color: Color(0xffb3b7c0)),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 4.w),
                            ),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                            onTap: () {
                              if (_searchController.text.isNotEmpty) {
                                _searchController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                      offset: _searchController.text.length),
                                );
                              }
                            }),
                      ),
                      if (_showClearButton)
                        GestureDetector(
                          onTap: _clearSearchText,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Icon(
                              Icons.clear,
                              size: 16.w,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.only(
                      bottom: 0.w, top: 0.w, left: 33.w, right: 33.w),
                  child: Wrap(
                      spacing: 6.0, // 主轴(水平)方向间距
                      runSpacing: 1.0, // 纵轴（垂直）方向间距
                      alignment: WrapAlignment.start,
                      children: searchList.map((e) {
                        return listitem(e);
                      }).toList())),
            ),
            SliverList(
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

  Widget listitem(tabDate.Obj value) {
    return ActionChip(
      // padding: EdgeInsets.only(top: 4.w,bottom: 4.w),
      // labelPadding:EdgeInsets.only(top: 0.w,bottom: 0.w) ,
      onPressed: () {
        //Util.toast(value['title']);
        Util.toast(value.name.toString());
        isRecentView = value.value == 101 ? true : false;
        classify = value.id ?? null;
        logic.getCollectList(
            SpUtil.getInt(BaseConstant.USER_ID),
            isRecentView,
            classify,
            pageSize,
            pageStartIndex);

        _searchController.text = value!.name!;
      },
      label: Text(
        value!.name!,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      ),
      backgroundColor: Colors.white,
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
                //todo  换成具体的id
                logic.toCollect(
                    SpUtil.getInt(BaseConstant.USER_ID), "1648489081851772929");
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
        logicDetail.addJumpToReviewDetailListen();
        logicDetail.getDetailAndEnterBrowsePage("${weekPaperList[index].subjectId}");
        showLoading("");
      },
      child: listitemBigBg(weekPaperList[index]),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {
    Get.delete<Collect_practicLogic>();
    Get.delete<WeekTestDetailLogic>();
    _refreshController.dispose();
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    //int userId, bool isRecentView, dynamic classify,int size,int current
    logic.getCollectList(SpUtil.getInt(BaseConstant.USER_ID), isRecentView, classify,
        pageSize, pageStartIndex);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getCollectList(SpUtil.getInt(BaseConstant.USER_ID), isRecentView, classify,
        pageSize, pageStartIndex);
  }
}
