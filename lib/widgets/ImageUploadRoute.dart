// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// ignore_for_file: public_member_api_docs

import 'dart:io';
import 'package:crazyenglish/base/AppUtil.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadRoute extends StatefulWidget {
  ImageUploadRoute({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUploadRoute> {
  //编辑文本
  late TextEditingController _controller;

  //图片上传相关
  String _title = "图片上传";
  List<XFile> _imageFileList = List.empty(growable: true); //存放选择的图片
  final ImagePicker _picker = ImagePicker();
  int maxFileCount = 9; //最大选择图片数量
  dynamic _pickImageError;
  int _bigImageIndex = 0; //选中的需要放大的图片的下标
  bool _bigImageVisibility = false; //是否显示预览大图

  //获取当前展示的图的数量
  int getImageCount() {
    if (_imageFileList.length < maxFileCount) {
      return _imageFileList.length + 1;
    } else {
      return _imageFileList.length;
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Widget _previewImages() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //每行三个
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
                  width: 20,
                  height: 20,
                  child: GestureDetector(
                    child: SizedBox(
                      child: Image.asset('images/delete.png'),
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
              child: Image.asset('images/addphoto.png'),
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
                right: 0.0,
                width: 20,
                height: 20,
                child: GestureDetector(
                  child: SizedBox(
                    child: Image.asset('images/delete.png'),
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

  //图片上传
  _upLoadImage() async {
    List<dynamic> _imgListUpload = [];
    _imageFileList.forEach((element) {
      //遍历图片 加入到dio的批量文件里面
      _imgListUpload.add(
          MultipartFile.fromFileSync(element.path, filename: element.name));
    });
    var formData = FormData.fromMap({
      'files': _imgListUpload, //批量的图片
      'WAREHOUSEID': 'TEST', //其他的参数
      'ORDERNO': 'HZ00000000001'
    });
    try {
      Dio dio = new Dio();
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

  //初始化的时候打开定位相关
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //页面的控件布局
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Stack(
          children: [
            Positioned(
                //占满屏幕
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    TextField(
                      maxLines: 10,
                      minLines: 3,
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "签收情况",
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      child: _handlePreview(),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: _upLoadImage,
                        child: const Text('确定'),
                      ),
                    ),
                  ],
                )),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                  visible: _bigImageVisibility,
                  child: GestureDetector(
                    child: displayBigImage(),
                    onTap: hiddenBigImage,
                  )),
            ),
          ],
        ));
  }
}
