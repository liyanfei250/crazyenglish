import 'package:crazyenglish/utils/time_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../../base/widgetPage/loading.dart';
import '../../../entity/error_note_response.dart' as errorDate;
import '../../../entity/error_note_response.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/colors.dart';
import '../error_note/error_note_logic.dart';
import 'error_note_child_list_logic.dart';

class ErrorNoteChildListPage extends StatefulWidget {
  static int WAIT_CORRECT = 0;
  static int HAS_CORRECTED = 1;

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
  final stateLogic = Get
      .find<Error_noteLogic>()
      .state;
  final state = Get
      .find<Error_note_child_listLogic>()
      .state;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  CancelFunc? _cancelLoading;
  final int pageSize = 10;
  int currentPageNo = 1;
  List<errorDate.Rows> weekPaperList = [];
  final int pageStartIndex = 1;

  @override
  void initState() {
    super.initState();
    print('type==' +
        widget.type.toString() +
        'typeTwo==' +
        widget.typeTwo.toString());

    /*noteLogic.addListenerId(GetBuilderIds.changeNoteList, () {
      currentPageNo = 1;
      logic.getList(
          stateLogic.correction, widget.typeTwo, pageStartIndex, pageSize);
    });*/

    logic.addListenerId(
        GetBuilderIds.errorNoteTestList +
            widget.type.toString() +
            widget.typeTwo.toString(), () {
      hideLoading();
      if (state.list != null && state.list != null) {
        if (state.pageNo == currentPageNo + 1) {
          weekPaperList = state.list;
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

    logic.addListenerId(GetBuilderIds.errorDetailList, () {
      if (state.weekTestDetailResponse != null &&
          state.weekTestDetailResponse.data != null &&
          state.weekTestDetailResponse.data!.length > 0 &&
          state.weekTestDetailResponse.data![0].type == 4 &&
          state.weekTestDetailResponse.data![0].typeChildren == 1) {

        RouterUtil.toNamed(AppRoutes.WritingPage,
            arguments: {"detail": state.weekTestDetailResponse});
      } else {
        RouterUtil.toNamed(AppRoutes.AnsweringPage,
            arguments: {"detail": state.weekTestDetailResponse});
      }
    });
    _onRefresh();
    showLoading("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("");
            } else if (mode == LoadStatus.canLoading) {
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                listitemBigBg,
                childCount: weekPaperList.length,
              ),
            ),
          ],
        ),
      ) /*ListView(
        children: listDataOne.map((value) {
          return listitemBigBg();
        }).toList(),
      )*/
      ,
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
                  weekPaperList![index].name ?? "",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff858aa0),
                      fontWeight: FontWeight.w500),
                )),
            Expanded(child: Text('')),
            Padding(
              padding: EdgeInsets.only(top: 8.w, bottom: 18.w),
              child: Text(
                  weekPaperList![index].lastTime!.isNotEmpty
                      ? TimeUtil.getFormatTime(weekPaperList![index].lastTime!)
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
          itemCount: weekPaperList![index].directory!.length,
          itemBuilder: (BuildContext context, int indexSmall) {
            return listitem(weekPaperList![index].directory!, indexSmall);
          },
        )
        /*ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: listData.map((value) {
            return listitem(value);
          }).toList(),
        )*/
        ,
      ],
    );
  }

  Widget listitem(List<Directory> value, index) {
    return InkWell(
        onTap: () {
          /*if (stateDetail.weekTestDetailResponse != null &&
              stateDetail.weekTestDetailResponse.data != null &&
              stateDetail.weekTestDetailResponse.data!.length > 0 &&
              stateDetail.weekTestDetailResponse.data![0].type == 4 &&
              stateDetail.weekTestDetailResponse.data![0].typeChildren == 1) {
            RouterUtil.toNamed(AppRoutes.WritingPage,
                arguments: {"detail": stateDetail.weekTestDetailResponse});
          } else {
            RouterUtil.toNamed(AppRoutes.AnsweringPage,
                arguments: {"detail": stateDetail.weekTestDetailResponse});
          }*/
          logic.getWeekTestDetail(value[index].uuid!);
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
                      top: value[index].correction == 1 ? 10.w : 14.w)),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            value[index].name ?? "",
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
                              value[index].exercisesSuccess.toString() +
                              "/" +
                              value[index].exercisesTotal.toString(),
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
                    child: value[index].correction == 0
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
                      top: value[index].correction == 1 ? 10.w : 14.w)),
            ],
          ),
        ));
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getList(widget.type, widget.typeTwo, pageStartIndex, pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getList(widget.type, widget.typeTwo, currentPageNo, pageSize);
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
