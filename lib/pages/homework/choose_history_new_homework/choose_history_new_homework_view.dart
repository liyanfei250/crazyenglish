import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/entity/HomeworkHistoryResponse.dart';
import 'package:crazyenglish/entity/class_list_response.dart';
import 'package:crazyenglish/pages/homework/base_choose_page_state.dart';
import 'package:crazyenglish/pages/homework/choose_history_new_homework/choose_history_new_homework_logic.dart';
import 'package:crazyenglish/routes/app_pages.dart';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../entity/class_list_response.dart'as choice;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;

import '../../../base/AppUtil.dart';
import '../../../base/common.dart' as common;
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../assign_homework/assign_homework_logic.dart';
import '../choose_logic.dart';
import '../homework_complete_overview/homework_complete_overview_view.dart';

class ChooseHistoryNewHomeworkPage  extends BasePage {

  bool isAssignHomework = false;

  static const String IsAssignHomework = "isAssignHomework";

  ChooseHistoryNewHomeworkPage({Key? key}) : super(key: key) {
    if(Get.arguments!=null &&
        Get.arguments is Map){
      isAssignHomework = Get.arguments[IsAssignHomework]??false;
    }
  }

  @override
  BasePageState<BasePage> getState() => _ChooseHistoryNewHomeworkPageState();
}

class _ChooseHistoryNewHomeworkPageState extends BaseChoosePageState<ChooseHistoryNewHomeworkPage,History> with SingleTickerProviderStateMixin {
  final logic = Get.put(Choose_history_new_homeworkLogic());
  final state = Get.find<Choose_history_new_homeworkLogic>().state;
  late AnimationController _controller;
  AssignHomeworkLogic? assignLogic;
  pull.RefreshController _refreshController = pull.RefreshController(initialRefresh: false);

  final int pageSize = 20;
  int currentPageNo = 1;
  List<History> historys = [];
  final int pageStartIndex = 1;
  var choiceText = "全部".obs;
  late List<String> items = [];
  List<choice.Obj> tabs = [];
  bool _isOpen = false;
  int _selectedIndex = -1;
  dynamic schoolClassId = null;

  @override
  String getDataId(String key,History n) {
    assert(n.id !=null);
    return n.id!.toString();
  }

  @override
  void onCreate() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    if(widget.isAssignHomework){
      assignLogic = Get.find<AssignHomeworkLogic>();
    }
    currentKey.value = "0";

    logic.addListenerId(
        GetBuilderIds.getHomeClassTab +
            SpUtil.getInt(BaseConstant.USER_ID).toString(), () {
      if (state.myClassList != null && state.myClassList!.obj != null) {
        tabs = state.myClassList!.obj!;
        items = tabs.map((obj) => obj.name!).toList();
        setState(() {
        });
      }
    });

    logic.getMyClassList(SpUtil.getInt(BaseConstant.USER_ID).toString());

