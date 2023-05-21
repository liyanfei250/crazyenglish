import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart'as refresh;

import '../../../../base/AppUtil.dart';
import '../../../../base/common.dart';
import '../../../../base/widgetPage/loading.dart';
import '../../../../entity/review/ErrorNoteTabDate.dart'as errorDate;
import '../../../../entity/review/ErrorNoteTabDate.dart';
import '../../../../r.dart';
import '../../../../routes/getx_ids.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/sp_util.dart';
import '../../../../widgets/PlaceholderPage.dart';
import '../../../practise/answering/answering_view.dart';
import '../../../week_test/week_test_detail/week_test_detail_logic.dart';
import '../error_note/error_note_logic.dart';
import '../error_note_child/error_note_child_view.dart';
import 'error_note_child_list_logic.dart';

class ErrorNoteChildListPage extends StatefulWidget {

  int type;
  int typeTwo;

  ErrorNoteChildListPage(this.type, this.typeTwo, {Key? key}) : super(key: key);

  @override
  _ErrorNoteChildListPageState createState() => _ErrorNoteChildListPageState();
}

class _ErrorNoteChildListPageState extends State<ErrorNoteChildListPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(Error_note_child_listLogic());
  final noteLogic = Get.find<Error_noteLogic>();
  final stateLogic = Get.find<Error_noteLogic>().state;
  final state = Get.find<Error_note_child_listLogic>().state;

  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;

  refresh.RefreshController _refreshController =
  refresh.RefreshController(initialRefresh: false);
  CancelFunc? _cancelLoading;
  final int pageSize = 10;
  int currentPageNo = 1;
  List<errorDate.Obj> weekPaperList = [];
  final int pageStartIndex = 1;

  @override
  void initState() {
    super.initState();
    print('type==${widget.type}typeTwo==${widget.typeTwo}');

    //isCorrect是否订正 0 否 1 是
    //classify 题型value
    logic.addListenerId(
        GetBuilderIds.errorNoteTestList +
            widget.type.toString() +
            widget.typeTwo.toString(), () {
      hideLoading();
      if (state.list != null ) {
        if (state.pageNo == currentPageNo + 1) {
          currentPageNo++;
          weekPaperList.addAll(state!.list!);
          if (mounted && _refreshController != null) {
            _refreshController.loadComplete();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            setState(() {});
          }
        } else if (state.pageNo == pageStartIndex) {
          currentPageNo = pageStartIndex;
          weekPaperList.clear();
          weekPaperList.addAll(state.list!);
          if (mounted && _refreshController != null) {
            _refreshController.refreshCompleted();
            if (!state!.hasMore) {
              _refreshController.loadNoData();
            } else {
              _refreshController.resetNoData();
            }
            setState(() {});
          }
        }
      }
    });

    logic.addListenerId(GetBuilderIds.getErrorNoteTabDate, () {
      Util.toast('获取列表数据成功');
    });

    _onRefresh();
    showLoading("");
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: refresh.SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: refresh.WaterDropHeader(),
        footer: refresh.CustomFooter(
          builder: (BuildContext context, refresh.LoadStatus? mode) {
            Widget body;
            if (mode == refresh.LoadStatus.idle) {
              body = Text("");
            } else if (mode == refresh.LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == refresh.LoadStatus.failed) {
              body = Text("");
            } else if (mode == refresh.LoadStatus.canLoading) {
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
            weekPaperList.length == 0
                ? SliverToBoxAdapter(
                child: PlaceholderPage(
                    imageAsset: R.imagesCommenNoDate,
                    title: '暂无数据',
                    topMargin: 100.w,
                    subtitle: ''))
                :
            SliverList(
              delegate: SliverChildBuilderDelegate(
                listitemBigBg,
                childCount: weekPaperList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listitemBigBg(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 10.w),
      padding:
          EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 10.w),
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
      child: listitemBig(index),
    );
  }

  Widget listitemBig(index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
                child: Text(
                  weekPaperList![index].journalName ?? "",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
              child: Text(
                  weekPaperList![index].createTime!.isNotEmpty
                      ? weekPaperList![index].createTime!
                      : "",
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff353e4d),
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: weekPaperList![index].recordListVos!.length,
          itemBuilder: (BuildContext context, int indexSmall) {
            return listitem(weekPaperList![index].recordListVos!, indexSmall);
          },
        ),
      ],
    );
  }

  Widget listitem(List<RecordListVos> value, index) {
    return InkWell(
        onTap: () {
          if(widget.type == ErrorNoteChildPage.HAS_CORRECTED){
            logicDetail.addJumpToReviewDetailListen(resultType: AnsweringPage.result_browse_type);
            logicDetail.getDetailAndEnterBrowsePage("${value[index].subjectId}","0");
          } else {
            logicDetail.addJumpToFixErrorListen();
            logicDetail.getDetailAndEnterFixPage("${value[index].subjectId}",value[index].correctionNotebooks);
          }
        },
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: Colors.grey,
                height: 1.w,
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: widget.type==0 ? 10.w : 14.w)),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            value[index].questionTypeName ?? "",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff353e4d)),
                          ),
                          Padding(padding: EdgeInsets.only(left: 11.w)),
                          Visibility(
                            child: Image.asset(
                              R.imagesListenigLastIcon,
                              fit: BoxFit.cover,
                              width: 26.w,
                              height: 18.w,
                            ),
                            visible: index == 0,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.w),
                        child: Text(
                          '正确率' +
                              "${value[index].correctCount??0}" +
                              "/" +
                              value[index].totalCount.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff858aa0)),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Text('')),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: widget.type==0
                        ? Image.asset(
                            R.imagesErrorToCorrect,
                            fit: BoxFit.cover,
                            width: 41.w,
                            height: 15.w,
                          )
                        : Image.asset(
                            R.imagesErrorToCorrectOver,
                            fit: BoxFit.cover,
                            width: 60.w,
                            height: 60.w,
                          ),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: widget.type==0 ? 10.w : 14.w)),
            ],
          ),
        ));
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    // int userId, int isCorrect, int classify, int current, int size
    logic.getList(SpUtil.getInt(BaseConstant.USER_ID),widget.type, widget.typeTwo, pageStartIndex, pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getList(SpUtil.getInt(BaseConstant.USER_ID),widget.type, widget.typeTwo, currentPageNo+1, pageSize);

  }

  @override
  void dispose() {
    Get.delete<Error_note_child_listLogic>();
    Get.delete<Error_noteLogic>();
    _refreshController.dispose();
    super.dispose();
  }

  void showLoading(String text) {
    if (text == null || text.isEmpty) {
      text = "";
    }
    if (_cancelLoading != null) {
      _cancelLoading!();
    }
    _cancelLoading =
        BotToast.showCustomLoading(toastBuilder: (_) => LoadingWidget());
  }

  void hideLoading() {
    if (_cancelLoading != null) {
      _cancelLoading!();
    }
  }

  bool get wantKeepAlive => true;
}
