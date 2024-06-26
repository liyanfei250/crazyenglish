import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/teacher_home_tips_response.dart' as number;
import 'package:crazyenglish/entity/teacher_week_list_response.dart'
    as weekList;
import 'package:crazyenglish/pages/homework/choose_history_new_homework/choose_history_new_homework_view.dart';
import 'package:crazyenglish/pages/homework/correct_notify_homework/correct_homework_view.dart';
import 'package:crazyenglish/pages/mine/person_info/person_info_logic.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:crazyenglish/xfyy/bean/xf_text_req.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;

import '../../entity/home/HomeKingNewDate.dart';
import '../../base/AppUtil.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/swiper.dart';
import '../homework/choose_exam_paper/choose_exam_paper_view.dart';
import 'teacher_index_logic.dart';
import '../../../entity/week_list_response.dart' as newData;

class TeacherIndexPage extends BasePage {
  TeacherIndexPage({Key? key}) : super(key: key);

  @override
  _TeacherIndexPageState getState() => _TeacherIndexPageState();
}

class _TeacherIndexPageState extends BasePageState<TeacherIndexPage> {
  final logic = Get.put(TeacherIndexLogic());
  final state = Get.find<TeacherIndexLogic>().state;
  final personInfoLogic = Get.find<Person_infoLogic>();

