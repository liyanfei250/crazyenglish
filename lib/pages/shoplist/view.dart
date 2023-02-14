import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../entity/week_paper_response.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/ScreenGetUtil.dart';
import '../../utils/colors.dart';
import 'logic.dart';

class ShoppingListPage extends BasePage {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToShoppingPageState();
}

class _ToShoppingPageState extends BasePageState<ShoppingListPage> {
  final logic = Get.put(ShoplistLogic());
  final state = Get.find<ShoplistLogic>().state;
  late TabController _tabController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;
  List<Shopping> shopList = [];

  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.shopList, () {
      hideLoading();
    });

    for (int i = 0; i < 20; i++) {
      var json = {
        "id": i,
        "name": "新的书籍的界面$i",
        "stage": "String",
        "sort": 0,
        "weekTime": "2023-02-09",
        "nameTitle": "新的书籍的界面",
        "img": "https://www.baidu.com/img/flexible/logo/pc/result.png",
        "createTime": "2023-02-09"
      };
      Shopping value = Shopping.fromJson(json);
      shopList.add(value);
    }

    _onRefresh();
    showLoading("模拟数据");
    Future.delayed(new Duration(seconds: 2), () {
      hideLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(children: [
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView(
                // 支持上下滑动
                children: <Widget>[
                  _recProductListWidget(),
                ],
              ),
            ),
          ),
          Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 14.w, right: 14.w, top: 7.w, bottom: 7.w),
              child: Row(
                ///主轴
                mainAxisAlignment: MainAxisAlignment.start,

                ///横轴
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    R.imagesIndexMsg,
                    width: 26.w,
                    height: 89.w,
                  ),
                  Expanded(
                    child: Container(
                      width: 80.w,
                      height: 89.w,
                      alignment: Alignment.centerRight,
                      color: Colors.white,
                      child: Text('¥218.9',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: AppColors.THEME_COLOR, fontSize: 22.sp)),
                    ),
                  ),
                  Center(
                    child: Container(
                        height: 89.w,
                        alignment: Alignment.center,
                        child: Container(
                            width: 109.w,
                            height: 36.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.w)),
                                color: AppColors.c_FFFF4D35),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _clickOk();
                              },
                              child: Center(
                                child: Text("立即购买",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.c_FFFFFFFF),
                                    textAlign: TextAlign.center),
                              ),
                            ))),
                  ),
                ],
              )),
        ]));
  }

  _clickOk() {
    RouterUtil.toNamed(AppRoutes.ShopCarPage);
  }

  @override
  void onDestroy() {}

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
  }

  void _onLoading() async {}

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Widget _recProductListWidget() {
    // （ScreenAdaper.width(ScreenAdaper.getScreenWidth()) - 30）/ 2来计算
    var itemWidth = 154.w;

    return Container(
      // 左右间距
      padding: EdgeInsets.all(10),
      child: Wrap(
          // GridView 只能设置宽高比，无法设置Item高度
          spacing: 10, // 水平间距(中间的10）
          runSpacing: 10, // 纵间距（上下的10）
          children: this.shopList.map((value) {
            // value为每一个Item

            String? sPic = value.img;

            return InkWell(
              child: Container(
                // Item 宽高l
                // 屏幕减去左右中间后的一半, 高度会自适应
                width: itemWidth,
                // 左右上下间距
                padding: EdgeInsets.all(10),
                // 边框
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1)),
                child: Column(
                  // 上图中文下价格
                  children: <Widget>[
                    Container(
                        // 防止Image以外层Container实现cover平铺
                        // 铺满外层Container（除pading外部分）
                        width: double.infinity,
                        child: AspectRatio(
                            // 防止服务器图片宽高不一致
                            aspectRatio: 1 / 1, // 宽度固定的，1：1则高度也固定
                            child:
                                Image.network("${sPic}", fit: BoxFit.cover))),
                    Padding(
                      // 和图片相距10
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "${value?.nameTitle}",
                        maxLines: 2,
                        // ...溢出
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Padding(
                      // 和标题相距10
                      padding: EdgeInsets.only(top: 10),
                      child: Stack(
                        // 左边打折价格 右边原价
                        children: <Widget>[
                          Align(
                            // 中间偏左
                            alignment: Alignment.centerLeft,
                            child: Text("¥177",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16)),
                          ),
                          Align(
                            // 中间偏右
                            alignment: Alignment.centerRight,
                            // 下划线
                            child: Text("¥277",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // 跳转到详情页面
              onTap: () {
                Navigator.pushNamed(context, '/productContent',
                    arguments: {"id": value?.id});
              },
            );
          }).toList()),
    );
  }
}
