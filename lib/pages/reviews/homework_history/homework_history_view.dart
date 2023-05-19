import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../r.dart';
import '../../../utils/colors.dart';
import '../../../widgets/LeftLineWidget.dart';
import '../../../widgets/MyDecoration.dart';
import '../../../widgets/PlaceholderPage.dart';
import '../../week_test/week_test_detail/week_test_detail_logic.dart';
import '../practise_history/utils.dart';
import 'homework_history_logic.dart';
//学生历史作业
class HomeworkHistoryPage extends BasePage {
  const HomeworkHistoryPage({Key? key}) : super(key: key);

  @override
  BasePageState<HomeworkHistoryPage> getState() => _HomeworkHistoryPageState();
}

class _HomeworkHistoryPageState extends BasePageState<HomeworkHistoryPage> {
  final logic = Get.put(HomeworkHistoryLogic());
  final state = Get.find<HomeworkHistoryLogic>().state;
  final logicDetail = Get.put(WeekTestDetailLogic());
  final stateDetail = Get.find<WeekTestDetailLogic>().state;

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("历史作业"),
      backgroundColor: const Color(0xfff8f9fb),
      body: SmartRefresher(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 38.w,right: 38.w),
                    decoration: BoxDecoration(
                      color: AppColors.c_FFFFFFFF,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.w),bottomRight: Radius.circular(20.w)),
                    ),
                    child: TableCalendar<Event>(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      calendarFormat: _calendarFormat,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                        CalendarFormat.week: 'Week',
                      },
                      rangeSelectionMode: _rangeSelectionMode,
                      eventLoader: _getEventsForDay,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekStyle: DaysOfWeekStyle(
                          dowTextFormatter:(date, locale){
                            String week =  DateFormat.E("en_US").format(date);
                            switch(week){
                              case "Mon": return "一";
                              case "Tue": return "二";
                              case "Wed": return "三";
                              case "Thu": return "四";
                              case "Fri": return "五";
                              case "Sat": return "六";
                              case "Sun": return "日";
                            }
                            return week;
                          }
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible:false,
                        titleCentered:true,
                        leftChevronMargin: EdgeInsets.only(left: 0),
                        leftChevronPadding: EdgeInsets.only(left: 8.w),
                        leftChevronIcon: Image.asset(R.imagesHistoryPreMonth,width: 12.w,height: 12.w,),
                        rightChevronIcon: Image.asset(R.imagesHistoryNextMonth,width: 12.w,height: 12.w,),
                        rightChevronMargin: EdgeInsets.only(right: 0),
                        rightChevronPadding: EdgeInsets.only(right: 8.w),
                      ),
                      calendarStyle: CalendarStyle(
                        markersMaxCount:1,
                        markerMargin:EdgeInsets.only(top: 6.w),
                        markerDecoration: const BoxDecoration(
                          color: const Color(0xFFED702D),
                          shape: BoxShape.circle,
                        ),
                        cellMargin: EdgeInsets.only(left: 6.w,right: 6.w,top: 11.w,bottom: 11.w),
                        todayTextStyle:  TextStyle(color: AppColors.c_FFED702D,fontSize: 14.sp,fontWeight: FontWeight.w500),
                        selectedTextStyle: TextStyle(color: AppColors.c_FFFFFFFF,fontSize: 14.sp,fontWeight: FontWeight.w500),
                        selectedDecoration: const BoxDecoration(
                          color: const Color(0xFFED702D),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: const BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          shape: BoxShape.circle,
                        ),
                        outsideTextStyle: TextStyle(color: AppColors.c_FF898A93,fontSize: 14.sp,fontWeight: FontWeight.w500),
                        defaultTextStyle: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp,fontWeight: FontWeight.w500),
                        weekendTextStyle: TextStyle(color: AppColors.c_FF353E4D,fontSize: 14.sp,fontWeight: FontWeight.w500),
                      ),
                      calendarBuilders: CalendarBuilders<Event>(
                        headerTitleBuilder:(context, day){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${day.year}年",style: TextStyle(color: AppColors.c_80ED702D,fontSize: 16.sp,fontWeight: FontWeight.w500),),
                              Text(" ${day.month}月",style: TextStyle(color: AppColors.c_FFED702D,fontSize: 16.sp,fontWeight: FontWeight.w500),),
                            ],
                          );
                        },
                      ),
                      onDaySelected: _onDaySelected,
                      onRangeSelected: _onRangeSelected,
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
                      builder: (context,value,_){
                        return Visibility(
                            visible: value.length > 0,
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
                                Text("${_selectedDay?.year}年${_selectedDay?.month}月${_selectedDay?.day}日",
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(0xff151619),fontSize: 14.w,fontWeight: FontWeight.w500),
                                )
                              ],));
                      }),
                 /* value.length == 0
                      ? SliverToBoxAdapter(
                      child: PlaceholderPage(
                          imageAsset: R.imagesCommenNoDate,
                          title: '暂无数据',
                          topMargin: 20.w,
                          subtitle: ''))
                      :*/
                  Container(
                    decoration: MyDecoration(),
                    margin: EdgeInsets.only(left: 24,top: 12.w),
                    padding: EdgeInsets.fromLTRB(11.w, 0, 16, 16),
                    child: ValueListenableBuilder<List<Event>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.all( Radius.circular(13.w)),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xfffbf4f2),
                                  offset: Offset(0,0),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                )]
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: value.map((element) {
                              return Container(
                                  padding: EdgeInsets.only(left: 28.2,right: 24.w),
                                  margin: EdgeInsets.only(top: 16.w),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          logicDetail.addJumpToStartExamListen();
                                          logicDetail.getDetailAndStartExam("0");
                                          showLoading("");
                                        },
                                        child: Expanded(child:
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("综合评估（听力｜阅读｜写作）",style: TextStyle(color: Color(0xff898a93),fontSize: 12.sp,fontWeight: FontWeight.w500),),
                                            SizedBox(height: 12.w,),
                                            Container(height: 0.5.w,color: Color(0xffd2d5dc),),
                                            SizedBox(height: 14.w,),
                                            Text("一班（七年级）",style: TextStyle(color: Color(0xff353e4d),fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                            SizedBox(height: 6.w,),
                                            Text("个人正确率：98%",style: TextStyle(color: Color(0xff353e4d),fontSize: 12.sp,fontWeight: FontWeight.w500),),
                                            SizedBox(height: 6.w,),
                                            Text("班级正确率：94%",style: TextStyle(color: Color(0xff353e4d),fontSize: 12.sp,fontWeight: FontWeight.w500),),
                                            SizedBox(height: 6.w,),
                                            Text("班级排名：21",style: TextStyle(color: Color(0xff353e4d),fontSize: 12.sp,fontWeight: FontWeight.w500),),
                                            SizedBox(height: 20.w,)
                                          ],
                                        ),),
                                      ),
                                    ],
                                  )
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            /*SliverPadding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  buildItem,
                  childCount: weekPaperList.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 165.w,
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    Get.delete<HomeworkHistoryLogic>();
    Get.delete<WeekTestDetailLogic>();

    super.dispose();
  }
  void _onRefresh() async {
    // currentPageNo = pageStartIndex;
    // logic.getList(2, pageStartIndex, pageSize);
  }

  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // logic.getList(2, currentPageNo, pageSize);
  }
  @override
  void onCreate() {
  }

  @override
  void onDestroy() {
  }
}