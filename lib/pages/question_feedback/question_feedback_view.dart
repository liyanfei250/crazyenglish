import 'package:crazyenglish/widgets/ImageUploadRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../utils/colors.dart';
import 'question_feedback_logic.dart';

class QuestionFeedbackPage extends BasePage {
  const QuestionFeedbackPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToQuestionFeedbackPageState();
}

class _ToQuestionFeedbackPageState extends BasePageState<QuestionFeedbackPage> {
  final logic = Get.put(Question_feedbackLogic());
  final state = Get
      .find<Question_feedbackLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text(
          '题目反馈',
          style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Util.buildBackWidget(context),
        elevation: 10.w,
        shadowColor: const Color(0x1F000000),
        actions: [
          InkWell(
            onTap: () {
              // 点击事件处理逻辑
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              child: Text(
                '提交',
                style: TextStyle(
                  color: Color(0xffed702d),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          SizedBox(
            height: 24.w,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 18.w,
              ),
              Container(
                width: 3.w,
                height: 13.w,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2),
                        bottomRight: Radius.circular(2))),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text('问题描述',
                  style: TextStyle(
                    color: Color(0xff353e4d),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          _buildQuestionLayout()
        ],
      ),
    );
  }

  Widget _buildSearchBar() =>
      Container(
        margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 24.w),
        padding: EdgeInsets.only(left: 2.w, right: 2.w),
        alignment: Alignment.center,
        height: 47.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7.w)),
          border: Border.all(width: 1.w, color: Color(0xffd2d5dc)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 17.w,
            ),
            Expanded(
                child: TextField(
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15),
                  //controller: getBoyController,
                  autofocus: false,
                  decoration: InputDecoration(
                    //提示信息
                      hintText: "请输入您的手机号",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                  //设置最大行数
                  maxLines: 1,
                )),
          ],
        ),
      );

  Widget _buildQuestionLayout() =>
      Container(
        margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 20.w),
        padding: EdgeInsets.only(left: 18.w, right: 18.w),
        alignment: Alignment.topLeft,
        height: 488.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7.w)),
          border: Border.all(width: 1.w, color: Color(0xffd2d5dc)),
        ),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.black,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
              //controller: getBoyController,
              autofocus: false,
              decoration: InputDecoration(
                //提示信息
                  hintText: "请输入您遇到的问题，建议400字以内",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
              //设置最大行数
              maxLines: 1,
            ),
            Expanded(child: Text('')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageUploadRoute(
                            title: "测试",
                          ),
                    ),
                  );
                },
                child:Text('data'))
          ],
        ),
      );

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
