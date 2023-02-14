import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../r.dart';
import '../../utils/ScreenGetUtil.dart';
import '../../utils/Util.dart';
import '../../utils/colors.dart';
import '../shoplist/view.dart';
import 'shop_logic.dart';

class ToShoppingPage extends BasePage {
  const ToShoppingPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() =>_ToShoppingPageState();

}

class _ToShoppingPageState extends BasePageState<ToShoppingPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  final logic = Get.put(ShopLogic());
  final state = Get.find<ShopLogic>().state;
  late TabController _tabController;

  final List<String> tabs = const[
    "默认",
    "新品",
    "销量",
    "价格",
  ];

  @override
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this,length: tabs.length);
  }

  @override
  void onCreate() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTitleBar("周报商城"),
      backgroundColor: AppColors.theme_bg,
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTabBar(),
          Expanded(child: _buildTableBarView())
        ],
      ),
    );
  }

  AppBar _buildTitleBar(String text){
    return AppBar(
      backgroundColor: AppColors.c_FFFFFFFF,
      centerTitle: false,
      title: Text(text,style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp,fontWeight: FontWeight.bold),),
      leading: Util.buildBackWidget(context),
      // bottom: ,
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
    );
  }

  Widget _buildSearchBar() => Container(
    margin: EdgeInsets.only(left: 14.w,right: 14.w,top: 7.w),
    height: 28.w,
    color: AppColors.theme_bg,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 294.w,
          height: 28.w,
          padding: EdgeInsets.only(left: 11.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
              color: AppColors.c_FFF0F0F0,

          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(R.imagesIndexSearch,fit:BoxFit.cover,width: 22.w,height: 22.w,),
              Padding(padding: EdgeInsets.only(left: 9.w)),
              Text("搜索周刊/书籍/卡券等",style: TextStyle(fontSize:12.sp,color: AppColors.TEXT_GRAY_COLOR),)
            ],
          ),
        ),
        Image.asset(R.imagesIndexMsg,width: 26.w,height: 22.w,)
      ],
    ),
  );
  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        switch(e){
          case "默认":
            return ShoppingListPage();
        }
        return Container();
      }).toList()
  );


  @override
  void onDestroy() {
  }
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildTabBar() => TabBar(
    onTap: (tab)=> print(tab),
    controller: _tabController,
    indicatorColor: AppColors.TAB_COLOR,
    indicatorSize: TabBarIndicatorSize.label,
    isScrollable: false,
    labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    indicatorWeight: 3,
    labelStyle: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 14.sp,color: AppColors.TEXT_BLACK_COLOR),
    labelColor: AppColors.TEXT_COLOR,
    tabs: tabs.map((e) => Tab(text:e)).toList(),
  );
}
