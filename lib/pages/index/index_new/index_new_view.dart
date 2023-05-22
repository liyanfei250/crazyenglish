import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/index/index_logic.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/common.dart' as common;
import '../../../entity/home/HomeKingNewDate.dart';
import '../../../entity/home/HomeMyTasksDate.dart' as homemytask;
import '../../../entity/week_list_response.dart' as weekListResponse;
import '../../../r.dart';
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
  List<weekListResponse.Obj> myListDate = [];
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
          myListDate = state.myJournalDetail!.obj!;
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
              SliverPersistentHeader(
                pinned: false,
                delegate: _MyAppbarDelegate(child: AppBar(
                automaticallyImplyLeading: false,
                title: _buildSearchBar(),
                elevation: 0,
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
                              Util.toast('我的期刊');
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
              myListDate.length > 0
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        buildItem,
                        childCount: myListDate.length,
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: PlaceholderPage(
                          imageAsset: R.imagesCommenNoDate,
                          title: '暂无数据',
                          topMargin: 100.w,
                          subtitle: '')),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,
            arguments: myListDate![index]);
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
                        myListDate[index].createTime ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff898a93),
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 62.w,
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
                              myListDate[index].journalView.toString() ?? '0',
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
          GestureDetector(
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
              children: makeBanner(logic.state.banner)),
        );
      },
    );
  }

  ///banner条目适配器
  List<Widget> makeBanner(banner.Banner banner) {
    List<Widget> items = [];
    if(banner!=null && banner.obj!=null && banner.obj!.isNotEmpty){
      for(int i = 0;i<banner.obj!.length;i++){
        items.add(InkWell(
          onTap: (){
            if((banner.obj![i].externalLinks??"").isNotEmpty){
              RouterUtil.toWebPage(
                banner.obj![i].externalLinks,
                title: banner.obj![i].positionName??"",
                showStatusBar: true,
                showAppBar: true,
                showH5Title: true,
              );
            }
          },
          child: ExtendedImage.network(
            banner.obj![i].img??"",
            cacheRawData: true,
            width: double.infinity,
            height: 130.w,
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
                      arguments: {'isteacher': false});
                },
                child: Container(
                  width: double.infinity,
                  height: 33.w,
                  // margin: EdgeInsets.only(right: 19.w, left: 19.w),
                  padding: EdgeInsets.only(left: 11.w),
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

  @override
  bool get wantKeepAlive => true;

  void _onRefresh() async {
    //新增金刚区的列表，有图片
    logic.getHomeListNew();
    //获取我的期刊列表
    logic.getMyJournalList();
    logic.getHomeBanner();
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

class _MyAppbarDelegate extends SliverPersistentHeaderDelegate{
  final Widget child;

  _MyAppbarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 70.w;

  @override
  // TODO: implement minExtent
  double get minExtent => 70.w;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }


}