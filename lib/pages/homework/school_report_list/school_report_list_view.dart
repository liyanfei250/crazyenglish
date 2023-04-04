import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../entity/HomeworkStudentResponse.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import 'school_report_list_logic.dart';

/**
 * 成绩单列表页
 */
class SchoolReportListPage extends BasePage {
  final String classId = "0";
  SchoolReportListPage({Key? key}) : super(key: key);

  @override
  BasePageState<SchoolReportListPage> getState() => _SchoolReportListPageState();
}

class _SchoolReportListPageState extends BasePageState<SchoolReportListPage> {
  final logic = Get.put(SchoolReportListLogic());
  final state = Get.find<SchoolReportListLogic>().state;


  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final int pageSize = 20;
  int currentPageNo = 1;
  List<Students> studentList = [];
  final int pageStartIndex = 1;

  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getStudentList+widget.classId,(){
      hideLoading();
      if(state.list!=null && state.list!=null){
        if(state.pageNo == currentPageNo+1){
          studentList.addAll(state!.list!);
          currentPageNo++;
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
          studentList.clear();
          studentList.addAll(state.list!);
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
    showLoading("加载中");
  }

  void _onRefresh() async{
    currentPageNo = pageStartIndex;
    logic.getStudentList(widget.classId,pageStartIndex,pageSize);
  }

  void _onLoading() async{
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getStudentList(widget.classId,currentPageNo+1,pageSize);
  }



  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("成绩单"),
      body: Container(
        margin: EdgeInsets.only(top: 30.w, left: 18.w, right: 18.w,bottom: 30.w),
        padding: EdgeInsets.only(top: 20.w, left: 23.w, right: 23.w),
        decoration: BoxDecoration(
          color: AppColors.c_FFFFFFFF,
          borderRadius: BorderRadius.all(Radius.circular(7.w)),
          boxShadow:[
            BoxShadow(
              color: Color(0xffe3edff).withOpacity(0.5),		// 阴影的颜色
              offset: Offset(0.w, 0.w),						// 阴影与容器的距离
              blurRadius: 10.w,							// 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 0.w,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("学生姓名",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 16.sp,fontWeight: FontWeight.w500),),
                Text("提交情况",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 16.sp,fontWeight: FontWeight.w500),),
                Text("成绩",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 16.sp,fontWeight: FontWeight.w500),)
              ],
            ),
            Container(
              color: AppColors.c_FFD2D5DC,
              height: 0.8.w,
              width: double.infinity,
              margin: EdgeInsets.only(top: 17.w),
            ),
            Expanded(child: SmartRefresher(
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
                  SliverPadding(
                    padding: EdgeInsets.only(left: 0.w,right: 0.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        buildItem,
                        childCount: studentList.length,
                      ),
                    ),)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }


  Widget buildItem(BuildContext context, int index) {
    Students student = studentList[index];

    return Container(
      height: 60.w,
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${index+1}",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff353e4d)),
              ),
              Padding(padding: EdgeInsets.only(left: 20.w)),
              Text(
                "${student.name}",
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff353e4d)),
              ),
            ],
          ),
          buildHasAnswered(index==1, index==1? "已做":"未做"),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "80",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffed702d)),
              ),
              Padding(padding: EdgeInsets.only(left: 30.w)),
              Image.asset(R.imagesSchoolReportRightArrow,width: 8.5.w,height: 8.5.w,),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHasAnswered(bool hasAnswered,String text){
    if(hasAnswered){
      return Container(
        height: 16.w,
        width: 42.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffec6b6a),
                Color(0xffee7b8a),
              ]),
          borderRadius: BorderRadius.only(topLeft:Radius.circular(7.w),bottomRight: Radius.circular(7.w)),
        ),
        child: Text(text,style: TextStyle(fontSize: 10.sp,color: Colors.white),),
      );
    }else{
      return Container(
        height: 16.w,
        width: 42.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.c_FFD2D5DC,
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
        ),
        child: Text(text,style: TextStyle(fontSize: 10.sp,color: Colors.white),),
      );
    }
  }


  @override
  void dispose() {
    Get.delete<SchoolReportListLogic>();
    super.dispose();
  }

}