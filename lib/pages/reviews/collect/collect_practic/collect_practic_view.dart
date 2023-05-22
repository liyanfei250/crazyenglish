import 'package:crazyenglish/pages/reviews/collect/collect_practic_page/collect_practic_page_view.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/widgets/CustomTab.dart';
import 'package:crazyenglish/widgets/CustomTabIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;

import '../../../../base/widgetPage/base_page_widget.dart';
import '../../../../entity/home/HomeKingDate.dart' as tabDate;
import '../../../../entity/review/SearchCollectListDate.dart';
import '../../../week_test/week_test_detail/week_test_detail_logic.dart';
import 'collect_practic_logic.dart';

//收藏界面
class ErrorColectPrctePage extends BasePage {
  const ErrorColectPrctePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToErrorColectPrctePageState();
}

class _ToErrorColectPrctePageState extends BasePageState<ErrorColectPrctePage>
    with TickerProviderStateMixin {
  final logic = Get.put(Collect_practicLogic());
  final state = Get.find<Collect_practicLogic>().state;
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;

  refresh.RefreshController _refreshController =
      refresh.RefreshController(initialRefresh: false);
  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;
  bool isRecentView = false;
  dynamic classify = null;
  late TabController _tabController;

  List<tabDate.Obj> searchList = [];
  List<Obj> weekPaperList = [];
  tabDate.Obj data1 = tabDate.Obj(id: 0, name: '全部', value: 100);
  tabDate.Obj data2 = tabDate.Obj(id: 1, name: '最近查看', value: 101);

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: searchList!.length);
    //获取筛选列表
    logic.addListenerId(GetBuilderIds.getHomeDateList, () {
      if (mounted && state.tabList != null && state.tabList!.obj != null) {
        searchList = state.tabList!.obj!;
        searchList.insertAll(0, [data1, data2]);
        setState(() {
          _tabController.dispose();
          _tabController =
              TabController(vsync: this, length: searchList.length);
        });
      }
    });
    //先获取tab接口，用来筛选
    logic.getHomeList('classify_type');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildBg(), Expanded(child: _buildTableBarView())],
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {
    Get.delete<Collect_practicLogic>();
    Get.delete<WeekTestDetailLogic>();
    _refreshController.dispose();
    _tabController.dispose();
  }

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: searchList!.map((e) {
        if (e.id == 0 || e.id == 1) {
          classify = null;
        } else {
          classify = e.id!;
        }
        if (e.id == 1) {
          isRecentView = true;
        } else {
          isRecentView = false;
        }
        return CollectPracticPageViewPage(isRecentView, classify);
      }).toList());

  Widget buildBg() => Container(
        margin:
            EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 0.w),
        width: double.infinity,
        height: 38.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.w)),
            color: Color(0xfff2f5fc)),
        child: TabBar(
          onTap: (tab) => print(tab),
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          isScrollable: true,
          controller: _tabController,
          labelColor: Color(0xffffbc00),
          indicatorWeight: 2,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 18.w),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xffffbc00),
          indicator: CustomTabIndicator(),
          // 添加自定义指示器
          tabs: searchList!.map((e) => Tab(text: e.name)).toList(),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
