import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/swiper.dart';
import 'index_logic.dart';

class IndexPage extends BasePage {
  const IndexPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _IndexPageState();
}

class _IndexPageState extends BasePageState<IndexPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(IndexLogic());
  final state = Get.find<IndexLogic>().state;

  final List<String> functionTxt = [
    "周报阅读",
    "周报题库",
    "综合听力",
    "阅读理解",
    "写作训练",
    "语言运用",
    "商城",
  ];
  List listData = [
    {
      "title": "【完形填空】Module 1 Unit3",
      "type": 0,
    },
    {"title": "【单词速记】Module 1 Unit3", "type": 1},
    {"title": "【单词速记】Module 2 Unit3", "type": 2},
    {"title": "【单词速记】Module 3 Unit3", "type": 3},
  ];

  @override
  void initState() {
    super.initState();
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
        child: SingleChildScrollView(
          child: Column(
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
                    // GridView.builder(
                    //     shrinkWrap:true,
                    //     itemCount: functionTxt.length,
                    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                    //     itemBuilder: (_,int position){
                    //       String e = functionTxt[position];
                    //       return _buildFuncAreaItem(e);
                    //     }),
                    Container(
                      height: 80.w,
                      margin: EdgeInsets.symmetric(horizontal: 14.w),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: functionTxt.length,
                          itemBuilder: (_, int position) {
                            String e = functionTxt[position];
                            return _buildFuncAreaItem(e);
                          }),
                    ),
                    Padding(padding: EdgeInsets.only(top: 12.w)),
                    //我的期刊
                    buildImageWithClickableIcon(
                      R.imagesHomeMyJournals,
                      () {
                        Util.toast('我的期刊');
                      },
                    ),
                    _createListView(),
                    Padding(padding: EdgeInsets.only(top: 14.w)),
                    _buildClassArea(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageWithClickableIcon(
      String imagePath, void Function()? onPress) {
    return Row(
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
          child: GestureDetector(
            onTap: onPress,
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 20),
              child: Image.asset(
                R.imagesHomeNextIcBlack,
                width: 10,
                height: 10,
              ),
            ),
          ),
        ),
      ],
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

  Widget _buildFuncAreaItem(String e) => InkWell(
        onTap: () {
          switch (e) {
            case "周报题库":
              RouterUtil.toNamed(AppRoutes.WeeklyTestList);
              break;
            case "周报阅读":
              RouterUtil.toNamed(AppRoutes.WeeklyList);
              break;
            case "写作训练":
              RouterUtil.toNamed(AppRoutes.WritingPage);
              break;
            case "综合口语":
              RouterUtil.toNamed(AppRoutes.TextToVoice);
              break;
            case "阅读理解":
              RouterUtil.toNamed(AppRoutes.INITIALNew);
              break;
            case "综合听力":
              RouterUtil.toNamed(AppRoutes.ListeningPracticePage);
              break;
            case "语言运用":
              RouterUtil.toNamed(AppRoutes.LOGIN);
              break;
            case "商城":
              RouterUtil.toNamed(AppRoutes.ToShoppingPage);
              break;
          }
        },
        child: Container(
          margin: EdgeInsets.only(right: 29.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "images/student_index_${functionTxt.indexOf(e)}.png",
                width: 50.w,
                height: 50.w,
              ),
              Padding(padding: EdgeInsets.only(bottom: 10.w)),
              Text(
                e,
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
            Row(
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
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 20),
                      child: Image.asset(
                        R.imagesHomeNextIcBlack,
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                )
              ],
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

  Widget _buildSearchBar() => Container(
        margin: EdgeInsets.only(top: 7.w),
        width: double.infinity,
        height: 28.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                  GestureDetector(
                      onTap: () {
                        RouterUtil.toNamed(AppRoutes.HomeSearchPage);
                      },
                      child: Text(
                        "搜词/翻译",
                        style: TextStyle(
                            fontSize: 16.sp, color: AppColors.TEXT_GRAY_COLOR),
                      ))
                ],
              ),
            )),
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
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          var widget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              widget = _loadingErrorWidget();
            } else {
              widget = _dataWidget(snapshot.data);
            }
          } else {
            widget = _loadingWidget();
          }
          return widget;
        });
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
  _dataWidget(data) {
    return Container(
        height: 100.w,
        margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 18.w),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Container(
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
                    child: Image.asset(
                      R.imagesHomeShowBuy,
                      width: 52.w,
                      height: 74.w,
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

  @override
  void dispose() {
    Get.delete<IndexLogic>();
    super.dispose();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
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

Widget _listOne(value) => Container(
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
                    child: Text("7/99",
                        style: TextStyle(
                            color: Color(0xff8b8f9f),
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(width: 10.w),
                  Text(value['title'],
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
                    Text("剩余时间：7小时29分钟",
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
    );
