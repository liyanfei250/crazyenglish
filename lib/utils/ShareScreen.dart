import 'dart:typed_data';

import 'package:crazyenglish/base/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../r.dart';

class ShareScreen extends StatefulWidget {
  final Uint8List imageBytes;

  ShareScreen({required this.imageBytes});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: MemoryImage(widget.imageBytes),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40.w,
            right: 40.w,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                R.imagesRankingClose,
                width: 22.w,
                height: 22.w,
              ),
            ),
          ),
          Positioned(
            bottom: 1.w,
            left: 20.w,
            right: 20.w,
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Util.toast('保存到相册');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          R.imagesRankingSaveToAlbum,
                          width: 42.w,
                          height: 42.w,
                        ),
                        SizedBox(height: 6.w),
                        Text(
                          '保存到相册',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Util.toast('微信');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          R.imagesRankingShareWechat,
                          width: 42.w,
                          height: 42.w,
                        ),
                        SizedBox(height: 6.w),
                        Text('微信',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Util.toast('朋友圈');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          R.imagesRankingShareWechatMoments,
                          width: 42.w,
                          height: 42.w,
                        ),
                        SizedBox(height: 6.w),
                        Text('朋友圈',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }
}
