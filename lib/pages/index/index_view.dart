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
                    Container(
                        height: 100.w,
                        margin: EdgeInsets.only(left: 8.w, right: 8.w),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.all(10),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                        )),
                    //待办工作
                    buildImageWithClickableIcon(
                      R.imagesHomeTodo,
                      () {
                        Util.toast('待办工作');
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: 74.w,
                      margin: EdgeInsets.only(left: 18.w, right: 18.w),
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
                          _buildItem(
                              context, R.imagesHomeWorkTips, '待提醒', '(10)'),
                          Container(
                            width: 1,
                            margin: EdgeInsets.only(top: 18.w, bottom: 18.w),
                            height: double.infinity,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          _buildItem(
                              context, R.imagesHomeWorkChange, '待批改', '(10)'),
                        ],
                      ),
                    ),
                    //推荐期刊
                    buildImageWithClickableIcon(
                      R.imagesHomeRecommendJournals,
                      () {
                        Util.toast('推荐期刊');
                      },
                    ),
                    Container(
                      margin: EdgeInsets.all(14),
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
                    )
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
                R.imagesIconToNext,
                width: 10,
                height: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(
      BuildContext context, String imagePath, String text, String text2) {
    return Expanded(
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
              SizedBox(height: 2.w,),
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
    );
  }

  List<Widget> _buildListItems() {
    List<Widget> items = [];
    // 假设数据列表为 data，这里只是简单列举
    List data = ['1', '2', '3', '4'];
    if (data.isEmpty) {
      // 如果数据列表为空，返回一个占位图组件
      items.add(
        Center(
          heightFactor: 4.0,
          child: Text('没有数据'),
        ),
      );
    } else {
      // 否则返回原来的 ListView.builder 组件
      items.add(
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(
                  top: 20.w, bottom: 20.w, left: 18.w, right: 18.w),
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
                              "Everyones Heart",
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
                          ],
                        )),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    child: Image.asset(
                      R.imagesShopImageLogoTest,
                      width: 54.w,
                      height: 54.w,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    return items;
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
