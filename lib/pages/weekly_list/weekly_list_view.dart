import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../r.dart';
import '../../utils/Util.dart';
import '../../utils/colors.dart';
import 'weekly_list_logic.dart';

class WeeklyListPage extends BasePage {
  const WeeklyListPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _WeeklyListPageState();
}

class _WeeklyListPageState extends BasePageState<WeeklyListPage> {
  final logic = Get.put(WeeklyListLogic());
  final state = Get.find<WeeklyListLogic>().state;
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text("英语周报",style: TextStyle(color: AppColors.c_FFFFFFFF,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        // bottom: ,
        elevation: 0,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: GridView.builder(
          itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (_,int position)=>buildItem(position)),
      ),
    );
  }


  Widget buildItem(int index){
    return Container(
      width: 88.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints.expand(
              width: 88.w,
              height: 122.w,
            ),
            decoration: BoxDecoration(
                boxShadow:[
                  BoxShadow(
                    color: AppColors.c_FF542327.withOpacity(0.5),		// 阴影的颜色
                    offset: Offset(10, 20),						// 阴影与容器的距离
                    blurRadius: 45.0,							// 高斯的标准偏差与盒子的形状卷积。
                    spreadRadius: 5.0,
                  )
                ],
                image: DecorationImage(
                  image: AssetImage(R.imagesWeeklyItemBg0),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.w)),
                color: AppColors.TEXT_BLACK_COLOR
            ),
            width: 88.w,
            height: 122.w,
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       width: 38.w,
            //       height: 14.w,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.all(Radius.circular(6.w)),
            //           color: AppColors.c_66000000
            //       ),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Image.asset(R.imagesWeeklyItemEye,width: 10.w,height: 10.w,),
            //           Padding(padding: EdgeInsets.only(left: 1.w)),
            //           Text("10",style: TextStyle(color: AppColors.c_FFFFFFFF,fontSize: 8.sp),)
            //         ],
            //       ),
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //             image: AssetImage(R.imagesWeeklyItemShadow),
            //           )
            //       ),
            //       width: 88.w,
            //       height: 33.w,
            //       child: Text("2022-10-15",style: TextStyle(color: AppColors.c_FFFFFFFF,fontSize: 10.sp),),
            //     )
            //   ],
            // ),
          ),
          Padding(padding: EdgeInsets.only(top: 4.w)),
          Text("第$index期",style: TextStyle(color: AppColors.TEXT_BLACK_COLOR,fontSize: 14.sp),)
        ],
      ),
    );
  }


  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 100));
    // currentPageNo = pageStartIndex;
    // logic.getArticleTopList({"pageSize":"$pageSize","index":pageStartIndex.toString()},pageStartIndex);
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 100));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // logic.getArticleTopList({"pageSize":"$pageSize","index":(currentPageNo+1).toString()},currentPageNo+1);
  }

  @override
  void dispose() {
    Get.delete<WeeklyListLogic>();
    _refreshController.dispose();
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