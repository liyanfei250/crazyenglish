import 'dart:convert';
import 'dart:io';

import 'dart:io';
import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/pages/question_feedback/question_feedback_logic.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:dio/dio.dart' as newdio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../base/common.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/getx_ids.dart';
import '../../utils/colors.dart';

class QuestionFeedbackPage extends BasePage {
  bool isFeedback = false;

  QuestionFeedbackPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isFeedback = Get.arguments['isFeedback'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToQuestionFeedbackPageState();
}

class _ToQuestionFeedbackPageState extends BasePageState<QuestionFeedbackPage> {
  final logic = Get.put(Question_feedbackLogic());
  final state = Get.find<Question_feedbackLogic>().state;

  //图片上传相关
  String _title = "图片上传";
  List<XFile> _imageFileList = List.empty(growable: true); //存放选择的图片
  final ImagePicker _picker = ImagePicker();
  int maxFileCount = 4; //最大选择图片数量
  dynamic _pickImageError;
  int _bigImageIndex = 0; //选中的需要放大的图片的下标
  bool _bigImageVisibility = false; //是否显示预览大图

   TextEditingController? contentContro ;
   TextEditingController? getBoyController ;

  //获取当前展示的图的数量
  int getImageCount() {
    if (_imageFileList.length < maxFileCount) {
      return _imageFileList.length + 1;
    } else {
      return _imageFileList.length;
    }
  }

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
          widget.isFeedback ? '题目反馈' : '意见反馈',
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
              // 点击事件处理逻辑
              _upLoadImage();
              //todo 图片地址获取
              logic.postContent(SpUtil.getInt(BaseConstant.USER_ID),getBoyController!.text,['https://www.baidu.com/img/flexible/logo/pc/result.png','https://www.baidu.com/img/flexible/logo/pc/result.png']);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              child: Text(
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

//图片上传
  _upLoadImage() async {
    List<dynamic> _imgListUpload = [];
    _imageFileList.forEach((element) {
      //遍历图片 加入到dio的批量文件里面
      _imgListUpload.add(newdio.MultipartFile.fromFileSync(element.path,
          filename: element.name));
    });
    var formData = newdio.FormData.fromMap({
      'files': _imgListUpload, //批量的图片
      'WAREHOUSEID': 'TEST', //其他的参数
      'ORDERNO': 'HZ00000000001'
    });
    try {
      newdio.Dio dio = new newdio.Dio();
      var respone = await dio.post<String>(
          "http://192.168.1.21:8080/FlutterService/UploadImages",
          data: formData);
      if (respone.statusCode == 200) {
        Util.toast("上传成功!");
      }
    } catch (e) {
      Util.toast("上传失败!");
    }
  }

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
                left: 14.w,
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, //每行三个
        crossAxisSpacing: 14.w,
        childAspectRatio: 1.0, //宽高比1：1
      ),
      itemBuilder: (context, index) {
        if (_imageFileList.length < maxFileCount) {
          //没选满
          if (index < _imageFileList.length) {
            //需要展示的图片
            return Stack(
              //层叠布局 图片上面要有一个删除的框
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: GestureDetector(
                      child: Image.file(File(_imageFileList[index].path),
                          fit: BoxFit.cover),
                      onTap: () => showBigImage(index),
                    )),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  left: 0.0,
                  child: GestureDetector(
                    child: SizedBox(
                      child: Image.asset(R.imagesReporterDeletePhone),
                    ),
                    onTap: () => _removeImage(index),
                  ),
                ),
              ],
            );
            //return Image.file(File(_imageFileList[index].path),fit:BoxFit.cover ,) ;
          } else {
            //显示添加符号
            return GestureDetector(
              //手势包含添加按钮 实现点击进行选择图片
              child: Image.asset(R.imagesReporterAddPhone),
              onTap: () => _onImageButtonPressed(
                //执行打开相册
                ImageSource.gallery,
                context: context,
                imageQuality: 40, //图片压缩
              ),
            );
          }
        } else {
          //选满了
          return Stack(
            //层叠布局 图片上面要有一个删除的框
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: GestureDetector(
                  child: Image.file(File(_imageFileList[index].path),
                      fit: BoxFit.cover),
                  onTap: () => showBigImage(index),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: GestureDetector(
                  child: SizedBox(
                    child: Image.asset(R.imagesReporterDeletePhone),
                  ),
                  onTap: () => _removeImage(index),
                ),
              ),
            ],
          );
        }
      },
      itemCount: getImageCount(),
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context,
      double? maxHeight,
      double? maxWidth,
      int? imageQuality}) async {
    try {
      final pickedFileList = await _picker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
      setState(() {
        //pickedFileList.e
        if (_imageFileList.length < maxFileCount) {
          //小于最大数量
          if ((_imageFileList.length + (pickedFileList?.length ?? 0)) <=
              maxFileCount) {
            //加上新选中的不超过最大数量
            pickedFileList!.forEach((element) {
              _imageFileList.add(element);
            });
          } else {
            //否则报错
            Util.toast("超过可选最大数量!自动移除多余的图片");
            int avaliableCount = maxFileCount - _imageFileList.length;
            for (int i = 0; i < avaliableCount; i++) {
              _imageFileList.add(pickedFileList![i]);
            }
          }
        }
      });
    } catch (e) {
      setState(() {
        Util.toast("$_pickImageError");
        _pickImageError = e;
      });
    }
  }

  //移除图片
  void _removeImage(int index) {
    setState(() {
      _imageFileList.removeAt(index);
    });
  }

  //通过双击小图的时候获取当前需要放大预览的图的下标
  void showBigImage(int index) {
    setState(() {
      _bigImageIndex = index;
      _bigImageVisibility = true;
    });
  }

  //通过大图的双击事件 隐藏大图
  void hiddenBigImage() {
    setState(() {
      _bigImageVisibility = false;
    });
  }

  //展示大图
  Widget? displayBigImage() {
    if (_imageFileList.length > _bigImageIndex) {
      return Image.file(File(_imageFileList[_bigImageIndex].path),
          fit: BoxFit.fill);
    } else {
      return null;
    }
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
