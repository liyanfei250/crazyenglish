import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/dialog_manager.dart';
import '../../../entity/commit_request.dart';
import '../../../entity/start_exam.dart';
import '../../../r.dart';
import '../../../utils/text_util.dart';
import '../writingDialog.dart';
import '../answer_interface.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import '../answering/answering_view.dart';
import '../question/question_factory.dart';
import 'base_question.dart';
import 'package:flutter/material.dart';
import '../../../entity/week_detail_response.dart';

/**
 * Description:写作
 */
class WritingQuestion extends BaseQuestion {

  WritingQuestion(Map<String, ExerciseLists> subtopicAnswerVoMap,
      int answerType, SubjectVoList data, int childIndex, {Key? key})
      : super(subtopicAnswerVoMap, answerType, childIndex,
            data: data, key: key);

  @override
  BaseQuestionState<BaseQuestion> getState() {
    return _WritingQuestionState();
  }
}

class _WritingQuestionState extends BaseQuestionState<WritingQuestion> {
  late SubjectVoList element;
  final TextEditingController writController = TextEditingController();
  Widget? detailWidget;

  @override
  getAnswers() {
    throw UnimplementedError();
  }

  @override
  void onCreate() {
    element = widget.data;
    if (widget.subtopicAnswerVoMap != null &&
        widget.subtopicAnswerVoMap!["${element.id}:0"] != null) {
      ExerciseLists exerciseLists = widget.subtopicAnswerVoMap!["${element
          .id}:0"]!;
      if ((exerciseLists.answer ?? "").isNotEmpty) {
        writController.text = exerciseLists.answer ?? "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (detailWidget == null) {
      detailWidget = _buildClassArea();
    }
    return SingleChildScrollView(
      child: detailWidget,
    );
  }

  Widget _buildClassArea() => Container(
        width: double.infinity,
        margin:
            EdgeInsets.only(right: 20.w, left: 20.w, top: 17.w, bottom: 17.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image.asset(
                      R.imagesWritingTitleBg,
                      width: 66.w,
                      height: 9.w,
                    ),
                    Text(
                      "题目",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: AppColors.c_FF101010),
                    ),
                  ],
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 16.w)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 2.w,
                  height: 13.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.zero,
                          topLeft: Radius.zero,
                          topRight: Radius.circular(2.w),
                          bottomRight: Radius.circular(2.w)),
                      color: Color(0xff353e4d)),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  "Reading",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: AppColors.c_FF101010),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 0.w)),
            SelectionArea(
              child: Html(
                data: TextUtil.weekDetail
                    .replaceFirst("###content###", element.stem ?? ""),
                onImageTap: (
                  url,
                  context,
                  attributes,
                  element,
                ) {
                  if (url != null && url!.startsWith('http')) {
                    DialogManager.showPreViewImageDialog(
                        BackButtonBehavior.close, url);
                  }
                },
                style: {
                  "p": QuestionFactory.getHtml_P_TagStyle(),
                  "sentence": Style(
                      textDecorationStyle: TextDecorationStyle.dashed,
                      textDecorationColor: AppColors.THEME_COLOR),
                  "hr": Style(
                    margin: Margins.only(
                        left: 0, right: 0, top: 10.w, bottom: 10.w),
                    padding: EdgeInsets.all(0),
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  )
                },
                tagsList: Html.tags..addAll(['sentence']),
              ),
            ),
            _buildClassCard(0),
            _inputCard(),
          ],
        ),
      );

  Widget _buildClassCard(int index) => Container(
        margin: EdgeInsets.only(top: 20.w),
        padding:
            EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 14.w),
        width: double.infinity,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                offset: Offset(10, 20), // 阴影与容器的距离
                blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: AppColors.c_FFFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_listShow(), _rightShow()],
        ),
      );

  Widget _inputCard() => Container(
        margin: EdgeInsets.only(top: 14.w),
        padding:
            EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 14.w),
        width: double.infinity,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                offset: Offset(10, 20), // 阴影与容器的距离
                blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: AppColors.c_FFFFFFFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                logic.uploadWrite();
              },
              child: Image.asset(
                R.imagesWritingCommitButton,
                width: 57.w,
                height: 17.w,
              ),
            ),
            TextField(
              autofocus: true,
              maxLines: 100,
              minLines: 10,
              controller: writController,
              onChanged: (String str) {
                  SubjectAnswerVo subjectAnswerVo = SubjectAnswerVo(subjectId:element.id,
                      isSubjectivity:true,questionTypeStr:'',answer:str);
                  userAnswerWritCallback.call(subjectAnswerVo);
              },
              style: TextStyle(color: Color(0xff353e4d), fontSize: 12.sp),
              decoration: InputDecoration(
                  //提示信息
                  hintText: "请在这里开始答题吧～",
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(color: Color(0xffb3b7c6), fontSize: 12.sp)),
            )
          ],
        ),
      );

  Widget _listShow() => Expanded(
      child: Container(
          height: 190.w,
          child: SingleChildScrollView(
            child: SelectionArea(
              child: Html(
                data: TextUtil.weekDetail
                    .replaceFirst("###content###", element.content ?? ""),
                onImageTap: (
                    url,
                    context,
                    attributes,
                    element,
                    ) {
                  if (url != null && url!.startsWith('http')) {
                    DialogManager.showPreViewImageDialog(
                        BackButtonBehavior.close, url);
                  }
                },
                style: {
                  "p": Style(fontSize: FontSize.large),
                  "sentence": Style(
                      textDecorationStyle: TextDecorationStyle.dashed,
                      textDecorationColor: AppColors.THEME_COLOR),
                  "hr": Style(
                    margin:
                    Margins.only(left: 0, right: 0, top: 10.w, bottom: 10.w),
                    padding: EdgeInsets.all(0),
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  )
                },
                tagsList: Html.tags..addAll(['sentence']),
              ),
            ),
          )));

  Widget _rightShow() => Container(
        width: 90.w,
        height: 190.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: (element.modelEssay ??
                  "").isNotEmpty,
              child: InkWell(
              onTap: () {
                //RouterUtil.toNamed(AppRoutes.IntensiveListeningPage);
                Util.toast("查看范文");
                showDialog(
                  context: context,
                  builder: (context) => WritDialog(
                      element.modelEssay ??
                          ""),
                );
              },
              child: Image.asset(
                R.imagesWritingLookBotton,
                width: 77.w,
                height: 18.w,
              ),
            )),
            Expanded(child: Text("")),
            Text(
              "注意：词数100左右",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 10.sp,
                  color: Color(0xfff2a842)),
            ),
          ],
        ),
      );

  @override
  void onDestroy() {
  }
}
