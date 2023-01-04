import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../entity/week_paper_response.dart';
import '../../r.dart';
import '../../routes/getx_ids.dart';
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

  final int pageSize = 20;
  int currentPageNo = 1;
  List<Records> weekPaperList = [];
  final int pageStartIndex = 1;
  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.weekList,(){
      if(state.list!=null && state.list!=null){
        if(state.pageNo == currentPageNo+1){
          weekPaperList = state.list;
          currentPageNo++;
          weekPaperList.addAll(state!.list!);
          if(mounted && _refreshController!=null){
            _refreshController.loadComplete();
            setState(() {

            });
          }
        }else if(state.pageNo == pageStartIndex){
          currentPageNo = pageStartIndex;
          weekPaperList.clear();
          weekPaperList.addAll(state.list!);
          if(mounted && _refreshController!=null){
            _refreshController.refreshCompleted();
            setState(() {
            });
          }

        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text("英语周报",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        // bottom: ,
        elevation: 0,
      ),
      backgroundColor: AppColors.c_FFFAF7F7,
      body: SmartRefresher(
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
        child: GridView.builder(
            shrinkWrap:true,
            itemCount: weekPaperList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                childAspectRatio:0.76),
            itemBuilder: (_,int position)=>buildItem(position)),
      ),
    );
  }


  Widget buildItem(int index){
    return InkWell(
      onTap: (){
        RouterUtil.toNamed(AppRoutes.PaperCategory,arguments: weekPaperList[index]);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 18.w),
            decoration: BoxDecoration(
              boxShadow:[
                BoxShadow(
                  color: AppColors.c_BF542327.withOpacity(0.25),		// 阴影的颜色
                  offset: Offset(7, 7),						// 阴影与容器的距离
                  blurRadius: 165,							// 高斯的标准偏差与盒子的形状卷积。
                  spreadRadius: 0.w,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
            ),
            width: 88.w,
            height: 122.w,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6.w)),
                  child: ExtendedImage.network(
                    weekPaperList[index].img??"",
                    fit: BoxFit.fill,
                    cacheRawData: true,
                    width: 88.w,
                    height: 122.w,),
                ),
                Container(
                  width: 38.w,
                  height: 14.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.w)),
                      color: AppColors.c_66000000
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(R.imagesWeeklyBrowse,width: 13.w,height: 13.w,),
                      Text("265",style: TextStyle(fontSize: 8.sp,color: AppColors.c_FFFFFFFF),)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.w,
                  child: Container(
                    width: 88.w,
                    height: 31.w,
                    padding: EdgeInsets.only(left: 7.w,bottom: 4.w),
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(R.imagesWeeklyBg)
                      ),
                    ),
                    child: Text(
                      weekPaperList[index].weekTime?? "",style: TextStyle(color: AppColors.c_FFFFFFFF,fontSize: 10.sp),),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4.w),
            child: Text(
              textAlign:TextAlign.center,
              maxLines:1,
              overflow:TextOverflow.ellipsis,
              weekPaperList[index].name?? "",style: TextStyle(color: AppColors.TEXT_BLACK_COLOR,fontSize: 14.sp),),
          )
          //
        ],
      ),
    );
  }



  void _onRefresh() async{
    currentPageNo = pageStartIndex;
    logic.getPeridList("2022-12-22",pageStartIndex,pageSize);
  }

  void _onLoading() async{
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getPeridList("2022-12-22",currentPageNo+1,pageSize);
  }

  @override
  void dispose() {
    Get.delete<WeeklyListLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}