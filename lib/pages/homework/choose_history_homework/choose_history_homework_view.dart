import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/HomeworkExamPaperResponse.dart';
import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/HomeworkHistoryResponse.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../base_choose_page_state.dart';
import '../choose_logic.dart';
import 'choose_history_homework_logic.dart';

/**
 * 待提醒、待批改、历史作业、布置历史作业 三页面复用
 * 先判断是否待提醒，待批改、再判断是否是布置历史作业
 */
class ChooseHistoryHomeworkPage extends BasePage {

  bool isAssignHomework = false;
  bool needNotify = false;
  bool needCorrected = false;
  ChooseHistoryHomeworkPage({Key? key}) : super(key: key) {
    if(Get.arguments!=null &&
        Get.arguments is Map){
      isAssignHomework = Get.arguments["isAssignHomework"]??false;
      needNotify = Get.arguments["needNotify"]??false;
      needCorrected = Get.arguments["needCorrected"]??false;
    }
  }

  @override
  BasePageState<BasePage> getState() => _ChooseHistoryHomeworkPageState();
}

class _ChooseHistoryHomeworkPageState extends BaseChoosePageState<ChooseHistoryHomeworkPage,History> {
  final logic = Get.put(ChooseHistoryHomeworkLogic());
  final state = Get.find<ChooseHistoryHomeworkLogic>().state;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final int pageSize = 20;
  int currentPageNo = 1;
  List<History> historys = [];
  final int pageStartIndex = 1;

  @override
  String getDataId(String key,History n) {
    assert(n.id !=null);
    return n.id!.toString();
  }

  @override
  void onCreate() {
    currentKey.value = "0";
    logic.addListenerId(GetBuilderIds.getHistoryHomeworkList,(){
      hideLoading();
      if(state.list!=null && state.list!=null){
        if(state.pageNo == currentPageNo+1){
          historys.addAll(state!.list!);
          currentPageNo++;
          if(mounted && _refreshController!=null){
            _refreshController.loadComplete();
            if(!state!.hasMore){
              _refreshController.loadNoData();
            }else{
              _refreshController.resetNoData();
            }

            addData(currentKey.value, state!.list!);
            setState(() {

            });
          }

        }else if(state.pageNo == pageStartIndex){
          currentPageNo = pageStartIndex;
          historys.clear();
          historys.addAll(state.list!);
          if(mounted && _refreshController!=null){
            _refreshController.refreshCompleted();
            if(!state!.hasMore){
              _refreshController.loadNoData();
            }else{
              _refreshController.resetNoData();
            }
            resetData(currentKey.value, state!.list!);
            setState(() {
            });
          }

        }
      }
    });
    _onRefresh();
    showLoading("加载中");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text(widget.needNotify? "作业待提醒":
                  widget.needCorrected? "作业待批改":"历史作业",
                  style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        elevation: 0,
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 18.w),
            child: InkWell(
              onTap: (){
                // RouterUtil.toNamed(AppRoutes.IntensiveListeningPage);
              },
              child: Text("确定",style: TextStyle(color: AppColors.c_FFED702D,fontSize: 14.sp),),
            ),
          ),
        ],
      ),
      body: NestedScrollView(
          floatHeaderSlivers:true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 24.w,left: 18.w),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 20.w,
                          width: 48.w,
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.c_FFFCEFD8,width: 5.w,))
                          ),
                        ),
                        Container(
                          height: 20.w,
                          child: Text("2023年03月21日 周二",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp,fontWeight: FontWeight.w500),),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: Image.asset(R.imagesHomeWorkTime,width: 16.w,height: 16.w,),
                      ),
                    )
                  ],
                ),
              ),
            )];
          },
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
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    buildItem,
                    childCount: historys.length,
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _onRefresh() async{
    currentPageNo = pageStartIndex;
    logic.getHomeworkHistoryList(pageStartIndex,pageSize);
  }

  void _onLoading() async{
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getHomeworkHistoryList(currentPageNo+1,pageSize);
  }


  Widget buildItem(BuildContext context, int index) {
    History history = historys[index];

    return Container(
      margin: EdgeInsets.only(left: 18.w, right: 18.w,top: 24.w),
      padding: EdgeInsets.only(left: 27.w,right: 27.w,top: 3.w,bottom: 12.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 16.w)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${history.name}",style: TextStyle(fontSize: 12.sp,color: AppColors.c_FF898A93,fontWeight: FontWeight.w500),),
              InkWell(
                onTap: (){
                  // HomeworkCompleteOverviewPage
                  // // widget.needNotify?
                  // // goToNextPage("去提醒") :
                  // // widget.needCorrected?
                  // // buildHasChecked(false,"待批改（18）"):
                  widget.needNotify? RouterUtil.toNamed(AppRoutes.HomeworkCompleteOverviewPage):
                  RouterUtil.toNamed(AppRoutes.HomeworkCompleteOverviewPage);
                  // buildHasChecked(false,"未检查"),
                },
                child: widget.needNotify?
                          goToNextPage("去提醒") :
                            widget.needCorrected?
                              buildHasChecked(false,"待批改（18）"):
                                widget.isAssignHomework?
                                goToNextPage("预览"):
                                buildHasChecked(false,"未检查"),
              )
            ],
          ),
          Container(margin:EdgeInsets.only(top: 11.w,bottom: 6.w),width: double.infinity,height: 0.2.w,color: AppColors.c_FFD2D5DC,),
          Row(
            children: [
              buildLineItem(R.imagesExamPaperName,"${history.name}"),
              Visibility(
                visible: widget.isAssignHomework,
                child: GetBuilder<ChooseLogic>(
                  id: GetBuilderIds.updateCheckBox+currentKey.value,
                  builder: (logic){
                    return Util.buildCheckBox(() {
                      addSelected(currentKey.value, history,
                          !isDataSelected(currentKey.value, history)
                      );
                    },chooseEnable: isDataSelected(currentKey.value, history));
                  },
              ),)
            ],
          ),
          buildLineItem(R.imagesExamPaperTiCount,"18/28 完成"),
          Visibility(
            visible: !widget.isAssignHomework,
            child: buildLineItem(R.imagesExamPaperTiType,"班级平均分")),
        ],
      ),
    );
  }

  Widget goToNextPage(String text){
    return Container(
      alignment: Alignment.center,
      height: 19.w,
      padding: EdgeInsets.only(left: 18.w,right: 18.w),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFF7ED,
        borderRadius: BorderRadius.all(Radius.circular(9.5.w)),
      ),
      child: Text(text,style: TextStyle(fontSize: 10.sp,color: AppColors.c_FFED702D),),
    );
  }

  Widget buildHasChecked(bool hasChecked,String text){
    if(hasChecked){
      return Container(
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
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.c_FFD2D5DC,
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
        ),
        child: Text(text,style: TextStyle(fontSize: 10.sp,color: Colors.white),),
      );
    }
  }

  Widget buildLineItem(String img,String text){
    return Container(
      height: 38.w,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(img,width: 16.w,height: 16.w,),
          Padding(padding: EdgeInsets.only(left: 9.w)),
          Text(text,style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp,),),
        ],
      ),
    );
  }




  @override
  void dispose() {
    Get.delete<ChooseHistoryHomeworkLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}