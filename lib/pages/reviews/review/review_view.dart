import 'dart:async';
import 'dart:convert';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/blocs/refresh_bloc_bloc.dart';
import 'package:crazyenglish/blocs/refresh_bloc_state.dart';
import 'package:crazyenglish/blocs/update_collect_bloc.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/review/ReviewHomeDetail.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import 'review_logic.dart';

class ReviewPage extends BasePage {
  ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState getState() => _ReviewPageState();
}

class _ReviewPageState extends BasePageState<ReviewPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ReviewLogic());
  final state = Get.find<ReviewLogic>().state;
  // ReviewHomeDetail? paperDetail;
  StreamSubscription? refrehStreamSubscription;
  StreamSubscription? refrehCollectStreamSubscription;

  @override
  void initState() {
    super.initState();

    refrehStreamSubscription = BlocProvider.of<RefreshBlocBloc>(context).stream.listen((event) {
      if(event is RefreshAnswerState){
        if(logic!=null && SpUtil.getInt(BaseConstant.USER_ID)>0){
          logic.getHomePagerInfo(SpUtil.getInt(BaseConstant.USER_ID).toString());
        }
      }
    });

    refrehCollectStreamSubscription = BlocProvider.of<UpdateCollectBloc>(context).stream.listen((event) {
      if(logic!=null && SpUtil.getInt(BaseConstant.USER_ID)>0){
        logic.getHomePagerInfo(SpUtil.getInt(BaseConstant.USER_ID).toString());
      }
    });

    logic.getHomePagerInfo(SpUtil.getInt(BaseConstant.USER_ID).toString());

    //获取金刚区列表
    logic.addListenerId(GetBuilderIds.getHomeDateList, () {
      if (state.tabList != null) {
        if (state.tabList!.obj != null && state.tabList!.obj!.length > 0) {
          RouterUtil.toNamed(AppRoutes.ErrorNotePage,
              arguments: state.tabList!.obj!);
        }
      }
    });
  }

  @override
  void loginChanged() {
    print("loginChanged");
    if(!Util.isLogin()){
      logic.resetOtherCount(ReviewHomeDetail());
    }
    if(mounted){
      print("loginChanged at mounted");
      setState(() {
        isLogin = Util.isLogin();
      });
    }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: false,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: Text(
                "复习巩固",
                style: TextStyle(
                    color: AppColors.c_FF353E4D,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),
              ),
              backgroundColor: Colors.transparent,
            ),
            Container(
              margin: EdgeInsets.only(left: 18.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GetBuilder<ReviewLogic>(
                      id:GetBuilderIds.getReviewHomeDate,
                      builder: (logic){
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${logic.state.cumulativeExercise}",
                          style: TextStyle(
                              color: AppColors.c_FF353E4D,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("累计练习（${logic.state.cumulativeExercise}个）",
                            style: TextStyle(
                              color: AppColors.c_FF434863,
                              fontSize: 12.sp,
                            ))
                      ],
                    );
                  }),
                  Padding(padding: EdgeInsets.only(left: 56.w)),
                  GetBuilder<ReviewLogic>(
                    id:GetBuilderIds.getReviewHomeDate,
                    builder: (logic){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${logic.state.todayExercise}",
                            style: TextStyle(
                                color: AppColors.c_FF353E4D,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text("今日练习（${logic.state.todayExercise}个）",
                              style: TextStyle(
                                color: AppColors.c_FF434863,
                                fontSize: 12.sp,
                              ))
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 97.w,
              padding: EdgeInsets.only(left: 27.w, right: 30.w, top: 37.w),
              margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 18.w),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(R.imagesWrongQuestionItem),
                      fit: BoxFit.contain)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<ReviewLogic>(
                      id: GetBuilderIds.getReviewHomeDate,
                      builder:(logic){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  R.imagesReviewReadingTag,
                                  width: 27.w,
                                  height: 14.w,
                                ),
                                Padding(padding: EdgeInsets.only(left: 3.w)),
                                Text(
                                  "累计错误${logic.state.cumulativeError}次",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 14.sp),
                                ),
                              ],
                            ),
                            Text(
                              "已消灭${logic.state.correct}个错题",
                              style: TextStyle(color: Colors.white, fontSize: 14.sp),
                            )
                          ],
                        );
                      }
                  ),
                  InkWell(
                    onTap: () {
                      //先获取tab接口，带着数据进去
                      logic.getHomeList('classify_type');
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 18.w),
                      child: InkWell(
                        child: Image.asset(
                          R.imagesReviewJumpPractise,
                          width: 57.w,
                          height: 24.w,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            _buildFavor(),
          ],
        ),
      ),
    );
  }

  Widget _buildFavor() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 23.w),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffffffff),
              Color(0xfff6f8fc),
            ]),
      ),
      padding: EdgeInsets.only(left: 18.w, right: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 18.w, top: 19.w, bottom: 17.w),
            child: Text(
              "我的收藏",
              style: TextStyle(
                  color: AppColors.c_FF353E4D,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.c_FFFDD9AF.withOpacity(0.1), // 阴影的颜色
                  offset: Offset(0.w, 1.w), // 阴影与容器的距离
                  blurRadius: 2.w, // 高斯的标准偏差与盒子的形状卷积。
                  spreadRadius: 2.w,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(R.imagesHomeReviewCardBg),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder<ReviewLogic>(
                      id: GetBuilderIds.getReviewHomeDate,
                      builder:(logic){
                        return _buildItem(() {
                          RouterUtil.toNamed(AppRoutes.ErrorNoteCollectPage,
                              arguments: {'type', 0});
                        },
                            title: "收藏题目个",
                            subTitle: "收藏题目${logic.state.collected}个",
                            icon: R.imagesReviewFavorQuestionIcon);
                      }
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18.w, top: 19.w, bottom: 17.w),
            child: Text(
              "练习记录",
              style: TextStyle(
                  color: AppColors.c_FF353E4D,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.c_FFFDD9AF.withOpacity(0.1), // 阴影的颜色
                  offset: Offset(0.w, 1.w), // 阴影与容器的距离
                  blurRadius: 2.w, // 高斯的标准偏差与盒子的形状卷积。
                  spreadRadius: 2.w,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
            ),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(R.imagesHomeReviewCardBg),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                      visible: !Util.isIOSMode(),
                      child: GetBuilder<ReviewLogic>(
                          id: GetBuilderIds.getReviewHomeDate,
                          builder:(logic){
                            return _buildItem(() {
                              RouterUtil.toNamed(
                                  AppRoutes.HomeworkHistoryPage,arguments: {'studentId':SpUtil.getInt(BaseConstant.USER_ID)});
                            },
                                title: "历史作业",
                                subTitle: "历史作业${logic.state.histoty}套",
                                icon: R.imagesReviewHistoryHomework);
                          }
                      )),
                  Visibility(
                    visible: !Util.isIOSMode(),
                    child: Divider(
                    color: AppColors.c_FFD2D5DC,
                    indent: 15.w,
                    endIndent: 15.w,
                  ),),
                  GetBuilder<ReviewLogic>(
                    id: GetBuilderIds.getReviewHomeDate,
                    builder:(logic){
                      return _buildItem(() {
                        RouterUtil.toNamed(
                            AppRoutes.PractiseHistoryPage,arguments: {'studentId':SpUtil.getInt(BaseConstant.USER_ID)}
                        );
                      },
                          title: "练习记录",
                          subTitle: "练习记录${logic.state.practiceRecord}条",
                          icon: R.imagesReviewPractiseRecord);
                    }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildItem(GestureTapCallback onTap,
      {String? icon, String? title, String? subTitle}) {
    return Container(
      height: 78.w,
      padding: EdgeInsets.only(left: 20.w, right: 25.w),
      child: InkWell(
        onTap: () {
          onTap.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  icon!,
                  width: 41.w,
                  height: 37.w,
                ),
                Padding(padding: EdgeInsets.only(left: 22.w)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                          color: AppColors.c_FF353E4D,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp),
                    ),
                    Text(
                      subTitle!,
                      style: TextStyle(
                          color: AppColors.c_FF898A93, fontSize: 12.sp),
                    )
                  ],
                )
              ],
            ),
            Image.asset(
              R.imagesMyIconRightArrow,
              width: 14.w,
              height: 14.w,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ReviewLogic>();
    refrehStreamSubscription?.cancel();
    refrehCollectStreamSubscription?.cancel();
    print("review dispose");
    super.dispose();
  }

  @override
  void onCreate() {
  }

  @override
  void onDestroy() {
  }

  @override
  bool get wantKeepAlive => true;
}
