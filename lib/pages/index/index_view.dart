import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/common.dart' as common;
import '../../entity/week_list_response.dart' as weekListResponse;
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/swiper.dart';
import '../homework/preview_exam_paper/preview_exam_paper_view.dart';
import 'index_logic.dart';
import '../../entity/home/HomeKingNewDate.dart';
import '../../entity/home/HomeMyTasksDate.dart' as homemytask;

class IndexPage extends BasePage {
  const IndexPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _IndexPageState();
}

class _IndexPageState extends BasePageState<IndexPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(IndexLogic());
  final state = Get.find<IndexLogic>().state;
  List<String> functionTxt = [
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<weekListResponse.Obj> myListDate = [];
  List<Obj> functionTxtNew = [];
  List<homemytask.Obj> listData = [];
  @override
  void initState() {
    super.initState();

    //获取金刚区列表新增的列表
    logic.addListenerId(GetBuilderIds.getHomeDateListNew, () {
      hideLoading();
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
      }
      if (state.paperDetailNew != null) {
        if (state.paperDetailNew != null) {
          if (state.paperDetailNew!.obj != null &&
              state.paperDetailNew!.obj!.length > 0) {
            setState(() {
              if(Util.isIOSMode()){
                int length = state.paperDetailNew!.obj!.length;
                functionTxtNew = [];
                for(int i = 0;i< length;i++){
                  if("shopping_type" == state.paperDetailNew!.obj![i].type){
                    continue;
                  }else{
                    functionTxtNew.add(state.paperDetailNew!.obj![i]);
                  }
                }
              }else{
                functionTxtNew = state.paperDetailNew!.obj!;
              }

              functionTxt =
                  functionTxtNew.map((obj) => obj.name!).toList();
            });
          }
        }
      }
    });

    logic.addListenerId(GetBuilderIds.getHomeMyJournalDate, () {
      hideLoading();
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
      }
      if (state.myJournalDetail != null) {
        if (mounted && state.myJournalDetail!.obj != null) {
          myListDate = state.myJournalDetail!.obj!;
          setState(() {});
        }
      }
    });

    logic.addListenerId(GetBuilderIds.getMyTasksDate, () {
      hideLoading();
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
      }

      if (state.myTask != null && state.myTask!.obj !=null) {
        listData = state.myTask!.obj!;
        if(mounted && _refreshController!=null){
          setState(() {
          });
        }
      }
    });
    _onRefresh();
    showLoading("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesReviewTopBg), fit: BoxFit.cover),
        ),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
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
                    AppBar(
                      automaticallyImplyLeading: false,
                      title: _buildSearchBar(),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 9.w)),
                          adsBanner,
                          Padding(padding: EdgeInsets.only(top: 13.w)),
                          Container(
                            height: 80.w,
                            margin: EdgeInsets.symmetric(horizontal: 14.w),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: functionTxtNew.length,
                                itemBuilder: (_, int position) {
                                  Obj e = functionTxtNew[position];
                                  return _buildFuncAreaItem(e);
                                }),
                          ),
                          Padding(padding: EdgeInsets.only(top: 12.w)),
                          //我的期刊
                          //todo 我的期刊跳转到期刊的列表，之前的页面复用
                          buildImageWithClickableIcon(
                            R.imagesHomeMyJournals,
                            () {
                              Util.toast('我的期刊');
                            },
                          ),
                          _createListView(),
                          Padding(padding: EdgeInsets.only(top: 14.w)),
                          Visibility(
                              visible: !Util.isIOSMode(),
                              child: _buildClassArea()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageWithClickableIcon(
      String imagePath, void Function()? onPress) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 19.w,
          ),
          Image.asset(
            imagePath,
            width: 102,
            height: 42,
          ),
          Expanded(
            child: Text(''),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 42,
            margin: EdgeInsets.only(right: 20),
            child: Image.asset(
              R.imagesHomeNextIcBlack,
              width: 10,
              height: 10,
            ),
          )
        ],
      ),
    );
  }

  Widget get adsBanner {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      height: 130.w,
      child: Swiper(
          autoStart: true,
          circular: true,
          indicator: CustomSwiperIndicator(
            spacing: 4.w,
            // radius: 4.0,
            padding: EdgeInsets.only(bottom: 10.w),
            // itemColor: AppColors.c_FFC2BFC2,
            // itemActiveColor: AppColors.c_FF11CA9C
            normalHeight: 4.w,
            normalWidth: 4.w,
            noralBoxDecoration: BoxDecoration(
                color: AppColors.c_80FFFFFF, shape: BoxShape.circle),
            selectHeight: 4.w,
            selectWidth: 4.w,
            selectBoxDecoration: BoxDecoration(
                color: AppColors.c_FFFFFFFF, shape: BoxShape.circle),
          ),
          indicatorAlignment: AlignmentDirectional.bottomCenter,
          children: makeBanner()),
    );
  }

  ///banner条目适配器
  List<Widget> makeBanner() {
    List<Widget> items = [];
    items.add(Image.asset(
      R.imagesIndexAd,
      fit: BoxFit.fill,
      width: double.infinity,
      height: 130.w,
    ));
    items.add(Image.asset(
      R.imagesIndexAd,
      fit: BoxFit.fill,
      width: double.infinity,
      height: 130.w,
    ));
    items.add(Image.asset(
      R.imagesIndexAd,
      fit: BoxFit.fill,
      width: double.infinity,
      height: 130.w,
    ));
    return items;
  }

  Widget _buildFuncAreaItem(Obj e) => InkWell(
        onTap: () {
          // switch (e.name) {
          //   case "数字英语":
          //     RouterUtil.toNamed(AppRoutes.WeeklyTestList,arguments: e);
          //     break;
          //   case "综合听力":
          //     RouterUtil.toNamed(AppRoutes.ListeningPracticePage,
          //         arguments: e);
          //     break;
          //   case "阅读理解":
          //     RouterUtil.toNamed(AppRoutes.ListeningPracticePage,
          //         arguments: e);
          //     break;
          //   case "写作训练":
          //     RouterUtil.toNamed(AppRoutes.WritingResultPage);
          //     break;

          switch (e.type) {
            case "weekly_type":
              RouterUtil.toNamed(AppRoutes.WeeklyTestList, arguments: e);
              break;
            case "lable_type":
              RouterUtil.toNamed(AppRoutes.ListeningPracticePage, arguments: e);
              break;

            /*case "周报题库":
              RouterUtil.toNamed(AppRoutes.WeeklyTestList);
              break;
            case "shopping_type":
              RouterUtil.toNamed(AppRoutes.ToShoppingPage,
                  arguments: e);
              break;*/
          }
        },
        child: Container(
          margin: EdgeInsets.only(right: 29.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ExtendedImage.network(
                e.icon ?? "",
                cacheRawData: true,
                width: 50.w,
                height: 50.w,
                fit: BoxFit.fill,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
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
                        R.imagesShopImageLogoTest,
                        fit: BoxFit.fill,
                      );
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(bottom: 10.w)),
              Text(
                e.name!,
                style: TextStyle(
                    fontSize: 12.sp, color: AppColors.TEXT_BLACK_COLOR),
              )
            ],
          ),
        ),
      );

  Widget _buildClassArea() => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesIndexTodayTodo), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 22.w,
            ),
            GestureDetector(
              onTap: () {
                //新的界面
                RouterUtil.toNamed(AppRoutes.MyTaskPage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    "我的任务",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xff151619)),
                  ),
                  Expanded(
                    child: Text(''),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 20),
                    child: Image.asset(
                      R.imagesHomeNextIcBlack,
                      width: 10,
                      height: 10,
                    ),
                  ),
                ],
              ),
            ),
            _buildClassCard(0),
          ],
        ),
      );

  Widget _buildClassCard(int index) => Container(
      margin: EdgeInsets.only(top: 20.w, left: 14.w, right: 14.w, bottom: 14.w),
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 2.w, bottom: 2.w),
      width: double.infinity,
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
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _listOne(listData[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 1, color: Color(0xffd2d5dc));
        },
        itemCount: listData.length,
      ));

  Widget _buildSearchBar() => Util.isIOSMode() ? Container():Container(
    margin: EdgeInsets.only(top: 7.w),
    width: double.infinity,
    height: 28.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: GestureDetector(
                onTap: () {
                  RouterUtil.toNamed(AppRoutes.HomeSearchPage,
                      arguments: {'isteacher': true});
                },
                child: Container(
                  width: double.infinity,
                  height: 28.w,
                  margin: EdgeInsets.only(right: 26.w),
                  padding: EdgeInsets.only(left: 11.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14.w)),
                      color: AppColors.c_FFFFFFFF),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        R.imagesIndexSearch,
                        fit: BoxFit.cover,
                        width: 16.w,
                        height: 16.w,
                      ),
                      Padding(padding: EdgeInsets.only(left: 9.w)),
                      Text(
                        "搜词/翻译",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.TEXT_GRAY_COLOR),
                      )
                    ],
                  ),
                ))),
        GestureDetector(
          onTap: () {
            RouterUtil.toNamed(AppRoutes.QRViewPage);
          },
          child: Image.asset(
            R.imagesIndexScan,
            width: 18.w,
            height: 18.w,
          ),
        ),
      ],
    ),
  );
  var _future = Future.delayed(Duration(seconds: 2), () {
    return '老王，一个有态度的程序员'; //模拟json字符串
  });

  //构建FutureBuilder控件：
  Widget _createListView() {
    if (myListDate.length > 0) {
      return _dataWidget();
    } else {
      return _loadingErrorWidget();
    }
  }

  //构建loading控件：
  _loadingWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      ),
    );
  }

  //数据加载成功，构建数据展示控件：
  _dataWidget() {
    return Container(
        height: 100.w,
        margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 18.w),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: myListDate.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                //todo 去具体的某一个期刊的列表界面，带上id
                RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,
                    arguments: myListDate![index]);
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: 4.w, right: 14.w, bottom: 6.w, top: 6.w),
                width: 288.w,
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
                    SizedBox(
                      width: 14.w,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      child: Image.asset(
                        R.imagesSearchPlaceIc,
                        width: 52.w,
                        height: 74.w,
                      ),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    Expanded(
                      child: Container(
                          height: 74.w,
                          margin: EdgeInsets.only(left: 4.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                myListDate[index].name ?? '',
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
              ),
            );
          },
        ));
  }

