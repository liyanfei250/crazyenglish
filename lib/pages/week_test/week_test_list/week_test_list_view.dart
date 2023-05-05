import 'dart:math';

import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../entity/home/HomeKingNewDate.dart' as data;
import '../../../entity/home/HomeKingDate.dart' as choiceDate;
import '../../../entity/week_list_response.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../base/AppUtil.dart';
import '../../../utils/colors.dart';
import '../../../widgets/PlaceholderPage.dart';
import '../../../widgets/search_bar.dart';
import '../../jingang/listening_practice/MenuWidget.dart';
import 'week_test_list_logic.dart';

// 周报列表页
class WeekTestListPage extends BasePage {
  data.Obj? type;

  WeekTestListPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is data.Obj) {
      type = Get.arguments;
    }
  }

  @override
  BasePageState<BasePage> getState() => _WeekTestListPageState();
}

class _WeekTestListPageState extends BasePageState<WeekTestListPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(WeekTestListLogic());
  final state = Get.find<WeekTestListLogic>().state;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 12;
  int currentPageNo = 1;
  List<Obj> weekPaperList = [];
  List<choiceDate.Obj> choiceList = [];
  final int pageStartIndex = 1;
  dynamic affiliatedGrade = null;

  late AnimationController _controller;
  bool _isOpen = false;
  int _selectedIndex = -1;
  late List<String> items = [];
  var formatter = DateFormat('yyyy-MM-dd');
  @override
  void onCreate() {
    addlistner();
    _onRefresh();
    showLoading("");
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    logic.addListenerId(GetBuilderIds.getHomeWeeklyChoiceDate, () {
      if (state.paperDetailNew != null) {
        if (state.paperDetailNew!.obj != null &&
            state.paperDetailNew!.obj!.length > 0) {
          setState(() {
            choiceList = state.paperDetailNew!.obj!;
            // functionTxt =
            //     state.paperDetailNew!.obj!.map((obj) => obj.name!).toList();
          });
          items = choiceList.map((obj) => obj.name!).toList();
        }
      }
    });
    logic.getChoiceMap('grade_type');
  }

  void addlistner() {
    logic.addListenerId(GetBuilderIds.weekTestList + affiliatedGrade.toString(),
        () {
      hideLoading();
      if (state.list != null ) {
        if (state.pageNo == currentPageNo + 1) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildNormalAppBar(widget.type!.name!),
        backgroundColor: AppColors.theme_bg,
        body:Stack(
          children: [
            SmartRefresher(
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
                    child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 5.w,
                                  top: 12.w,
                                  left: 33.w,
                                  right: 33.w),
                              child: SearchBar(
                                width: double.infinity,
                                height: 28.w,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: weekPaperList.length == 0
                                  ? PlaceholderPage(
                                  imageAsset: R.imagesCommenNoDate,
                                  title: '暂无数据',
                                  topMargin: 100.w,
                                  subtitle: '')
                                  : GridView.builder(
                                itemCount: weekPaperList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisExtent: 165,
                                ),
                                itemBuilder: (context, index) {
                                  return buildItem(context, index);
                                },
                              ),
                            ),
                          ],
                        ),

                  ),
                ],
              ),
            ),
            Visibility(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.5),
              ),
              visible: _isOpen,
            ),
            Visibility(
                visible: _isOpen,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 15.w, right: 15.w, top: 10.w, bottom: 20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.w),
                        bottomLeft: Radius.circular(10.w)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 3),
                        blurRadius: 3,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 25.w,
                            width:
                            MediaQuery.of(context).size.width / 4,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                bottom: 12.w, top: 18.w),
                            padding:
                            EdgeInsets.only(left: 8.w, right: 8.w),
                            decoration: BoxDecoration(
                              color: Color(0xfff5f6f9),
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = -1;
                                  _isOpen = false;
                                });
                                affiliatedGrade = null;
                                addlistner();
                                logic.getList(affiliatedGrade,
                                    pageStartIndex, pageSize); //全部
                              },
                              child: Text(
                                '全部分类',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: _selectedIndex == -1
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              spacing: 18.w,
                              runSpacing: 4.w,
                              children: List.generate(
                                items.length,
                                    (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                      _isOpen = false;
                                    });
                                    affiliatedGrade =
                                        choiceList[index]!.id!.toInt();
                                    addlistner();
                                    logic.getList(affiliatedGrade,
                                        pageStartIndex, pageSize);
                                  },
                                  child: Container(
                                    height: 25.w,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        4,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xfff5f6f9),
                                      borderRadius:
                                      BorderRadius.circular(20.w),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                      vertical: 8.0,
                                    ),
                                    child: Text(
                                      items[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: _selectedIndex == index
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ) );
  }

  AppBar buildNormalAppBar(String text) {
    return AppBar(
      backgroundColor: AppColors.c_FFFFFFFF,
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold),
      ),
      leading: Util.buildBackWidget(context),
      // bottom: ,
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
      actions: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isOpen = !_isOpen;
            });
            _startAnimation(_isOpen);
          },
          child: Row(
            children: [
              Text(
                '全部',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xff898a93),
                ),
              ),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
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
                        formatter.format(DateTime.parse(weekPaperList[index].createTime!))  ?? "",
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

  void _startAnimation(bool _isOpen) {
    if (_isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getList(affiliatedGrade, pageStartIndex, pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getList(affiliatedGrade, currentPageNo+1, pageSize);
  }

  @override
  void dispose() {
    Get.delete<WeekTestListLogic>();
    _refreshController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void onDestroy() {}
}
