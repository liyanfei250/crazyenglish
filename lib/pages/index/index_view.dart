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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Image.asset(
                        R.imagesStudentDayWords,
                        width: 123.w,
                        height: 23.w,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.w)),
                    _buildPlayBar(),
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

  Widget _buildPlayBar() => Container(
        width: double.infinity,
        height: 64.w,
        margin: EdgeInsets.symmetric(horizontal: 14.w),
        padding:
            EdgeInsets.only(left: 24.w, right: 10.w, top: 10.w, bottom: 10.w),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesIndexDayWord), fit: BoxFit.fitWidth),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Group",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.sp,
                      fontStyle: FontStyle.italic,
                      color: AppColors.c_FFFFFFFF),
                ),
                Image.asset(
                  R.imagesIndexCollectionWords,
                  width: 37.w,
                  height: 10.w,
                )
              ],
            ),
            SizedBox(
              width: 18.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _item_word(),
                _item_word(),
                _item_word(),
              ],
            )
          ],
        ),
      );

  Widget _item_word() => Row(
        children: [
          Text(
            "adj.",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 8.sp,
                fontStyle: FontStyle.normal,
                color: AppColors.c_FFFFFFFF),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "令人满意的；有利的；熟练的；好的",
            style: TextStyle(
                fontSize: 8.sp,
                fontStyle: FontStyle.normal,
                color: AppColors.c_FFFFFFFF),
          ),
        ],
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
                  "今日任务",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: AppColors.c_FF101010),
                ),
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
        margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 7.w),
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
                    width: 22.w,
                    height: 22.w,
                  ),
                  Padding(padding: EdgeInsets.only(left: 9.w)),
                  Text(
                    "疯狂英语",
                    style: TextStyle(
                        fontSize: 16.sp, color: AppColors.TEXT_GRAY_COLOR),
                  )
                ],
              ),
            )),
            Image.asset(
              R.imagesIndexScan,
              width: 18.w,
              height: 18.w,
            )
          ],
        ),
      );

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

Widget _listOne(value) =>
    Container(
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
                    Container(
                      width: 25.w,
                      height: 12.w,
                      padding: EdgeInsets.only(
                          top: 2.w, bottom: 2.w, left: 5.w, right: 5.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7.w)),
                          color: Color(0xfff0e9ff)),
                      child: Text("默认",
                          style: TextStyle(
                              color: Color(0xffc66afe),
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              ],
            ),
          ),
          Image.asset(
            R.imagesIconToNext,
            width: 14.w,
            height: 14.w,
          )
        ],
      ),
    );