//构建网络加载失败控件：
  _loadingErrorWidget() {
    return Image.asset(
      R.imagesHomeMyListNoData,
      width: double.infinity,
      height: 98.w,
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onRefresh() async {
    //新增金刚区的列表，有图片
    logic.getHomeListNew('');
    //获取我的期刊列表
    logic.getMyJournalList();
    //获取我的任务
    logic.getMyTasks();
  }

  void _onLoading() async {

  }

  @override
  void dispose() {
    Get.delete<IndexLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}

LinearGradient yellowGreen(
        {begin = AlignmentDirectional.centerStart,
        end = AlignmentDirectional.centerEnd,
        opacity = 1.0}) =>
    _getLinearGradient(Color(0xfffaeed7), Color(0xffe5d2ac),
        begin: begin, end: end, opacity: opacity);

LinearGradient _getLinearGradient(Color left, Color right,
        {begin = AlignmentDirectional.centerStart,
        end = AlignmentDirectional.centerEnd,
        opacity = 1.0}) =>
    LinearGradient(
      colors: [
        left.withOpacity(opacity),
        right.withOpacity(opacity),
      ],
      begin: begin,
      end: end,
    );

Widget _listOne(homemytask.Obj value) => InkWell(
      onTap: () {
        RouterUtil.toNamed(AppRoutes.PreviewExamPaperPage, arguments: {
          PreviewExamPaperPage.PaperType:common.PaperType.HistoryHomework,
          PreviewExamPaperPage.StudentOperationId:value.id,
          PreviewExamPaperPage.PaperId:value.operationId});
      },
      child: Container(
        padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Padding(padding: EdgeInsets.only(left: 7.w,right: 7.w)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [
                    Container(
                      width: 27.w,
                      height: 14.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: yellowGreen(),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.w),
                              topRight: Radius.circular(7.w),
                              bottomRight: Radius.circular(7.w),
                              bottomLeft: Radius.circular(0.w)),
                          color: Color(0xfff0e9ff)),
                      child: Text("${value.completeSize}/${value.totalSize}",
                          style: TextStyle(
                              color: Color(0xff8b8f9f),
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(width: 10.w),
                    Text("${value.name}",
                        style: TextStyle(
                            color: Color(0xff353e4d),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                  ]),
                  SizedBox(
                    height: 5.w,
                  ),
                  Row(
                    children: [
                      Text("剩余时间：${value.timeRemaining}",
                          style: TextStyle(
                              color: Color(0xff8b8f9f),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700)),
                      SizedBox(width: 30.w),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
