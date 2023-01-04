import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/widgets/ChoiceRadioItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../r.dart';
import '../../routes/getx_ids.dart';
import '../../utils/Util.dart';
import '../../utils/colors.dart';
import 'week_test_detail_logic.dart';

class WeekTestDetailPage extends BasePage {
  String? id;
  String? name;
  WeekTestDetailPage({Key? key}) : super(key: key) {
    if(Get.arguments!=null &&
        Get.arguments is Map){
      id = Get.arguments["id"];
      name = Get.arguments["name"];
    }
  }

  @override
  BasePageState<BasePage> getState() => _WeekTestDetailPageState();
}

class _WeekTestDetailPageState extends BasePageState<WeekTestDetailPage> {
  final logic = Get.put(WeekTestDetailLogic());
  final state = Get.find<WeekTestDetailLogic>().state;


  @override
  void onCreate() {
    // TODO: implement onCreate
    logic.getWeekTestDetail(widget.id!);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text(widget.name??"",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        // bottom: ,
        elevation: 0,),
      body: GetBuilder<WeekTestDetailLogic>(
        id: GetBuilderIds.weekTestDetailList,
        builder: (logic){
          return SingleChildScrollView(
            child: Column(
              children: [
                buildSingleChoice(),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<WeekTestDetailLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  Widget buildSingleChoice(){
    final Map<String,ItemBean> items = {
      "A":ItemBean("A","Guests could exchange them for traditional plastic",false),
      "B":ItemBean("B","second",false),
      "C":ItemBean("C","third",false),
      "D":ItemBean("D","forth",true),
    };
    var choseItem = "".obs;
    String answer = "B";
    return Container(
      margin: EdgeInsets.only(left: 14.w,right: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46.w,
            height: 22.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 10.w),
            decoration: BoxDecoration(
                color: AppColors.c_33FEDD00,
                borderRadius: BorderRadius.all(Radius.circular(2.w))
            ),
            child: Text("单选题",style: TextStyle(color: AppColors.c_FFFFBC00,fontSize: 10.sp),),
          ),
          Text(
            "第1题",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp),
          ),
          Padding(padding: EdgeInsets.only(top: 7.w)),
          Text(
            "题干 If I hadn't practiced when I was ",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp),
          ),
          Padding(padding: EdgeInsets.only(top: 12.w)),
          Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: items.keys.map(
                    (e) => InkWell(
                  onTap: (){
                    choseItem.value = items[e]!.label!;
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.w),
                    child: ChoiceRadioItem(
                        getType(answer,choseItem.value,items[e]!.label!),
                        choseItem.value,
                        items[e]!.label!,
                        items[e]!.content!,
                        double.infinity,
                        52.w
                    ),
                  ),
                )
            ).toList(),
          ))
        ],
      ),
    );
  }

  Widget buildListenQuestion(){
    return Container(
      child: Stack(
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){

                },
                child: Image.asset(R.imagesTestPaly,width: 32.w,height: 32.w,),
              )
            ],
          )
        ],
      ),
    );
  }

  ChoiceRadioItemType getType(String rightAnswer,String choseItemValue,String myLabel){
    if(choseItemValue.isNotEmpty){
      if(choseItemValue == myLabel){
        if(rightAnswer == choseItemValue){
          return ChoiceRadioItemType.RIGHT_SELECTED;
        }else{
          return ChoiceRadioItemType.WRONG_SELECTED;
        }
      }else{
        return ChoiceRadioItemType.DEFAULT;
      }

    }else{
      return ChoiceRadioItemType.DEFAULT;
    }
  }
}

class ItemBean{
  final String label;
  final String content;

  final bool isRightAnswer;
  ItemBean(this.label,this.content,this.isRightAnswer);
}