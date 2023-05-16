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
import 'role_two_logic.dart';

class RoleTwoPage extends BasePage {
  int? identity;

  RoleTwoPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      identity = Get.arguments['identity'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToRoleTwoPageState();
}

class _ToRoleTwoPageState extends BasePageState<RoleTwoPage> {
  final logic = Get.put(Role_twoLogic());
  final state = Get.find<Role_twoLogic>().state;
  List list = [
    {
      "title": "高三",
      "type": 12,
    },
    {"title": "高二", "type": 11},
    {"title": "高一", "type": 10},
    {"title": "初三", "type": 9},
    {"title": "初二", "type": 8},
    {"title": "初一", "type": 7},
  ];

  @override
  void initState() {
    super.initState();

    logic.addListenerId(GetBuilderIds.choiceRole, () {
      if (state.sendCodeResponse.code == 1) {
        SpUtil.putBool(BaseConstant.IS_CHOICE_ROLE_STUDENT, false); //是学生且已选年级
        Util.toast("选择成功");
        RouterUtil.offAndToNamed(AppRoutes.HOME);
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
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 50.w, right: 27.w),
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    RouterUtil.offAndToNamed(AppRoutes.HOME);
                  },
                  child: Container(
                    height: 26.w,
                    width: 72.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      //圆角半径
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                      //边框线宽、颜色
                      border: Border.all(width: 1.0, color: Colors.red),
                    ),
                    child: const Text('跳过',
                        style: TextStyle(color: Colors.red, fontSize: 12)),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 9.w, left: 30.w),
              child: Text(
                '完善信息',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 19.w, left: 30.w),
              child: Text(
                '选择年级',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
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
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                logic.setUserInfo(3, groupValue);
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

  Widget listitem(context, value) {
    var deviceSize = MediaQuery.of(context).size;
    print(value['type']);
    return groupValue == value['type']
        ? ElevatedButton(
            onPressed: () {
              print('切换${value}');
              updateGroupValue(value['type']);
            },
            child: Text(
              value['title'],
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color?>(Colors.red),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ))
        : OutlinedButton(
            onPressed: () {
              print('切换${value}');
              updateGroupValue(value['type']);
            },
            child: Text(
              value['title'],
              style: TextStyle(fontSize: 16),
            ),
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
            ));
  }

  int groupValue = 13;

  updateGroupValue(int v) {
    setState(() {
      groupValue = v;
    });
  }
}
