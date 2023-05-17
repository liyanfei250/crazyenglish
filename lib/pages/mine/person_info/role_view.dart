import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/user_info_response.dart';
import 'package:crazyenglish/pages/mine/login_new/login_new_view.dart';
import 'package:crazyenglish/pages/mine/person_info/person_info_logic.dart';
import 'package:crazyenglish/r.dart';
import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class RolePage extends BasePage {

  bool isEnterHome = true;
  UserInfoResponse? userInfoResponse;

  RolePage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      isEnterHome = Get.arguments[LoginNewPage.inEnterHome]??false;
      userInfoResponse = Get.arguments[LoginNewPage.UserInfoResponse];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToRolePageState();
}

class _ToRolePageState extends BasePageState<RolePage> {
  final logic = Get.put(Person_infoLogic());
  final state = Get.find<Person_infoLogic>().state;
  int? identity; // 1老师  2学生
  @override
  void initState() {
    super.initState();
    logic.addListenerId(GetBuilderIds.getPersonInfo,() {
      if(state.infoResponse.obj?.identity == RoleType.student
      || state.infoResponse.obj?.identity == RoleType.teacher ){
        SpUtil.putBool("${BaseConstant.IS_CHOICE_ROLE}${state.infoResponse.obj?.id}", true);//是学生且没选年级
        if (state.infoResponse.obj?.identity == RoleType.student && !SpUtil.getBool("${BaseConstant.IS_CHOICE_ROLE_GRADE}${state.infoResponse.obj?.id}")) {
          RouterUtil.offAndToNamed(AppRoutes.RoleTwoPage,
              arguments: {
                LoginNewPage.inEnterHome: widget.isEnterHome,
                LoginNewPage.UserInfoResponse: state.infoResponse,
              });
        }else{
          logic.updateNativeUserInfo(state.infoResponse);
          if(widget.isEnterHome){
            if(SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN)){
              RouterUtil.offAndToNamed(AppRoutes.TEACHER_HOME);
            }else{
              RouterUtil.offAndToNamed(AppRoutes.HOME);
            }
          }else{
            if(SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN) && state.infoResponse.obj?.identity == RoleType.student){
              RouterUtil.offAndToNamed(AppRoutes.HOME);
            }else if(!SpUtil.getBool(BaseConstant.IS_TEACHER_LOGIN) && state.infoResponse.obj?.identity == RoleType.teacher){
              RouterUtil.offAndToNamed(AppRoutes.TEACHER_HOME);
            }
            Get.back();
          }
        }
      }
    });
    logic.addListenerId(GetBuilderIds.choiceRole, () {
      logic.getPersonInfo(widget.userInfoResponse?.obj?.username??"");
    });
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
                      identity = RoleType.student;
                      logic.toChangeRole(identity!);
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
                      identity = RoleType.teacher;
                      logic.toChangeRole(identity!);
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
