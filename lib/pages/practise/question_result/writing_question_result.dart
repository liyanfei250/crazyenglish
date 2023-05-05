import 'package:audioplayers/audioplayers.dart';
import 'package:crazyenglish/pages/practise/question_result/base_question_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../r.dart';
import '../../../utils/colors.dart';
import '../../week_test/week_test_detail/test_player_widget.dart';

class WritingQuestionResult extends BaseQuestionResult {
  SubjectVoList data;

  WritingQuestionResult(Map<String, ExerciseLists> subtopicAnswerVoMap,
      {required this.data, Key? key})
      : super(subtopicAnswerVoMap, key: key);

  @override
  BaseQuestionResultState<BaseQuestionResult> getState() {
    return _WritingQuestionResultState();
  }
}

class _WritingQuestionResultState
    extends BaseQuestionResultState<WritingQuestionResult> {
  late SubjectVoList element;
  bool isFavorite = false;
  @override
  getAnswers() {
    throw UnimplementedError();
  }

  @override
  void onCreate() {
    element = widget.data;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            _buildBgView(context),
            Positioned(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: Util.buildBackWidget(context),
                  centerTitle: true,
                  title: Text(
                    "作文批改",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Color(0xff353e4d)),
                  ),
                )),
            Positioned(
              top: 90.w,
              child: _buildClassCard(0),
            )
          ],
        ));
  }

  Widget _buildBgView(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.imagesReviewTopBg), fit: BoxFit.cover),
        ));
  }

  Widget _buildClassCard(int index) => SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 340.w,
            margin: EdgeInsets.only(
                top: 20.w, left: 14.w, right: 14.w, bottom: 14.w),
            padding: EdgeInsets.only(
                left: 18.w, right: 18.w, top: 2.w, bottom: 2.w),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                _myHorizontalLayout(
                    R.imagesWritingResultTime, "答题用时： ", "08:41:"),
                _myHorizontalLayout(R.imagesWritingResultType, "习题类型： ",
                    "Module 1 Unit3 听力"),

              ],
            )),
        Container(
          margin: EdgeInsets.only(top: 8.w),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.only(top: 18.w, left: 18.w, right: 18.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _rowList(),
              // _exampleLayout(),
            ],
          ),
        )
      ],
    ),
  );

  Widget _myHorizontalLayout(String iconData, String title, String subtitle) =>
      Row(
        children: [
          Image.asset(
            iconData,
            width: 12.w,
            height: 12.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Color(0xffb3b7c6)),
              )),
          SizedBox(
            width: 10.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
            child: Expanded(
                child: Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffb3b7c6)),
                )),
          )
        ],
      );

  @override
  void onDestroy() {}

  Widget _rowList() {
    return Row(
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
              "范文",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: AppColors.c_FF101010),
            ),
          ],
        ),
        Expanded(child: Text('')),
        InkWell(
          onTap: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xffffb800), width: 2),
            ),
            child: Row(
              children: [
                Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: Color(0xffffb800),
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  isFavorite ? '已收藏' : '收藏',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
