import 'package:crazyenglish/entity/paper_category.dart';
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
import 'reading_catalog_logic.dart';

class Reading_catalogPage extends StatefulWidget {
  Records? records;

  Reading_catalogPage({Key? key}) : super(key: key) {
    if(Get.arguments!=null &&
        Get.arguments is Records){
      records = Get.arguments;
    }
  }

  @override
  _Reading_catalogPageState createState() => _Reading_catalogPageState();
}

class _Reading_catalogPageState extends State<Reading_catalogPage> {
  final logic = Get.put(Reading_catalogLogic());
  final state = Get.find<Reading_catalogLogic>().state;
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  PaperCategory? paperCategory;

  @override
  void initState(){
    super.initState();
    logic.addListenerId(GetBuilderIds.paperCategory,(){
      if(state.paperCategory!=null){
        paperCategory = state.paperCategory;
        if(mounted && _refreshController!=null){
          _refreshController.refreshCompleted();
          setState(() {
          });
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
        title: Text(widget.records!.name!,style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        // bottom: ,
        elevation: 0,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
            itemCount: paperCategory!=null && paperCategory!.data!=null ? paperCategory!.data!.length:0,
            itemBuilder: (_,int position)=>buildItem(position)),
      ),
    );
  }


  Widget buildItem(int index){
    return InkWell(
      onTap: (){
        RouterUtil.toNamed(AppRoutes.PaperDetail,arguments: paperCategory!.data![index]);
      },
      child: Container(
        width: 332.w,
        height: 106.w,
        margin: EdgeInsets.only(top: 11.w,left: 14.w,right: 14.w),
        padding: EdgeInsets.only(top: 14.w,bottom: 14.w),
        decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(
                color: AppColors.c_0FA50D1A.withOpacity(0.05),		// 阴影的颜色
                offset: Offset(10, 20),						// 阴影与容器的距离
                blurRadius: 45.0,							// 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 0,
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(6.w)),
            color: AppColors.c_FFFFFFFF
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 72.w,
              margin: EdgeInsets.only(left: 12.w,right: 15.w),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExtendedNetworkImageProvider(
                      paperCategory!.data![index].catalogueTitleImg??"",
                      cacheRawData: true
                    ),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.w)),
              ),
            ),
            Expanded(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(paperCategory!.data![index].catalogueTitle?? "",
                          maxLines:1,
                          style: TextStyle(color: AppColors.c_FF101010,fontSize: 18.sp,fontWeight: FontWeight.bold),),
                        Text(paperCategory!.data![index].catalogueTitleSubtitle?? "",
                          maxLines:1,style: TextStyle(color: AppColors.TEXT_GRAY_COLOR,fontSize: 16.sp),),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(R.imagesWeeklyFabulous,width: 14.w,height:14.w,),
                              Padding(padding: EdgeInsets.only(left: 4.w)),
                              Text("${paperCategory!.data![index].likeCount}",style: TextStyle(color: AppColors.TEXT_GRAY_COLOR,fontSize: 10.sp),),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 6.w)),
                        InkWell(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(R.imagesWeeklyCollect,width: 14.w,height:14.w,),
                              Padding(padding: EdgeInsets.only(left: 4.w)),
                              Text("${paperCategory!.data![index].collectCount}",style: TextStyle(color: AppColors.TEXT_GRAY_COLOR,fontSize: 10.sp),),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 6.w)),
                        InkWell(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(R.imagesWeeklyDeBrowse,width: 14.w,height:14.w,),
                              Padding(padding: EdgeInsets.only(left: 4.w)),
                              Text("${paperCategory!.data![index].viewsCount}",style: TextStyle(color: AppColors.TEXT_GRAY_COLOR,fontSize: 10.sp),),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }



  void _onRefresh() async{
    logic.getPagerCategory("${widget.records!.id}");
  }

  void _onLoading() async{
    // monitor network fetch
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getPagerCategory("${widget.records!.id}");
  }

  @override
  void dispose() {
    Get.delete<Reading_catalogLogic>();
    super.dispose();
  }
}