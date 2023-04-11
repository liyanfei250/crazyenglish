import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/common.dart';
import '../../config.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../utils/sp_util.dart';
import 'mine_logic.dart';

class MinePage extends BasePage {
  const MinePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _MinePageState();
}

class _MinePageState extends BasePageState<MinePage> {
  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;
  final TextStyle textStyle = TextStyle(
      fontSize: 13, color: Color(0xff353e4d), fontWeight: FontWeight.w400);

  void onClickPosition(int position) {
    switch (position) {
      case 4:
        RouterUtil.toNamed(AppRoutes.SettingPage);
        break;
      case 6:
        RouterUtil.toNamed(AppRoutes.QuestionFeedbackPage);
        break;
      case 5:
        var role = '';
        if (SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)) {
          role = '学生端';
        } else {
          role = '教师端';
        }
        showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("提示"),
              content: Text("您确定要切换到" + role + "吗？"),
              actions: <Widget>[
                TextButton(
                  child: Text("取消"),
                  onPressed: () => Navigator.of(context).pop(), // 关闭对话框
                ),
                TextButton(
                  child: Text("确定"),
                  onPressed: () {
                    Navigator.of(context).pop(true); //关闭对话框
                    // ... 执行
                    if (SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)) {
                      RouterUtil.offAndToNamed(AppRoutes.HOME);
                      SpUtil.putBool(BaseConstant.IS_TEACHER_LOGIN, false);
                    } else {
                      RouterUtil.offAndToNamed(AppRoutes.TEACHER_HOME);
                      SpUtil.putBool(BaseConstant.IS_TEACHER_LOGIN, true);
                    }
                  },
                ),
              ],
            );
          },
        );

        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120.w + statusBarHeight,
            margin: EdgeInsets.only(
              top: statusBarHeight,
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: AssetImage(R.imagesHomeTeachBg), fit: BoxFit.fill),
            ),
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30.w, left: 18.w),
              child: GestureDetector(
                onTap: () {
                  RouterUtil.toNamed(AppRoutes.PersonInfoPage);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                        child: Image.asset(
                      R.imagesIconHomeMeDefaultHead,
                      width: 54.w,
                      height: 54.w,
                    )),
                    Padding(padding: EdgeInsets.only(left: 15.w)),
                    isLogin //是否登录
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () =>
                                      RouterUtil.toNamed(AppRoutes.LoginNew),
                                  child: Text(
                                    "吴尊",
                                    style: TextStyle(
                                        color: Color(0xff353e4d),
                                        fontSize: 20.w),
                                  )),
                              //TextButton(onPressed: toLogin(), child: Text("用户登录")),
                              Text(
                                "要读的书太多，没时间写签名",
                                style: TextStyle(
                                    color: Color(0xff898a93), fontSize: 10.sp),
                              )
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              RouterUtil.toNamed(AppRoutes.LoginNew);
                            },
                            child: Container(
                              child: Text("未登录",
                                  style: TextStyle(
                                      color: AppColors.c_FFFFEBEB,
                                      fontSize: 16.sp)),
                            )),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildItemType('我的班级', R.imagesMineClass),
                buildItemType('我的订单', R.imagesMineOrder),
                buildItemType('历史作业', R.imagesMineHistoryWork),
              ],
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
                  buildItem(
                      "给我们评价",
                      Image(
                        image: AssetImage(R.imagesMineAppraise),
                        width: 20.w,
                        height: 20.w,
                      ),
                      0),
                  buildItem(
                      "意见反馈",
                      Image(
                        image: AssetImage(R.imagesMineAdvice),
                        width: 20.w,
                        height: 20.w,
                      ),
                      0),
                  buildItem(
                      "关于我们",
                      Image(
                        image: AssetImage(R.imagesMineAboutUs),
                        width: 20.w,
                        height: 20.w,
                      ),
                      0),
                  buildItem(
                      "我的设置",
                      Image(
                        image: AssetImage(R.imagesMineSetting),
                        width: 20.w,
                        height: 20.w,
                      ),
                      4),
                  buildItem(
                      "切换用户",
                      Image(
                        image: AssetImage("images/my_icon_setting.png"),
                        width: 20.w,
                        height: 20.w,
                      ),
                      5),
                  buildItem(
                      "题目反馈",
                      Image(
                        image: AssetImage("images/my_icon_setting.png"),
                        width: 20.w,
                        height: 20.w,
                      ),
                      6),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildItemType(String menu, String icon) {
    return Column(
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
    );
  }

  Widget buildItem(String menu, Image icon, int position) {
    return Container(
        padding: EdgeInsets.only(left: 24.w),
        height: 58.5.w,
        child: GestureDetector(
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    Get.delete<MineLogic>();
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
