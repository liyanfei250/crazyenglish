import 'package:crazyenglish/entity/review/HomeSecondListDate.dart';
import 'package:crazyenglish/pages/homework/choose_question/choose_question_logic.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;

import '../../../../base/AppUtil.dart';
import '../../../../base/common.dart';
import '../../../../base/widgetPage/base_page_widget.dart';
import '../../../../entity/QuestionListResponse.dart';
import '../../../../r.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/sp_util.dart';
import '../../assign_homework/assign_homework_logic.dart';
import '../../choose_logic.dart';
import 'question_list_logic.dart';
import '../../../../entity/review/HomeSecondListDate.dart' as data;

class QuestionListPage extends BasePage {
  ChooseIntel chooseLogic;
  String tagId;

  QuestionListPage({required this.chooseLogic, required this.tagId, Key? key})
      : super(key: key);

  @override
  BasePageState<BasePage> getState() => _QuestionListPageState();
}

class _QuestionListPageState extends BasePageState<QuestionListPage> {
  final logic = Get.put(QuestionListLogic());
  final state = Get.find<QuestionListLogic>().state;

  pull.RefreshController _refreshController =
      pull.RefreshController(initialRefresh: false);
  final assignLogic = Get.find<AssignHomeworkLogic>();

  final gradeLogic = Get.find<ChooseQuestionLogic>();
  final int pageSize = 20;
  int currentPageNo = 1;
  final int pageStartIndex = 1;
  List<data.Obj> homeSecondListDate = [];
  List<data.CatalogueRecordVoList> homeFinalListDate = [];

