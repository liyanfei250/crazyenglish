import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../r.dart';
import '../../widgets/swiper.dart';
import 'recommend_logic.dart';

class RecommendPage extends BasePage {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _RecommendPageState();

}

class _RecommendPageState extends BasePageState<RecommendPage> {
  final logic = Get.put(RecommendLogic());
  final state = Get.find<RecommendLogic>().state;

  final List<String> functionTxt = [
    "周报阅读",
    "周报题库",
    "高考真题",
    "中考提分",
    "综合听力",
    "集中识词",
    "语言运用",
    "阅读理解",
    "综合口语",
    "写作训练",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 9.w)),
            adsBanner,
            Padding(padding: EdgeInsets.only(top: 13.w)),
            GridView.builder(
                shrinkWrap:true,
                itemCount: functionTxt.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                itemBuilder: (_,int position){
                  String e = functionTxt[position];
                  return _buildFuncAreaItem(e);
                }),
            Padding(padding: EdgeInsets.only(top: 12.w)),
            _buildPlayBar(),
            Padding(padding: EdgeInsets.only(top: 8.w)),
            _buildTeacherArea(),
            Padding(padding: EdgeInsets.only(top: 14.w)),
            _buildClassArea(),

          ],
        ),
      ),
    );
  }

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
    items.add(Image.asset(R.imagesIndexAd,fit:BoxFit.fill,width: double.infinity,height: 130.w,));
    items.add(Image.asset(R.imagesIndexAd,fit:BoxFit.fill,width: double.infinity,height: 130.w,));
    items.add(Image.asset(R.imagesIndexAd,fit:BoxFit.fill,width: double.infinity,height: 130.w,));
    return items;
  }

  Widget _buildFuncAreaItem(String e) => InkWell(
    onTap: (){
      switch(e){
        case "周报题库":
          RouterUtil.toNamed(AppRoutes.WeeklyTestList);
          break;
        case "周报阅读":
          RouterUtil.toNamed(AppRoutes.WeeklyList);
          break;
        case "综合口语":
          RouterUtil.toNamed(AppRoutes.TextToVoice);
          break;
      }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("images/index_icon_${functionTxt.indexOf(e)+1}.png",width: 40.w,height: 40.w,),
        Padding(padding: EdgeInsets.only(bottom: 2.w)),
        Text(e,style: TextStyle(fontSize: 12.sp,color: AppColors.TEXT_BLACK_COLOR),)
      ],
    ),
  );

  Widget _buildPlayBar() => Container(
    width: double.infinity,
    height: 28.w,
    padding: EdgeInsets.only(left: 10.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.w)),
        color: AppColors.c_FFFFEBEB
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(R.imagesIndexIconPlay,width: 16.w,height: 16.w,),
        Padding(padding: EdgeInsets.only(left: 6.w)),
        Text("每日一词:",style: TextStyle(fontSize:10.sp,color: AppColors.TEXT_GRAY_COLOR),)
      ],
    ),
  );

  Widget _buildTeacherArea() => Container(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("名师推荐",style: TextStyle(fontWeight:FontWeight.bold,fontSize:18.sp,color: AppColors.c_FF101010),),
            Image.asset(R.imagesIndexClassMore,width: 55.w,height: 18.w,)
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 10.w)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTeacherCard(0),
            _buildTeacherCard(1),
            _buildTeacherCard(2),
          ],
        )

      ],
    ),
  );

  Widget _buildTeacherCard(int index) => Container(
    decoration: BoxDecoration(
        boxShadow:[
          BoxShadow(
              color: AppColors.c_FFFFEBEB.withOpacity(0.5),		// 阴影的颜色
              offset: Offset(10, 20),						// 阴影与容器的距离
              blurRadius: 45.0,							// 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 10.0,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(6.w)),
        color: AppColors.c_FFFFFFFF
    ),
    width: 103.w,
    height: 144.w,
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(R.imagesIndexTeacherIcon2,width: 70.w,height: 70.w,),
        Padding(padding: EdgeInsets.only(top: 8.w)),
        Text("Slience",style: TextStyle(fontSize:12.sp,color: AppColors.c_FF101010),),
        Padding(padding: EdgeInsets.only(top: 1.w)),
        Text("金牌讲师",style: TextStyle(fontSize:12.sp,color: AppColors.TEXT_BLACK_COLOR),),
        Padding(padding: EdgeInsets.only(top: 2.w)),
        Container(
          width: 68.w,
          height: 20.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
              color: AppColors.c_FFFF4D35
          ),
          child: Text("了解老师",style: TextStyle(fontSize:12.sp,color: AppColors.c_FFFFFFFF),),
        )
      ],
    ),
  );

  Widget _buildClassArea() => Container(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("精品课程",style: TextStyle(fontWeight:FontWeight.bold,fontSize:18.sp,color: AppColors.c_FF101010),),
            Image.asset(R.imagesIndexClassMore,width: 55.w,height: 18.w,)
          ],
        ),
        Padding(padding: EdgeInsets.only(left: 4.w)),
        _buildClassCard(0),
        _buildClassCard(1),
        Padding(padding: EdgeInsets.only(top: 16.w)),
      ],
    ),
  );

  Widget _buildClassCard(int index) => Container(
    margin: EdgeInsets.only(top: 6.w),
    padding: EdgeInsets.only(bottom: 7.w),
    width: double.infinity,
    height: 75.w,
    alignment: Alignment.topRight,
    decoration: BoxDecoration(
        boxShadow:[
          BoxShadow(
            color: AppColors.c_FFFFEBEB.withOpacity(0.5),		// 阴影的颜色
            offset: Offset(10, 20),						// 阴影与容器的距离
            blurRadius: 45.0,							// 高斯的标准偏差与盒子的形状卷积。
            spreadRadius: 10.0,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        color: AppColors.c_FFFFFFFF
    ),
    child:Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(left: 7.w)),
            Image.asset(R.imagesIndexClassThumb1,width: 87.w,height: 61.w,),
            Padding(padding: EdgeInsets.only(left: 7.w,top: 7.w)),
            Expanded(
                flex:1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 7.w)),
                    Text("懂你英语A+学习计划",style: TextStyle(fontWeight:FontWeight.bold,fontSize:16.sp,color: AppColors.c_FF101010),),
                    Text("为你量身定制系统化的英语课程",style: TextStyle(fontSize:10.sp,color: AppColors.TEXT_GRAY_COLOR),),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("精品课 量身定制",style: TextStyle(fontWeight:FontWeight.bold,fontSize:10.sp,color: AppColors.c_FFFFBC00),),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("14节课",style: TextStyle(fontWeight:FontWeight.bold,fontSize:10.sp,color: AppColors.c_FFD7D7D7),),
                            Padding(padding: EdgeInsets.only(left: 8.w)),
                            Text("3.8w人学习",style: TextStyle(fontWeight:FontWeight.bold,fontSize:10.sp,color: AppColors.c_FFD7D7D7),),
                            Padding(padding: EdgeInsets.only(right: 8.w)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
        Positioned(
          right: 0,
            top: 0,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.c_FFFFBC00,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.w),topRight: Radius.circular(10.w))
                // FFBC00
              ),
              // color: AppColors.darkGray,
                width: 56.w,height: 18.w,
              child: Text("限时免费",style: TextStyle(fontSize: 10.sp,color: AppColors.c_FFFFFFFF),),

           )
        )
        // Align(
        //     alignment: Alignment.topRight,
        //   child: Image.asset(R.imagesIndexClassNew,width: 56.w,height: 18.w,)
        // )

      ],
    )
  );

  @override
  void dispose() {
    Get.delete<RecommendLogic>();
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