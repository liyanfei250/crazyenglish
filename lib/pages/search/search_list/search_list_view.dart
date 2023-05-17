import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import 'search_list_logic.dart';

class SearchListPage extends BasePage {
  int type;
  int typeTwo;

  SearchListPage(this.type, this.typeTwo, {Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToSearchListPageState();
}

class _ToSearchListPageState extends BasePageState<SearchListPage> {
  final logic = Get.put(Search_listLogic());
  final state = Get.find<Search_listLogic>().state;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  CancelFunc? _cancelLoading;
  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;


  @override
  void initState() {
    super.initState();
    //收藏列表
    // logic.addListenerId(GetBuilderIds.getHomeSearchDate, () {
    //   hideLoading();
    //   if(state.paperList!=null && state.paperList!=null){
    //     if(state.pageNo == currentPageNo+1){
    //       weekPaperList = state.paperList;
    //       currentPageNo++;
    //       weekPaperList.addAll(state!.paperList!);
    //       if(mounted && _refreshController!=null){
    //         _refreshController.loadComplete();
    //         if(!state!.hasMore){
    //           _refreshController.loadNoData();
    //         }else{
    //           _refreshController.resetNoData();
    //         }
    //         setState(() {
    //
    //         });
    //       }
    //     }else if(state.pageNo == pageStartIndex){
    //       currentPageNo = pageStartIndex;
    //       weekPaperList.clear();
    //       weekPaperList.addAll(state.paperList!);
    //       if(mounted && _refreshController!=null){
    //         _refreshController.refreshCompleted();
    //         if(!state!.hasMore){
    //           _refreshController.loadNoData();
    //         }else{
    //           _refreshController.resetNoData();
    //         }
    //         setState(() {
    //         });
    //       }
    //
    //     }
    //   }
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
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
                  listitemBigBg,
                  childCount: 4,
                ),
              ),
            ],
          ),
        ));
  }

  Widget listitemBigBg(BuildContext context, int index) {
    if (widget.typeTwo == 5) {
      return returnStudentLayout();
    } else if (widget.typeTwo == 4) {
      return returnShopLayout();
    } else if (widget.typeTwo == 2) {
      return returnNormalLayout();
    } else if (widget.typeTwo == 3) {
      return PlaceholderPage(
          imageAsset: R.imagesCommenNoDate,
          title: '没有找到与“高四”相关的结果',
          topMargin: 16.w,
          subtitle: '');
    } else {
      if (index == 0) {
        return returnShopLayout();
      } else {
        return returnNormalLayout();
      }
    }
  }

  Widget returnStudentLayout() {
    return buildItem();
  }

  Widget buildItem() {
    return InkWell(
      onTap: () {
        RouterUtil.toNamed(AppRoutes.TEACHER_STUDENT,arguments: {'studentId': 0});
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.w, left: 22.w, right: 22.w),
        padding: EdgeInsets.only(left: 16.w,top: 14.w,bottom: 14.w),
        width: double.infinity,
        alignment: Alignment.center,
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
        child: Row(
          children: [
            Image.asset(
              R.imagesStudentHead,
              width: 80.w,
              height: 100.w,
              fit: BoxFit.fill,
            ),
            Padding(padding: EdgeInsets.only(left: 15.w)),
            Container(
              height: 100.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildItemClassStudent('姓名：', '张慧敏'),
                  buildItemClassStudent('班级：', '初一（3）班'),
                  buildItemClassStudent('努力值：', '80分'),
                  buildItemClassStudent('学习时长：', '20小时'),
                  buildItemClassStudent('听力时长：', '100分钟'),
                  buildItemClassStudent('阅读时长：', '10分钟'),
                  buildItemClassStudent('答题总数：', '听(20) 说(12) 读(21)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemClassStudent(String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          first,
          style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
        Text(
          second,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
      ],
    );
  }

  Container returnShopLayout() {
    return Container(
      margin: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 0.w, top: 16.w),
      padding:
          EdgeInsets.only(left: 22.w, right: 22.w, top: 16.w, bottom: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            child: Image.asset(
              R.imagesShopImageLogoTest,
              width: 80.w,
              height: 80.w,
            ),
          ),
          Expanded(
            child: Container(
                height: 80.w,
                margin: EdgeInsets.only(left: 15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "英语周刊 年度订阅",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff3e454e)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "everyones heart have a hero",
                      style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff8a9098),
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "￥199.00",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff353e4d),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Container returnNormalLayout() {
    return Container(
      margin: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 0.w, top: 16.w),
      padding:
          EdgeInsets.only(left: 18.w, right: 18.w, top: 12.w, bottom: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            child: Image.asset(
              R.imagesSearchPlaceIc,
              width: 52.w,
              height: 74.w,
            ),
          ),
          Expanded(
            child: Container(
                height: 74.w,
                margin: EdgeInsets.only(left: 14.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "高一综合阅读",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff3e454e)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "everyones heart have a hero",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff898a93),
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "796阅读",
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff8b8f94),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    // logic.getList(widget.type, widget.typeTwo, pageStartIndex, pageSize);
    //搜索数据，之后数据更新
    logic.getSearchList("2022-12-22", pageStartIndex, pageSize);

  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // logic.getList(widget.type, widget.typeTwo, currentPageNo, pageSize);
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
