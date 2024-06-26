import 'dart:io' as io;

import 'package:crazyenglish/entity/check_update_resp.dart';
import 'package:crazyenglish/pages/classes/class_view.dart';
import 'package:crazyenglish/pages/config/config_logic.dart';
import 'package:crazyenglish/pages/index/teacher_index_view.dart';
import 'package:crazyenglish/pages/mine/person_info/person_info_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../base/AppUtil.dart';
import '../base/common.dart';
import '../routes/getx_ids.dart';
import '../utils/colors.dart';
import '../utils/updateApp/app_upgrade.dart';
import '../utils/updateApp/download_status.dart';
import 'app_update_panel/app_update_panel_logic.dart';
import 'mine/mine_view.dart';

/**
 * Time: 2022/9/16 16:33
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class HomeTeacherPage extends StatefulWidget {
  const HomeTeacherPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeTeacherPage> {
  final PageController pageController = PageController(keepPage: true);
  List<Widget> pages = <Widget>[];

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  var _selectedIndex = 0.obs;

  // final trackLogic = Get.put(TrackEffectsLogic());
  // final userCenterLogic = Get.put(UserCenterLogic());
  final appUpdatePanelLogic = Get.put(AppUpdatePanelLogic());
  final appUpdatePanelState = Get.find<AppUpdatePanelLogic>().state;
  final dataGroupLogic = Get.put(ConfigLogic());
  final dataGroupState = Get.find<ConfigLogic>().state;

  final personInfoLogic = Get.lazyPut(()=>Person_infoLogic());
  final personInfoState = Get.find<Person_infoLogic>().state;

  List<String> bottomTitles = [
    "首页",
    "班级",
    "我的",
  ];

  List<String> titles = [
    "首页",
    "班级",
    "我的",
  ];

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
    pageController!.jumpToPage(_selectedIndex.value);
  }

  @override
  void initState() {
    super.initState();
    Util.initWhenEnterMain();
    appUpdatePanelLogic.getAppVersion();
    appUpdatePanelLogic.addListenerId(GetBuilderIds.APPVERSION, () {
      if (appUpdatePanelState.checkUpdateResp != null) {
        showAppUpgrade(appUpdatePanelState.checkUpdateResp!);
      }
    });
    // dataGroupLogic.getConfig();
    dataGroupLogic.addListenerId(GetBuilderIds.datagroupDetailResponse, () {
      if(dataGroupState.groupQUESTION_TYPE.obj!=null){
        dataGroupState.groupQUESTION_TYPE.obj!.forEach((e) {
          DataGroup.questionType["${e.value??0}"] = e.name??"";
        });
      }
    });
  }

  @override
  void dispose() {
    Get.delete<AppUpdatePanelLogic>();
    Get.delete<ConfigLogic>();
    Get.delete<Person_infoLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,//状态栏颜色
        statusBarIconBrightness: Brightness.light, //状态栏图标颜色
        statusBarBrightness: Brightness.dark,  //状态栏亮度
        systemStatusBarContrastEnforced: true, //系统状态栏对比度强制
        systemNavigationBarColor: Colors.white,  //导航栏颜色
        systemNavigationBarIconBrightness: Brightness.light,//导航栏图标颜色
        systemNavigationBarDividerColor: Colors.transparent,//系统导航栏分隔线颜色
        systemNavigationBarContrastEnforced: true,//系统导航栏对比度强制
    ),
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(()=>Offstage(
                  offstage: _selectedIndex.value == 3,
                  child: Container(),
                )),
                Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: _neverScroll,
                      children: [
                        TeacherIndexPage(),
                        ClassPage(),
                        MinePage()
                      ],
                    )
                )
              ],
            ),
          ),
        bottomNavigationBar: buildBottomRowBar(),
      ),
    );
  }

  Widget buildBottomRowBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 56.w,
          decoration: BoxDecoration(
            color: AppColors.c_FFFFFFFF,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), // 阴影的颜色
                offset: Offset(0.w, -10.w), // 阴影与容器的距离
                blurRadius: 10.w, // 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 0.w,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(6.w)),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildBottomBar(0),
                buildBottomBar(1),
                buildBottomBar(2),
              ],
            ),
          ),
        ),
        Visibility(
            visible: io.Platform.isIOS,
            child: Container(
              color: AppColors.c_FFFFFFFF,
              height: 22.w,
              width: double.infinity,
            ))
      ],
    );
  }

  Widget buildBottomBar(int index) {
    return Expanded(
        child: InkWell(
      onTap: () {
        _onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Image.asset(
                fit: BoxFit.contain,
                "images/icon_tab${index + 1}_${_selectedIndex.value == index ? "pressed" : "normal"}.png",
                height: 26.w,
              )),
          Padding(padding: EdgeInsets.only(top: 4.w)),
          Obx(() => Text(
                bottomTitles[index],
                style: TextStyle(
                    color: _selectedIndex.value == index
                        ? AppColors.c_FF585858
                        : AppColors.c_FF828282,
                    fontWeight: _selectedIndex.value == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 10.sp),
              )),
        ],
      ),
    ));
  }

  void showAppUpgrade(CheckUpdateResp resp) {
    if ((resp.forceUpdate ?? 0) > 0) {
      AppUpgrade.appUpgrade(
        context,
        resp,
        // appMarketInfo: AppMarket.huaWei,
        onCancel: () {
          print('onCancel');
        },
        onOk: () {
          print('onOk');
        },
        downloadProgress: (count, total) {
          print('count:$count,total:$total');
        },
        downloadStatusChange: (DownloadStatus status, {dynamic error}) {
          print('status:$status,error:$error');
        },
      );
    }
  }
}
