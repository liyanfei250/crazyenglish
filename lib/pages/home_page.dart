import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crazyenglish/entity/check_update_resp.dart';

import '../entity/login/login_util.dart';
import '../r.dart';
import '../routes/app_pages.dart';
import '../routes/getx_ids.dart';
import '../routes/routes_utils.dart';
import '../utils/Util.dart';
import '../utils/colors.dart';
import '../utils/updateApp/app_upgrade.dart';
import '../utils/updateApp/download_status.dart';
import 'app_update_panel/app_update_panel_logic.dart';
import 'index/index_view.dart';
import 'learn/learn_view.dart';
import 'mine/mine_view.dart';
import 'say/say_view.dart';

/**
 * Time: 2022/9/16 16:33
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(keepPage: true);
  List<Widget> pages = <Widget>[];

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  var _selectedIndex = 0.obs;
  // final trackLogic = Get.put(TrackEffectsLogic());
  // final userCenterLogic = Get.put(UserCenterLogic());
  final appUpdatePanelLogic = Get.put(AppUpdatePanelLogic());
  final appUpdatePanelState = Get.find<AppUpdatePanelLogic>().state;

  List<String> bottomTitles = [
    "首页",
    "我学",
    "我说",
    "我的",
  ];

  List<String> titles = [
    "首页",
    "我学",
    "我说",
    "我的",
  ];


  void _onItemTapped(int index) {
    _selectedIndex.value = index;
    pageController!.jumpToPage(_selectedIndex.value);
  }


  @override
  void initState(){
    super.initState();
    Util.initWhenEnterMain();
    appUpdatePanelLogic.getAppVersion();
    appUpdatePanelLogic.addListenerId(GetBuilderIds.APPVERSION, () {
      if(appUpdatePanelState.checkUpdateResp!=null){
        showAppUpgrade(appUpdatePanelState.checkUpdateResp!);
      }
    });
  }

  @override
  void dispose(){
    // Get.delete<TrackEffectsLogic>();
    // Get.delete<UserCenterLogic>();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.c_FFFAF7F7,
      body: SafeArea(
        child: Container(
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
                    children: const [
                      IndexPage(),
                      LearnPage(),
                      SayPage(),
                      MinePage()
                    ],
                  )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: buildBottomRowBar(),
      ),
    );
  }

  Widget buildBottomRowBar(){
    return Container(
      color: AppColors.c_FFFFFFFF,
      height: 56.w,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildBottomBar(0),
            buildBottomBar(1),
            buildBottomBar(2),
            buildBottomBar(3),
          ],
        ),
      ),
    );
  }

  Widget buildBottomBar(int index){
    return Expanded(child:
    InkWell(
      onTap: (){
        _onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(()=>Image.asset("images/icon_tab${index+1}_${_selectedIndex.value == index ? "pressed":"normal"}.png",
            height: 26.w,)),
          // Padding(padding: EdgeInsets.only(top: 4.w)),
          Obx(()=>Text(
            bottomTitles[index],
            style: TextStyle(
                color: _selectedIndex.value == index ? AppColors.c_FF585858:AppColors.c_FF828282,
                fontWeight: _selectedIndex.value == index ? FontWeight.bold:FontWeight.normal,
                fontSize: 10.sp),
          )),
        ],
      ),
    )
    );
  }

  void showAppUpgrade(CheckUpdateResp resp){
    if (resp.isUpdate??false) {
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
