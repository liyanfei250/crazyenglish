import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/pages/practise/question_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/common.dart';
import '../../../base/widgetPage/dialog_manager.dart';
import '../../../entity/week_detail_response.dart';
import '../../../utils/colors.dart';
import '../answer_interface.dart';
import '../answering/answering_logic.dart';

/**
 * Time: 2023/2/21 14:14
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

typedef GetEditingControllerCallback = TextEditingController Function(String key);
typedef GetFocusNodeControllerCallback = FocusNode Function(String key);
typedef GetAnswerControllerCallback = String Function(String key);
typedef PageControllerListener = TextEditingController Function(String key);


abstract class BaseQuestion extends StatefulWidget with AnswerMixin{
  late BaseQuestionState baseQuestionState;

  BaseQuestion({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  BaseQuestionState createState() {
    baseQuestionState = getState();
    return baseQuestionState;
  }

  BaseQuestionState getState();

  @override
  getAnswers() {
    baseQuestionState.getAnswers();
  }
  bool next(){
    return baseQuestionState.next();
  }
  bool pre(){
    return baseQuestionState.pre();
  }

  int getQuestionCount(){
    return baseQuestionState.getQuestionCount();
  }
}

abstract class BaseQuestionState<T extends BaseQuestion> extends State<T> with AnswerMixin{
  String curPage = "";
  String tag = "BaseQuestionState_";

  Map<String,TextEditingController> gapEditController = {};
  Map<String,FocusNode> gapFocusNodeController = {};
  Map<String,String> gapAnswerController = {};
  final PageController pageController = PageController(keepPage: true);

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
  List<Widget> questionList = [];
  int currentPage = 0;
  final selectGapGetxController = Get.put(SelectGapGetxController());
  final logic = Get.find<AnsweringLogic>();
  @override
  void initState(){
    super.initState();
    onCreate();
    tag = tag+curPage;
    print(tag + "initState\n");
  }


  @override
  bool get mounted {
    print(tag + "mounted\n");
    return super.mounted;
  }

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

  Widget buildQuestionDesc(String name){
    return Container(
      width: 66.w,
      height: 22.w,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: 66.w,
            height: 9.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0x78FCB853),
                Color(0x00FDB446),
              ]),
            ),
          ),
          Text(name,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.c_FF353E4D),)
        ],
      ),
    );
  }

  Widget getQuestionDetail(Data element){
    questionList.clear();
    if(element.options!=null && element.options!.length>0){
      int questionNum = element.options!.length;
      bool isHebing = false;
      for(int i = 0 ;i< questionNum;i++){
        Options question = element.options![i];

        List<Widget> itemList = [];
        itemList.add(Padding(padding: EdgeInsets.only(top: 7.w)));

        if(element.type == 1){
          if(element.typeChildren == QuestionType.single_choice){
            // 选择题
            itemList.add(buildQuestionType("选择题"));
            // itemList.add(Visibility(
            //   visible: question!.title != null && question!.title!.isNotEmpty,
            //   child: Text(
            //     question!.title!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            //   ),));
            if((question!.list??[]).length > 0) {
              itemList.add(QuestionFactory.buildSingleImgChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
            }
          }else if(element.typeChildren == 2){
            // 选择题
            itemList.add(buildQuestionType("选择题"));
            if((question!.list??[]).length > 0) {
              itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
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
              itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
            }
          }else if(element.typeChildren == 4){
            itemList.add(buildReadQuestion(element.content??""));
            itemList.add(QuestionFactory.buildHuGapQuestion(element.options??[],0,makeEditController));
            isHebing = true;
          }

        }else if(element.type == 2){
          if(element.typeChildren == 1){ // 阅读理解选项
            // 选择题
            itemList.add(buildQuestionType("选择题"));
            if((question!.list??[]).length > 0) {
              itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
            }
          }else if(element.typeChildren == 2){ // 阅读填空
            // 选择题
            itemList.add(buildQuestionType("填空题"));
            itemList.add(QuestionFactory.buildHuGapQuestion(element.options??[],0,makeEditController));
            isHebing = true;
          }else  if(element.typeChildren == 3){ // 阅读理解对话
            // 选择题
            itemList.add(buildQuestionType("简单题"));
            itemList.add(Visibility(
              visible: question!.name != null && question!.name!.isNotEmpty,
              child: Text(
                question!.name!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
              ),));
            itemList.add(QuestionFactory.buildShortAnswerQuestion(question.value??"",0,makeEditController));
          }
        } else if(element.type == 3 ){ // 语言综合训练
          if (element.typeChildren == 2){
            // 补全对话
            itemList.add(buildQuestionType("填空题"));
            itemList.add(QuestionFactory.buildHuGapQuestion(element.options??[],0,makeEditController));
            isHebing = true;
          } else if(element.typeChildren == 1){ // 单选题

          } else if(element.typeChildren == 3){
            itemList.add(buildQuestionType("选择题"));
            if((question!.list??[]).length > 0) {
              itemList.add(QuestionFactory.buildSingleTxtChoice(question!.list??[],int.parse(question.answer!.isEmpty?"-1":question.answer!)));
            }
          }
        }
        // else if(element.type == 5){
        //   itemList.add(buildQuestionType("纠错题"));
        //   itemList.add(QuestionFactory.buildFixProblemQuestion(question!.bankAnswerAppListVos,question!.title!));
        // }else if(element.type == 12){
        //   itemList.add(buildQuestionType("选择填空题"));
        //   itemList.add(QuestionFactory.buildSelectGapQuestion(question!.bankAnswerAppListVos,question!.title!,0,makeFocusNodeController));
        //   itemList.add(QuestionFactory.buildSelectAnswerQuestion(["abc","leix","axxxbc","lddddeix","ddeeeddd","leix","dddddd","lsssseix",])
        //   );
        // }

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
    if(logic!=null){
      logic.initPageStr("1/${questionList.length}");
    }
    return PageView(
      controller: pageController,
      physics: _neverScroll,
      onPageChanged: (int value){
        if(logic!=null){
          logic.updatePageStr("${(value+1)}/${questionList.length}");
        }
      },
      children: questionList,
    );
  }

  // 单选题结构不一致所以这么处理
  Widget getSingleQuestionDetail(List<Data> datas){
    questionList.clear();
    for(Data element in datas){
      if(element!=null && element.options!.length>0){
          List<Widget> itemList = [];
          itemList.add(Padding(padding: EdgeInsets.only(top: 7.w)));
          itemList.add(Visibility(
            visible: element!.title != null && element!.title!.isNotEmpty,
            child: Text(
              element!.title!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),));
          if(element.type == 3 ){ // 语言综合训练
            if(element.typeChildren == 1){ // 单选题 or 多选题
              if((element.options??[]).length > 0) {
                itemList.add(QuestionFactory.buildSingleOptionsTxtChoice(element.options!,-1));
              }
            }
          }

          questionList.add(SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: itemList,
            ),
          ));
      }else{
        questionList.add(const SizedBox());
      }
    }

    if(logic!=null){
      logic.initPageStr("1/${questionList.length}");
    }
    return PageView(
      controller: pageController,
      physics: _neverScroll,
      onPageChanged: (int value){
        if(logic!=null){
          logic.updatePageStr("${(value+1)}/${questionList.length}");
        }
      },
      children: questionList,
    );
  }


  @override
  int getQuestionCount() {
    return questionList.length;
  }

  Widget buildReadQuestion(String? htmlContent){
    return Container(
      height: 204.w,
      margin: EdgeInsets.only(top: 17.w,bottom: 18.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(color: AppColors.c_FFD2D5DC,width: 0.4.w)
      ),
      child: SingleChildScrollView(
        child:  Html(
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
      ),
    );
  }

  @override
  bool next() {
    if(currentPage< questionList.length-1 && currentPage>=0){
      currentPage = currentPage+1;
      pageController.jumpToPage(currentPage);
      if(currentPage< questionList.length-1){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }

  }

  @override
  bool pre() {
    if(currentPage>0){
      currentPage = currentPage-1;
      pageController.jumpToPage(currentPage);
      if(currentPage>0){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
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

  FocusNode makeFocusNodeController(String key){
    if(gapFocusNodeController[key] == null){
      FocusNode focusNode = FocusNode();
      gapFocusNodeController[key] = focusNode;
      return focusNode;
    }else{
      return gapFocusNodeController[key]!;
    }
  }

  String makeGapAnswerController(String key){
    return "";
  }

  void onCreate();

  void onDestroy();

  @override
  void didUpdateWidget(T oldWidget) {
    print(tag + "didUpdateWidget\n");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    print(tag + "reassemble\n");
    super.reassemble();
  }

  @override
  void deactivate() {
    print(tag + "deactivate\n");
    super.deactivate();
  }

  @override
  void dispose() {
    print(tag + "dispose\n");
    Get.delete<SelectGapGetxController>();
    onDestroy();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print(tag + "didChangeDependencies\n");
    super.didChangeDependencies();
  }


}

class SelectGapGetxController extends GetxController{
  // 答案 列表
  List<String> indexContentList = [];

  // 填空的 焦点 key-bool
  var hasFocusMap = {}.obs;
  // 填空的内容
  var contentMap = {}.obs;
  // 答案索引-填空索引
  var answerIndexToGapIndexMap = {}.obs;

  bool nextFocus = false;

  initContent(List<String> list){
    indexContentList.clear();
    indexContentList.addAll(list);
  }

  updateFocus(String key,bool hasFocus){
    if(hasFocus){
      hasFocusMap.value.keys.toList().forEach((element) {
        hasFocusMap.value.addIf(true, element, false);
      });
      hasFocusMap.value.addIf(true, key, hasFocus);
      hasFocusMap.value.keys.toList().forEach((element) {
        update([element]);
      });
      // update([key]);
    } else {
      hasFocusMap.value.addIf(true, key, hasFocus);
      update([key]);
    }
  }

  updateContent(String key,String contentTxt){
    contentMap.value.addIf(true, key, contentTxt);
    if(contentTxt.isNotEmpty){
      nextFocus = true;
    }else{
      nextFocus = false;
    }
    update([key]);
  }

  resetNextFocus(){
    nextFocus = false;
  }

  updateIndex(String answerIndex,String gapIndex){
    answerIndexToGapIndexMap.value.addIf(true, answerIndex, gapIndex);
    update([answerIndex]);
  }
}
