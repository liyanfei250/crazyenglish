import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../base/AppUtil.dart';
import '../../../../base/widgetPage/base_page_widget.dart';
import '../../../../entity/QuestionListResponse.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/colors.dart';
import '../../choose_logic.dart';
import 'question_list_logic.dart';

class QuestionListPage extends BasePage {

  ChooseIntel chooseLogic;
  String tagId;
  QuestionListPage({required this.chooseLogic,required this.tagId,Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _QuestionListPageState();

}

class _QuestionListPageState extends BasePageState<QuestionListPage> {
  final logic = Get.put(QuestionListLogic());
  final state = Get.find<QuestionListLogic>().state;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final int pageSize = 20;
  int currentPageNo = 1;
  List<Questions> questionList = [];
  final int pageStartIndex = 1;



  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getQuestionList+widget.tagId,(){
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

            widget.chooseLogic.addData(widget.tagId, state!.list!);
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
            widget.chooseLogic.resetData(widget.tagId, state!.list!);
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

  Widget buildItem(BuildContext context, Questions question) {
    return Container(
      height: 40.w,
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${question.name}",
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff353e4d)),
          ),
          GetBuilder<ChooseLogic>(
            id: GetBuilderIds.updateCheckBox+widget.tagId,
            builder: (logic){
              return Util.buildCheckBox(() {
                widget.chooseLogic.addSelected(widget.tagId, question,
                    !widget.chooseLogic.isDataSelected(widget.tagId, question)
                );
              },chooseEnable: widget.chooseLogic.isDataSelected(widget.tagId, question));
            },
          )
        ],
      ),
    );
  }



  @override
  void dispose() {
    Get.delete<QuestionListLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}