import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/blocs/login_change_bloc.dart';
import 'package:crazyenglish/blocs/login_change_event.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crazyenglish/entity/home/HomeKingDate.dart' as king;


class RoleTwoPage extends BasePage {

  bool isEnterHome = true;
  UserInfoResponse? userInfoResponse;

  RoleTwoPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      isEnterHome = Get.arguments[LoginNewPage.inEnterHome]??false;
      userInfoResponse = Get.arguments[LoginNewPage.UserInfoResponse];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToRoleTwoPageState();
}

class _ToRoleTwoPageState extends BasePageState<RoleTwoPage> {
  final logic = Get.put(Person_infoLogic());
  final state = Get.find<Person_infoLogic>().state;
  List<king.Obj> list = [];
  num groupValue = 0;
  @override
  void initState() {
    super.initState();
    logic.getChoiceMap(DictionaryType.GradeType);
    logic.addListenerId(GetBuilderIds.getPersonInfo,() {
      if("${state.infoResponse.obj?.affiliatedGrade}".isNotEmpty){
        SpUtil.putBool("${BaseConstant.IS_CHOICE_ROLE_GRADE}${state.infoResponse.obj?.id}", true);//是学生且没选年级
        if(widget.userInfoResponse!=null){
          logic.updateNativeUserInfo(widget.userInfoResponse);
        }else{
          logic.updateNativeUserInfo(state.infoResponse);
        }
        BlocProvider.of<LoginChangeBloc>(context)
            .add(SendLoginChangeEvent());
        if(widget.isEnterHome){
          if(state.infoResponse.obj?.identity == RoleType.teacher){
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
    });
    logic.addListenerId(GetBuilderIds.getHomeListChoiceDate,(){
      if(state.homeKingDate!=null && state.homeKingDate.obj!=null){
        list.clear();
        list.addAll(state.homeKingDate.obj??[]);
      }
    });
    logic.addListenerId(GetBuilderIds.toAffiliatedGrade, () {
      logic.getPersonInfo(widget.userInfoResponse?.obj?.username??"");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.theme_bg,
      body: Stack(children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.imagesLoginTopBg), fit: BoxFit.cover),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text("",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 20.sp,fontWeight: FontWeight.w700),),
              backgroundColor:Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.only(top: 9.w, left: 30.w),
              child: Text(
                '完善信息',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 19.w, left: 30.w),
              child: Text(
                '选择年级',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            GetBuilder<Person_infoLogic>(
                id: GetBuilderIds.getHomeListChoiceDate,
                builder: (logic){
              return Padding(
                padding: EdgeInsets.only(top: 16.w, left: 30.w, right: 30.w),
                child: GridView.count(
                  padding: EdgeInsets.all(4.w),
                  //一行多少个
                  crossAxisCount: 3,
                  //滚动方向
                  scrollDirection: Axis.vertical,
                  // 左右间隔
                  crossAxisSpacing: 14.w,
                  // 上下间隔
                  mainAxisSpacing: 16.w,
                  //宽高比
                  childAspectRatio: 1 / 0.4,
                  shrinkWrap: true,
                  children: list.map((value) {
                    return listitem(context, value);
                  }).toList(),
                ),
              );
            }),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if(groupValue>0){
                  logic.toChangeGrade([groupValue]);
                }else{
                  Util.toast("请选择年级");
                }
              },
              child: Container(
                height: 47.w,
                margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 55.w),
                decoration: BoxDecoration(
                    color: AppColors.THEME_COLOR,
                    borderRadius: const BorderRadius.all(Radius.circular(22))),
                child: const Center(
                  child: Text(
                    "确定",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  void onPressed() {}

  Widget listitem(context, king.Obj value) {
    return groupValue == value.id
        ? ElevatedButton(
            onPressed: () {
              updateGroupValue(value.id??0);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color?>(Colors.red),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Text(
              value.name??"",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ))
        : OutlinedButton(
            onPressed: () {
              updateGroupValue(value.id??0);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll<Color?>(Colors.black),
              textStyle:
                  MaterialStateProperty.all(TextStyle(color: Colors.red)),
              side: MaterialStateProperty.all(
                  BorderSide(color: Color(0xffd2d5dc))),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffd2d5dc)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Text(
              value.name??"",
              style: TextStyle(fontSize: 16.sp),
            ));
  }

  updateGroupValue(num v) {
    setState(() {
      groupValue = v;
    });
  }
}
