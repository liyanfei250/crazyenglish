import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/shop/BaseRoutesWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../r.dart';
import '../../utils/colors.dart';
import '../shoplist/view.dart';
import 'shop_logic.dart';

class ToShoppingPage extends BasePage {
  const ToShoppingPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToShoppingPageState();
}

class _ToShoppingPageState extends BasePageState<ToShoppingPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ShopLogic());
  final state = Get.find<ShopLogic>().state;
  late TabController _tabController;

  final List<String> tabs = const [
    "默认",
    "新品",
    "销量",
    "价格",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onCreate() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTitleBar("周报商城"),
      backgroundColor: AppColors.theme_bg,
      body: Column(
        children: [
          _buildSearchBar(),
          //_buildTabBar(),
          _subHeaderWidget(),
          // BaseRoutesWidget(),
          Expanded(child: _buildTableBarView())
        ],
      ),
    );
  }

  AppBar _buildTitleBar(String text) {
    return AppBar(
      backgroundColor: AppColors.c_FFFFFFFF,
      centerTitle: false,
      title: Text(
        text,
        style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold),
      ),
      leading: Util.buildBackWidget(context),
      // bottom: ,
      elevation: 10.w,
      shadowColor: const Color(0x1F000000),
    );
  }

  Widget _buildSearchBar() => Container(
        margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 7.w),
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
                  Image.asset(
                    R.imagesIndexSearch,
                    fit: BoxFit.cover,
                    width: 22.w,
                    height: 22.w,
                  ),
                  Padding(padding: EdgeInsets.only(left: 9.w)),
                  Text(
                    "搜索周刊/书籍/卡券等",
                    style: TextStyle(
                        fontSize: 12.sp, color: AppColors.TEXT_GRAY_COLOR),
                  )
                ],
              ),
            ),
            Image.asset(
              R.imagesIndexMsg,
              width: 26.w,
              height: 22.w,
            )
          ],
        ),
      );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) {
        switch (e) {
          case "默认":
            return ShoppingListPage();
        }
        return Container();
      }).toList());

  @override
  void onDestroy() {}

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildTabBar() => TabBar(
        onTap: (tab) => print(tab),
        controller: _tabController,
        indicatorColor: Colors.transparent,
        isScrollable: false,
        labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        indicatorWeight: 3,
        labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, color: AppColors.TEXT_BLACK_COLOR),
        labelColor: AppColors.TEXT_COLOR,
        tabs: tabs.map((e) => Tab(text: e,icon: Icon(Icons.arrow_drop_down, size: 128.0, color: Colors.black12,),)).toList(),
      );

// 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      // 放在下面可以位于最顶层，盖住列表
      top: 0, //位于顶部
      width: double.infinity,
      height: 50.w,
      child: Container(
        width: 347.w,
        height: 50.w,
        child: Row(
          // 多个元素从左到右
          children: this.tabs.map((value) {
            // 循环遍历数组
            return Expanded(
              // 需要用到自适应布局
              flex: 1,
              child: InkWell(
                // 按钮支持点击
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, 2.0, 0, 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(value,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black)),
                        // 添加选中箭头
                        _showIcon(2)
                      ],
                    )),
                onTap: () {
                  _subHeaderChange(1);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  //显示header Icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      return Icon((true ? Icons.arrow_drop_down : Icons.arrow_drop_up));
    } else {
      return Text("ddd");
    }
  }

  //导航改变的时候触发
  _subHeaderChange(id) {
    if (id == 4) {
      setState(() {
        //this._selectHeaderId = id;
      });
    } else {

      // 更改选中颜色
      setState(() {
        // 改变排序方式:id-1在数组中为0
        // 重置分页数为1
        // 清空旧数据列表
        // 回到顶部位置
        // 在价格中拉到最底部hasmore为false,在销量时候就会只请求一页,需要重置
        // 再次点击，排序方式相反，从降序变为升序
        // 重新请求数据
      });
    }
  }
}
