import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../../../widgets/search_bar.dart';
import 'collect_words_logic.dart';

class ErrorColectWordPage extends BasePage {
  const ErrorColectWordPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToErrorColectWordPageState();
}

class _ToErrorColectWordPageState extends BasePageState<ErrorColectWordPage> {
  final logic = Get.put(Collect_wordsLogic());
  final state = Get.find<Collect_wordsLogic>().state;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                    bottom: 5.w, top: 12.w, left: 33.w, right: 33.w),
                child: Container(
                  width: double.infinity,
                  height: 28.w,
                  margin: EdgeInsets.only(top: 16.w, bottom: 30.w),
                  decoration: BoxDecoration(
                      color: AppColors.c_FFFFFFFF,
                      borderRadius: BorderRadius.all(Radius.circular(14.w))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 7.w)),
                      Image.asset(
                        R.imagesHomeSearch,
                        width: 16.w,
                        height: 16.w,
                      ),
                      Padding(padding: EdgeInsets.only(left: 6.w)),
                      Text(
                        "搜词",
                        style: TextStyle(
                            fontSize: 12.sp, color: Color(0xffb3b7c0)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                buildItem,
                childCount: 9,
              ),
            ),
          ],
        ),
      ),
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

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        //RouterUtil.toNamed(AppRoutes.WeeklyTestCategory);
      },
      child: _buildPlayBar(),
    );
  }

  Widget _buildPlayBar() => Container(
        width: double.infinity,
        height: 64.w,
        margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.w),
        padding:
            EdgeInsets.only(left: 24.w, right: 10.w, top: 10.w, bottom: 10.w),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesCollecWordsError),
              fit: BoxFit.fitWidth),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Group",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.sp,
                  fontStyle: FontStyle.italic,
                  color: AppColors.c_FFFFFFFF),
            ),
            SizedBox(
              width: 18.w,
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: _item_word(),
                      );
                    })),
            /* Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _item_word(),
                _item_word(),
                _item_word(),
              ],
            )*/
            Padding(
              padding: EdgeInsets.only(right: 34.w),
              child: Image.asset(
                R.imagesCollecWordIcon,
                width: 37.w,
                height: 10.w,
              ),
            ),
          ],
        ),
      );

  Widget _item_word() => Container(
        padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
        child: Row(
          children: [
            Text(
              "adj.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 8.sp,
                  fontStyle: FontStyle.normal,
                  color: AppColors.c_FFFFFFFF),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(child: Text(
              "令人满意的；有利的；熟练的；好的sdfsdfasdfsdfsdfsdfsdfsdfsdfsdfsdf",
              style: TextStyle(
                  fontSize: 8.sp,
                  fontStyle: FontStyle.normal,
                  color: AppColors.c_FFFFFFFF),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ))
            ,
          ],
        ),
      );

  @override
  void onCreate() {}

  @override
  void onDestroy() {
    Get.delete<Collect_wordsLogic>();
    _refreshController.dispose();
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    // logic.getList("2022-12-22",pageStartIndex,pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // logic.getList("2022-12-22",currentPageNo,pageSize);
  }
}
