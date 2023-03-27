import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/swiper.dart';
import 'teacher_index_logic.dart';

class TeacherIndexPage extends StatefulWidget {
  const TeacherIndexPage({Key? key}) : super(key: key);

  @override
  _TeacherIndexPageState createState() => _TeacherIndexPageState();
}

class _TeacherIndexPageState extends State<TeacherIndexPage> {
  final logic = Get.put(TeacherIndexLogic());
  final state = Get.find<TeacherIndexLogic>().state;

  final List<String> functionTxt = [
    "英语周报",
    "每周题库",
    "历史作业",
    "试卷库",
    "商城",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesHomeTeachBg), fit: BoxFit.fill),
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
                margin: EdgeInsets.only(left: 14.w,right: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 16.w)),
                    adsBanner,
                    Padding(padding: EdgeInsets.only(top: 22.w)),
                    GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: functionTxt.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                        itemBuilder: (_, int position) {
                          String e = functionTxt[position];
                          return _buildFuncAreaItem(e);
                        }),
                    Padding(padding: EdgeInsets.only(top: 20.w)),
                    _buildClassArea(),
                  ],
                ),
              )],
          ),
        )) ;
  }
  Widget _buildSearchBar() => Container(
    margin: EdgeInsets.only( top: 15.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: Image.asset(
            R.imagesShopImageLogoTest,
            width: 32.w,
            height: 32.w,
          ),
        ),
        Container(
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
                "英语周报教师端",
                style: TextStyle(fontSize: 12.sp, color: Color(0xff898a93)),
              )
            ],
          ),
        ),
      ],
    ),
  );
  Widget get adsBanner {
    return Container(
      width: double.infinity,
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
            case "每周题库":
              RouterUtil.toNamed(AppRoutes.WeeklyTestList);
              break;
            case "英语周报":
              RouterUtil.toNamed(AppRoutes.WeeklyList);
              break;
            case "历史作业":
              RouterUtil.toNamed(AppRoutes.TEACHER_WORK);
              break;
            case "试卷库":
              RouterUtil.toNamed(AppRoutes.TEACHER_WORK);
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
                "images/num_index${functionTxt.indexOf(e)}.png",
                width: 42.w,
                height: 42.w,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 8.w)),
            Text(
              e,
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
            buildImageWithClickableIcon(
              R.imagesHomeTodo,
              () {
                Util.toast('待办工作');
              },
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
                  _buildItem(context, R.imagesHomeWorkTips, '待提醒', '(10)'),
                  Container(
                    width: 1,
                    margin: EdgeInsets.only(top: 18.w, bottom: 18.w),
                    height: double.infinity,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  _buildItem(context, R.imagesHomeWorkChange, '待批改', '(10)'),
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
    );
  }

  Widget buildImageWithClickableIcon(
      String imagePath, void Function()? onPress) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 4.w,
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
              margin: EdgeInsets.only(right: 6.w),
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
        margin: EdgeInsets.only(left: 4.w, right: 4.w, top: 18.w),
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
  void dispose() {
    Get.delete<TeacherIndexLogic>();
    super.dispose();
  }
}
