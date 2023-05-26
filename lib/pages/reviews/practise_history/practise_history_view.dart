import 'dart:async';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/blocs/refresh_bloc_bloc.dart';
import 'package:crazyenglish/blocs/refresh_bloc_state.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/MyDecoration.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;

import '../../../entity/home/PractiseDate.dart';
import '../../../entity/review/PractiseHistoryDate.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../widgets/LeftLineWidget.dart';
import '../../../widgets/PlaceholderPage.dart';
import '../../week_test/week_test_detail/week_test_detail_logic.dart';
import 'practise_history_logic.dart';
import 'package:table_calendar/table_calendar.dart';

import 'utils.dart';
//学生练习记录
class Practise_historyPage extends BasePage {
  num? studentId;
   Practise_historyPage({Key? key}) : super(key: key){
    if (Get.arguments != null && Get.arguments is Map) {
      studentId = Get.arguments['studentId'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _Practise_historyPageState();
}

class _Practise_historyPageState extends BasePageState<Practise_historyPage> {
  final logic = Get.put(Practise_historyLogic());
  final state = Get.find<Practise_historyLogic>().state;
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;
  pull.RefreshController _refreshController =
      pull.RefreshController(initialRefresh: false);
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  List timeTestList = [
  ];
  int currentPageNo = 1;
  late DateTime _selectedDay;
  PractiseHistoryDate? paperDetail;
  PractiseDate? dateDetail;
  late List<Obj> listData = [];
  int pageSize = 10;
  int current = 1;
  var formatter = DateFormat('yyyy-M-d');
  Map<String, List<Event>> _events = {
  };

  int month = 0;
  StreamSubscription? refrehStreamSubscription;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    refrehStreamSubscription = BlocProvider.of<RefreshBlocBloc>(context).stream.listen((event) {
      if(event is RefreshAnswerState){
        if(logic!=null && SpUtil.getInt(BaseConstant.USER_ID)>0){
          _onRefresh();
        }
      }
    });
    logic.addListenerId(GetBuilderIds.PracticeDate, () {
      if (state.dateDetail != null) {
        dateDetail = state.dateDetail;
        if (state.dateDetail!.obj != null &&
            state.dateDetail!.obj!.isNotEmpty) {
          setState(() {
            state.dateDetail!.obj!.forEach((element) {
              _events[formatter.format(DateTime.parse(element))] = [const Event('Event A',isMarked:true),];
            });
          });
        }

      }
    });
    logic.getPracticeDateInfo(
        widget.studentId.toString(), "'${formatter.format(_selectedDay)}'");
    _addDayListListener(null, _selectedDay);
    _onRefresh();

  }

  _addDayListListener(DateTime? oldDay,DateTime newDay){
    if(oldDay!=null){
      logic.disposeId(GetBuilderIds.getPracticeRecordList + formatter.format(oldDay));
    }
    logic.addListenerId(GetBuilderIds.getPracticeRecordList + formatter.format(newDay),
            () {
          hideLoading();
          if (state.list != null ) {
            if (state.pageNo == currentPageNo + 1) {
              currentPageNo++;
              listData.addAll(state.list!);
              if (mounted && _refreshController != null) {
                _refreshController.loadComplete();
                if (!state!.hasMore) {
                  _refreshController.loadNoData();
                } else {
                  _refreshController.resetNoData();
                }
                setState(() {});
              }
            } else if (state.pageNo == current) {
              currentPageNo = current;
              listData.clear();
              listData.addAll(state.list!);
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
  }

  List<Event> _getEventsForDay(DateTime day) {
    String key = formatter.format(day);
    return _events[key] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      logic.addListenerId(GetBuilderIds.getPracticeRecordList + formatter.format(selectedDay),
              () {
            hideLoading();
            if (state.list != null ) {
              if (state.pageNo == currentPageNo + 1) {
                currentPageNo++;
                listData.addAll(state.list!);
                if (mounted && _refreshController != null) {
                  _refreshController.loadComplete();
                  if (!state!.hasMore) {
                    _refreshController.loadNoData();
                  } else {
                    _refreshController.resetNoData();
                  }
                  setState(() {});
                }
              } else if (state.pageNo == current) {
                currentPageNo = current;
                listData.clear();
                listData.addAll(state.list!);
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

      _onRefresh();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("练习记录"),
      backgroundColor: const Color(0xfff8f9fb),
      body: pull.SmartRefresher(
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
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 38.w, right: 38.w),
                    decoration: BoxDecoration(
                      color: AppColors.c_FFFFFFFF,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.w),
                          bottomRight: Radius.circular(20.w)),
                    ),
                    child: TableCalendar<Event>(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                        CalendarFormat.week: 'Week',
                      },
                      eventLoader: _getEventsForDay,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekStyle:
                          DaysOfWeekStyle(dowTextFormatter: (date, locale) {
                        String week = DateFormat.E("en_US").format(date);
                        switch (week) {
                          case "Mon":
                            return "一";
                          case "Tue":
                            return "二";
                          case "Wed":
                            return "三";
                          case "Thu":
                            return "四";
                          case "Fri":
                            return "五";
                          case "Sat":
                            return "六";
                          case "Sun":
                            return "日";
                        }
                        return week;
                      }),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronMargin: EdgeInsets.only(left: 0),
                        leftChevronPadding: EdgeInsets.only(left: 8.w),
                        leftChevronIcon: Image.asset(
                          R.imagesHistoryPreMonth,
                          width: 12.w,
                          height: 12.w,
                        ),
                        rightChevronIcon: Image.asset(
                          R.imagesHistoryNextMonth,
                          width: 12.w,
                          height: 12.w,
                        ),
                        rightChevronMargin: EdgeInsets.only(right: 0),
                        rightChevronPadding: EdgeInsets.only(right: 8.w),
                      ),
                      calendarStyle: CalendarStyle(
                        markersMaxCount: 1,
                        markerMargin: EdgeInsets.only(top: 6.w),
                        markerDecoration: const BoxDecoration(
                          color: const Color(0xFFED702D),
                          shape: BoxShape.circle,
                        ),
                        cellMargin: EdgeInsets.only(
                            left: 6.w, right: 6.w, top: 11.w, bottom: 11.w),
                        todayTextStyle: TextStyle(
                            color: AppColors.c_FFED702D,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                        selectedTextStyle: TextStyle(
                            color: AppColors.c_FFFFFFFF,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                        selectedDecoration: const BoxDecoration(
                          color: const Color(0xFFED702D),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: const BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          shape: BoxShape.circle,
                        ),
                        outsideTextStyle: TextStyle(
                            color: AppColors.c_FF898A93,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                        defaultTextStyle: TextStyle(
                            color: AppColors.c_FF353E4D,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                        weekendTextStyle: TextStyle(
                            color: AppColors.c_FF353E4D,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      calendarBuilders: CalendarBuilders<Event>(
                        headerTitleBuilder: (context, day) {
                          if(month!=day.month){
                            logic.getPracticeDateInfo(widget.studentId.toString(), "'${formatter.format(day)}'");
                          }
                          month = day.month;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${day.year}年",
                                style: TextStyle(
                                    color: AppColors.c_80ED702D,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " ${day.month}月",
                                style: TextStyle(
                                    color: AppColors.c_FFED702D,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          );
                        },
                      ),
                      onDaySelected: _onDaySelected,
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;

                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ValueListenableBuilder<List<Event>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return Visibility(
                            visible: listData.length > 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 24.w,
                                  child: LeftLineWidget(
                                    showBottom: true,
                                    showTop: false,
                                    isLight: false,
                                  ),
                                ),
                                Text(
                                  "${_selectedDay?.year}年${_selectedDay?.month}月${_selectedDay?.day}日",
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xff151619),
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ));
                      }),
                  listData.length == 0
                      ? PlaceholderPage(
                          imageAsset: R.imagesCommenNoDate,
                          title: '暂无数据',
                          topMargin: 20.w,
                          subtitle: '')
                      : Container(
                          decoration: MyDecoration(),
                          margin: EdgeInsets.only(left: 24, top: 12.w),
                          padding: EdgeInsets.fromLTRB(11.w, 0, 16, 16),
                          child: ValueListenableBuilder<List<Event>>(
                            valueListenable: _selectedEvents,
                            builder: (context, value, _) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13.w)),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xfffbf4f2),
                                        offset: Offset(0, 0),
                                        blurRadius: 20,
                                        spreadRadius: 0,
                                      )
                                    ]),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: listData.map((element) {
                                    return Container(
                                        padding: EdgeInsets.only(
                                            left: 28.2, right: 24.w, top: 20.w),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                logicDetail
                                                    .addJumpToReviewDetailListen();
                                                logicDetail
                                                    .getDetailAndEnterResult(
                                                        "${element.subjectId}",
                                                        "${element.exerciseId}");
                                                showLoading("");
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        element.journalName??""+(element.questionTypeName??""),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff353e4d),
                                                            fontSize: 14.sp),
                                                      ),
                                                      Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                              top: 11.w)),
                                                      Text(
                                                        element.catalogueName??"",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff353e4d),
                                                            fontSize: 14.sp),
                                                      ),
                                                      Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                              top: 11.w)),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            alignment:
                                                            Alignment
                                                                .center,
                                                            padding: EdgeInsets
                                                                .only(
                                                                left:
                                                                10.w,
                                                                right:
                                                                10.w,
                                                                top: 4.w,
                                                                bottom:
                                                                4.w),
                                                            margin: EdgeInsets
                                                                .only(
                                                                right:
                                                                13.w),
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Color(
                                                                  0xfffff7ed),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  2.w)),
                                                            ),
                                                            child: Text(
                                                              element.time ??
                                                                  "",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffed702d),
                                                                  fontSize:
                                                                  12.sp),
                                                            ),
                                                          ),
                                                          Text(
                                                            element.accuracy! +
                                                                "%正确率",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff898a93),
                                                                fontSize:
                                                                12.sp),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Image.asset(
                                                    R.imagesHistoryJumpArrow,
                                                    width: 10.w,
                                                    height: 10.w,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                                visible: true,
                                                child: Divider(
                                                  color: AppColors.c_FFD2D5DC,
                                                  thickness: 0.2.w,
                                                ))
                                          ],
                                        ));
                                  }).toList(),
                                ),
                              );
                            },
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    _refreshController.dispose();
    Get.delete<Practise_historyLogic>();
    Get.delete<WeekTestDetailLogic>();
    if(refrehStreamSubscription!=null){
      refrehStreamSubscription!.cancel();
    }
    super.dispose();
  }

  void _onRefresh() async {
    currentPageNo = current;
    logic.getRecordInfo(widget.studentId.toString(),
        formatter.format(_selectedDay), pageSize, current);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getRecordInfo(widget.studentId.toString(),
        formatter.format(_selectedDay), pageSize, currentPageNo+1);
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
