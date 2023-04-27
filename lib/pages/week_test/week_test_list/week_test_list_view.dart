import 'dart:math';

import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../entity/home/HomeKingDate.dart' as choiceDate;
import '../../../entity/week_list_response.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../base/AppUtil.dart';
import '../../../utils/colors.dart';
import '../../../widgets/search_bar.dart';
import '../../jingang/listening_practice/MenuWidget.dart';
import 'week_test_list_logic.dart';

// 周报列表页
class WeekTestListPage extends BasePage {
  const WeekTestListPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _WeekTestListPageState();
}

class _WeekTestListPageState extends BasePageState<WeekTestListPage> {
  final logic = Get.put(WeekTestListLogic());
  final state = Get.find<WeekTestListLogic>().state;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;
  List<Obj> weekPaperList = [];
  List<choiceDate.Obj> choiceList = [];
  final int pageStartIndex = 1;

  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.weekTestList, () {
      hideLoading();
      if (state.list != null && state.list != null) {
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

    logic.addListenerId(GetBuilderIds.getHomeWeeklyChoiceDate, () {
      if (state.paperDetailNew != null) {
        if (state.paperDetailNew!.obj != null &&
            state.paperDetailNew!.obj!.length > 0) {
          setState(() {
            choiceList = state.paperDetailNew!.obj!;
            // functionTxt =
            //     state.paperDetailNew!.obj!.map((obj) => obj.name!).toList();
          });
        }

      }
    });
    logic.getChoiceMap('grade_type');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar("每周习题"),
        backgroundColor: AppColors.theme_bg,
        body: SmartRefresher(
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
              SliverToBoxAdapter(
                child: MenuWidget(
                  title: '全部分类',
                  items: choiceList.map((obj) => obj.name!).toList(),
                  onSelected: (index) {
                    print('选中了第${index + 1}项');
                    if ((index + 1)>0){
                      logic.getList(choiceList[index]!.id!.toInt(), currentPageNo, pageSize);
                    }else{
                      logic.getList(0, currentPageNo, pageSize);//全部
                    };
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: 5.w, top: 12.w, left: 33.w, right: 33.w),
                  child: SearchBar(
                    width: double.infinity,
                    height: 28.w,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    buildItem,
                    childCount: weekPaperList.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 165.w,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Util.toast(weekPaperList![index].id!.toString());
        RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,
            arguments: weekPaperList![index]);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 18.w),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.c_BF542327.withOpacity(0.25), // 阴影的颜色
                  offset: Offset(0.w, 0.w), // 阴影与容器的距离
                  blurRadius: 10.w, // 高斯的标准偏差与盒子的形状卷积。
                  spreadRadius: 0.w,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
            ),
            width: 88.w,
            height: 122.w,
            child: Stack(
              children: [
                ExtendedImage.network(
                  weekPaperList[index].coverImg ?? "",
                  cacheRawData: true,
                  width: 88.w,
                  height: 122.w,
                  fit: BoxFit.fill,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(6.w)),
                  enableLoadState: true,
                  loadStateChanged: (state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.completed:
                        return ExtendedRawImage(
                          image: state.extendedImageInfo?.image,
                          fit: BoxFit.cover,
                        );
                      default:
                        return Image.asset(
                          R.imagesReadingDefault,
                          fit: BoxFit.fill,
                        );
                    }
                  },
                ),
                Container(
                  width: 38.w,
                  height: 14.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.w)),
                      color: AppColors.c_66000000),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        R.imagesWeeklyBrowse,
                        width: 13.w,
                        height: 13.w,
                      ),
                      Text(
                        "265",
                        style: TextStyle(
                            fontSize: 8.sp, color: AppColors.c_FFFFFFFF),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.w,
                  child: Container(
                    width: 88.w,
                    height: 31.w,
                    padding: EdgeInsets.only(bottom: 4.w),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage(R.imagesWeeklyBg)),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      weekPaperList[index].createTime ?? "",
                      style: TextStyle(
                          color: AppColors.c_FFFFFFFF, fontSize: 10.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4.w),
            child: Text(
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              weekPaperList[index].name ?? "",
              style:
                  TextStyle(color: AppColors.TEXT_BLACK_COLOR, fontSize: 14.sp),
            ),
          )
          //
        ],
      ),
    );
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getList(2, pageStartIndex, pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getList(2, currentPageNo, pageSize);
  }

  @override
  void dispose() {
    Get.delete<WeekTestListLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
