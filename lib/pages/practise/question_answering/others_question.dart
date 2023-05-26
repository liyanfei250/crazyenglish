import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/dialog_manager.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../entity/start_exam.dart';
import '../../../utils/colors.dart';
import 'base_question.dart';
import 'package:flutter/material.dart';
import '../../../entity/week_detail_response.dart';

/**
 * Time: 2023/2/21 16:05
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class OthersQuestion extends BaseQuestion {
  OthersQuestion(Map<String,ExerciseLists> subtopicAnswerVoMap,int answerType,SubjectVoList data,int childIndex,{Key? key}) : super(subtopicAnswerVoMap,answerType,childIndex,data:data,key: key);

  @override
  BaseQuestionState<BaseQuestion> getState() {
    // TODO: implement getState
    return _OthersQuestionState();
  }

}

class _OthersQuestionState extends BaseQuestionState<OthersQuestion> {

  late SubjectVoList element;
  @override
  getAnswers() {
    // TODO: implement getAnswers
    throw UnimplementedError();
  }

  @override
  void onCreate() {
    element = widget.data;
  }


  @override
  Widget build(BuildContext context) {
    if(selectGapGetxController!=null){
      selectGapGetxController.disposeId(GetBuilderIds.updateFocus+"isInit");
      selectGapGetxController.disposeId(GetBuilderIds.updateFocus);
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.w,right: 18.w,top: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildQuestionDesc(QuestionType.getName(element.questionTypeStr!)),
          Padding(padding: EdgeInsets.only(top: 8.w),),
          Visibility(
              visible: element.stem!=null && element.stem!.isNotEmpty,
              child: Text(element.stem??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          Visibility(
            visible: (element!.content??"").isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildReadQuestion(element!.content),
              buildQuestionDesc("Question"),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildReadQuestion(String? htmlContent){
    return Container(
      height: 204.w,
      margin: EdgeInsets.only(top: 17.w,bottom: 18.w),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child:  Html(
          data: htmlContent??"",
          onImageTap: (url,context,attributes,element,){
            if(url!=null && url!.startsWith('http')){
              DialogManager.showPreViewImageDialog(
                  BackButtonBehavior.close, url);
            }
          },
          style: {
            "p": Style(
                fontSize:FontSize(14.sp),
                color: const Color(0xff353e4d)
            ),

            // "hr":Style(
            //   margin: Margins.only(left:0,right: 0,top: 10.w,bottom:10.w),
            //   padding: EdgeInsets.all(0),
            //   border: Border(bottom: BorderSide(color: Colors.grey)),
            // )
          },
          tagsList: Html.tags..addAll(['gap']),
          customRenders: {
          },

        ),
      ),
    );
  }


  @override
  void onDestroy() {
  }
}