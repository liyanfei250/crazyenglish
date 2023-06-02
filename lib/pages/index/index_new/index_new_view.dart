import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/homework/preview_exam_paper/preview_exam_paper_view.dart';
import 'package:crazyenglish/pages/index/index_logic.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/utils/time_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/common.dart' as common;
import '../../../entity/home/HomeKingNewDate.dart';
import '../../../entity/home/HomeMyTasksDate.dart' as homemytask;
import 'package:crazyenglish/entity/teacher_week_list_response.dart' as weekListResponse;
import '../../../r.dart';
import '../../../entity/week_list_response.dart' as newData;
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../../widgets/swiper.dart';
import 'package:crazyenglish/entity/home/banner.dart' as banner;

class IndexNewPage extends BasePage {
  const IndexNewPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _IndexPageState();
}

class _IndexPageState extends BasePageState<IndexNewPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(IndexLogic());
  final state = Get.find<IndexLogic>().state;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<weekListResponse.Records> myListDate = [];
  List<Obj> functionTxtNew = [];
  late Obj weekData;
  List<homemytask.Obj> listData = [];
  @override
  void initState() {
    super.initState();
    SpUtil.putBool(common.BaseConstant.IS_TEACHER_LOGIN, false);
    //获取金刚区列表新增的列表
    logic.addListenerId(GetBuilderIds.getHomeMyJournalDate, () {
      hideLoading();
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
      }
      if (state.myJournalDetail != null) {
        if (mounted && state.myJournalDetail!.obj != null) {
          myListDate = state.myJournalDetail!.obj!.records!;
          setState(() {});
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
                body = Text("释放以加载更多");
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
              SliverPersistentHeader(
                pinned: false,
                delegate: _MyAppbarDelegate(child: AppBar(
                automaticallyImplyLeading: false,
                title: _buildSearchBar(),
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                backgroundColor: Colors.transparent,
              )),

              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 20.w)),
                          adsBanner,
                          Padding(padding: EdgeInsets.only(top: 18.w)),
                          GetBuilder<IndexLogic>(
                            id: GetBuilderIds.getHomeDateListNew,
                            builder: (logic) {
                              if (state.paperDetailNew != null &&
                                  state.paperDetailNew!.obj != null &&
                                  state.paperDetailNew!.obj!.isNotEmpty) {
                                functionTxtNew.clear();
                                int length = state.paperDetailNew!.obj!.length;
                                for (int i = 0; i < length; i++) {
                                  if ("weekly_type" ==
                                      state.paperDetailNew!.obj![i].type) {
                                    weekData = state.paperDetailNew!.obj![i];
                                  }
                                }
                                if (Util.isIOSMode()) {
                                  int length =
                                      state.paperDetailNew!.obj!.length;
                                  for (int i = 0; i < length; i++) {
                                    if ("shopping_type" ==
                                        state.paperDetailNew!.obj![i].type) {
                                      continue;
                                    } else {
                                      functionTxtNew
                                          .add(state.paperDetailNew!.obj![i]);
                                    }
                                  }
                                } else {
                                  functionTxtNew
                                      .addAll(state.paperDetailNew!.obj!);
                                }
                                return Container(
                                    child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: functionTxtNew.length,
                                  itemBuilder: (_, int position) {
                                    Obj e = functionTxtNew[position];
                                    return _buildFuncAreaItem(e);
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                  ),
                                ));
                              }
                              return const SizedBox();
                            },
                          ),
                          Padding(padding: EdgeInsets.only(top: 18.w)),
                          //我的期刊
                          buildImageWithClickableIcon(
                            R.imagesStudentHomeJou,
                            () {
                              // Util.toast('我的期刊');
                            },
                          ),
                          SizedBox(
                            height: 30.w,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                  child: _createListView()),
              SliverToBoxAdapter(
                child: Padding(padding: EdgeInsets.only(top: 14.w)),
              ),
              SliverVisibility(
                  visible: !Util.isIOSMode(),
                  sliver: SliverToBoxAdapter(
                child: _buildClassArea(),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        weekListResponse.Records old = myListDate[index];
        newData.Obj updatedObj = updateObj(old);
        RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,
            arguments: updatedObj);
      },
      child: Container(
        margin:
            EdgeInsets.only(left: 14.w, right: 14.w, bottom: 12.w, top: 6.w),
        child: Row(
          children: [
            SizedBox(
              width: 14.w,
            ),
            ExtendedImage.network(
              myListDate[index].coverImg ?? "",
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
            SizedBox(
              width: 14.w,
            ),
            Expanded(
              child: Container(
                  height: 88.w,
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
                        TimeUtil.extractDate(myListDate[index].createTime ?? ''),
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff898a93),
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 66.w,
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 2.w, bottom: 2.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.w)),
                            color: Color(0xfff0f0f0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              R.imagesWeeklyBrowse,
                              width: 13.w,
                              height: 13.w,
                              color: Color(0xff898a93),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              Util.formatNum(myListDate[index].journalView??0),
                              style: TextStyle(
                                  fontSize: 11.sp, color: Color(0xff898a93)),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 19.w,
          ),
          Image.asset(
            imagePath,
            width: 20.w,
            height: 20.w,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            '推荐期刊',
            style: TextStyle(
                color: Color(0xff3E454E),
                fontWeight: FontWeight.w600,
                fontSize: 18.sp),
          ),
          Expanded(
            child: Text(''),
          ),
          InkWell(
            onTap: () {
              RouterUtil.toNamed(AppRoutes.WeeklyTestList, arguments: weekData);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffdfe2e9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(17),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.w),
              child: Text(
                '更多',
                style: TextStyle(
                  color: Color(0xff8b8f94),
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 19.w,
          ),
        ],
      ),
    );
  }

  Widget get adsBanner {
    return GetBuilder<IndexLogic>(
      id: GetBuilderIds.getHomeBanner,
      builder: (logic){
        if(logic.state.banner!=null && logic.state.banner.obj!=null && logic.state.banner.obj!.isNotEmpty){
          return Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            height: 140.w,
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
                children: makeBanner(logic.state.banner)),
          );
        }else{
          return const SizedBox();
        }

      },
    );
  }

  ///banner条目适配器
  List<Widget> makeBanner(banner.Banner banner) {
    List<Widget> items = [];
    if(banner!=null && banner.obj!=null && banner.obj!.isNotEmpty){
      for(int i = 0;i<banner.obj!.length;i++){
        items.add(InkWell(
          onTap: () async{
            if(banner.obj![i].type == 1){
              if((banner.obj![i].externalLinks??"").isNotEmpty){
                RouterUtil.toWebPage(
                  banner.obj![i].externalLinks,
                  title: banner.obj![i].positionName??"",
                  showStatusBar: true,
                  showAppBar: true,
                  showH5Title: true,
                );
              }else{
                Util.toast("获取地址失败");
              }
            }else if(banner.obj![i].type == 2){
              if((banner.obj![i].appletId??"").isNotEmpty){
                Util.jumpToMiniProgram(banner.obj![i].appletId);
              }else{
                Util.toast("获取小程序id失败");
              }

            }
          },
          child: ExtendedImage.network(
            banner.obj![i].img??"",
            cacheRawData: true,
            width: double.infinity,
            height: 140.w,
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
                    R.imagesIconHomeMeDefaultHead,
                    fit: BoxFit.fill,
                  );
              }
            },
          ),
        ));
      }

    }

    return items;
  }

  Widget _buildFuncAreaItem(Obj e) => InkWell(
        onTap: () {

          switch (e.type) {
            case "weekly_type":
              RouterUtil.toNamed(AppRoutes.WeeklyTestList, arguments: e);
              break;
            case "lable_type":
              RouterUtil.toNamed(AppRoutes.ListeningPracticePage, arguments: e);
              break;

            /*
            case "shopping_type":
              RouterUtil.toNamed(AppRoutes.ToShoppingPage,
                  arguments: e);
              break;*/
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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

  Widget _buildSearchBar() => Container(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: GestureDetector(
                onTap: () {
                  RouterUtil.toNamed(AppRoutes.HomeSearchPage,
                      arguments: {'isteacher': false});
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 11.w,top: 4.w,bottom: 4.w),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(14.w)),
                      color: AppColors.c_FFFFFFFF),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        R.imagesIndexSearch,
                        fit: BoxFit.cover,
                        width: 22.w,
                        height: 22.w,
                        color: Color(0xffb3b7c0),
                      ),
                      Padding(padding: EdgeInsets.only(left: 9.w)),
                      Text(
                        "搜索",
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xffb3b7c0)),
                      )
                    ],
                  ),
                ))),
      ],
    ),
  );

  //构建FutureBuilder控件：
  Widget _createListView() {
    if (myListDate.length > 0) {
      return _dataWidget();
    } else {
      return _loadingErrorWidget();
    }
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
                weekListResponse.Records old = myListDate[index];
                newData.Obj updatedObj = updateObj(old);
                RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,
                    arguments: updatedObj);
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

                    ExtendedImage.network(
                      myListDate[index].coverImg ?? "",
                      cacheRawData: true,
                      width: 52.w,
                      height: 74.w,
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
                                "${myListDate[index].journalView.toString()}阅读",
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
      child: listData.isNotEmpty ? ListView.separated(
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
      ): Container(
        margin: EdgeInsets.only( left: 20.w, right: 20.w),
        child: PlaceholderPage(
            imageAsset: R.imagesCommenNoDate,
            title: '暂无作业任务',
            topMargin: 0.w,
            subtitle: ''),
      )) ;

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
    logic.getHomeListNew();
    //获取我的期刊列表
    logic.getMyRecommendation();
    logic.getHomeBanner();

    if(!Util.isIOSMode()){
      //获取我的任务
      logic.getMyTasks();
    }

  }

  void _onLoading() async {}

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
newData.Obj updateObj(weekListResponse.Records obj,
    {int? id,
      String? name,
      int? affiliatedGrade,
      int? schoolYear,
      int? periodsNum,
      bool? status,
      bool? isDelete,
      int? journalView,
      String? createTime,
      int? createUser}) {
  return newData.Obj(
    id: id ?? int.parse(obj.id!),
    name: name ?? obj.name,
    affiliatedGrade: affiliatedGrade ?? obj.affiliatedGrade,
    schoolYear: schoolYear ?? obj.schoolYear,
    periodsNum: periodsNum ?? obj.periodsNum,
    status: status ?? obj.status,
    isDelete: isDelete ?? obj.isDelete,
    journalView: journalView ?? obj.journalView,
    createTime: createTime ?? obj.createTime,
    createUser: createUser ?? obj.createUser,
  );
}
class _MyAppbarDelegate extends SliverPersistentHeaderDelegate{
  final Widget child;

  _MyAppbarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 77.w;

  @override
  double get minExtent => 77.w;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }


}