import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/pages/search/search_list/search_list_view.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import 'home_search_logic.dart';

class HomeSearchPage extends BasePage {
  var isteacher;

  //搜索类型 1：期刊 2：商城 3：学生
  final int JOURNALS_FORMAT = 1;
  final int STUDENT_FORMAT = 3;

  HomeSearchPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isteacher = Get.arguments["isteacher"];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToHomeSearchPageState();
}

class _ToHomeSearchPageState extends BasePageState<HomeSearchPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(Home_searchLogic());
  final state = Get.find<Home_searchLogic>().state;
  late TabController _tabController;
  TextEditingController getBoyController = TextEditingController();
  bool _showClearButton = false;
  late List tabs = [
    // {"title": "全部", "type": widget.JOURNALS_FORMAT, "lacal": 1},
    {"title": "周报", "type": widget.JOURNALS_FORMAT, "lacal": 2},
    // {"title": "期刊", "type": widget.JOURNALS_FORMAT, "lacal": 3},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.isteacher) {
      tabs = [
        // {"title": "全部", "type": widget.JOURNALS_FORMAT, "lacal": 1},
        {"title": "周报", "type": widget.JOURNALS_FORMAT, "lacal": 2},
        // {"title": "期刊", "type": widget.JOURNALS_FORMAT, "lacal": 3},
        {"title": "学生", "type": widget.STUDENT_FORMAT, "lacal": 4},
      ];
    } else {
      tabs = [
        // {"title": "全部", "type": widget.JOURNALS_FORMAT, "lacal": 1},
        {"title": "周报", "type": widget.JOURNALS_FORMAT, "lacal": 2},
        // {"title": "期刊", "type": widget.JOURNALS_FORMAT, "lacal": 3},
        // {"title": "学生", "type": widget.STUDENT_FORMAT, "lacal": 4},
      ];
    }
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchView(statusBarHeight),
            buildBg(),
            Expanded(child: _buildTableBarView())
          ],
        )));
  }

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        return SearchListPage(e['lacal'], e['type']);
      }).toList());

  Widget buildBg() =>Visibility(child: Container(
    margin: EdgeInsets.only(top: 0.w, left: 0.w, right: 0.w, bottom: 0.w),
    width: double.infinity,
    height: 38.w,
    alignment: Alignment.center,
    color: Colors.white,
    child: TabBar(
      onTap: (tab) => print(tab),
      labelStyle:
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      isScrollable: false,
      controller: _tabController,
      labelColor: Color(0xffffbc00),
      indicatorWeight: 2,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 34),
      unselectedLabelColor: Colors.grey,
      indicatorColor: Color(0xffffbc00),
      tabs: tabs.map((e) => Tab(text: e['title'])).toList(),
    ),
  ),
  visible: tabs.length >1,) ;

  Widget searchView(padding) {
    return Container(
      padding: EdgeInsets.only(top: padding, bottom: 16.w),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSearchBar(),
          TextButton(
            child: const Text(
              "取消",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() => Container(
        margin: EdgeInsets.only(left: 14.w, right: 0.w, top: 7.w),
        padding: EdgeInsets.only(left: 10.w, right: 2.w),
        alignment: Alignment.centerLeft,
        width: 290.w,
        height: 30.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.w)),
            color: Color(0xfff5f6f9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 15.w,
            ),
            Expanded(
                child: TextField(
              cursorColor: Colors.black,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 12.sp, color: Colors.black),
              controller: getBoyController,
              autofocus: false,
              onChanged: (String str) {
                state.searchText = str;
              },
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration(
                  //提示信息
                  hintText: "搜索",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color(0xffb3b7c0), fontSize: 12)),
              //设置最大行数
              maxLines: 1,
            )),
          ],
        ),
      );

  void _handleSubmitted(String text) {

    logic.getSearchList(
        text, state.searchType, SpUtil.getInt(BaseConstant.USER_ID), state.pageStartIndex, state.pageSize);
    // 在这里处理提交的文本
  }

  @override
  void onCreate() {

  }

  @override
  void onDestroy() {
    Get.delete<Home_searchLogic>();
    getBoyController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
