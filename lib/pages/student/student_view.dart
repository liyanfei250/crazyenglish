import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../r.dart';
import 'student_logic.dart';

class StudentPage extends BasePage {
  const StudentPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() {
    // TODO: implement getState
    return _StudentPageState();
  }
}

class _StudentPageState extends BasePageState<StudentPage> {
  final logic = Get.put(StudentLogic());
  final state = Get.find<StudentLogic>().state;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("学生"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Image.asset(R.imagesIconCloseRoundBlack),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("姓名："),
                    Text("班级："),
                    Text("学习总时长："),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("练习题目总数："),
              Text("上月学习报告")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("练习记录"),
              Text("查看更多")
            ],
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("作业状态：待批改"),
                Text("7年级2021-2022学年 第5期"),
                Text("作答时间：2022.12.20"),

              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("学习情况"),
                Text("听力练习时长："),
                Text("阅读练习时长："),
                Text("写作练习时长："),
                Text("语言应用练习时长："),

              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<StudentLogic>();
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