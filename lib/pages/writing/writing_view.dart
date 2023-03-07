import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../../entity/week_detail_response.dart' as detail;
import 'writing_logic.dart';

class WritingPage extends BasePage {
  detail.WeekDetailResponse? testDetailResponse;

  WritingPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      testDetailResponse = Get.arguments["detail"];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToOrderDetailPageState();
}

class _ToOrderDetailPageState extends BasePageState<WritingPage> {
  final logic = Get.put(WritingLogic());
  final state = Get.find<WritingLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("Module 1 Unit3写作"),
      backgroundColor: AppColors.theme_bg,
      body: SingleChildScrollView(
        child: _buildClassArea(),
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  Widget _buildClassArea() => Container(
        width: double.infinity,
        margin:
            EdgeInsets.only(right: 20.w, left: 20.w, top: 17.w, bottom: 17.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image.asset(
                      R.imagesWritingTitleBg,
                      width: 66.w,
                      height: 9.w,
                    ),
                    Text(
                      "题目",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: AppColors.c_FF101010),
                    ),
                  ],
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 16.w)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 2.w,
                  height: 13.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.zero,
                          topLeft: Radius.zero,
                          topRight: Radius.circular(2.w),
                          bottomRight: Radius.circular(2.w)),
                      color: Color(0xff353e4d)),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  "Reading",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: AppColors.c_FF101010),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 8.w)),
            Text(
              widget.testDetailResponse?.data![0].content??"",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  wordSpacing: 6.w,
                  height: 1.5,
                  color: Color(0xff353e4d)),
            ),
            _buildClassCard(0),
            _inputCard(),
          ],
        ),
      );

  Widget _inputCard() => Container(
        margin: EdgeInsets.only(top: 14.w),
        padding:
            EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 14.w),
        width: double.infinity,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                offset: Offset(10, 20), // 阴影与容器的距离
                blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: AppColors.c_FFFFFFFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => Util.toast("提交"),
              child: Image.asset(
                R.imagesWritingCommitButton,
                width: 57.w,
                height: 17.w,
              ),
            ),
            TextField(
              autofocus: true,
              maxLines: 100,
              minLines: 10,
              style: TextStyle(color: Color(0xff353e4d), fontSize: 12.sp),
              decoration: InputDecoration(
                  //提示信息
                  hintText: "请在这里开始答题吧～",
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(color: Color(0xffb3b7c6), fontSize: 12.sp)),
            )
          ],
        ),
      );

  Widget _buildClassCard(int index) => Container(
        margin: EdgeInsets.only(top: 20.w),
        padding:
            EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 14.w),
        width: double.infinity,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                offset: Offset(10, 20), // 阴影与容器的距离
                blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: AppColors.c_FFFFFFFF),
        child: Row(
          children: [_listShow(), _rightShow()],
        ),
      );

  Widget _listShow() => Expanded(
          child: Container(
        width: 195.w,
        height: 156.w,
        child: ListView.builder(
          itemCount: 6,
          itemExtent: 26.w,
          //列表项构造器
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 50.w, minWidth: 50.w),
                  child: Text(
                    "主题：",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: Color(0xff353e4d)),
                  ),
                ),
                Container(
                  child: Text(
                    "6月15日下午2:00—5:00",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: Color(0xff353e4d)),
                  ),
                ),
              ],
            );
          },
        ),
      ));

  Widget _rightShow() => Container(
        width: 90.w,
        height: 180.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                //RouterUtil.toNamed(AppRoutes.IntensiveListeningPage);
                Util.toast("查看范文");
              },
              child: Image.asset(
                R.imagesWritingLookBotton,
                width: 77.w,
                height: 18.w,
              ),
            ),
            Expanded(child: Text("")),
            Text(
              "注意：词数100左右",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 10.sp,
                  color: Color(0xfff2a842)),
            ),
          ],
        ),
      );
}
