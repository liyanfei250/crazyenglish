import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/base/widgetPage/empty.dart';
import 'package:crazyenglish/widgets/ChoiceRadioItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../base/widgetPage/dialog_manager.dart';
import '../../entity/week_test_detail_response.dart';
import '../../r.dart';
import '../../routes/getx_ids.dart';
import '../../utils/Util.dart';
import '../../utils/colors.dart';
import '../../utils/text_util.dart';
import 'test_player_widget.dart';
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


  AudioPlayer audioPlayer  = AudioPlayer();

  WeekTestDetailResponse? weekTestDetailResponse;
  CustomRenderMatcher gapMatcher() => (context) => context.tree.element?.localName == 'input';
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
          weekTestDetailResponse = logic.state.weekTestDetailResponse;
          if(weekTestDetailResponse == null){
            return EmptyWidget("么有试题");
          }
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: buildQuestionList(weekTestDetailResponse!),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<WeekTestDetailLogic>();
    audioPlayer.release();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  List<Widget> buildQuestionList(WeekTestDetailResponse weekTestDetailResponse){
    List<Widget> questionList = [];
    if(weekTestDetailResponse.data!=null){
      weekTestDetailResponse.data!.forEach((element) {
        switch(element.type){
          case 1: // 听力题
            questionList.add(buildQuestionType("听力题"));
            questionList.add(buildListenQuestion());
            break;
          case 2: // 选择题
            questionList.add(buildQuestionType("选择题"));
            break;
          case 3: // 填空题
            questionList.add(buildQuestionType("填空题"));
            break;
          case 4: // 阅读题
            questionList.add(Stack(
              children: [
                buildQuestionType("阅读题"),
                buildReadQuestion(element!.readContent)
              ],
            ));
            break;
        }
        if(element.questionBankAppListVos!=null && element.questionBankAppListVos!.length>0){
          int questionNum = element.questionBankAppListVos!.length;
          for(int i = 0 ;i< questionNum;i++){
            QuestionBankAppListVos question = element.questionBankAppListVos![i];
            questionList.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "第${i+1}题",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp),
                ),
                Padding(padding: EdgeInsets.only(top: 7.w)),
                Visibility(
                  visible: question!.title != null && question!.title!.isNotEmpty,
                  child: Text(
                  question!.title!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp),
                ),)
              ],
            ));
            if(question.type == 2 || question.listenType == 1){
              // 选择题
              questionList.add(buildSingleChoice(question!.bankAnswerAppListVos!));
            }
          }
        }
      });
    }
    return questionList;
  }

  Widget buildQuestionType(String name){
    return Container(
      width: 46.w,
      height: 22.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top:10.w,bottom: 10.w),
      decoration: BoxDecoration(
          color: AppColors.c_33FEDD00,
          borderRadius: BorderRadius.all(Radius.circular(2.w))
      ),
      child: Text(name,style: TextStyle(color: AppColors.c_FFFFBC00,fontSize: 10.sp),),
    );
  }

  Widget buildSingleChoice(List<BankAnswerAppListVos> list){
    var choseItem = "".obs;
    String answer = "B";
    list.forEach((element) {
      if(element.isAnswer??false){
        answer = element.logoAnswer??"K";
      }
    });
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 12.w)),
          Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: list.map(
                    (e) => InkWell(
                  onTap: (){
                    choseItem.value = e.logoAnswer??"K";
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.w),
                    child: ChoiceRadioItem(
                        getType(answer,choseItem.value,e.logoAnswer??"K"),
                        choseItem.value,
                        e.logoAnswer??"K",
                        e!.content!,
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

  Widget buildGapQuestion(List<BankAnswerAppListVos> list){

    return Container();
  }

  Widget buildListenQuestion(){
    audioPlayer.setSourceUrl("https://ps-1252082677.cos.ap-beijing.myqcloud.com/test.mp3");
    return Container(
      child: TestPlayerWidget(player: audioPlayer),
    );
  }

  Widget buildReadQuestion(String? htmlContent){
    return Container(
      child: Html(
        data: TextUtil.weekDetail.replaceFirst("###content###", htmlContent??""),
        onImageTap: (url,context,attributes,element,){
          if(url!=null && url!.startsWith('http')){
            DialogManager.showPreViewImageDialog(
                BackButtonBehavior.close, url);
          }
        },
        style: {
          "p":Style(
              fontSize:FontSize.large
          ),

          "hr":Style(
            margin: Margins.only(left:0,right: 0,top: 10.w,bottom:10.w),
            padding: EdgeInsets.all(0),
            border: Border(bottom: BorderSide(color: Colors.grey)),
          )
        },
        customRenders: {
          gapMatcher():CustomRender.widget(widget: (context, buildChildren){
            return TextField(controller: TextEditingController(text: "sddss"));
          })
        },

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