import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../entity/commit_request.dart';
import '../../../entity/week_detail_response.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../question_factory.dart';
import 'result_logic.dart';

class ResultPage extends BasePage{
  CommitRequest? commitResponse;

  ResultPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Map){
      commitResponse = Get.arguments["detail"];
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
    if(widget.commitResponse!.exercises![0].options!=null && widget.commitResponse!.exercises![0].options!.length>0) {
      int questionNum = widget.commitResponse!.exercises![0].options!.length;
      _tabController = TabController(vsync: this, length: questionNum);
    }

    questionList = [];
    tabs = [];
  }

  @override
  Widget build(BuildContext context) {

    Widget resutl = buildQuestionResult(widget.commitResponse!.exercises![0]);

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
              buildTransparentAppBar("${widget.commitResponse!.directory}"),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 24.w)),
                    Container(
                      padding: EdgeInsets.only(left: 18.w,right: 18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(R.imagesResultAnswerCardTips,width: 18.w,height: 18.w,),
                              Padding(padding: EdgeInsets.only(left: 9.w)),
                              Text("答题卡",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.c_FF1B1D2C),),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildAnswerState(1),
                              buildAnswerState(2),
                              buildAnswerState(3),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 24.w)),
                    _buildTabBar(),
                    Container(
                      height: 0.5.w,
                      width: double.infinity,
                      color: AppColors.c_FFD2D5DC,
                    ),
                    resutl,
                  ],
                ),
              ))
            ],
          ),
        ),
      ),);
  }

  Widget buildAnswerState(int state){
    String text = "未答";
    BoxDecoration decoration;
    if ( state == 1 ) { // 未答
      text = "未答";
      decoration = BoxDecoration(
          color: AppColors.c_FFF5F7FA,
          borderRadius: BorderRadius.all(Radius.circular(22.w)),
          border: Border.all(color: AppColors.c_FFD6D9DB,width: 1.w)
      );
    } else if(state == 2){   // 答对
      text = "答对";
      decoration = BoxDecoration(
        color: AppColors.c_FF62C5A2,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    } else {  // 答错
      text = "答错";
      decoration = BoxDecoration(
        color: AppColors.c_FFEC6560,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(padding: EdgeInsets.only(left: 13.w)),
        Container(
          width: 10.w,
          height: 10.w,
          decoration: decoration,
        ),
        Padding(padding: EdgeInsets.only(left: 3.w)),
        Text(text,style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.c_FF878DA6,fontSize: 12.sp),)
      ],
    );
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
    indicatorColor: AppColors.c_FF353E4D,
    isScrollable: true,
    labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
    indicatorWeight: 2.w,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    unselectedLabelStyle:
    TextStyle(fontSize: 14.sp, color: AppColors.TEXT_BLACK_COLOR),
    labelColor: AppColors.TEXT_COLOR,
    tabs: tabs.map((e) => buildTab(e)).toList(),
  );

  Widget buildTab(String e){
    int state = tabs.indexOf(e);

    BoxDecoration decoration;
    Color textColor = Colors.white;
    if(state == 1){
      decoration = BoxDecoration(
        color: AppColors.c_FFF5F7FA,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
        border: Border.all(color: AppColors.c_FFD6D9DB,width: 1.w)
      );
      textColor = AppColors.c_FFD6D9DB;
    }else if(state == 2){
      decoration = BoxDecoration(
        color: AppColors.c_FF62C5A2,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    }else{
      decoration = BoxDecoration(
        color: AppColors.c_FFEC6560,
        borderRadius: BorderRadius.all(Radius.circular(22.w)),
      );
    }

    return Container(
      width: 34.w,
      height: 34.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 9.w),
      decoration: decoration,
      child: Text(e,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: textColor),),
    );
  }

  Widget buildQuestionType(String name){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 17.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 7.w,right: 7.w,bottom: 2.w),
          margin: EdgeInsets.only(top:14.w,bottom: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.w)),
              border: Border.all(color: AppColors.c_FF898A93,width: 0.4.w)
          ),
          child: Text(name,style: TextStyle(color: AppColors.c_FF898A93,fontSize: 12.sp),),
        ),
        Padding(padding: EdgeInsets.only(left: 11.w)),
        Image.asset(R.imagesResultFavor,width: 48.w,height: 17.w,),
      ],
    );
  }

  Widget buildQuestionResult(Data element){
    questionList.clear();
    if(element.options!=null && element.options!.length>0){
      int questionNum = element.options!.length;
      bool isHebing = false;
      for(int i = 0 ;i< questionNum;i++){
        Options question = element.options![i];

        tabs.add("${i+1}");
        List<Widget> itemList = [];
        itemList.add(Padding(padding: EdgeInsets.only(top: 7.w)));

        if(element.type == 1){
          if(element.typeChildren == 1){
            // 选择题
            itemList.add(buildQuestionType("选择题"));
            // itemList.add(Visibility(
            //   visible: question!.title != null && question!.title!.isNotEmpty,
            //   child: Text(
            //     question!.title!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            //   ),));
            if((question!.list??[]).length > 0) {
              itemList.add(QuestionFactory.buildSingleImgChoice(question!.list??[],question.answer!.toInt()));
            }
          }else if(element.typeChildren == 2){
            // 选择题
            itemList.add(buildQuestionType("选择题"));
            if((question!.list??[]).length > 0) {
              itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],question.answer!.toInt()));
            }
          }else if(element.typeChildren == 3){
            // 选择题
            itemList.add(buildQuestionType("选择题"));
            itemList.add(Visibility(
              visible: question!.name != null && question!.name!.isNotEmpty,
              child: Text(
                question!.name!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
              ),));
            if((question!.list??[]).length > 0) {
              itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],question.answer!.toInt()));
            }
          }

        }else if(element.type == 2){
          if(element.typeChildren == 3){
            // 选择题
            itemList.add(buildQuestionType("选择题"));
            if((question!.list??[]).length > 0) {
              itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],question.answer!.toInt()));
            }
          }else if(element.typeChildren == 4){ // 阅读选项
            // 选择题
            itemList.add(buildQuestionType("选择题"));
            if((question!.list??[]).length > 0) {
              itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],question.answer!.toInt()));
            }
          }else if(element.typeChildren == 5 || element.typeChildren == 6){ // 阅读填空 阅读理解 对话
            // 选择题
            itemList.add(buildQuestionType("填空题"));
            // itemList.add(QuestionFactory.buildHuGapQuestion(element.options??[],0,makeEditController));
            isHebing = true;
          }
        }

        questionList.add(SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: itemList,
          ),
        ));
        if(isHebing){
          break;
        }
      }
    }else{
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