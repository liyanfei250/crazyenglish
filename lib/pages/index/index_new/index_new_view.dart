import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/index/index_new/index_new_logic.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/common.dart' as common;
import '../../../entity/week_list_response.dart' as weekListResponse;
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../../widgets/swiper.dart';
import '../../homework/preview_exam_paper/preview_exam_paper_view.dart';
import '../index_logic.dart';
import '../../../entity/home/HomeKingNewDate.dart';
import '../../../entity/home/HomeMyTasksDate.dart' as homemytask;

class IndexNewPage extends BasePage {
  const IndexNewPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _IndexPageState();
}

class _IndexPageState extends BasePageState<IndexNewPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(Index_newLogic());
  final state = Get.find<Index_newLogic>().state;

  List<String> functionTxt = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<weekListResponse.Obj> myListDate = [];
  List<Obj> functionTxtNew = [];
  List<homemytask.Obj> listData = [];

  @override
  void initState() {
    super.initState();
    SpUtil.putBool(common.BaseConstant.IS_TEACHER_LOGIN, false);
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
              if (Util.isIOSMode()) {
                int length = state.paperDetailNew!.obj!.length;
                functionTxtNew = [];
                for (int i = 0; i < length; i++) {
                  if ("shopping_type" == state.paperDetailNew!.obj![i].type) {
                    continue;
                  } else {
                    functionTxtNew.add(state.paperDetailNew!.obj![i]);
                  }
                }
              } else {
                functionTxtNew = state.paperDetailNew!.obj!;
              }

              functionTxt = functionTxtNew.map((obj) => obj.name!).toList();
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
                          Padding(padding: EdgeInsets.only(top: 20.w)),
                          adsBanner,
                          Padding(padding: EdgeInsets.only(top: 13.w)),
                          Container(
                            height: 80.w,
                            margin: EdgeInsets.symmetric(horizontal: 14.w),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
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
                            R.imagesStudentHomeJou,
                            () {
                              Util.toast('推荐期刊');
                            },
                          ),
                          SizedBox(height: 30.w,)
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
    return GestureDetector(
      onTap: () {
        //todo 去具体的某一个期刊的列表界面，带上id
        RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,
            arguments: myListDate![index]);
      },
      child: Container(
        margin: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 6.w, top: 6.w),
        child: Row(
          children: [
            SizedBox(
              width: 14.w,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Image.asset(
                R.imagesSearchPlaceIc,
                width: 88.w,
                height: 122.w,
              ),
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
          Text('推荐期刊',style: TextStyle(color: Color(0xff3E454E),fontWeight: FontWeight.w600,fontSize: 18.sp),),
          Expanded(
            child: Text(''),
          ),
          GestureDetector(
            onTap: () {},
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

  Widget _buildSearchBar() => Util.isIOSMode()
      ? Container()
      : Container(
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
    logic.getMyJournalList();
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
