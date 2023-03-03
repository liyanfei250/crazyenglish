import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import 'mine_logic.dart';

class MinePage extends BasePage {
  const MinePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _MinePageState();
}

class _MinePageState extends BasePageState<MinePage> {
  final logic = Get.put(MineLogic());
  final state = Get
      .find<MineLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(R.imagesMyTopBg),
              Container(
                margin: EdgeInsets.only(top: 69.w, left: 16.w),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      ClipOval(
                          child: CircleAvatar(
                              radius: 30.w,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                  "images/icon_home_me_default_head.png"))),
                      Padding(padding: EdgeInsets.only(left: 15.w)),
                      isLogin //是否登录
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () =>
                                  RouterUtil.toNamed(AppRoutes.LoginNew),
                              child: Text(
                                "吴尊",
                                style: TextStyle(
                                    color: AppColors.c_FFFFFFFF,
                                    fontSize: 20.w),
                              )),
                          //TextButton(onPressed: toLogin(), child: Text("用户登录")),
                          Text(
                            "要读的书太多，没时间写签名",
                            style: TextStyle(
                                color: AppColors.c_FFFFEBEB,
                                fontSize: 16.sp),
                          )
                        ],
                      )
                          :
                      GestureDetector(
                          onTap: () {
                            RouterUtil.toNamed(AppRoutes.LoginNew);
                          },
                          child: Container(
                            child: Text("未登录",
                                style: TextStyle(
                                    color: AppColors.c_FFFFEBEB,
                                    fontSize: 16.sp)),
                          )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          buildItem(
              "我的订单",
              Image(
                image: AssetImage(R.imagesMyIconOrder),
                width: 30.w,
                height: 30.w,
              ),
              0),
          buildItem(
              "我的优惠券",
              Image(
                image: AssetImage(R.imagesMyIconCoupon),
                width: 30.w,
                height: 30.w,
              ),
              1),
          buildItem(
              "分享给好友",
              Image(
                image: AssetImage(R.imagesMyIconShare),
                width: 30.w,
                height: 30.w,
              ),
              2),
          buildItem(
              "帮助",
              Image(
                image: AssetImage(R.imagesMyIconHelp),
                width: 30.w,
                height: 30.w,
              ),
              3),
          buildItem(
              "设置",
              Image(
                image: AssetImage("images/my_icon_setting.png"),
                width: 30.w,
                height: 30.w,
              ),
              4),
        ],
      ),
    );
  }

  void onClickPosition(int position) {
    switch (position) {
      case 4:
        RouterUtil.toNamed(AppRoutes.SettingPage);
        break;
      default:
        break;
    }
  }

  Widget buildItem(String menu, Image icon, int position) {
    return Container(
        padding: EdgeInsets.only(left: 26.5.w),
        height: 58.5.w,
        child: GestureDetector(
          onTap: () {
            onClickPosition(position);
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 57.5.w,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    icon,
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15.w,
                      ),
                      child: Text(
                        menu,
                        style: TextStyle(
                          color: AppColors.c_FF32374E,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(""),
                    ),
                    Image.asset(
                      'images/my_icon_right_arrow.png',
                      height: 13.w,
                      width: 13.w,
                    ),
                    Padding(padding: EdgeInsets.only(right: 11.8.w)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 55.w),
                child: Divider(
                  height: 0.5.w,
                  color: AppColors.c_FFECECEC,
                ),
              ),
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
