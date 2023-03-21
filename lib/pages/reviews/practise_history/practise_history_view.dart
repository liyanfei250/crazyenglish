import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../r.dart';
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 38.w,right: 38.w),
            decoration: BoxDecoration(
              color: AppColors.c_FFFFFFFF,

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
                    return DateFormat.E("en_US").format(date);
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
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
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