  @override
  void onCreate() {
    gradeLogic.state.dictionaryId = widget.tagId;
    gradeLogic.addListenerId(
        GetBuilderIds.getHomeSecondListDate +
            gradeLogic.state.dictionaryId.toString(), () {
      hideLoading();
      if (gradeLogic.state.homeSecondListDate != null) {
        //判断选择之前勾选的数据
        if (gradeLogic.state.homeFinalListDate != null) {
          if (assignLogic.state.assignHomeworkRequest.journalCatalogueIds !=
                  null &&
              assignLogic
                      .state.assignHomeworkRequest.journalCatalogueIds!.length >
                  0) {
            gradeLogic.state.homeFinalListDate.forEach((element) {
              if (assignLogic.state.assignHomeworkRequest.journalCatalogueIds!
                  .contains(element.catalogueId)) {
                widget.chooseLogic.addSelected(widget.tagId, element, true);
              }
            });
          }
        }

        if (gradeLogic.state.pageNo == currentPageNo + 1) {
          currentPageNo++;
          homeSecondListDate.addAll(gradeLogic.state.homeSecondListDate!);
          if (mounted && _refreshController != null) {
            _refreshController.loadComplete();
            if (!gradeLogic.state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            widget.chooseLogic
                .addData(widget.tagId, gradeLogic.state!.homeFinalListDate!);
            setState(() {});
          }
        } else if (gradeLogic.state.pageNo == pageStartIndex) {
          currentPageNo = pageStartIndex;
          homeSecondListDate.clear();
          homeSecondListDate.addAll(gradeLogic.state!.homeSecondListDate!);
          if (mounted && _refreshController != null) {
            _refreshController.refreshCompleted();
            if (!gradeLogic.state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            widget.chooseLogic
                .resetData(widget.tagId, gradeLogic.state!.homeFinalListDate!);
            setState(() {});
          }
        }
      }
    });

    _onRefresh();
    showLoading("加载中");
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    gradeLogic.getQuestionList(
        SpUtil.getInt(BaseConstant.USER_ID),
        gradeLogic.state.dictionaryId,
        gradeLogic.state.affiliatedGrade,
        pageSize,
        pageStartIndex);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    gradeLogic.getQuestionList(
        SpUtil.getInt(BaseConstant.USER_ID),
        gradeLogic.state.dictionaryId,
        gradeLogic.state.affiliatedGrade,
        gradeLogic.state.pageSize,
        currentPageNo + 1);
  }

  @override
  Widget build(BuildContext context) {
    return pull.SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: pull.WaterDropHeader(),
      footer: pull.CustomFooter(
        builder: (BuildContext context, pull.LoadStatus? mode) {
          Widget body;
          if (mode == pull.LoadStatus.idle) {
            body = Text("");
          } else if (mode == pull.LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == pull.LoadStatus.failed) {
            body = Text("");
          } else if (mode == pull.LoadStatus.canLoading) {
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
          SliverPadding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            sliver: homeSecondListDate.length > 0
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      buildItemTop,
                      childCount: homeSecondListDate.length,
                    ),
                  )
                : SliverToBoxAdapter(
                    child: PlaceholderPage(
                        imageAsset: R.imagesCommenNoDate,
                        title: '暂无数据',
                        topMargin: 100.w,
                        subtitle: '')),
          )
        ],
      ),
    );
  }

  Widget buildGroupHeader(data.Obj question) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(top: 11.w)),
          Text(
            "${question.journalName}",
            style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.c_FF898A93,
                fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.only(top: 11.w),
            width: double.infinity,
            height: 0.2.w,
            color: AppColors.c_FFD2D5DC,
          ),
        ],
      ),
    );
  }

  Widget buildItemTop(BuildContext context, int index) {
    return InkWell(
      onTap: () {},
      child: listitemBigBg(homeSecondListDate[index]),
    );
  }

  Widget listitemBigBg(data.Obj obj) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 11.w),
                child: SizedBox(
                  width: 180.w,
                  child: Text(
                    obj.journalName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff858aa0),
                        fontWeight: FontWeight.w500),
                  ),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(
                left: 2.w,
                top: 9.w,
                bottom: 11.w,
                right: 18.w,
              ),
              child: Image.asset(
                R.imagesIconToNext,
                color: Color(0xff353e4d),
                fit: BoxFit.cover,
                width: 7.w,
                height: 11.w,
              ),
            ),
          ],
        ),
        Container(
          margin:
              EdgeInsets.only(top: 11.w, left: 4.w, right: 4.w, bottom: 10.w),
          // padding:
          //     EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 10.w),
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
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return listitemBig(obj.catalogueMergeVo![index], index);
            },
            itemCount: obj.catalogueMergeVo!.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget listitemBig(CatalogueMergeVo value, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: index == 0
                ? BorderRadius.only(topLeft: Radius.circular(7.w))
                : BorderRadius.only(topLeft: Radius.circular(0.w)),
            gradient: LinearGradient(
              colors: [Color(0xfffcefd8), Color(0x0fcefd8)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w, left: 17.w),
                  child: SizedBox(
                    width: 240.w,
                    child: Text(
                      value.catalogueMergeName ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13,
                          color: Color(0xffed702d),
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                  child: Text(
                    '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff858aa0),
                        fontWeight: FontWeight.w500),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                  child: Text(
                    '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xffed702d),
                        fontWeight: FontWeight.w500),
                  )),
              Expanded(child: Text('')),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 17.w, right: 17.w),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return listitem(value.catalogueRecordVoList![index], index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1, color: Color(0xffd2d5dc));
            },
            itemCount: value.catalogueRecordVoList!.length,
          ),
        ),
      ],
    );
  }

  Widget listitem(CatalogueRecordVoList data, int value) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
        child: Row(
          children: [
            SizedBox(
              width: 190.w,
              child: Text(
                data.catalogueName ?? "",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff353e4d)),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 11.w)),
            Expanded(child: Text('')),
            GetBuilder<ChooseLogic>(
              id: GetBuilderIds.updateCheckBox + widget.tagId,
              builder: (logic) {
                return Util.buildCheckBox(() {
                  widget.chooseLogic.addSelected(widget.tagId, data,
                      !widget.chooseLogic.isDataSelected(widget.tagId, data));
                },
                    chooseEnable:
                        widget.chooseLogic.isDataSelected(widget.tagId, data));
              },
            )
          ],
        ),
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
