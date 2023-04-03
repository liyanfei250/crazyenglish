import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../entity/QuestionListResponse.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/colors.dart';
import 'exam_question_logic.dart';

class ExamQuestionPage extends BasePage {

  String tagId;

  ExamQuestionPage({required this.tagId,Key? key}) : super(key: key);

  @override
  BasePageState<ExamQuestionPage> getState() => _ExamQuestionPageState();
}

class _ExamQuestionPageState extends BasePageState<ExamQuestionPage> {
  final logic = Get.put(ExamQuestionLogic());
  final state = Get.find<ExamQuestionLogic>().state;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final int pageSize = 20;
  int currentPageNo = 1;
  List<Questions> questionList = [];
  final int pageStartIndex = 1;



  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getExamper+widget.tagId,(){
      hideLoading();
      if(state.list!=null && state.list!=null){
        if(state.pageNo == currentPageNo+1){
          questionList.addAll(state!.list!);
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
          questionList.clear();
          questionList.addAll(state.list!);
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
    logic.getQuestionList(widget.tagId,pageStartIndex,pageSize);
  }

  void _onLoading() async{
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getQuestionList(widget.tagId,currentPageNo+1,pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
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
          SliverPadding(padding: EdgeInsets.only(left: 25.w,right: 25.w),
              sliver: SliverGroupedListView<Questions,num>(
                groupBy: (element) => element.groupId??0,
                groupSeparatorBuilder: buildSeparatorBuilder,
                elements: questionList,
                itemBuilder: buildItem,
                groupHeaderBuilder: buildGroupHeader,
              ))
        ],
      ),
    );
  }

  Widget buildGroupHeader(Questions question){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.w),topRight: Radius.circular(7.w)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(top: 11.w)),
          Text("${question.groupName}",style: TextStyle(fontSize: 12.sp,color: AppColors.c_FF898A93,fontWeight: FontWeight.w500),),
          Container(margin:EdgeInsets.only(top: 11.w),width: double.infinity,height: 0.2.w,color: AppColors.c_FFD2D5DC,),
        ],
      ),
    );
  }

  Widget buildSeparatorBuilder(num question){
    return Container(
      height: 24.w,
      color: Colors.transparent,
    );
  }

  Widget buildItem(BuildContext context, Questions question) {
    return Container(
      height: 40.w,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7.w),bottomRight: Radius.circular(7.w)),
      ),
      child: Text(
        "${question.name}",
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xff353e4d)),
      ),
    );
  }


  @override
  void dispose() {
    Get.delete<ExamQuestionLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}