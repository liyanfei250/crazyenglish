import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../../widgets/search_bar.dart';
import '../collect_practic/collect_practic_view.dart';
import '../collect_words/collect_words_view.dart';
import '../error_note_child/error_note_child_view.dart';
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
  final List<String> tabs = const [
    '题目',
    '单词',
  ];

  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: buildBottomAppBar("错题本"),
        backgroundColor: AppColors.theme_bg,
        body: TabBarView(controller: _tabController,
            //构建
            children: [
              ErrorColectPrctePage(),
              ErrorColectWordPage(),
            ]),
      ),
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
      bottom: TabBar(
        onTap: (tab) => print(tab),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        isScrollable: true,
        controller: _tabController,
        labelColor: Color(0xffeb5447),
        indicatorPadding: EdgeInsets.symmetric(horizontal: 22.w),
        unselectedLabelColor: Colors.grey,
        indicatorColor: Color(0xffeb5447),
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
    );
  }

  @override
  void onCreate() {
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onDestroy() {
    _tabController.dispose();
    Get.delete<Error_note_collectLogic>();
  }
}
