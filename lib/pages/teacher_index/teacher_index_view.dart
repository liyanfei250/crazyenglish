import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
    "周报题库",
    "作业布置",
    "电子教材",
    "周报商城",
    "开始直播",
    "课程录制",
    "打卡日历",
    "试题编写",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 9.w)),
            adsBanner,
            Padding(padding: EdgeInsets.only(top: 13.w)),
            GridView.builder(
                shrinkWrap:true,
                itemCount: functionTxt.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (_,int position){
                  String e = functionTxt[position];
                  return _buildFuncAreaItem(e);
                }),
            Padding(padding: EdgeInsets.only(top: 12.w)),
            Image.asset(R.imagesTeacherDayWords,width: 123.w,height: 22.w,),
            _buildPlayBar(),
            Padding(padding: EdgeInsets.only(top: 8.w)),
            Image.asset(R.imagesTeacherStudentState,width: 159.w,height: 22.w,),
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
        case "试题编写":
        case "作业布置":
          RouterUtil.toNamed(AppRoutes.TEACHER_WORK);
          break;
      }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("images/num_index${functionTxt.indexOf(e)}.png",width: 40.w,height: 40.w,),
        Padding(padding: EdgeInsets.only(bottom: 2.w)),
        Text(e,style: TextStyle(fontSize: 12.sp,color: AppColors.TEXT_BLACK_COLOR),)
      ],
    ),
  );

  Widget _buildPlayBar() => Container(
    width: double.infinity,
    height: 95.w,
    padding: EdgeInsets.only(left: 10.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.w)),
        image: DecorationImage(
            image: AssetImage(R.imagesTeacherDayWordsBg),
            fit: BoxFit.cover
        )
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(alignment: Alignment.bottomLeft,
          children: [
            Image.asset(R.imagesTeacherWordsBg,width: 53.w,height: 10.w,),
            Text("Good ",style: TextStyle(fontSize:26.sp,color: Color(0xFF353e4d),))
          ],
        ),
        Padding(padding: EdgeInsets.only(left: 11.w)),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("adj. ",style: TextStyle(fontSize:10.sp,color: Color(0xFF353e4d),)),
                Text("令人满意的；有利的；熟练的；好的",style: TextStyle(fontSize:12.sp,color: Color(0xFF353e4d),)),
              ],
            ),
            Row(
              children: [
                Text("adv. ",style: TextStyle(fontSize:10.sp,color: Color(0xFF353e4d),)),
                Text("好地",style: TextStyle(fontSize:12.sp,color: Color(0xFF353e4d),)),
              ],
            ),
            Row(
              children: [
                Text("n.    ",style: TextStyle(fontSize:10.sp,color: Color(0xFF353e4d),)),
                Text("善行；好处；美德",style: TextStyle(fontSize:12.sp,color: Color(0xFF353e4d),)),
              ],
            ),
          ],
        )

      ],
    ),
  );

  Widget _buildTopBar() => Container(
    margin: EdgeInsets.only(left: 14.w,right: 14.w,top: 7.w),
    height: 48.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(R.imagesLaunchLogo,fit:BoxFit.cover,width: 22.w,height: 22.w,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(R.imagesIndexSearch,fit:BoxFit.cover,width: 22.w,height: 22.w,),
            Text("扫一扫"),
          ],
        )
      ],
    ),
  );

  Widget _buildSearchBar() => Container(
    margin: EdgeInsets.only(left: 14.w,right: 14.w,top: 7.w),
    height: 28.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 274.w,
          height: 28.w,
          padding: EdgeInsets.only(left: 11.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
              color: AppColors.c_FFF0F0F0
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(R.imagesIndexSearch,fit:BoxFit.cover,width: 22.w,height: 22.w,),
              Padding(padding: EdgeInsets.only(left: 9.w)),
              Text("疯狂英语",style: TextStyle(fontSize:16.sp,color: AppColors.TEXT_GRAY_COLOR),)
            ],
          ),
        ),
        Image.asset(R.imagesIndexMsg,width: 26.w,height: 22.w,)
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
        Padding(padding: EdgeInsets.only(left: 4.w)),
        _buildClassCard(0),
        _buildClassCard(1),
        Padding(padding: EdgeInsets.only(top: 16.w)),
      ],
    ),
  );


  Widget _buildClassCard(int index) => Container(
      margin: EdgeInsets.only(top: 10.w),
      width: double.infinity,
      height: 65.w,
      alignment: Alignment.center,
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
        alignment: Alignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(left: 20.w)),
              Expanded(
                  flex:1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 7.w)),
                      Text("初 160 完形填空 Module 1 Unit3",style: TextStyle(fontWeight:FontWeight.bold,fontSize:16.sp,color: AppColors.c_FF101010),),
                      Text("剩余时间：7小时29分钟",style: TextStyle(fontSize:10.sp,color: AppColors.TEXT_GRAY_COLOR),),
                    ],
                  )),
              Image.asset(R.imagesTeacherHomeBtnPop,width: 11.w,height: 11.w,),
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
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.w),topRight: Radius.circular(10.w))
                  // FFBC00
                ),
                // color: AppColors.darkGray,
                width: 68.w,height: 18.w,
                child: Text("进度：7/99",style: TextStyle(fontSize: 10.sp,color: AppColors.c_FFFFFFFF),),

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
    Get.delete<TeacherIndexLogic>();
    super.dispose();
  }
}