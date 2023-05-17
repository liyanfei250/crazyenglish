import 'dart:math';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../entity/user_info_response.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/FullScreenImage.dart';
import '../../../utils/colors.dart';
import '../../../utils/permissions/permissions_util.dart';
import 'create_class_logic.dart';
import 'dart:io' as FileNew;
import 'package:path/path.dart' as path;
import 'package:tencent_cos/tencent_cos.dart';

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

  UserInfoResponse? userInfoResponse;

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

    logic.addListenerId(GetBuilderIds.getMyClassAdd, () {
      Util.toast("添加成功");
      Get.back(result: 'add_success');
    });
    userInfoResponse = UserInfoResponse.fromJson(SpUtil.getObject(BaseConstant.USER_INFO));

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
                _myHorizontalLayout(R.imagesClassInfoTeacherName, "讲师名称:",
                    SpUtil.getString(BaseConstant.USER_NAME)),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayout(R.imagesClassInfoTeacherSex, "讲师性别:",
                    "${userInfoResponse?.obj?.username}"),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                // TODO 需增加教龄字段
                _myHorizontalLayout(R.imagesClassInfoTeacherAge, "讲师教龄:",
                    "${userInfoResponse?.obj?.username}"),
                Divider(
                  color: AppColors.c_FFD2D5DC,
                ),
                _myHorizontalLayout(R.imagesClassInfoTeacherPhoneNum, "联系方式:",
                    "${userInfoResponse?.obj?.phone}"),
                SizedBox(
                  height: 36.w,
                ),
                Container(
                  height: 47.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 30.w),
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25.w),
                    gradient: LinearGradient(
                      colors: [Color(0xFFF19B57), Color(0xFFEC622D)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (_controller.text.isEmpty) {
                        Util.toast('班级名称不能为空！');
                        return;
                      }
                      //todo 图片处理
                      logic.toAddClass(
                          'https://p0.ssl.img.360kuai.com/t01736c309615e3dc19.jpg',
                          _controller.text,
                          SpUtil.getInt(BaseConstant.USER_ID).toString());
                    },
                    child: Text(
                      '创建班级',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16.sp),
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

  /*Future<String> uploadImageToTencentCos(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    final file = FileNew.File(pickedFile.path);
    final fileName = path.basename(file.path);
    final objectName = 'images/$fileName'; // 腾讯云对象存储的路径
    final cos = TencentCloudCos(
      secretId: '你的SecretId',
      secretKey: '你的SecretKey',
      region: '你的region',
      bucket: '你的bucket名称',
    );
    try {
      await cos.uploadFile(objectName, file);
      final url = cos.getObjectUrl(objectName);
      return url;
    } catch (e) {
      print('上传图片失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('上传图片失败'),
      ));
      return null;
    }
  }*/
  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