  pull.RefreshController _refreshController =
      pull.RefreshController(initialRefresh: false);
  List<Obj> functionTxtNew = [];
  List<weekList.Records> myListDate = []; //我的期刊
  List<weekList.Records> myBottomDate = []; //推荐期刊
  late number.Obj myTipsNum = number.Obj(); //提醒数量
  @override
  void initState() {
    super.initState();
    SpUtil.putBool(BaseConstant.IS_TEACHER_LOGIN, true);
    //获取金刚区列表新增的列表
    logic.addListenerId(GetBuilderIds.getHomeDateListTeacher, () {
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
      }
      if (state.paperDetailNew != null) {
        if (state.paperDetailNew != null) {
          if (state.paperDetailNew!.obj != null &&
              state.paperDetailNew!.obj!.length > 0) {
            functionTxtNew = state.paperDetailNew!.obj!;
            setState(() {});
          }
        }
      }
    });
    //获取金刚区我的期刊
    logic.addListenerId(GetBuilderIds.getHomeMyJournalDateTeacher, () {
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
    //获取底部推荐期刊
    logic.addListenerId(GetBuilderIds.getHomeMyRecommendation, () {
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
      }
      if (state.recommendJournal != null) {
        if (mounted && state.recommendJournal!.obj != null) {
          myBottomDate = state.recommendJournal!.obj!.records!;
          setState(() {});
        }
      }
    });

    //获取提醒数量
    logic.addListenerId(GetBuilderIds.getTeacherHomeGetNumber, () {
      if (mounted && _refreshController != null) {
        _refreshController.refreshCompleted();
      }
      if (state.number != null) {
        if (mounted && state.number!.obj != null) {
          myTipsNum = state.number.obj!;
          setState(() {});
        }
      }
    });

    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesHomeTeachBg), fit: BoxFit.fill),
        ),
        child: pull.SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: pull.WaterDropHeader(),
          footer: pull.CustomFooter(
            builder: (BuildContext context, pull.LoadStatus? mode) {
              Widget body;
              if (mode == pull.LoadStatus.idle) {
                body = Text("");
              } else if (mode == pull.LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == pull.LoadStatus.failed) {
                body = Text("");
              } else if (mode == pull.LoadStatus.canLoading) {
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
                  children: [
                    AppBar(
                      automaticallyImplyLeading: false,
                      title: _buildSearchBar(),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 14.w, right: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 16.w)),
                          // adsBanner,
                          Padding(padding: EdgeInsets.only(top: 22.w)),
                          GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: functionTxtNew.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5),
                              itemBuilder: (_, int position) {
                                Obj e = functionTxtNew[position];
                                return _buildFuncAreaItem(e);
                              }),
                          Padding(padding: EdgeInsets.only(top: 20.w)),
                          _buildClassArea(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void loginChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildSearchBar() => Container(
        margin: EdgeInsets.only(top: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: GetBuilder<Person_infoLogic>(
                  id: GetBuilderIds.getPersonInfo,
                  builder: (logic) {
                    return InkWell(
                      onTap: () {
                        RouterUtil.toNamed(AppRoutes.PersonInfoPage,
                            isNeedCheckLogin: true,
                            arguments: {
                              'isStudent':
                                  SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)
                                      ? false
                                      : true
                            });
                      },
                      child: ExtendedImage.network(
                        isLogin ? logic.state.infoResponse.obj?.url ?? "" : "",
                        cacheRawData: true,
                        width: 32.w,
                        height: 32.w,
                        fit: BoxFit.fill,
                        shape: BoxShape.circle,
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
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                RouterUtil.toNamed(AppRoutes.HomeSearchPage,
                    arguments: {'isteacher': true});
              },
              child: Container(
                width: 291.w,
                height: 28.w,
                padding: EdgeInsets.only(left: 11.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.w)),
                    color: Colors.white),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      R.imagesHomeSearchIc,
                      fit: BoxFit.cover,
                      width: 16.w,
                      height: 16.w,
                    ),
                    Padding(padding: EdgeInsets.only(left: 9.w)),
                    Text(
                      "数字英语教师端",
                      style:
                          TextStyle(fontSize: 12.sp, color: Color(0xff898a93)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  // Widget get adsBanner {
  //   return Container(
  //     width: double.infinity,
  //     height: 130.w,
  //     child: Swiper(
  //         autoStart: true,
  //         circular: true,
  //         indicator: CustomSwiperIndicator(
  //           spacing: 4.w,
  //           // radius: 4.0,
  //           padding: EdgeInsets.only(bottom: 10.w),
  //           // itemColor: AppColors.c_FFC2BFC2,
  //           // itemActiveColor: AppColors.c_FF11CA9C
  //           normalHeight: 4.w,
  //           normalWidth: 4.w,
  //           noralBoxDecoration: BoxDecoration(
  //               color: AppColors.c_80FFFFFF, shape: BoxShape.circle),
  //           selectHeight: 4.w,
  //           selectWidth: 4.w,
  //           selectBoxDecoration: BoxDecoration(
  //               color: AppColors.c_FFFFFFFF, shape: BoxShape.circle),
  //         ),
  //         indicatorAlignment: AlignmentDirectional.bottomCenter,
  //         children: makeBanner()),
  //   );
  // }

  ///banner条目适配器
  // List<Widget> makeBanner() {
  //   List<Widget> items = [];
  //   items.add(Image.asset(
  //     R.imagesIndexAd,
  //     fit: BoxFit.fill,
  //     width: double.infinity,
  //     height: 130.w,
  //   ));
  //   items.add(Image.asset(
  //     R.imagesIndexAd,
  //     fit: BoxFit.fill,
  //     width: double.infinity,
  //     height: 130.w,
  //   ));
  //   items.add(Image.asset(
  //     R.imagesIndexAd,
  //     fit: BoxFit.fill,
  //     width: double.infinity,
  //     height: 130.w,
  //   ));
  //   return items;
  // }

  Widget _buildFuncAreaItem(Obj e) => InkWell(
        onTap: () {
          switch (e.name) {
            case "英语周报":
              RouterUtil.toNamed(AppRoutes.WeeklyTestList, arguments: e);
              break;
            case "历史作业":
              RouterUtil.toNamed(AppRoutes.ChooseHistoryNewHomeworkPage,
                  arguments: {
                    ChooseHistoryNewHomeworkPage.IsAssignHomework: false
                  });
              break;
            case "试卷库":
              RouterUtil.toNamed(AppRoutes.ChooseExamPaperPage,
                  arguments: {ChooseExamPaperPage.IsAssignHomework: false});
              break;
            case "布置作业":
              RouterUtil.toNamed(AppRoutes.AssignHomeworkPage);
              break;
            case "商城":
              RouterUtil.toNamed(AppRoutes.ShoppingListPage);
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                "images/num_index${functionTxtNew.indexOf(e)}.png",
                width: 42.w,
                height: 42.w,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 8.w)),
            Text(
              e.name ?? '',
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff353e4d)),
            )
          ],
        ),
      );

  Widget _buildClassArea() => Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: EdgeInsets.only(left: 4.w)),
            //我的期刊
            buildImageWithClickableIcon(
              R.imagesHomeMyJournals,
              () {
                Util.toast('我的期刊');
              },
            ),
            _createListView(),
            SizedBox(
              height: 20.w,
            ),
            //待办工作
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 19.w,
                ),
                Image.asset(
                  R.imagesHomeTodo,
                  width: 102,
                  height: 42,
                ),
                Expanded(
                  child: Text(''),
                ),
              ],
            ),
            SizedBox(
              height: 16.w,
            ),
            Container(
              width: double.infinity,
              height: 74.w,
              margin: EdgeInsets.only(left: 4.w, right: 4.w),
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
                  _buildItem(() {
                    RouterUtil.toNamed(AppRoutes.CorrectHomeworkPage,
                        arguments: {
                          CorrectHomeworkPage.NeedNotify: true,
                          CorrectHomeworkPage.listType:
                              ScoreListType.waitTipsList
                        });
                  }, context, R.imagesHomeWorkTips, '待提醒',
                      '(${myTipsNum.remindCount ?? 0})'),
                  Container(
                    width: 1,
                    margin: EdgeInsets.only(top: 18.w, bottom: 18.w),
                    height: double.infinity,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  _buildItem(() {
                    RouterUtil.toNamed(AppRoutes.CorrectHomeworkPage,
                        arguments: {
                          CorrectHomeworkPage.NeedNotify: false,
                          CorrectHomeworkPage.listType:
                              ScoreListType.waitCorrectingList
                        });
                  }, context, R.imagesHomeWorkChange, '待批改',
                      '(${myTipsNum.correctionCount ?? 0})'),
                ],
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            //推荐期刊
            buildImageWithClickableIcon(
              R.imagesHomeRecommendJournals,
              () {
                Util.toast('推荐期刊');
              },
            ),
            SizedBox(
              height: 16.w,
            ),
            Container(
              margin: EdgeInsets.only(left: 4.w, right: 4.w),
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
              width: double.infinity,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _buildListItems(),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 16.w)),
          ],
        ),
      );

  List<Widget> _buildListItems() {
    List<Widget> items = [];
    // 假设数据列表为 data，这里只是简单列举
    if (myBottomDate.isEmpty) {
      // 如果数据列表为空，返回一个占位图组件
      items.add(
        PlaceholderPage(
            imageAsset: R.imagesCommenNoDate,
            title: '暂无数据',
            topMargin: 0.w,
            subtitle: ''),
      );
    } else {
      // 否则返回原来的 ListView.builder 组件
      items.add(
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: myBottomDate.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                weekList.Records old = myBottomDate[index];
                newData.Obj updatedObj = updateObj(old);
                RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,
                    arguments: updatedObj);
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: 20.w, bottom: 20.w, left: 4.w, right: 4.w),
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 54.w,
                          margin: EdgeInsets.only(left: 4.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                myBottomDate[index].name ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xff3e454e)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                (myBottomDate[index].createTime ?? '') +
                                    " " +
                                    "阅读" +
                                    myBottomDate[index].journalView.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff898a93),
                                    fontWeight: FontWeight.w400),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      child:ExtendedImage.network(
                        myBottomDate[index].coverImg ?? "",
                        cacheRawData: true,
                        width: 54.w,
                        height: 54.w,
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
                      ) ,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
    return items;
  }

  Widget _buildItem(GestureTapCallback callback, BuildContext context,
      String imagePath, String text, String text2) {
    return Expanded(
      child: InkWell(
        onTap: () {
          callback.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 44.w,
              height: 44.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff353e4d)),
                ),
                SizedBox(
                  height: 2.w,
                ),
                Text(
                  text2,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffed702d)),
                ),
              ],
            )
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

  Widget _buildClassCard(int index) => Container(
      margin: EdgeInsets.only(top: 10.w),
      width: double.infinity,
      height: 65.w,
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(left: 20.w)),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 7.w)),
                      Text(
                        "初 160 完形填空 Module 1 Unit3",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.c_FF101010),
                      ),
                      Text(
                        "剩余时间：7小时29分钟",
                        style: TextStyle(
                            fontSize: 10.sp, color: AppColors.TEXT_GRAY_COLOR),
                      ),
                    ],
                  )),
              Image.asset(
                R.imagesTeacherHomeBtnPop,
                width: 11.w,
                height: 11.w,
              ),
              Padding(padding: EdgeInsets.only(left: 10.w)),
            ],
          ),
          Positioned(
              right: 0,
              top: 0,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.c_FFFFBC00,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.w),
                        topRight: Radius.circular(10.w))
                    // FFBC00
                    ),
                // color: AppColors.darkGray,
                width: 68.w,
                height: 18.w,
                child: Text(
                  "进度：7/99",
                  style:
                      TextStyle(fontSize: 10.sp, color: AppColors.c_FFFFFFFF),
                ),
              ))
          // Align(
          //     alignment: Alignment.topRight,
          //   child: Image.asset(R.imagesIndexClassNew,width: 56.w,height: 18.w,)
          // )
        ],
      ));
  var _future = Future.delayed(Duration(seconds: 1), () {
    return '老王，一个有态度的程序员'; //模拟json字符串
  });

  //构建FutureBuilder控件：
  Widget _createListView() {
    return myListDate.length > 0 ? _dataWidget() : _loadingErrorWidget();
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
        margin: EdgeInsets.only(left: 4.w, right: 4.w, top: 18.w),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: myListDate.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                weekList.Records old = myListDate[index];
                newData.Obj updatedObj = updateObj(old);
                RouterUtil.toNamed(AppRoutes.WeeklyTestCategory,
                    arguments: updatedObj);
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: 4.w, right: 14.w, bottom: 6.w, top: 6.w),
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                width: 288.w,
                height: 98.w,
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
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      child: ExtendedImage.network(
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
                    ),
                    Expanded(
                      child: Container(
                          height: 74.w,
                          margin: EdgeInsets.only(left: 4.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                myBottomDate[index].createTime ?? '',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff898a93),
                                    fontWeight: FontWeight.w400),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                myListDate[index].journalView.toString() + "阅读",
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
  void dispose() {
    Get.delete<TeacherIndexLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    //新增金刚区的列表，有图片
    logic.getHomeListNew();
    //获取我的期刊列表
    logic.getMyJournalList("${SpUtil.getInt(BaseConstant.USER_ID)}", 10, 1);
    //获取我的推荐期刊任务
    logic.getMyRecommendation("${SpUtil.getInt(BaseConstant.USER_ID)}", 10, 1);
    //提醒数量
    logic.getNumber();
  }

  void _onLoading() async {}

  newData.Obj updateObj(weekList.Records obj,
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

  @override
  void onCreate() {
  }

  @override
  void onDestroy() {
  }
}
