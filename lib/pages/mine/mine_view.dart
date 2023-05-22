import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/base/widgetPage/dialog_manager.dart';
import 'package:crazyenglish/blocs/refresh_bloc_bloc.dart';
import 'package:crazyenglish/blocs/refresh_bloc_event.dart';
import 'package:crazyenglish/blocs/refresh_bloc_state.dart';
import 'package:crazyenglish/pages/homework/choose_history_new_homework/choose_history_new_homework_view.dart';
import 'package:crazyenglish/pages/mine/person_info/person_info_logic.dart';
import 'package:crazyenglish/pages/mine/question_feedback/question_feedback_view.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart' as appUtil;
import '../../base/common.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../utils/sp_util.dart';
import 'mine_logic.dart';
import '../../../entity/user_info_response.dart' as userIfo;

class MinePage extends BasePage {
  const MinePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _MinePageState();
}

class _MinePageState extends BasePageState<MinePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;
  final personInfoLazyLogic = Get.lazyPut(()=>Person_infoLogic());
  final personInfoLogic = Get.find<Person_infoLogic>();
  final personInfoState = Get.find<Person_infoLogic>().state;
  final TextStyle textStyle = TextStyle(
      fontSize: 13, color: Color(0xff353e4d), fontWeight: FontWeight.w400);

  StreamSubscription? refrehUserInfoStreamSubscription;
  void onClickPosition(int position) {
    switch (position) {
      case 0:

        break;
      case 1: //意见反馈
        RouterUtil.toNamed(AppRoutes.QuestionFeedbackPage,
            isNeedCheckLogin: true, arguments: { QuestionFeedbackPage.FeedBack : true});
        break;
      case 2: //关于我们
        RouterUtil.toNamed(AppRoutes.AboutUsPage);
        break;
      case 3:
        RouterUtil.toNamed(AppRoutes.SettingPage);
        break;
      case 6:
        RouterUtil.toNamed(AppRoutes.QuestionFeedbackPage,
            arguments: {'isFeedback': true});
        break;
      default:
        break;
    }
  }


  @override
  void loginChanged() {
    setState(() {
      isLogin = appUtil.Util.isLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Color(0xfff4f5f8),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 180.w + statusBarHeight,
            // margin: EdgeInsets.only(
            //   top: statusBarHeight,
            // ),
            decoration: BoxDecoration(
              color: Colors.red,
              gradient: LinearGradient(
                colors: [Color(0xffffdeac), Color(0xfff4f5f8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              image: DecorationImage(
                  image: AssetImage(R.imagesMineInfoTopBg), fit: BoxFit.cover),
            ),
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30.w+ statusBarHeight, left: 18.w),
              child: InkWell(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                        child: GetBuilder<Person_infoLogic>(
                            id: GetBuilderIds.getPersonInfo,
                            builder: (logic){
                              return InkWell(
                                onTap: (){
                                  if((logic.state.infoResponse.obj?.url ?? "").startsWith("http")){
                                    DialogManager.showPreViewImageDialog(
                                        BackButtonBehavior.close,
                                        logic.state.infoResponse.obj?.url ?? ""
                                    );
                                  }else{
                                    RouterUtil.toNamed(AppRoutes.PersonInfoPage,
                                        isNeedCheckLogin: true,
                                        arguments: {
                                          'isStudent':
                                          SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)
                                              ? false
                                              : true
                                        });
                                  }
                                },
                                child: ExtendedImage.network(
                                  logic.state.infoResponse.obj?.url??"",
                                  cacheRawData: true,
                                  width: 82.w,
                                  height: 82.w,
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
                                          R.imagesIconHomeMeDefaultHead,
                                          fit: BoxFit.fill,
                                        );
                                    }
                                  },
                                ),
                              );
                            })),
                    Padding(padding: EdgeInsets.only(top: 15.w)),
                    isLogin //是否登录
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (!appUtil.Util.isIOSMode()) {
                                      RouterUtil.toNamed(
                                          AppRoutes.PersonInfoPage,
                                          isNeedCheckLogin: true,
                                          arguments: {
                                            'isStudent': SpUtil.getBool(
                                                    BaseConstant
                                                        .IS_TEACHER_LOGIN)
                                                ? false
                                                : true
                                          });
                                    }
                                  },
                                  child: Text(
                                    SpUtil.getString(BaseConstant.USER_NAME),
                                    style: TextStyle(
                                        color: Color(0xff353e4d),
                                        fontSize: 20.w),
                                  )),
                              //TextButton(onPressed: toLogin(), child: Text("用户登录")),
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              RouterUtil.toNamed(AppRoutes.PersonInfoPage,
                                  isNeedCheckLogin: true,
                                  arguments: {
                                    'isStudent': SpUtil.getBool(
                                            BaseConstant.IS_TEACHER_LOGIN)
                                        ? false
                                        : true
                                  });
                            },
                            child: Container(
                              child: Text("未登录",
                                  style: TextStyle(
                                      color: Color(0xff353e4d),
                                      fontSize: 16.sp)),
                            )),
                    Container(
                      margin: EdgeInsets.only(left: 2.w,top: 6.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(R.imagesMineGradeIcon,width: 20.w,height: 20.w,),
                              Padding(padding: EdgeInsets.only(left: 10.w)),
                              GetBuilder<Person_infoLogic>(
                                  id: GetBuilderIds.getPersonInfo,
                                  builder: (logic){
                                    return Text(
                                      isLogin? (logic.state.infoResponse.obj?.affiliatedGradeName ?? "").replaceAll(",", " "):"年级未知",
                                      style: TextStyle(fontSize: 12.sp,color: AppColors.c_FF898A93),
                                    );
                                  })
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              RouterUtil.toNamed(AppRoutes.PersonInfoPage,
                                  isNeedCheckLogin: true,
                                  arguments: {
                                    'isStudent':
                                    SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)
                                        ? false
                                        : true
                                  });
                            },
                            child: Container(
                              width: 67.w,
                              height: 20.w,
                              margin: EdgeInsets.only(right: 18.w),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.c_FFDFE2E9,width: 0.4.w),
                                  borderRadius: BorderRadius.all(Radius.circular(17.w))
                              ),
                              child: Text("编辑资料",style: TextStyle(color: AppColors.c_FF8B8F94,fontSize:12.sp),),
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: !appUtil.Util.isIOSMode(),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
              margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 20.w),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildItemType('我的班级', R.imagesMineClass),
                  // buildItemType('我的订单', R.imagesMineOrder),
                  SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)
                      ? buildItemType('历史作业', R.imagesMineHistoryWork)
                      : buildItemType('题目反馈', R.imagesMineHistoryWork),
                ],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
              margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 20.w),
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
                children: [
                  // buildItem(
                  //     "给我们评价",
                  //     Image(
                  //       image: AssetImage(R.imagesMineAppraise),
                  //       width: 20.w,
                  //       height: 20.w,
                  //     ),
                  //     0),
                  buildItem(
                      "意见反馈",
                      Image(
                        image: AssetImage(R.imagesMineAdvice),
                        width: 20.w,
                        height: 20.w,
                      ),
                      1),
                  buildItem(
                      "关于我们",
                      Image(
                        image: AssetImage(R.imagesMineAboutUs),
                        width: 20.w,
                        height: 20.w,
                      ),
                      2),
                  buildItem(
                      "我的设置",
                      Image(
                        image: AssetImage(R.imagesMineSetting),
                        width: 20.w,
                        height: 20.w,
                      ),
                      3),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildItemType(String menu, String icon) {
    return InkWell(
      onTap: () {
        switch (menu) {
          case '我的班级':
            if (SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)) {
              RouterUtil.toNamed(AppRoutes.MyClassListPage,
                  isNeedCheckLogin: true);
            } else {
              userIfo.UserInfoResponse? infoResponse =appUtil.Util.getUserInfoResponse();
              RouterUtil.toNamed(
                  AppRoutes.QRViewPageNextClass,
                  isNeedCheckLogin: true,
                  arguments: {
                    'isShowAdd': 0,
                    'classId': infoResponse?.obj?.classId??""
                  });
            }
            break;
          case '我的订单':
            RouterUtil.toNamed(
              AppRoutes.MyOrderPage,
              isNeedCheckLogin: true,
            );
            break;
          case '历史作业':
            RouterUtil.toNamed(AppRoutes.ChooseHistoryNewHomeworkPage,
                isNeedCheckLogin: true,
                arguments: {ChooseHistoryNewHomeworkPage.IsAssignHomework: false});
            break;
          case '题目反馈':
            RouterUtil.toNamed(AppRoutes.QuestionFeedbackPage,
                isNeedCheckLogin: true, arguments: { QuestionFeedbackPage.FeedBack : true});
            break;
          default:
            return null;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 31.w,
            width: 31.w,
          ),
          SizedBox(
            height: 3.w,
          ),
          Text(
            menu,
            style: textStyle,
          )
        ],
      ),
    );
  }

  Widget buildItem(String menu, Image icon, int position) {
    return Container(
        padding: EdgeInsets.only(left: 24.w),
        height: 58.5.w,
        child: InkWell(
          onTap: () {
            onClickPosition(position);
          },
          child: Row(
            children: [
              icon,
              Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                ),
                child: Text(
                  menu,
                  style: TextStyle(
                    color: AppColors.c_FF32374E,
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: Text(""),
              ),
              Image.asset(
                R.imagesHomeNextIcBlack,
                height: 7.w,
                width: 11.w,
              ),
              Padding(padding: EdgeInsets.only(right: 25.w)),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    Get.delete<MineLogic>();
    Get.delete<Person_infoLogic>();
    if(refrehUserInfoStreamSubscription !=null){
      refrehUserInfoStreamSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  void onCreate() {
    int userId = SpUtil.getInt(BaseConstant.USER_ID);
    if(personInfoLogic!=null && userId>0){
      personInfoLogic!.getPersonInfo("$userId");
    }
    refrehUserInfoStreamSubscription = BlocProvider.of<RefreshBlocBloc>(context).stream.listen((event) {
      if(event is RefreshPersonInfoState){
        int userId = SpUtil.getInt(BaseConstant.USER_ID);
        if(personInfoLogic!=null && userId>0){
          personInfoLogic!.getPersonInfo("$userId");
        }
      }
    });
  }

  @override
  void onDestroy() {
  }
}
