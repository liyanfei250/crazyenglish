import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../base/widgetPage/dialog_manager.dart';
import '../answer_interface.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import 'base_question.dart';
import 'package:flutter/material.dart';
import '../../../entity/week_test_detail_response.dart';
/**
 * Time: 2023/2/21 14:02
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class ReadQuestion extends BaseQuestion {
  Data data;

  ReadQuestion({required this.data,Key? key}) : super(key: key);

  @override
  BaseQuestionState<BaseQuestion> getState() {
    // TODO: implement getState
    return _ReadQuestionState();
  }

}

class _ReadQuestionState extends BaseQuestionState<ReadQuestion> {

  late Data element;

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
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 18.w,right: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildQuestionType("阅读题"),
            Visibility(
                visible: element.title!=null && element.title!.isNotEmpty,
                child: Text(element.title??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
            Visibility(
                visible: element.name!=null && element.name!.isNotEmpty,
                child: Text(element.name??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
            buildReadQuestion(element!.readContent),
            getQuestionDetail(element),
          ],
        ),
    );
  }

  Widget buildReadQuestion(String? htmlContent){
    return Container(
      height: 204.w,
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

  @override
  void onDestroy() {
  }
}