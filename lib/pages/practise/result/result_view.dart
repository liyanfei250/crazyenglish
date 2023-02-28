import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../entity/week_test_detail_response.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../question_factory.dart';
import 'result_logic.dart';

class ResultPage extends BasePage{
  WeekTestDetailResponse? testDetailResponse;

  ResultPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      testDetailResponse = Get.arguments["detail"];
    }
  }

  @override
  BasePageState<BasePage> getState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends BasePageState<ResultPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final logic = Get.put(ResultLogic());
  final state = Get.find<ResultLogic>().state;

  late TabController _tabController;

  List<Widget> questionList = [];

  List<String> tabs = [];

  @override
  void onCreate() {
    if(widget.testDetailResponse!.data![0].questionBankAppListVos!=null && widget.testDetailResponse!.data![0].questionBankAppListVos!.length>0) {
      int questionNum = widget.testDetailResponse!.data![0].questionBankAppListVos!.length;
      _tabController = TabController(vsync: this, length: questionNum);
    }

    questionList = [];
    tabs = [];
  }

  @override
  Widget build(BuildContext context) {

    Widget resutl = buildQuestionResult(widget.testDetailResponse!.data![0]);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,//状态栏颜色
        statusBarIconBrightness: Brightness.light, //状态栏图标颜色
        statusBarBrightness: Brightness.dark,  //状态栏亮度
        systemStatusBarContrastEnforced: true, //系统状态栏对比度强制
        systemNavigationBarColor: Colors.white,  //导航栏颜色
        systemNavigationBarIconBrightness: Brightness.light,//导航栏图标颜色
        systemNavigationBarDividerColor: Colors.transparent,//系统导航栏分隔线颜色
        systemNavigationBarContrastEnforced: true,//系统导航栏对比度强制
      ),
      child: Scaffold(
        // extendBody: true,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.imagesReviewTopBg),
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              AppBar(
                elevation: 0,
                automaticallyImplyLeading:false,
                title: Text("Module 1 Unit3",style: TextStyle(color: AppColors.c_FF353E4D,fontSize: 20.sp,fontWeight: FontWeight.w700),),
                backgroundColor:Colors.transparent,
              ),
              buildTopIndicator(),
              Expanded(child: Container(
                margin: EdgeInsets.only(top: 8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow:[
                    BoxShadow(
                      color: AppColors.c_26D0C5B4,		// 阴影的颜色
                      offset: Offset(0.w, 0.w),						// 阴影与容器的距离
                      blurRadius: 3.w,							// 高斯的标准偏差与盒子的形状卷积。
                      spreadRadius: 1.w,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildTabBar(),
                    resutl,
                  ],
                ),
              ))
            ],
          ),
        ),
      ),);
  }

  Widget buildTopIndicator(){
    final customWidth01 =
    CustomSliderWidths(trackWidth: 6, progressBarWidth: 20, shadowWidth: 20);
    final customColors01 = CustomSliderColors(
        dotColor: Colors.white.withOpacity(0.8),
        trackColor: HexColor('#FFB648').withOpacity(0.6),
        progressBarColors: [
          AppColors.c_FFFFB648,
          AppColors.c_FFFFB648,
        ],
        shadowColor: HexColor('#FFD7E2'),
        shadowMaxOpacity: 0.08);

    final info = InfoProperties(
        mainLabelStyle: TextStyle(
            color: Colors.white, fontSize: 60, fontWeight: FontWeight.w100));
    return Container(
      width: double.infinity,
      height: 224.w,
      margin: EdgeInsets.only(left: 18.w,right: 18.w),
      decoration: BoxDecoration(
        color: AppColors.c_FFFFFFFF,
        boxShadow:[
          BoxShadow(
            color: AppColors.c_FFD0C5B4,		// 阴影的颜色
            offset: Offset(0.w, 0.w),						// 阴影与容器的距离
            blurRadius: 3.w,							// 高斯的标准偏差与盒子的形状卷积。
            spreadRadius: 1.w,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width:193.w,
            height: 193.w,
            margin: EdgeInsets.only(top: 30.w),
            child: SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: 60,
              appearance: CircularSliderAppearance(
                  customWidths: customWidth01,
                  customColors: customColors01,
                  infoProperties: info,
                  startAngle: 180,
                  angleRange: 180,
                  size: 350.0.w),
              onChange: (double value) {
                // callback providing a value while its being changed (with a pan gesture)
              },
              onChangeStart: (double startValue) {
                // callback providing a starting value (when a pan gesture starts)
              },
              onChangeEnd: (double endValue) {
                // callback providing an ending value (when a pan gesture ends)
              },
              innerWidget: (double value) {
                //This the widget that will show current value
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 31.w)),
                    Text("正确率",style: TextStyle(fontSize: 14.w,fontWeight: FontWeight.w500,color: AppColors.c_FF898A93),),
                    Text("6",style: TextStyle(fontSize: 40.w,fontWeight: FontWeight.w500,color: AppColors.c_FF1B1D2C),),
                    Text("/10题",style: TextStyle(fontSize: 12.w,fontWeight: FontWeight.w500,color: AppColors.c_FF898A93),),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 13.w,right: 13.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 0.2.w,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 150.w),
                  color: AppColors.c_FFD2D5DC,
                ),
                Padding(padding: EdgeInsets.only(top: 14.w)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(R.imagesResultTimeTips,width: 12.w,height: 12.w,),
                        Padding(padding: EdgeInsets.only(left: 7.w)),
                        Text("答题用时：",style: TextStyle(fontSize: 12.w,color: AppColors.c_FFB3B7C6 , fontWeight: FontWeight.w500),)
                      ],
                    ),
                    Text("08:41",style: TextStyle(fontSize: 12.w,color: AppColors.c_FFB3B7C6 , fontWeight: FontWeight.w500),)
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 9.w)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(R.imagesResultVectorTips,width: 12.w,height: 12.w,),
                        Padding(padding: EdgeInsets.only(left: 7.w)),
                        Text("习题类型：",style: TextStyle(fontSize: 12.w,color: AppColors.c_FFB3B7C6 , fontWeight: FontWeight.w500),)
                      ],
                    ),
                    Text("Module1 Unit3 听力",style: TextStyle(fontSize: 12.w,color: AppColors.c_FFB3B7C6 , fontWeight: FontWeight.w500),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
    onTap: (value){

    },
    controller: _tabController,
    indicatorColor: Colors.transparent,
    isScrollable: true,
    labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    indicatorWeight: 3,
    labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    unselectedLabelStyle:
    TextStyle(fontSize: 14.sp, color: AppColors.TEXT_BLACK_COLOR),
    labelColor: AppColors.TEXT_COLOR,
    tabs: tabs.map((e) => Container(
      width: 34.w,
      height: 34.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      ),
      child: Text(e),
    )).toList(),
  );

  Widget buildQuestionType(String name){
    return Container(
      width: 46.w,
      height: 22.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top:14.w,bottom: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
          border: Border.all(color: AppColors.c_FF898A93,width: 0.4.w)
      ),
      child: Text(name,style: TextStyle(color: AppColors.c_FF898A93,fontSize: 12.sp),),
    );
  }

  Widget buildQuestionResult(Data element){
    if(element.questionBankAppListVos!=null && element.questionBankAppListVos!.length>0){
      int questionNum = element.questionBankAppListVos!.length;
      for(int i = 0 ;i< questionNum;i++){
        QuestionBankAppListVos question = element.questionBankAppListVos![i];

        tabs.add("${i+1}");
        List<Widget> itemList = [];
        itemList.add(Padding(padding: EdgeInsets.only(top: 7.w)));

        if(question.type == 2 || (
            (question.type == 1 || question.type ==4)
                && question.listenType == 1)){
          // 选择题
          itemList.add(buildQuestionType("选择题"));
          itemList.add(Visibility(
            visible: question!.title != null && question!.title!.isNotEmpty,
            child: Text(
              question!.title!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),));
          if((question!.bankAnswerAppListVos??[]).length > 0) {
            itemList.add(QuestionFactory.buildSingleChoice(question!.bankAnswerAppListVos??[]));
          }
        }else if(question.type == 3 ){  // 填空题
          itemList.add(buildQuestionType("填空题"));
          // itemList.add(QuestionFactory.buildGapQuestion(question!.bankAnswerAppListVos,question!.title!,0,makeEditController));
        }else if(question.type == 5){
          itemList.add(buildQuestionType("纠错题"));
          itemList.add(QuestionFactory.buildFixProblemQuestion(question!.bankAnswerAppListVos,question!.title!));
        }

        questionList.add(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: itemList,
          ),
        );
      }
    } else {
      questionList.add(const SizedBox());
    }

    return Expanded(child: TabBarView(
      controller: _tabController,
      children: questionList,
    ));
  }


  @override
  void onDestroy() {
    Get.delete<ResultLogic>();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}