import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import 'person_info_logic.dart';

class PersonInfoPage extends BasePage {
  const PersonInfoPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<PersonInfoPage> {
  final logic = Get.put(Person_infoLogic());
  final state = Get.find<Person_infoLogic>().state;
  final TextStyle textStyle = TextStyle(
      fontSize: 14, color: Color(0xff4d3535), fontWeight: FontWeight.w500);
  final TextStyle textSenStyle = TextStyle(
      fontSize: 12, color: Color(0xff898a93), fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("个人信息"),
      backgroundColor: AppColors.theme_bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 21.w,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                  child: Image.asset(
                R.imagesIconHomeMeDefaultHead,
                width: 56.w,
                height: 56.w,
              )),
              Positioned(
                  bottom: 0.w,
                  left: 1.w,
                  right: 1.w,
                  child: Image.asset(
                    R.imagesMinePhone,
                    width: 31.w,
                    height: 19.w,
                  )),
            ],
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: 10.w, bottom: 10.w, left: 13.w, right: 13.w),
              margin: EdgeInsets.only(left: 34.w, right: 34.w, top: 16.w),
              decoration: BoxDecoration(
                color: Color(0xfffef4e6),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '头像一自然年只能提交一次，无论是否修改成功，提交即消耗本年度修改次数，请谨慎提交。',
                style: textStyle,
              )),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 25.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
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
                  SizedBox(
                    height: 20.w,
                  ),
                  buildItemType('修改昵称', '真不睡懒觉'),
                  SizedBox(
                    height: 14.w,
                  ),
                  Divider(),
                  SizedBox(
                    height: 14.w,
                  ),
                  buildItemType('修改密码'),
                  SizedBox(
                    height: 14.w,
                  ),
                  Divider(),
                  SizedBox(
                    height: 14.w,
                  ),
                  buildItemType('更换手机号', '198****0987'),
                  SizedBox(
                    height: 20.w,
                  ),
                ],
              )),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 25.w),
              padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 29.w,
                  ),
                  Text(
                    '所属学校',
                    style: textStyle,
                  ),
                  SizedBox(
                    width: 38.w,
                  ),
                  Expanded(
                    child: Text(
                      '山西省第七实验中学',
                      style: textSenStyle,
                    ),
                  ),
                ],
              )),
          Expanded(child: Text('')),
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 25.w,bottom: 30.w),
              padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '退出当前帐号',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff353e4d)),
              ))
        ],
      ),
    );
  }

  Widget buildItemType(String menu, [String? second]) {
    return GestureDetector(
      onTap: () {
        //todo 具体的跳转界面

        switch (menu) {
          case '修改昵称':
            Util.toast(menu);
            break;
          case '修改密码':
            Util.toast(menu);
            break;
          default:
            return null;
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 29.w,
          ),
          Text(
            menu,
            style: textStyle,
          ),
          SizedBox(
            width: 38.w,
          ),
          Expanded(
            child: (second != null)
                ? Text(
                    second,
                    style: textSenStyle,
                  )
                : Text(''),
          ),
          Image.asset(
            R.imagesHomeNextIcBlack,
            height: 7.w,
            width: 11.w,
          ),
          SizedBox(
            width: 25.w,
          ),
        ],
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
