import 'dart:convert';
import 'dart:io';

import 'dart:io';
import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/pages/mine/question_feedback/question_feedback_logic.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:crazyenglish/widgets/image_get_widget/image_get_widget_view.dart';
import 'package:dio/dio.dart' as newdio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';

class QuestionFeedbackPage extends BasePage {
  static final String subtopicStr = "subtopicId";
  static final String subjectidStr = "subjectId";
  static final String FeedBack = "FeedBack";
  bool isFeedback = false;

  num subtopicId = 0;
  num subjectId = 0;


  QuestionFeedbackPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isFeedback = Get.arguments[FeedBack]??false;
      subtopicId = Get.arguments['subtopicStr']??0;
      subjectId = Get.arguments['subjectidStr']??0;
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToQuestionFeedbackPageState();
}

class _ToQuestionFeedbackPageState extends BasePageState<QuestionFeedbackPage> {
  final logic = Get.put(Question_feedbackLogic());
  final state = Get.find<Question_feedbackLogic>().state;

  //图片上传相关
  final ImagePicker _picker = ImagePicker();
  int maxFileCount = 4; //最大选择图片数量
  dynamic _pickImageError;
  int _bigImageIndex = 0; //选中的需要放大的图片的下标
  bool _bigImageVisibility = false; //是否显示预览大图

   TextEditingController? contentContro ;
   TextEditingController? getBoyController ;

   Map<String,String> imgsMap = {};

  @override
  void initState() {
    super.initState();
    contentContro = TextEditingController();
    getBoyController = TextEditingController();
    logic.addListenerId(GetBuilderIds.toPushContent, () {
      Util.toast('提交成功');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text(
          widget.isFeedback ? '意见反馈' : '题目反馈',
          style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Util.buildBackWidget(context),
        elevation: 10.w,
        shadowColor: const Color(0x1F000000),
        actions: [
          InkWell(
            onTap: () {
              List<String> imgsList = [];
              imgsMap.forEach((key, value) {
                if(value.isNotEmpty){
                  imgsList.add(value);
                }
              });
              if(widget.isFeedback){
                logic.postFeedback(0,FeedbackType.system,getBoyController!.text,imgsList);
              }else{
                if(widget.subtopicId>0){
                  logic.postFeedback(widget.subtopicId,FeedbackType.subtopicType,getBoyController!.text,imgsList);
                }else if(widget.subjectId>0){
                  logic.postFeedback(widget.subjectId,FeedbackType.subjectType,getBoyController!.text,imgsList);
                }else{
                  Util.toast("没法获取试题数据");
                }
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              child: const Text(
                '提交',
                style: TextStyle(
                  color: Color(0xffed702d),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          SizedBox(
            height: 24.w,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 18.w,
              ),
              Container(
                width: 3.w,
                height: 13.w,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2),
                        bottomRight: Radius.circular(2))),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text('问题描述',
                  style: TextStyle(
                    color: Color(0xff353e4d),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          _buildQuestionLayout()
        ],
      ),
    );
  }

  Widget _buildSearchBar() => Container(
        margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 24.w),
        padding: EdgeInsets.only(left: 2.w, right: 2.w),
        alignment: Alignment.center,
        height: 47.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7.w)),
          border: Border.all(width: 1.w, color: Color(0xffd2d5dc)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 17.w,
            ),
            Expanded(
                child: TextField(
              cursorColor: Colors.black,
              controller: contentContro,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
              //controller: getBoyController,
              autofocus: false,
              decoration: InputDecoration(
                  //提示信息
                  hintText: "请输入您的手机号",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
              //设置最大行数
              maxLines: 1,
            )),
          ],
        ),
      );

  Widget _buildQuestionLayout() => Container(
        margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 20.w),
        padding: EdgeInsets.only(left: 18.w, right: 18.w),
        alignment: Alignment.topLeft,
        height: 488.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7.w)),
          border: Border.all(width: 1.w, color: Color(0xffd2d5dc)),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 10.w,
                left: 2.w,
                right: 14.w,
                child: TextField(
                  maxLines: 12,
                  minLines: 3,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15),
                  controller: getBoyController,
                  autofocus: false,
                  decoration: InputDecoration(
                      //提示信息
                      hintText: "请输入您遇到的问题，建议400字以内",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                )),
            Positioned(
                bottom: 1.w,
                left: 14.w,
                right: 14.w,
                child: SizedBox(
                  height: 100,
                  child: _handlePreview(),
                ))
          ],
        ),
      );

  Widget _handlePreview() {
    return _previewImages();
  }

  Widget _previewImages() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, //每行三个
        childAspectRatio: 1.0, //宽高比1：1
      ),
      itemBuilder: (context, index) {
        return ImageGetWidgetPage("feekback_${SpUtil.getInt(BaseConstant.USER_ID)}_${index}",
            "",(imgUrl){
              imgsMap["feekback_${SpUtil.getInt(BaseConstant.USER_ID)}_${index}"] = imgUrl;
        },(){
          return true;
        },false);
      },
      itemCount: 3,
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
