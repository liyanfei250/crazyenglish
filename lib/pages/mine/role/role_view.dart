import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../../utils/sp_util.dart';
import 'role_logic.dart';

class RolePage extends BasePage {
  const RolePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToRolePageState();
}

class _ToRolePageState extends BasePageState<RolePage> {
  final logic = Get.put(RoleLogic());
  final state = Get.find<RoleLogic>().state;
  int? identity; //2老师  3学生
  @override
  void initState() {
    super.initState();

    logic.addListenerId(GetBuilderIds.choiceRole, () {
      if (state.sendCodeResponse.code == 1) {
        SpUtil.putBool(BaseConstant.IS_CHOICE_ROLE, true);
        if (identity == 3) {
          SpUtil.putBool(BaseConstant.IS_CHOICE_ROLE_STUDENT, true);//是学生且没选年级
          RouterUtil.toNamed(AppRoutes.RoleTwoPage, arguments: {'identity': 3});
        } else {
          Util.toast("选择成功");
          RouterUtil.offAndToNamed(AppRoutes.HOME);
        }
      } else {
        Util.toast("选择失败");
      }
    });
    // Future.delayed(Duration(milliseconds: 400),quickLogin(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.theme_bg,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.imagesLoginTopBg), fit: BoxFit.cover),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //246  185
                Padding(
                  padding: EdgeInsets.only(top: 40.w, left: 60.w, right: 60.w),
                  child: Image.asset(R.imagesLoginRoleStudent),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14.w, left: 84.w, right: 84.w),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      identity = 3;
                      logic.setUserInfo(identity!);
                    },
                    child: Container(
                      height: 44.w,
                      decoration: BoxDecoration(
                          color: AppColors.THEME_COLOR,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: const Center(
                        child: Text(
                          "我是学生",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 38.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 138.w,
                        height: 0.5.w,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xffd2d5dc)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w, right: 8.w),
                        child: Text(
                          '或者',
                          style: TextStyle(
                              fontSize: 12.sp, color: Color(0xffb4b9c6)),
                        ),
                      ),
                      SizedBox(
                        width: 138.w,
                        height: 0.5.w,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xffd2d5dc)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(top: 46.w, left: 68.w, right: 68.w),
                    child: Image.asset(R.imagesLoginRoleTeacher)),
                Padding(
                  padding: EdgeInsets.only(top: 30.w, left: 84.w, right: 84.w),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      //直接掉接口
                      //RouterUtil.toNamed(AppRoutes.RoleTwoPage,arguments: {'identity':2});
                      identity = 2;
                      logic.setUserInfo(identity!);
                    },
                    child: Container(
                      height: 44.w,
                      decoration: BoxDecoration(
                          color: AppColors.THEME_COLOR,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: const Center(
                        child: Text(
                          "我是老师",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  void onPressed() {}
}
