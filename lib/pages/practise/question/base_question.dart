import 'package:crazyenglish/pages/practise/question_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../entity/week_test_detail_response.dart';
import '../../../utils/colors.dart';
import '../answer_interface.dart';

/**
 * Time: 2023/2/21 14:14
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

typedef GetEditingControllerCallback = TextEditingController Function(String key);

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
}

abstract class BaseQuestionState<T extends BaseQuestion> extends State<T> with AnswerMixin{
  String curPage = "";
  String tag = "BaseQuestionState_";

  Map<String,TextEditingController> gapEditController = {};
  final PageController pageController = PageController(keepPage: true);

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();
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
      margin: EdgeInsets.only(top:10.w,bottom: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
        border: Border.all(color: AppColors.c_FF898A93)
      ),
      child: Text(name,style: TextStyle(color: AppColors.c_FF898A93,fontSize: 12.sp),),
    );
  }

  Widget getQuestionDetail(Data element){
    List<Widget> questionList = [];
    if(element.questionBankAppListVos!=null && element.questionBankAppListVos!.length>0){
      int questionNum = element.questionBankAppListVos!.length;
      for(int i = 0 ;i< questionNum;i++){
        QuestionBankAppListVos question = element.questionBankAppListVos![i];


        List<Widget> itemList = [];
        itemList.add(Padding(padding: EdgeInsets.only(top: 7.w)));

        if(question.type == 2 || (
            (question.type == 1 || question.type ==4)
                && question.listenType == 1)){
          // 选择题
          itemList.add(Visibility(
            visible: question!.title != null && question!.title!.isNotEmpty,
            child: Text(
              question!.title!,style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),));
          if((question!.bankAnswerAppListVos??[]).length > 0) {
            itemList.add(QuestionFactory.buildSingleChoice(question!.bankAnswerAppListVos??[]));
          }
        }else if(question.type == 3 ){  // 填空题
          itemList.add(QuestionFactory.buildGapQuestion(question!.bankAnswerAppListVos,question!.title!,0,makeEditController));
        }else if(question.type == 5){
          itemList.add(QuestionFactory.buildFixProblemQuestion(question!.bankAnswerAppListVos,question!.title!));
        }

        questionList.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: itemList,
        ));
      }
    }else{
      questionList.add(const SizedBox());
    }

    return PageView(
      controller: pageController,
      physics: _neverScroll,
      children: questionList,
    );
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
    onDestroy();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print(tag + "didChangeDependencies\n");
    super.didChangeDependencies();
  }
}
