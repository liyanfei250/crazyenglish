import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/base/widgetPage/empty.dart';
import 'package:crazyenglish/widgets/ChoiceRadioItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _WeekTestDetailPageState extends BasePageState<WeekTestDetailPage> with WidgetsBindingObserver{
  final logic = Get.put(WeekTestDetailLogic());
  final state = Get.find<WeekTestDetailLogic>().state;


  AudioPlayer audioPlayer  = AudioPlayer();

  WeekTestDetailResponse? weekTestDetailResponse;
  Map<String,TextEditingController> gapEditController = {};
  int gapKey = -1;
  @override
  void onCreate() {
    WidgetsBinding.instance.addObserver(this);
    logic.getWeekTestDetail(widget.id!);
    showLoading("");
  }


  TextEditingController makeEditController(String key){
    if(gapEditController[key] == null){
      TextEditingController controller = TextEditingController();
      gapEditController[key] = controller;
      return controller;
    }else{
      return gapEditController[key]!;
    }
  }



  @override
  Widget build(BuildContext context) {
    gapKey == -1;
    return Scaffold(
      appBar: buildNormalAppBar(widget.name??""),
      backgroundColor: AppColors.theme_bg,
      body: GetBuilder<WeekTestDetailLogic>(
        id: GetBuilderIds.weekTestDetailList,
        builder: (logic){
          weekTestDetailResponse = logic.state.weekTestDetailResponse;
          if(weekTestDetailResponse == null){
            return EmptyWidget("么有试题");
          }
          if(weekTestDetailResponse != null
            && weekTestDetailResponse!.data !=null){
            hideLoading();
          }
          if(weekTestDetailResponse != null
              && weekTestDetailResponse!.data !=null && weekTestDetailResponse!.data!.length ==0){
            return EmptyWidget("空页面 请录入试题！");
          }

          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.w),
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
      //  应用程序处于闲置状态并且没有收到用户的输入事件。
      //注意这个状态，在切换到后台时候会触发，所以流程应该是先冻结窗口，然后停止UI
        print('YM----->AppLifecycleState.inactive');
        break;
      case AppLifecycleState.paused:
//      应用程序处于不可见状态
        if(audioPlayer!=null){
          audioPlayer!.pause();
        }
        break;
      case AppLifecycleState.resumed:
        print('YM----->AppLifecycleState.resumed');
        break;
      case AppLifecycleState.detached:
      //当前页面即将退出
        print('YM----->AppLifecycleState.detached');
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
        switch(element.questionType){
          case 1: // 听力题
            questionList.add(makeMarkeContainer(buildQuestionType("听力题")));
            questionList.add(makeMarkeContainer(Visibility(
                visible: element!.title!=null && element!.title!.isNotEmpty,
                child: Text(element!.title??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),))));

            questionList.add(
                makeMarkeContainer(
                Visibility(
                visible: element!.name!=null && element!.name!.isNotEmpty,
                child: Text(element!.name??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),))
                ));

            if(element.type == 3 && element!.content !=null && element!.content!.isNotEmpty){
              questionList.add(makeMarkeContainer(buildListenQuestion(element!.content??"")));
            }

            break;
          case 2: // 选择题
            questionList.add(makeMarkeContainer(buildQuestionType("选择题")));
            questionList.add(makeMarkeContainer(Visibility(
                visible: element!.title!=null && element!.title!.isNotEmpty,
                child: Text(element!.title??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),))));
            questionList.add(makeMarkeContainer(Visibility(
                visible: element!.name!=null && element!.name!.isNotEmpty,
                child: Text(element!.name??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),))));

            break;
          case 3: // 填空题
            questionList.add(makeMarkeContainer(buildQuestionType("填空题")));
            break;
          case 4: // 阅读题
            questionList.add(makeMarkeContainer(buildQuestionType("阅读题")));
            questionList.add(makeMarkeContainer(Visibility(
                visible: element!.name!=null && element!.name!.isNotEmpty,
                child: Text(element!.name??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),))));
            questionList.add(buildReadQuestion(element!.readContent));

            break;
          case 5: // 纠错
            questionList.add(makeMarkeContainer(buildQuestionType("纠错题")));
            questionList.add(makeMarkeContainer(Visibility(
                visible: element!.title!=null && element!.title!.isNotEmpty,
                child: Text(element!.title??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),))));
            questionList.add(makeMarkeContainer(Visibility(
                visible: element!.name!=null && element!.name!.isNotEmpty,
                child: Text(element!.name??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),))));
        }
        if(element.questionBankAppListVos!=null && element.questionBankAppListVos!.length>0){
          int questionNum = element.questionBankAppListVos!.length;
          for(int i = 0 ;i< questionNum;i++){
            QuestionBankAppListVos question = element.questionBankAppListVos![i];

            // questionList.add(Text(
            //   "第${i+1}题",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp),
            // ));
            questionList.add(Padding(padding: EdgeInsets.only(top: 7.w)));

            if(question.type == 2 || (
                (question.type == 1 || question.type ==4)
                && question.listenType == 1)){
              // 选择题
              questionList.add(makeMarkeContainer(Visibility(
                visible: question!.title != null && question!.title!.isNotEmpty,
                child: Text(
                  question!.title!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
                ),)));
              if((question!.bankAnswerAppListVos??[]).length > 0) {
                questionList.add(makeMarkeContainer(buildSingleChoice(question!.bankAnswerAppListVos??[])));
              }
            }else if(question.type == 3 ){  // 选择题
              questionList.add(buildGapQuestion(question!.bankAnswerAppListVos,question!.title!));
            }else if(question.type == 5){
              questionList.add(buildFixProblemQuestion(question!.bankAnswerAppListVos,question!.title!));
            }
          }
        }
      });
    }
    return questionList;
  }

  Widget makeMarkeContainer(Widget child){
    return Container(
      margin: EdgeInsets.only(left: 8.w,right: 5.w),
      child: child,
    );
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

  Color getInputColor(int type){
    switch(type){
      case 0:
        return AppColors.c_FF101010;
      case -1:
        return AppColors.c_FFEC9D4E;
      case 1:
        return AppColors.c_FF58BC6D;
      default:
        return AppColors.c_FF101010;
    }
  }

  Widget buildGapQuestion(List<BankAnswerAppListVos>? list,String htmlContent){
    FocusScopeNode _scopeNode = FocusScopeNode();
    int max = 0;
    String gap = "____";

    int gapIndex = -1;
    while(htmlContent.contains(gap)){
      gapKey++;
      gapIndex++;
      print("gapKey: $gapKey gapIndex:$gapIndex");
      htmlContent = htmlContent.replaceFirst(gap, '<gap value="$gapKey" index="$gapIndex"></gap>');

    }
    return FocusScope(
      node: _scopeNode,
      child: Html(
        data: htmlContent??"",
        onImageTap: (url,context,attributes,element,){
          if(url!=null && url!.startsWith('http')){
            DialogManager.showPreViewImageDialog(
                BackButtonBehavior.close, url);
          }
        },
        style: {
          // "p":Style(
          //     fontSize:FontSize.large
          // ),
        },
        tagsList: Html.tags..addAll(['gap']),
        customRenders: {
          tagMatcher("gap"):CustomRender.widget(widget: (context, buildChildren){
            String key = context.tree.element!.attributes["value"]??"unknown";
            String gapIndex = context.tree.element!.attributes["index"]??"unknown";
            String content = "";
            int num = 0;
            var correctType = 0.obs;
            try {
              num = int.parse(gapIndex);
              max = num;

              if(list!=null && num< list!.length){
                content = list![num].content!;
              }else{
                content = "";
              }
              print("num: $num content: $content");
            } catch (e) {
              e.printError();
            }

            return SizedBox(
              width: 50.w,
              child: Obx(()=>TextField(
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: getInputColor(correctType.value)),
                  decoration: InputDecoration(
                    isDense:true,
                    contentPadding: EdgeInsets.all(0.w),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                          color: getInputColor(correctType.value),
                          style: BorderStyle.solid
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.w,
                          color: getInputColor(correctType.value),
                          style: BorderStyle.solid
                      ),
                    ),
                  ),
                  onChanged: (text){
                    print("intput:"+text+"  content:"+content);
                    if(content.isNotEmpty){
                      if(text.isNotEmpty){
                        if(content.startsWith(text)){
                          correctType.value = 1;
                        }else{
                          correctType.value = -1;
                        }
                      }else{
                        correctType.value = 0;
                      }
                    }else{
                      correctType.value = 0;
                    }

                  },
                  onSubmitted: (text){

                  },
                  onEditingComplete: (){
                    if(num < max){
                      _scopeNode.nextFocus();
                    }else{
                      _scopeNode.unfocus();
                    }

                  },
                  controller: makeEditController(key))),

            );
          })
        },

      ),
    );
  }

  Widget buildFixProblemQuestion(List<BankAnswerAppListVos>? list,String htmlContent){

    TextEditingController? _inputController;
    _inputController = TextEditingController(
      text: htmlContent??"",
    );
    // list!=null && list.length>0 && list[0].content!=null && list[0].content!.isNotEmpty? list[0].content!:""
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: 8.w,right: 5.w),
          child: Text(
            htmlContent,
            style: TextStyle(
                fontSize: 16.sp,),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.w,right: 5.w,top: 10.w),
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.w)),
              color: AppColors.c_4DD9D9D9
          ),
          child: TextField(
            controller: _inputController,
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 20,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16.sp,
                height: 1.5,
                textBaseline: TextBaseline.alphabetic
            ),
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: InputBorder.none,
              hintText: "请输入改正后的文字",
            ),
          ),
        )

      ],
    );
  }

  Widget buildListenQuestion(String listtenUrl){
    audioPlayer.setSourceUrl(listtenUrl);
    return Container(
      child: TestPlayerWidget(audioPlayer,true),
    );
  }

  Widget buildReadQuestion(String? htmlContent){
    return Container(
      child: Html(
        data: htmlContent??"",
        onImageTap: (url,context,attributes,element,){
          if(url!=null && url!.startsWith('http')){
            DialogManager.showPreViewImageDialog(
                BackButtonBehavior.close, url);
          }
        },
        style: {
          // "p":Style(
          //     fontSize:FontSize.large
          // ),

          "hr":Style(
            margin: Margins.only(left:0,right: 0,top: 10.w,bottom:10.w),
            padding: EdgeInsets.all(0),
            border: Border(bottom: BorderSide(color: Colors.grey)),
          )
        },
        tagsList: Html.tags..addAll(['gap']),
        customRenders: {
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