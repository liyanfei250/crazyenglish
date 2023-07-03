import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../base/AppUtil.dart';
import '../../../../base/widgetPage/base_page_widget.dart';
import '../../../../routes/app_pages.dart';
import '../../../../routes/routes_utils.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/search_bar.dart';
import '../collect_practic/collect_practic_view.dart';
import '../../error/error_note_child/error_note_child_view.dart';
import 'error_note_collect_logic.dart';

class ErrorNoteCollectPage extends BasePage {
  const ErrorNoteCollectPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToErrorNoteCollectPageState();
}

class _ToErrorNoteCollectPageState extends BasePageState<ErrorNoteCollectPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(Error_note_collectLogic());
  final state = Get.find<Error_note_collectLogic>().state;
  late TabController _tabController;

  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBottomAppBar("收藏题目"),
      backgroundColor: AppColors.theme_bg,
      body: TabBarView(controller: _tabController,
          //构建
          children: [
            ErrorColectPrctePage(),
          ]),
    );
  }

  AppBar buildBottomAppBar(String text) {
    return AppBar(
      backgroundColor: AppColors.c_FFFFFFFF,
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
      ),
      leading: Util.buildBackWidget(context),
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
    );
  }

  @override
  void onCreate() {
    _tabController = TabController(vsync: this, length: 1);
  }

  @override
  void onDestroy() {
    _tabController.dispose();
    Get.delete<Error_note_collectLogic>();
  }
}
