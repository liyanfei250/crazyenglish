import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/teacher_index/teacher_index_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../r.dart';
import '../../utils/colors.dart';
import 'index_logic.dart';

class IndexTeacherPage extends BasePage {
  const IndexTeacherPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _IndexTeacherPageState();
}

class _IndexTeacherPageState extends BasePageState<IndexTeacherPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(IndexLogic());
  final state = Get.find<IndexLogic>().state;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesHomeTeachBg), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [_buildSearchBar(), Expanded(child: TeacherIndexPage())],
          ),
        ));
  }

  Widget _buildSearchBar() => Container(
        margin: EdgeInsets.only(left: 19.w, right: 19.w, top: 15.w),
        padding: EdgeInsets.only(bottom: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Image.asset(
                R.imagesShopImageLogoTest,
                width: 32.w,
                height: 32.w,
              ),
            ),
            Container(
              width: 291.w,
              height: 28.w,
              padding: EdgeInsets.only(left: 11.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.w)),
                  color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    R.imagesHomeSearchIc,
                    fit: BoxFit.cover,
                    width: 16.w,
                    height: 16.w,
                  ),
                  Padding(padding: EdgeInsets.only(left: 9.w)),
                  Text(
                    "英语周报教师端",
                    style: TextStyle(fontSize: 12.sp, color: Color(0xff898a93)),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    Get.delete<IndexLogic>();
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
