import 'package:crazyenglish/base/AppUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../base/widgetPage/base_page_widget.dart';
import '../../../../entity/review/SearchCollectListDate.dart';
import '../../../../entity/review/SearchRecordDate.dart';
import '../../../../r.dart';
import '../../../../routes/app_pages.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../routes/routes_utils.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/search_bar.dart';
import 'collect_practic_logic.dart';

class ErrorColectPrctePage extends BasePage {
  const ErrorColectPrctePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToErrorColectPrctePageState();
}

class _ToErrorColectPrctePageState extends BasePageState<ErrorColectPrctePage> {
  final logic = Get.put(Collect_practicLogic());
  final state = Get.find<Collect_practicLogic>().state;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _showClearButton = false;
  final TextEditingController _searchController = TextEditingController();
  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;
  SearchRecordDate? paperDetail;
  List listDataOne = [
    {
      "title": "01.情景反应",
      "type": 0,
    },
    {"title": "02.对话理解", "type": 1},
    {"title": "03.语篇理解", "type": 2},
    {"title": "04.听力填空", "type": 3},
  ];
  List listData = [
    {
      "title": "01.情景反应",
      "type": 0,
    },
    {"title": "02.对话理解", "type": 1},
  ];

  List searchList = [
    {
      "title": "全部",
      "type": 0,
    },
    {"title": "最近查看", "type": 1},
    {"title": "听力题", "type": 2},
    {"title": "阅读题", "type": 3},
    {"title": "写作题", "type": 4},
  ];
  List<SearchCollectListDate> weekPaperList = [];

  @override
  void initState() {
    super.initState();
    // 监听输入框内容变化
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
      });
    });

    logic.getSearchRecord('0');

    //收藏筛选列表
    logic.addListenerId(GetBuilderIds.getSearchRecord, () {
      if (state.paperDetail != null) {
        paperDetail = state.paperDetail;
        /*if(mounted && _refreshController!=null){
          if(paperDetail!.data!=null
              && paperDetail!.data!.videoFile!=null
              && paperDetail!.data!.videoFile!.isNotEmpty){
          }
          if(paperDetail!.data!=null
              && paperDetail!.data!.audioFile!=null
              && paperDetail!.data!.audioFile!.isNotEmpty){

          }
          setState(() {
          });
        }*/

      }
    });

    //收藏列表
    logic.addListenerId(GetBuilderIds.getCollectListDate, () {
      hideLoading();
      /*if(state.paperList!=null && state.paperList!=null){
        if(state.pageNo == currentPageNo+1){
          weekPaperList = state.paperList;
          currentPageNo++;
          weekPaperList.addAll(state!.paperList!);
          if(mounted && _refreshController!=null){
            _refreshController.loadComplete();
            if(!state!.hasMore){
              _refreshController.loadNoData();
            }else{
              _refreshController.resetNoData();
            }
            setState(() {

            });
          }
        }else if(state.pageNo == pageStartIndex){
          currentPageNo = pageStartIndex;
          weekPaperList.clear();
          weekPaperList.addAll(state.paperList!);
          if(mounted && _refreshController!=null){
            _refreshController.refreshCompleted();
            if(!state!.hasMore){
              _refreshController.loadNoData();
            }else{
              _refreshController.resetNoData();
            }
            setState(() {
            });
          }

        }
      }*/
    });
    _onRefresh();
    // showLoading("");

    //收藏
    logic.addListenerId(GetBuilderIds.toCollectDate, () {});
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
                childCount: listDataOne.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget test(value) {
    var newlist = searchList.where((element) => element['type'] > 1);
    return listitem(newlist);
  }

  Widget listitem(value) {
    return ActionChip(
      // padding: EdgeInsets.only(top: 4.w,bottom: 4.w),
      // labelPadding:EdgeInsets.only(top: 0.w,bottom: 0.w) ,
      onPressed: () {
        //Util.toast(value['title']);
        Util.toast(value['type'].toString());
        _searchController.text = value['title'];
      },
      label: Text(
        value['title'],
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget listitemBigBg() {
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
      child: listitemBig(),
    );
  }

  Widget listitemBig() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
                child: Text(
                  '七年级新课程第29期',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
              child: Text('2023.2.27 16:48',
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
                  '01.情景反应',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w400),
                )),
            Expanded(child: Text('')),
            GestureDetector(
              onTap: () {
                logic.toCollect('id');
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
              'As winter approaches, warm-blooded animals have two ways to cope with the cold. The first is , building a layer of fat under the skin and shedding their svelte As winter approaches, warm-blooded animals...',
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
        //todo 点击跳转到新的界面
        Util.toast("跳转到目录页");
        // RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,arguments: weekPaperList![index]);
      },
      child: listitemBigBg(),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {
    Get.delete<Collect_practicLogic>();
    _refreshController.dispose();
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getCollectList("2022-12-22", pageStartIndex, pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getCollectList("2022-12-22", currentPageNo, pageSize);
  }
}
