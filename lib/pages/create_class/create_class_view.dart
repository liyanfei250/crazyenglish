import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../utils/FullScreenImage.dart';
import '../../utils/colors.dart';
import '../../utils/permissions/permissions_util.dart';
import 'create_class_logic.dart';
import 'dart:io' as FileNew;

class Create_classPage extends BasePage {
  const Create_classPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToCreateClassPageState();
}

class _ToCreateClassPageState extends BasePageState<Create_classPage> {
  final logic = Get.put(Create_classLogic());
  final state = Get.find<Create_classLogic>().state;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;
  bool _hasImage = false;
  FileNew.File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = FileNew.File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _clearText() {
    _controller.clear();
    _onTextChanged();
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
            "新建班级",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Color(0xff353e4d)),
          ),
        )),
        Positioned(top: 116.w, child: _buildClassCard(0))
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
        child: Container(
            margin: EdgeInsets.only(
                top: 20.w, left: 14.w, right: 14.w, bottom: 14.w),
            padding:
                EdgeInsets.only(left: 18.w, right: 18.w, top: 2.w, bottom: 2.w),
            width: 340.w,
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
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        R.imagesClassInfoName,
                        width: 16.w,
                        height: 16.w,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '班级名称：',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Color(0xff353e4d),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          textAlignVertical: TextAlignVertical(y: -0.0),
                          maxLines: 1,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 0.w,
                              right: 14.w,
                              top: 0,
                              bottom: 0,
                            ),
                            border: InputBorder.none,
                            hintText: '请输入班级名称',
                            hintStyle: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Visibility(
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          alignment: Alignment.bottomCenter,
                          child: IconButton(
                            padding: EdgeInsets.only(bottom: 0),
                            icon: Icon(Icons.clear),
                            onPressed: _clearText,
                          ),
                        ),
                        visible: _hasText,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayoutImage(
                    R.imagesClassInfoPhoto, "班级照片:", R.imagesHomeNextIcBlack),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayout(
                    R.imagesClassInfoTeacherName, "讲师名称:", "七年级一班"),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayout(
                    R.imagesClassInfoTeacherSex, "讲师性别:", "七年级一班"),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayout(
                    R.imagesClassInfoTeacherAge, "讲师教龄:", "七年级一班"),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayout(
                    R.imagesClassInfoTeacherPhoneNum, "联系方式:", "七年级一班"),
                SizedBox(
                  height: 36.w,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              '是否加入当前班级：七年级一班',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '否',
                                  style: TextStyle(
                                      color: Color(0xff353e4d),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                        color: Color(0xffd2d5dc), width: 1.0),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // TODO: 处理确认按钮点击事件
                                },
                                child: Text(
                                  '是',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.sp),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 270.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: Color(0xfff19e59),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Text(
                      '创建班级',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 42.w,
                ),
              ],
            )),
      );

  Widget buildItemClass(String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          first,
          style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
        Expanded(child: Text('')),
        Text(second,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff353e4d))),
      ],
    );
  }

  Widget _myHorizontalLayoutImage(
          String iconData, String title, String subtitle) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 17.w, bottom: 17.w),
            child: Image.asset(
              iconData,
              width: 16.w,
              height: 16.w,
            ),
          ),
          SizedBox(width: 12.w),
          Padding(
              padding: EdgeInsets.only(top: 17.w, bottom: 17.w),
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Color(0xff353e4d)),
              )),
          SizedBox(width: 12.w),
          Padding(
            padding: EdgeInsets.only(top: 17.w, bottom: 17.w),
            child: _image != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (_, __, ___) =>
                              FullScreenImage(imageFile: _image),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'imageHero',
                      child: Image.file(
                        FileNew.File(_image!.path),
                        width: 120.w,
                        height: 80.w,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      await PermissionsUtil.checkPermissions(
                          context,
                          "为了正常访问相册，需要您授权以下权限",
                          [RequestPermissionsTag.PHOTOS], () {
                        _pickImage();
                      });
                    },
                    child: Container(
                      width: 120.w,
                      height: 80.w,
                      alignment: Alignment.center,
                      color: Color(0xffd2d5dc),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            R.imagesClassAddWhite,
                            width: 14.w,
                            height: 14.w,
                          ),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            '从相册选择',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: Colors.white),
                          )
                        ],
                      ),
                    )),
          ),
        ],
      );

  Widget _placeWidget() {
    return Container();
  }

  Widget _myHorizontalLayout(String iconData, String title, String subtitle) =>
      Row(
        children: [
          Image.asset(
            iconData,
            width: 16.w,
            height: 16.w,
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Color(0xff353e4d)),
          ),
          SizedBox(
            width: 10.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
            child: Expanded(
                child: Text(
              subtitle,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff353e4d)),
            )),
          )
        ],
      );

  Widget buildItemClassLode(String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '班级照片',
          style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff353e4d)),
        ),
        GestureDetector(
          onTap: () async {
            await PermissionsUtil.checkPermissions(
                context, "为了正常访问相册，需要您授权以下权限", [RequestPermissionsTag.PHOTOS],
                () {
              _pickImage();
            });
          },
          child: _image == null
              ? Text('上传照片',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff353e4d)))
              : Image.file(
                  FileNew.File(_image!.path),
                  width: 100.w,
                  height: 100.w,
                ),
        ),
      ],
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
