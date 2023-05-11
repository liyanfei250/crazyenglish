import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/widgets/PlaceholderPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:flutter_pickers/utils/check.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../entity/student_work_list_response.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../base/widgetPage/loading.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/my_text.dart';
import 'watting_push_logic.dart';

class Watting_pushPage extends StatefulWidget {
  static int WAIT_CORRECT = 0;
  static int HAS_CORRECTED = 1;

  int type; //1待提交2.已完成3.待批改
  num? typeTwo; //student

  Watting_pushPage(this.type, this.typeTwo, {Key? key}) : super(key: key);

  @override
  _WattingPushPageState createState() => _WattingPushPageState();
}

class _WattingPushPageState extends State<Watting_pushPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(Watting_pushLogic());
  final state = Get.find<Watting_pushLogic>().state;
  var selectData = {
    DateMode.YMDHMS: '',
    DateMode.YMDHM: '',
    DateMode.YMDH: '',
    DateMode.YMD: '',
    DateMode.YM: '',
    DateMode.Y: '',
    DateMode.MDHMS: '',
    DateMode.HMS: '',
    DateMode.MD: '',
    DateMode.S: '',
  };
  var selectDataTwo = {
    DateMode.YMDHMS: '',
    DateMode.YMDHM: '',
    DateMode.YMDH: '',
    DateMode.YMD: '',
    DateMode.YM: '',
    DateMode.Y: '',
    DateMode.MDHMS: '',
    DateMode.HMS: '',
    DateMode.MD: '',
    DateMode.S: '',
  };
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  CancelFunc? _cancelLoading;
  final int pageSize = 10;
  int currentPageNo = 1;
  final int pageStartIndex = 1;
  List<Records> workList = [];
  late num startTime;
  late num endTime;

  @override
  void initState() {
    super.initState();

    logic.addListenerId(
        GetBuilderIds.getStudentWorkList +
            widget.type.toString() +
            widget.typeTwo.toString(), () {
      hideLoading();
      if (state.list != null) {
        if (state.pageNo == currentPageNo + 1) {
          currentPageNo++;
          workList.addAll(state!.list!);
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
          workList.clear();
          workList.addAll(state.list!);
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

    DateTime now = DateTime.now();
    DateTime thirtyDaysAgo = now.subtract(Duration(days: 30));
    DateTime thirtyDaysAgoMidnight =
    DateTime(thirtyDaysAgo.year, thirtyDaysAgo.month, thirtyDaysAgo.day);
    startTime = thirtyDaysAgoMidnight.millisecondsSinceEpoch;

    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    endTime = endOfDay.millisecondsSinceEpoch;

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
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                    left: 25.w, right: 25.w, top: 22.w, bottom: 20.w),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () async {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _item('年月日', DateMode.YMD),
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        height: 1.w,
                        width: 18.w,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      _itemTwo(DateMode.YMD),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image.asset(
                        R.imagesCalendarRightIc,
                        width: 12.w,
                        height: 12.w,
                      )
                    ],
                  ),
                ),
              ),
            ),
            workList.length > 0
                ?
            SliverList(
              delegate: SliverChildBuilderDelegate(listitemBigBg,
                  childCount:  workList.length,
                  ),
            )
            : SliverToBoxAdapter(
                    child: PlaceholderPage(
                        imageAsset: R.imagesCommenNoDate,
                        title: '暂无数据',
                        topMargin: 0.w,
                        subtitle: ''),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _item(title, model) {
    return Container(
        child: GestureDetector(
      onTap: () {
        _onClickItem(model);
      },
      child: MyText(
        PicketUtil.strEmpty(selectData[model])
            ? "${DateFormat("yyyy年M月d日").format(DateTime.now().toUtc().add(Duration(hours: 8)).subtract(Duration(days: 30)))}"
            : selectData[model],
        color: Colors.black,
        size: 14,
        toppadding: 4.w,
        bottompadding: 4.w,
      ),
    ));
  }

  Widget _itemTwo(model) {
    return Container(
        child: GestureDetector(
      onTap: () {
        _onClickItemTwo(model);
      },
      child: MyText(
        PicketUtil.strEmpty(selectDataTwo[model])
            ? "${DateFormat("yyyy年M月d日").format(DateTime.now().toUtc().add(Duration(hours: 8)))}"
            : selectDataTwo[model],
        color: Colors.black,
        size: 14,
      ),
    ));
  }

  void _onClickItem(model) {
    Pickers.showDatePicker(
      context,
      mode: model,
      suffix: Suffix.normal(),
      minDate: PDuration(year: 2020, month: 2, day: 10),
      maxDate: PDuration(second: 22),
      onConfirm: (p) {
        print('longer >>> 返回数据：$p');
        setState(() {
          switch (model) {
            case DateMode.YMD:
              selectData[model] = '${p.year}年${p.month}月${p.day}日';
              DateTime date = DateTime(p.year!, p.month!, p.day!);
              DateTime startOfDay = DateTime(date.year, date.month, date.day);
              startTime = startOfDay.millisecondsSinceEpoch;
              break;
          }
          _onRefresh();
        });
      },
      // onChanged: (p) => print(p),
    );
  }

  void _onClickItemTwo(model) {
    Pickers.showDatePicker(
      context,
      mode: model,
      suffix: Suffix.normal(),
      minDate: PDuration(year: 2020, month: 2, day: 10),
      maxDate: PDuration(second: 22),
      onConfirm: (p) {
        print('longer >>> 返回数据：$p');
        setState(() {
          switch (model) {
            case DateMode.YMD:
              selectDataTwo[model] = '${p.year}年${p.month}月${p.day}日';
              DateTime date = DateTime(p.year!, p.month!, p.day!);
              DateTime startOfDay =
              DateTime(date.year, date.month, date.day, 23, 59, 59);
              endTime = startOfDay.millisecondsSinceEpoch;
              break;
          }
          _onRefresh();
        });
      },
      // onChanged: (p) => print(p),
    );
  }

  Widget listitemBigBg(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(top: 0.w, left: 10.w, right: 10.w, bottom: 10.w),
      padding:
          EdgeInsets.only(left: 14.w, right: 14.w, top: 0.w, bottom: 10.w),
      width: double.infinity,
      alignment: Alignment.topRight,
      child: Column(
        children: [
          returnLayout(index),
          SizedBox(
            height: 14.w,
          ),
          Divider(),
        ],
      )
    );
  }

  Widget listitemOne(index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildItemClassStudent('作业名称：', workList[index].name ?? ''),
        SizedBox(
          height: 14.w,
        ),
        buildItemClassStudentOne('作业状态：', getStatus(workList[index]!)),
      ],
    );
  }

  getStatus(Records records) {
    //1 未开始 2 进行中 3 已完成（有待批改项）4 已完成）
    if (records.operationStatus == 1) {
      return '未开始';
    }
    if (records.operationStatus == 2) {
      num percentage = (records.completeSize! / records.totalSize!) * 100;
      return '进行中（${percentage.toStringAsFixed(0)}%）';
    }
    if (records.operationStatus == 3) {
      return '已完成（有待批改项）';
    }
    if (records.operationStatus == 4) {
      return '已完成';
    }
  }

  getStatusTwo(Records records) {
    num percentage =
        (records.objectiveProperSize! / records.objectiveSize!) * 100;
    return '${percentage.toStringAsFixed(0)}%';
  }

  Widget listitemTwo(index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildItemClassStudent('作业名称：', workList[index].name ?? ''),
        SizedBox(
          height: 14.w,
        ),
        buildItemClassStudent('作业状态：', getStatus(workList[index]!)),
        SizedBox(
          height: 14.w,
        ),
        buildItemClassStudent('客观题正确率：', getStatusTwo(workList[index]!)),
      ],
    );
  }

  Widget listitemThree(index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildItemClassStudent('作业名称：', workList[index].name ?? ''),
        SizedBox(
          height: 14.w,
        ),
        buildItemClassStudent('作业状态：',  getStatus(workList[index]!)),
        SizedBox(
          height: 14.w,
        ),
        buildItemClassStudentThree('待批改内容：', '查看详情'),
      ],
    );
  }

  Widget buildItemClassStudent(String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          first,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff353e4d)),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            second,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff353e4d)),
          ),
        ),
      ],
    );
  }

  Widget buildItemClassStudentOne(String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          first,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff353e4d)),
        ),
        Text(
          second,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff353e4d)),
        ),
        SizedBox(
          height: 14.w,
        ),
      ],
    );
  }

  Widget buildItemClassStudentThree(String first, String second) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              first,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff353e4d)),
            ),
            Expanded(child: Text('')),
            InkWell(
              onTap: () {
                RouterUtil.toNamed(AppRoutes.TeacherToBeCorrectedPage);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    top: 2.w, bottom: 2.w, right: 10.w, left: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(11.w)),
                    color: Color(0xfffff7ed)),
                child: Text("查看详情",
                    style: TextStyle(
                        color: Color(0xfff2a842),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600)),
              ),
            )
          ],
        ),
        SizedBox(
          height: 14.w,
        ),
      ],
    );
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          first,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff353e4d)),
        ),
        Expanded(child: Text('')),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0.w)),
              color: Color(0xfffff7ed)),
          child: Text("查看详情",
              style: TextStyle(
                  color: Color(0xfff2a842),
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w600)),
        )
      ],
    );
  }

  void _onRefresh() async {
    currentPageNo = pageStartIndex;
    logic.getStudentWorkList(
        widget.type, widget.typeTwo!.toString(), pageStartIndex, pageSize,startTime, endTime);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getStudentWorkList(
        widget.type, widget.typeTwo!.toString(), currentPageNo + 1, pageSize,startTime, endTime);
  }

  @override
  void dispose() {
    Get.delete<Watting_pushLogic>();
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

  Widget returnLayout(int index) {
    if (widget.type == 1) {
      return listitemOne(index);
    }
    if (widget.type == 2) {
      return listitemTwo(index);
    }
    if (widget.type == 3) {
      return listitemThree(index);
    }
    return PlaceholderPage(
        imageAsset: R.imagesCommenNoDate,
        title: '暂无数据',
        topMargin: 16.w,
        subtitle: '');
  }
}
