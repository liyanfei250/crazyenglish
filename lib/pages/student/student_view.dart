import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/widgets/DashedLine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:flutter_pickers/utils/check.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/AppUtil.dart';
import '../../r.dart';
import '../../utils/colors.dart';
import '../../widgets/DatePicker.dart';
import '../../widgets/my_text.dart';
import 'student_logic.dart';

class StudentPage extends BasePage {
  const StudentPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() {
    return _StudentPageState();
  }
}

class _StudentPageState extends BasePageState<StudentPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(StudentLogic());
  final state = Get.find<StudentLogic>().state;
  late TabController _tabController;
  String stateText = '';
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
  List tabs = [
    {"title": "听力", "type": 1},
    {"title": "阅读", "type": 2},
    {"title": "写作", "type": 3},
    {"title": "语法", "type": 4},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text(
          '学生详情',
          style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Util.buildBackWidget(context),
        elevation: 10.w,
        shadowColor: const Color(0x1F000000),
        actions: [
          InkWell(
            onTap: () {
              // 点击事件处理逻辑
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              child: Text(
                '练习记录',
                style: TextStyle(
                  color: Color(0xffed702d),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 19.w, bottom: 20.w, left: 25.w, right: 25.w),
              margin: EdgeInsets.only(
                  top: 20.w, left: 18.w, right: 18.w, bottom: 0.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                      offset: Offset(2, 4), // 阴影与容器的距离
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                      child: Image.asset(
                    R.imagesShopImageLogoTest,
                    width: 80.w,
                    height: 80.w,
                  )),
                  SizedBox(
                    height: 16.w,
                  ),
                  Text('张慧敏',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff353e4d))),
                  SizedBox(
                    height: 4.w,
                  ),
                  Text('一班（初一）',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff898a93))),
                  SizedBox(
                    height: 24.w,
                  ),
                  Row(
                    children: [
                      Text('学习总时长',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff353e4d))),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: DashedLine()),
                      ),
                      Text('343天20小时58分钟',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffed702d))),
                    ],
                  ),
                  SizedBox(
                    height: 6.w,
                  ),
                  Row(
                    children: [
                      Text('客观题正确率',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff353e4d))),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: DashedLine()),
                      ),
                      Text('85%',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffed702d))),
                    ],
                  ),
                  SizedBox(
                    height: 6.w,
                  ),
                  Row(
                    children: [
                      Text('主观题平均分',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff353e4d))),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: DashedLine()),
                      ),
                      Text('77分',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffed702d))),
                    ],
                  ),
                  SizedBox(
                    height: 6.w,
                  ),
                  Row(
                    children: [
                      Text('努力值',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff353e4d))),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 12.w),
                            child: DashedLine()),
                      ),
                      Text('77分',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffed702d))),
                    ],
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  buildContainer('学习报告生成')
                ],
              ),
            ),
            /*GestureDetector(
              onTap: () async {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "东八区 ${DateFormat("yyyy年MM月dd日").format(DateTime.now().toUtc().add(Duration(hours: 8)).subtract(Duration(days: 30)))}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "东八区 ${DateFormat("yyyy年MM月dd日").format(DateTime.now().toUtc().add(Duration(hours: 8)))}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _item('年月日', DateMode.YMD),*/
            Container(
              margin: EdgeInsets.only(
                  top: 20.w, left: 18.w, right: 18.w, bottom: 0.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                      offset: Offset(2, 4), // 阴影与容器的距离
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [buildBg(), _buildTableBarView()],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildContainer(String first) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20.w),
        gradient: LinearGradient(
          colors: [Color(0xFFF19B57), Color(0xFFEC622D)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding:
              EdgeInsets.only(left: 7.w, right: 7.w, bottom: 5.w, top: 5.w),
          child: Text(
            first,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 12.sp),
          ),
        ),
      ),
    );
  }

  Widget _item(title, model) {
    return Container(
      color: Colors.white,
      child: ListTile(
          title: Text(title),
          onTap: () {
            _onClickItem(model);
          },
          trailing: MyText(
              PicketUtil.strEmpty(selectData[model]) ? '暂无' : selectData[model],
              color: Colors.grey,
              rightpadding: 18)),
    );
  }

  Widget _buildTableBarView() => SizedBox(
        height: 2000.w,
        child: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return /*WaittingPutPage('widget.type')*/ Container(
              color: Colors.red,
            );
          }).toList(),
        ),
      );

  void _onClickItem(model) {
    Pickers.showDatePicker(
      context,
      mode: model,
      suffix: Suffix.normal(),

      // selectDate: PDuration(month: 2),
      minDate: PDuration(year: 2020, month: 2, day: 10),
      maxDate: PDuration(second: 22),

      // selectDate: PDuration(hour: 18, minute: 36, second: 36),
      // minDate: PDuration(hour: 12, minute: 38, second: 3),
      // maxDate: PDuration(hour: 12, minute: 40, second: 36),
      onConfirm: (p) {
        print('longer >>> 返回数据：$p');
        setState(() {
          switch (model) {
            case DateMode.YMDHMS:
              selectData[model] =
                  '${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}:${p.second}';
              break;
            case DateMode.YMDHM:
              selectData[model] =
                  '${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}';
              break;
            case DateMode.YMDH:
              selectData[model] = '${p.year}-${p.month}-${p.day} ${p.hour}';
              break;
            case DateMode.YMD:
              selectData[model] = '${p.year}-${p.month}-${p.day}';
              break;
            case DateMode.YM:
              selectData[model] = '${p.year}-${p.month}';
              break;
            case DateMode.Y:
              selectData[model] = '${p.year}-${p.month}';
              break;
            case DateMode.MDHMS:
              selectData[model] =
                  '${p.month}-${p.day} ${p.hour}:${p.minute}:${p.second}';
              break;
            case DateMode.HMS:
              selectData[model] = '${p.hour}:${p.minute}:${p.second}';
              break;
            case DateMode.MD:
              selectData[model] = '${p.month}-${p.day}';
              break;
            case DateMode.S:
              selectData[model] = '${p.second}';
              break;
          }
        });
      },
      // onChanged: (p) => print(p),
    );
  }

//帮我封装一个时间选择器，界面要求是横向两个text，第一个显示东八区当前时间往前推一个月，第二个显示东八区今天的时间，时间的格式是'YYYY年mm月dd日'。点击text，在当前界面弹出底部时间选择器，可以选择年月日，选择之后可以点击确定，选择之后可以点取消关闭底部时间选择器，text展示选择的时间
  Widget buildBg() => Container(
        margin:
            EdgeInsets.only(top: 20.w, left: 18.w, right: 18.w, bottom: 0.w),
        width: double.infinity,
        height: 38.w,
        alignment: Alignment.center,
        child: TabBar(
          onTap: (tab) => print(tab),
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          isScrollable: false,
          controller: _tabController,
          labelColor: Color(0xffffbc00),
          indicatorWeight: 2,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 28),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xffffbc00),
          tabs: tabs.map((e) => Tab(text: e['title'])).toList(),
        ),
      );

  @override
  void dispose() {
    Get.delete<StudentLogic>();
    super.dispose();
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  @override
  bool get wantKeepAlive => true;
}
