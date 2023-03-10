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
  List listDataOne = [
    {
      "title": "01.情景反应",
      "type": 0,
    },
    {"title": "02.对话理解", "type": 1},
    {"title": "03.语篇理解", "type": 2},
    {"title": "04.听力填空", "type": 3},
  ];
  List listData = [
    {
      "title": "01.情景反应",
      "type": 0,
    },
    {"title": "02.对话理解", "type": 1},
  ];

  RefreshController _refreshController = RefreshController(initialRefresh: false);

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
        body: TabBarView(
          controller: _tabController,
          //构建
          children:[
            ErrorColectPrctePage(),
            ErrorColectWordPage(),
          ] /*tabs.map((e) {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context,LoadStatus? mode){
                  Widget body ;
                  if(mode==LoadStatus.idle){
                    body =  Text("");
                  }
                  else if(mode==LoadStatus.loading){
                    body =  CupertinoActivityIndicator();
                  }
                  else if(mode == LoadStatus.failed){
                    body = Text("");
                  }
                  else if(mode == LoadStatus.canLoading){
                    body = Text("release to load more");
                  }
                  else{
                    body = Text("");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child:body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(bottom:5.w,top: 12.w,left: 33.w,right: 33.w),
                      child: SearchBar(width: double.infinity,height: 28.w,),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      buildItem,
                      childCount: listDataOne.length,
                    ),
                  ),
                ],
              ),
            )

              *//*Container(
              alignment: Alignment.center,
              child: ListView(
                children: listDataOne.map((value) {
                  return listitemBigBg();
                }).toList(),
              ),
            )*//*;
          }).toList()*/,
        ),
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
        indicatorPadding:  EdgeInsets.symmetric(horizontal: 22.w),
        unselectedLabelColor: Colors.grey,
        indicatorColor: Color(0xffeb5447),
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
    );
  }
  Widget listitemBigBg() {
    return Container(
      margin: EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 10.w),
      padding:
      EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 10.w),
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
      child: listitemBig(),
    );
  }
  Widget listitemBig() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
                child: Text(
                  '2023年02月09日 14:50:39',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
              child: Text('已完成',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),

      ],
    );
  }
  Widget buildItem(BuildContext context,int index){
    return InkWell(
      onTap: (){
        //RouterUtil.toNamed(AppRoutes.WeeklyTestCategory);
      },
      child: listitemBigBg(),
    );
  }
  @override
  void onCreate() {

    _tabController = TabController(vsync: this, length: tabs.length);

    /*logic.addListenerId(GetBuilderIds.weekTestList,(){
      hideLoading();
      if(state.list!=null && state.list!=null){
        if(state.pageNo == currentPageNo+1){
          weekPaperList = state.list;
          currentPageNo++;
          weekPaperList.addAll(state!.list!);
          if(mounted && _refreshController!=null){
            _refreshController.loadComplete();
            if(!state!.hasMore){
              _refreshController.loadNoData();
            }else{
              _refreshController.resetNoData();
            }
            setState(() {

            });
          }
        }else if(state.pageNo == pageStartIndex){
          currentPageNo = pageStartIndex;
          weekPaperList.clear();
          weekPaperList.addAll(state.list!);
          if(mounted && _refreshController!=null){
            _refreshController.refreshCompleted();
            if(!state!.hasMore){
              _refreshController.loadNoData();
            }else{
              _refreshController.resetNoData();
            }
            setState(() {
            });
          }

        }
      }
    });
    _onRefresh();
    showLoading("");*/
  }

  @override
  void onDestroy() {
    _tabController.dispose();
    Get.delete<Error_note_collectLogic>();
    _refreshController.dispose();
  }

  void _onRefresh() async{
    currentPageNo = pageStartIndex;
    // logic.getList("2022-12-22",pageStartIndex,pageSize);
  }

  void _onLoading() async{
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // logic.getList("2022-12-22",currentPageNo,pageSize);
  }


}