    logic.addListenerId(GetBuilderIds.getHistoryHomeworkList,(){
      hideLoading();
      if(state.list!=null){
        if(widget.isAssignHomework && (assignLogic!.state.assignHomeworkRequest.historyOperationClassId??"").isNotEmpty){
          state.list.forEach((element) {
            if("${element.id}" == assignLogic!.state.assignHomeworkRequest.historyOperationClassId){
              addSelected(currentKey.value,element,true);
            }
          });
        }
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
        title: Text("历史作业",
          style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        elevation: 0,
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 18.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isOpen = !_isOpen;
                    });
                    _startAnimation(_isOpen);
                  },
                  child: Row(
                    children: [
                      Obx(() => Text(
                        choiceText.value,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xff898a93),
                        ),
                      )),
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
        widget.isAssignHomework?
                InkWell(
                  onTap: (){
                    // RouterUtil.toNamed(AppRoutes.IntensiveListeningPage);
                    // 先判断是否待提醒，待批改、再判断是否是布置历史作业
                    if(widget.isAssignHomework){
                      int totalNum = 0;
                      List<History> historys = [];
                      dataList.forEach((key, value) {
                        if(value!=null){
                          for(History n in value!){
                            String id = getDataId(key,n);
                            if(isSelectedMap[key]!=null && (isSelectedMap[key]![id]??false)){
                              historys.add(n);
                            }
                          }
                        }
                      });
                      if(historys.isNotEmpty){
                        assignLogic!.updateAssignHomeworkRequest(paperType: common.PaperType.HistoryHomework,
                            historyHomeworkDesc: '作业名称：'+historys[0].name.toString(),
                            historyOperationId: "${historys[0].operationId}",
                            historyOperationClassId:"${historys[0].id}"
                        );
                      }else{
                        assignLogic!.updateAssignHomeworkRequest(paperType: -1,
                            historyHomeworkDesc: "",
                            historyOperationId: "",
                            historyOperationClassId:''
                        );
                      }
                      Get.back();
                    }
                  },
                  child: Text("确定",style: TextStyle(color: AppColors.c_FFED702D,fontSize: 14.sp),),
                ):SizedBox.shrink()
              ],
            )
          ,
          ),
        ],
      ),
      body:Stack(
        children: [
          NestedScrollView(
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
              body: pull.SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: pull.WaterDropHeader(),
                footer: pull.CustomFooter(
                  builder: (BuildContext context,pull.LoadStatus? mode){
                    Widget body ;
                    if(mode== pull.LoadStatus.idle){
                      body =  Text("");
                    }
                    else if(mode==pull.LoadStatus.loading){
                      body =  CupertinoActivityIndicator();
                    }
                    else if(mode == pull.LoadStatus.failed){
                      body = Text("");
                    }
                    else if(mode == pull.LoadStatus.canLoading){
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
                    historys.length>0? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        buildItem,
                        childCount: historys.length,
                      ),
                    ): SliverToBoxAdapter(
                        child: PlaceholderPage(
                            imageAsset: R.imagesCommenNoDate,
                            title: '暂无数据',
                            topMargin: 100.w,
                            subtitle: ''))
                  ],
                ),
              )),
          Visibility(
            child: InkWell(
              onTap: () {
                setState(() {
                  _isOpen = !_isOpen;
                });
                _startAnimation(_isOpen);
              },
              child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.5),
            ),),
            visible: _isOpen,
          ),
          Visibility(
              visible: _isOpen,
              child: Container(
                padding: EdgeInsets.only(
                    left: 15.w, right: 15.w, top: 10.w, bottom: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.w),
                      bottomLeft: Radius.circular(10.w)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 3),
                      blurRadius: 3,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25.w,
                          width: MediaQuery.of(context).size.width / 4,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 12.w, top: 18.w),
                          padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          decoration: BoxDecoration(
                            color: Color(0xfff5f6f9),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = -1;
                                _isOpen = false;
                                choiceText.value ="全部";
                                schoolClassId = null;
                              });
                              _startAnimation(_isOpen);
                              logic.getHomeworkHistoryList(schoolClassId,pageStartIndex,pageSize);//全部
                            },
                            child: Text(
                              '全部分类',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: _selectedIndex == -1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 18.w,
                            runSpacing: 4.w,
                            children: List.generate(
                              items.length,
                                  (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                    _isOpen = false;
                                    choiceText.value = tabs[index]!.name!;
                                  });
                                  _startAnimation(_isOpen);
                                  logic.getHomeworkHistoryList(tabs[index]!.id!,pageStartIndex,pageSize);
                                },
                                child: Container(
                                  height: 25.w,
                                  width: MediaQuery.of(context).size.width / 4,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff5f6f9),
                                    borderRadius: BorderRadius.circular(20.w),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                    vertical: 8.0,
                                  ),
                                  child: Text(
                                    items[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: _selectedIndex == index
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      )
        ,
    );
  }

  void _onRefresh() async{
    currentPageNo = pageStartIndex;
      logic.getHomeworkHistoryList(schoolClassId,pageStartIndex,pageSize);

  }

  void _onLoading() async{
      logic.getHomeworkHistoryList(schoolClassId,currentPageNo+1,pageSize);
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
                  if(widget.isAssignHomework){
                    RouterUtil.toNamed(AppRoutes.HomeworkCompleteOverviewPage,arguments: {HomeworkCompleteOverviewPage.HistoryItem:history});
                  }
                },
                child: widget.isAssignHomework?
                goToNextPage("预览"):
                buildHasChecked(history.operationStatus == common.HomeworkStatus.completed,
                    history.operationStatus == common.HomeworkStatus.completed? "已检查":
                    "未检查"),
              )
            ],
          ),
          Container(margin:EdgeInsets.only(top: 11.w,bottom: 6.w),width: double.infinity,height: 0.2.w,color: AppColors.c_FFD2D5DC,),
          Row(
            children: [
              Expanded(child: buildLineItem(R.imagesExamPaperName,"${history.name}"))
              ,
              Visibility(
                visible: widget.isAssignHomework,
                child: GetBuilder<ChooseLogic>(
                  id: GetBuilderIds.updateCheckBox+currentKey.value,
                  builder: (logic){
                    return Util.buildCheckBox(() {
                      selectSingle(currentKey.value,history);
                    },chooseEnable: isDataSelected(currentKey.value, history));
                  },
                ),)
            ],
          ),
          buildLineItem(R.imagesExamPaperTiCount,"${history.studentCompleteSize}/${history.studentTotalSize} 完成"),
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

  void _startAnimation(bool _isOpen) {
    if (_isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }


  @override
  void dispose() {
    Get.delete<Choose_history_new_homeworkLogic>();
    _controller.dispose();
    super.dispose();
  }

  @override
  void onDestroy() {
  }
}