import 'dart:convert';

import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../r.dart';
import 'review_logic.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final logic = Get.put(ReviewLogic());
  final state = Get.find<ReviewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.imagesReviewTopBg),
              fit: BoxFit.cover
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                elevation: 0,
                automaticallyImplyLeading:false,
                title: Text("复习巩固",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 20.sp),),
                backgroundColor:Colors.transparent,
                actions: [
                  InkWell(
                    onTap: (){
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 18.w),
                      child: Image.asset(R.imagesReviewPractiseHistory,width: 93.w,height: 30.w,),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("195",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 26.sp,fontWeight: FontWeight.w500),),
                        Text("累计练习（10个）",style: TextStyle(color: AppColors.c_FF434863,fontSize: 12.sp,))
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(left: 56.w)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("10",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 26.sp,fontWeight: FontWeight.w500),),
                        Text("今日练习（10个）",style: TextStyle(color: AppColors.c_FF434863,fontSize: 12.sp,))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 97.w,
                padding: EdgeInsets.only(left: 27.w,right: 30.w,top: 37.w),
                margin: EdgeInsets.only(left: 18.w,right: 18.w,top: 18.w),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(R.imagesWrongQuestionItem),
                    fit: BoxFit.contain
                  )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(R.imagesReviewReadingTag,width: 27.w,height: 14.w,),
                            Padding(padding: EdgeInsets.only(left: 3.w)),
                            Text("累计错误5次",style: TextStyle(color: Colors.white,fontSize: 14.sp),),
                          ],
                        ),
                        Text("已消灭10个错题",style: TextStyle(color: Colors.white,fontSize: 14.sp),)
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18.w),
                      child: InkWell(
                        child: Image.asset(R.imagesReviewJumpPractise,width:57.w,height: 24.w,),
                      ),
                    )
                  ],
                ),
              ),
              _buildFavor()
            ],
          ),
        ),
    );
  }

  Widget _buildFavor(){

    return Expanded(child: Container(
      margin: EdgeInsets.only(top: 23.w),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin:Alignment.topCenter,
            end:Alignment.bottomCenter,
            colors: [
          Color(0xffffffff),
          Color(0xfff6f8fc),
        ]),
      ),
      padding: EdgeInsets.only(left: 18.w,right: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 18.w,top: 19.w,bottom: 17.w),
            child: Text("我的收藏",style: TextStyle(color: AppColors.c_FF353E4D,
                fontWeight: FontWeight.w500,fontSize: 16.sp),),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.imagesReviewFavorQuestionBg),
                    fit: BoxFit.contain
                )
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFavorItem(0),
                Divider(color: AppColors.c_FFD2D5DC,indent: 15.w,endIndent: 15.w,),
                _buildFavorItem(1),
              ],
            ),
          ),

        ],
      ),
    ));
  }

  Widget _buildFavorItem(int type ){
    String icon = R.imagesReviewFavorQuestionIcon;
    String title = "收藏题目19个";
    String subTitle = "复习题目7个";

    if(type == 0){
      icon = R.imagesReviewFavorQuestionIcon;
      title = "收藏题目19个";
      subTitle = "复习题目7个";
    }else{
      icon = R.imagesReviewFavorWordsIcon;
      title = "收藏单词19个";
      subTitle = "复习单词7个";
    }
    return Container(
      height: 78.w,
      padding: EdgeInsets.only(left: 20.w,right: 25.w),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(icon,width: 41.w,height: 37.w,),
                Padding(padding: EdgeInsets.only(left: 22.w)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title,style: TextStyle(color: AppColors.c_FF353E4D,
                        fontWeight: FontWeight.w500,fontSize: 16.sp),),
                    Text(subTitle,style: TextStyle(color:AppColors.c_FF898A93,fontSize: 12.sp),)
                  ],
                )
              ],
            ),
            Image.asset(R.imagesMyIconRightArrow,width: 14.w,height: 14.w,)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ReviewLogic>();
    super.dispose();
  }
}