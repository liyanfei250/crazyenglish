import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/colors.dart';

class MyDialog extends Dialog {
  final String title;
  final String content;

  _showTimer(context) {
    var timer;
    timer = Timer.periodic(Duration(seconds: 10), (t) {
      print("关闭");
      Navigator.pop(context);
      timer.cancel();
    });
  }

  MyDialog(this.title, this.content);

  TextEditingController getBoyController = new TextEditingController(); //声明controller
  TextEditingController phoneController = new TextEditingController(); //声明controller
  TextEditingController cityController = new TextEditingController(); //声明controller
  TextEditingController addressController = new TextEditingController(); //声明controller
  @override
  Widget build(BuildContext context) {
    //_showTimer(context);
    return Material(
      child: Center(
          child: Container(
        height: 270.w,
        width: 290.w,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Text(title,
                        style: TextStyle(
                            color: AppColors.c_FF32374E,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.topCenter,
                  ),
                  Align(
                    child: InkWell(
                      child: Icon(Icons.close),
                      onTap: () => Navigator.pop(context),
                    ),
                    alignment: Alignment.topRight,
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Container(
                  width: 112.w,
                  child: TextField(
                    controller: getBoyController,
                    autofocus: true,
                    decoration: InputDecoration(
                        //提示信息
                        hintText: "收货人",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey)),
                    //设置最大行数
                    maxLines: 1,
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                ),
                Container(
                  width: 50.w,
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      //提示信息
                      hintText: "+86",
                      border: InputBorder.none,
                    ),
                    //设置最大行数
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: 112.w,
                  child: TextField(
                    controller: phoneController,
                    autofocus: true,
                    decoration: InputDecoration(
                        //提示信息
                        hintText: "电话",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey)),
                    //设置最大行数
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: TextField(
                controller: cityController,
                autofocus: true,
                decoration: InputDecoration(
                    //提示信息
                    hintText: "请选择省、市、区",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey)),
                //设置最大行数
                maxLines: 1,
              ),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
            Container(
              width: double.infinity,
              child: TextField(
                controller: addressController, //指定controller
                autofocus: true,
                decoration: InputDecoration(
                  //提示信息
                  hintText: "详细地址（如街道、小区、乡镇、村）",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                //设置最大行数
                maxLines: 1,
              ),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
            Container(
              width: 250.w,
              height: 44.w,
              //在此设置
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [
                  Color(0xfff5bec7),
                  Color(0xfff5bec7),
                  Color(0xfff5bec7),
                ]),
              ),
              child: ElevatedButton(
                onPressed: onTap(context),
                child: const Text(
                  '保存',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                style: ButtonStyle(
                  //去除阴影
                  elevation: MaterialStateProperty.all(0),
                  //将按钮背景设置为透明
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
              ),
            )
          ],
        ),
      )),
      type: MaterialType.transparency,
    );
  }

  onTap(BuildContext context) {

    phoneController.text;
    cityController.text;
    addressController.text;
    Navigator.popAndPushNamed(context,AppRoutes.OrderSurePage,arguments: getBoyController.text);
  }
}
