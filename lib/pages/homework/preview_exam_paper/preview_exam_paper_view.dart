import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../base/AppUtil.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../../week_test/week_test_detail/week_test_detail_logic.dart';
import 'preview_exam_paper_logic.dart';
import '../../../entity/test_paper_look_response.dart' as paper;

/**
 * 试卷预览
 */
class PreviewExamPaperPage extends BasePage {
  static const String PaperType = "PaperType";
  static const String PaperId = "OperationId";
  static const String ShowAssignHomework = "isShowAssignHomework";
  static const String StudentOperationId = "StudentOperationId";
  late int paperType;
  late int paperId;
  late bool isShowAssignHomework;
  int? studentOperationId;
  int? operationId;

  PreviewExamPaperPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      paperType = Get.arguments[PaperType];
      paperId = Get.arguments[PaperId];
      isShowAssignHomework = Get.arguments[ShowAssignHomework] ?? false;
      studentOperationId = Get.arguments[StudentOperationId] ?? 0;
    }else {
      Get.back();
    }
  }

  @override
  BasePageState<PreviewExamPaperPage> getState() => _PreviewExamPaperPageState();
}

class _PreviewExamPaperPageState extends BasePageState<PreviewExamPaperPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(PreviewExamPaperLogic());
  final state = Get.find<PreviewExamPaperLogic>().state;

  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;

  var isChooseName = "".obs;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<paper.Obj> questionList = [];
  @override
  void onCreate() {
    logic.addListenerId(GetBuilderIds.getExamper,(){
      hideLoading();
      questionList.clear();
      questionList.addAll(state.list!);
      if(mounted && _refreshController!=null){
        _refreshController.refreshCompleted();
          _refreshController.loadNoData();
        setState(() {
        });
      }
    });
    _onRefresh();
    showLoading("加载中");
  }

  void _onRefresh() async{
    logic.getPreviewQuestionList(widget.paperType,widget.paperId);
  }

  void _onLoading() async{
    logic.getPreviewQuestionList(widget.paperType,widget.paperId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      body: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.c_FFFFFFFF,
            centerTitle: true,
            title: Text("试卷预览",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
            leading: Util.buildBackWidget(context),
            // bottom: ,
            elevation: 0,
            actions: [
              Visibility(
                visible: widget.isShowAssignHomework,
                child: Container(
                height: 22.w,
                margin: EdgeInsets.only(left:17.w,right: 22.w),
                child: InkWell(
                  onTap: (){
                    RouterUtil.toNamed(AppRoutes.AssignHomeworkPage);
                  },
                  child: Text("布置作业",style: TextStyle(fontSize: 14.sp,color: AppColors.c_FFED702D),),
                ),
              ),)
            ],
          ),
          Expanded(child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow:[
                      BoxShadow(
                        color: Color(0xffee754f),		// 阴影的颜色
                        offset: Offset(0.w, 0.w),						// 阴影与容器的距离
                        blurRadius: 9.w,							// 高斯的标准偏差与盒子的形状卷积。
                        spreadRadius: 0.w,
                      ),
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
                  SliverPadding(padding: EdgeInsets.only(left: 25.w,right: 25.w),
                      sliver: SliverGroupedListView<paper.Obj,num>(
                        groupBy: (element) => int.parse(element.classifyId??'0'),
                        groupSeparatorBuilder: buildSeparatorBuilder,
                        elements: questionList,
                        itemBuilder: buildItem,
                        groupHeaderBuilder: buildGroupHeader,
                      ))
                ],
              ),
            ),
          ),),
        ],
      ),
    );
  }

  Widget buildGroupHeader(paper.Obj question){
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
          Text("${question.classifyName}",style: TextStyle(fontSize: 12.sp,color: AppColors.c_FF898A93,fontWeight: FontWeight.w500),),
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

  Widget buildItem(BuildContext context, paper.Obj question) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: question.catalogues!.length,
      itemBuilder: (BuildContext context, int indexSmall) {
        return listitem(question.catalogues![indexSmall], indexSmall);
      },
    );
  }

  Widget listitem(paper.Catalogues value, index) {
    return InkWell(
      onTap: (){
        // studentOperationId
        if((widget.studentOperationId??0) > 0){
          // 做作业流程
          logicDetail.addJumpToStartHomeworkListen();
          logicDetail.getDetailAndStartHomework(value.journalCatalogueId??"","${widget.studentOperationId}","${widget.paperId}");
          showLoading("");
        }else{
          // 预览试题流程
          logicDetail.addJumpToBrowsePaperListen();
          logicDetail.getDetailAndEnterBrowsePaperPage(value.journalCatalogueId??"");
          showLoading("");
        }
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7.w),bottomRight: Radius.circular(7.w)),
        ),
        child: Text(
          "${value.catalogueName}",
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
      ),
    );
  }
  @override
  void dispose() {
    Get.delete<PreviewExamPaperLogic>();
    Get.delete<WeekTestDetailLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
  }

  @override
  bool get wantKeepAlive => true;
}