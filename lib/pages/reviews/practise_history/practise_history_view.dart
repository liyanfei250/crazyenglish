import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/reviews/practtise_history/MyDecoration.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../r.dart';
import '../practtise_history/LeftLineWidget.dart';
import 'practise_history_logic.dart';
import 'package:table_calendar/table_calendar.dart';

import 'utils.dart';

class Practise_historyPage extends BasePage {
  const Practise_historyPage({Key? key}) : super(key: key);
  @override
  BasePageState<BasePage> getState() => _Practise_historyPageState();
}

class _Practise_historyPageState extends BasePageState<Practise_historyPage> {
  final logic = Get.put(Practise_historyLogic());
  final state = Get.find<Practise_historyLogic>().state;

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

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
      appBar: buildNormalAppBar("练习记录"),
      backgroundColor: const Color(0xfff8f9fb),
      body: Column(
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
          Container(
            decoration: MyDecoration(),
            margin: EdgeInsets.only(left: 24),
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
                    children: value.map((element) {
                      return Container(
                        height: 83.w,
                        padding: EdgeInsets.only(left: 28.2,right: 24.w),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("01. 情景反应",style: TextStyle(color: Color(0xff353e4d),fontSize: 14.sp),),
                                    Padding(padding: EdgeInsets.only(top: 11.w)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 48.w,
                                          height: 17.w,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 13.w),
                                          decoration: BoxDecoration(
                                            color: Color(0xfffff7ed),
                                            borderRadius: BorderRadius.all(Radius.circular(2.w)),
                                          ),
                                          child: Text("10:11",style: TextStyle(color: Color(0xffed702d),fontSize: 12.sp),),
                                        ),
                                        Text("60%正确率",style: TextStyle(color: Color(0xff898a93),fontSize: 12.sp),),
                                      ],
                                    )
                                  ],
                                ),
                                Image.asset(R.imagesHistoryJumpArrow,width: 10.w,height: 10.w,)
                              ],
                            ),),
                            Visibility(
                                visible: true,
                                child: Divider(color: AppColors.c_FFD2D5DC,thickness: 0.2.w,))

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
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    Get.delete<Practise_historyLogic>();
    super.dispose();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}