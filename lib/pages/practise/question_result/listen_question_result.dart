import 'package:audioplayers/audioplayers.dart';
import 'package:crazyenglish/pages/practise/question/base_question.dart';
import 'package:crazyenglish/pages/practise/question_result/base_question_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../entity/week_detail_response.dart';
import '../../../utils/colors.dart';
import '../../week_test/week_test_detail/test_player_widget.dart';

/**
 * Time: 2023/2/21 13:59
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
class ListenQuestionResult extends BaseQuestionResult {
  SubjectVoList data;

  ListenQuestionResult({required this.data,Key? key}) : super(key: key);


  @override
  BaseQuestionResultState<BaseQuestionResult> getState() {
    // TODO: implement getState
   return _ListenQuestionResultState();
  }

}

class _ListenQuestionResultState extends BaseQuestionResultState<ListenQuestionResult> {

  AudioPlayer audioPlayer  = AudioPlayer();
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

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 18.w,right: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildQuestionType("听力题"),
          Visibility(
              visible: element.stem!=null && element.stem!.isNotEmpty,
              child: Text(element.stem??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          // Visibility(
          //     visible: element.name!=null && element.name!.isNotEmpty,
          //     child: Text(element.name??"",style: TextStyle(color: AppColors.c_FF101010,fontSize: 14.sp,fontWeight: FontWeight.bold),)),
          Visibility(
              visible: element.type == 1 && element.audio !=null && element.audio!.isNotEmpty,
              child: buildListenQuestion(element.audio??"")),
          Expanded(child: getQuestionDetail(element)),
        ],
      ),
    );
  }



  Widget buildListenQuestion(String listtenUrl){
    audioPlayer.setSourceUrl(listtenUrl);
    return Container(
      child: TestPlayerWidget(audioPlayer,TestPlayerWidget.PRACTISE_TYPE),
    );
  }



  @override
  void onDestroy() {
    audioPlayer.release();
  }

}
