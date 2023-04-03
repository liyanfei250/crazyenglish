import 'dart:typed_data';

import 'package:crazyenglish/utils/ShareScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:flutter_pickers/utils/check.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import 'dart:ui' as ui;
import '../../../r.dart';
import '../../../utils/permissions/permissions_util.dart';
import '../../../widgets/my_text.dart';
import 'learning_report_logic.dart';

class LearningReportPage extends BasePage {
  const LearningReportPage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToLearningReportPageState();
}

class _ToLearningReportPageState extends BasePageState<LearningReportPage> {
  final logic = Get.put(Learning_reportLogic());
  final state = Get.find<Learning_reportLogic>().state;
  final GlobalKey _globalKey = GlobalKey();
  var selectData = {
    DateMode.YMDHMS: '',
    DateMode.YMDHM: '',
    DateMode.YMDH: '',
    DateMode.YMD: '',
    DateMode.YM: '',
    DateMode.Y: '',
    DateMode.MDHMS: '',
    DateMode.HMS: '',
    DateMode.MD: '',
    DateMode.S: '',
  };
  var selectDataTwo = {
    DateMode.YMDHMS: '',
    DateMode.YMDHM: '',
    DateMode.YMDH: '',
    DateMode.YMD: '',
    DateMode.YM: '',
    DateMode.Y: '',
    DateMode.MDHMS: '',
    DateMode.HMS: '',
    DateMode.MD: '',
    DateMode.S: '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RepaintBoundary(
      key: _globalKey,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFCF0EE),
                  Color(0xFFFFFDF9),
                  Color(0xFFEEF7F4),
                ],
                stops: [0, 0.5, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          Positioned(
              child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.back();
              },
              child: Center(
                child: Container(
                  width: Util.setWidth(20) as double?,
                  height: Util.setWidth(20) as double?,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: Util.setWidth(13) as double),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black, // 这里修改成你想要的颜色
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      R.imagesIconBackBlack,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            centerTitle: true,
          )),
          Positioned(
              top: 50.w,
              right: 18.w,
              child: GestureDetector(
                onTap: () async {
                  await PermissionsUtil.checkPermissions(context,
                      "为了正常访问相册，需要您授权以下权限", [RequestPermissionsTag.PHOTOS], () {
                    _saveImage();
                  });
                },
                child: Container(
                  width: 48.w,
                  height: 22.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Color(0xffed702d), width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '分享',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffed702d)),
                  ),
                ),
              )),
          Positioned(
              top: 80.w,
              right: 18.w,
              left: 18.w,
              child: GestureDetector(
                onTap: () {},
                child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                            child: Image.asset(
                          R.imagesShopImageLogoTest,
                          width: 54.w,
                          height: 54.w,
                        )),
                        SizedBox(
                          height: 16.w,
                        ),
                        Text('张慧敏',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff353e4d))),
                        SizedBox(
                          height: 4.w,
                        ),
                        Text('一班（初一）',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff898a93))),
                        SizedBox(
                          height: 24.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('85%',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff353e4d))),
                                SizedBox(
                                  height: 4.w,
                                ),
                                Text('客观题正确率',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff898a93)))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('85%',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff353e4d))),
                                SizedBox(
                                  height: 4.w,
                                ),
                                Text('主观题平均分',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff898a93)))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('85%',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff353e4d))),
                                SizedBox(
                                  height: 4.w,
                                ),
                                Text('努力值',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff898a93)))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.w,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 8.w, right: 8.w, top: 10.w, bottom: 10.w),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: 15.w, left: 18.w, right: 18.w, bottom: 10.w),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.w)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                  spreadRadius: 0,
                                ),
                              ],
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                R.imagesReportShareIc,
                                width: 28.w,
                                height: 28.w,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              _item('年月日', DateMode.YMD),
                              SizedBox(
                                width: 4.w,
                              ),
                              Container(
                                height: 1.w,
                                width: 18.w,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              _itemTwo(DateMode.YMD),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 12.w,
                            ),
                            Image.asset(
                              R.imagesReportShareBeforDate,
                              width: 22.w,
                              height: 31.w,
                            ),
                            Text('学习数据',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff353e4d))),
                          ],
                        ),
                        GridView(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, //每行显示的元素个数
                                    crossAxisSpacing: 20.0,
                                    mainAxisSpacing: 16.0,
                                    childAspectRatio: 100 / 120 //宽高比为1时，子widget
                                    ),
                            children: <Widget>[
                              _buildFuncAreaItem(
                                  R.imagesReportOne, '累计听力', '88d12h3m'),
                              _buildFuncAreaItem(
                                  R.imagesReportTwo, '累计阅读', '88d12h3m'),
                              _buildFuncAreaItem(
                                  R.imagesReportThree, '累计口语', '88d12h3m'),
                              _buildFuncAreaItem(
                                  R.imagesReportFour, '累计写作', '88d12h3m'),
                            ]),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    ));
  }

  Future<void> _saveImage() async {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }

    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    await ImageGallerySaver.saveImage(pngBytes);
    if (byteData != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ShareScreen(
            imageBytes: byteData.buffer.asUint8List(),
          ),
        ),
      );
    }
  }

  Widget _item(title, model) {
    return Container(
        child: GestureDetector(
      onTap: () {
        _onClickItem(model);
      },
      child: MyText(
        PicketUtil.strEmpty(selectData[model])
            ? "${DateFormat("yyyy年MM月dd日").format(DateTime.now().toUtc().add(Duration(hours: 8)).subtract(Duration(days: 30)))}"
            : selectData[model],
        color: Colors.black,
        size: 14,
        toppadding: 4.w,
        bottompadding: 4.w,
      ),
    ));
  }

  Widget _itemTwo(model) {
    return Container(
        child: GestureDetector(
      onTap: () {
        _onClickItemTwo(model);
      },
      child: MyText(
        PicketUtil.strEmpty(selectDataTwo[model])
            ? "${DateFormat("yyyy年MM月dd日").format(DateTime.now().toUtc().add(Duration(hours: 8)))}"
            : selectDataTwo[model],
        color: Colors.black,
        size: 14,
      ),
    ));
  }

  void _onClickItem(model) {
    Pickers.showDatePicker(
      context,
      mode: model,
      suffix: Suffix.normal(),
      minDate: PDuration(year: 2020, month: 2, day: 10),
      maxDate: PDuration(second: 22),
      onConfirm: (p) {
        print('longer >>> 返回数据：$p');
        setState(() {
          switch (model) {
            case DateMode.YMD:
              selectData[model] = '${p.year}年${p.month}月${p.day}日';
              break;
          }
        });
      },
      // onChanged: (p) => print(p),
    );
  }

  void _onClickItemTwo(model) {
    Pickers.showDatePicker(
      context,
      mode: model,
      suffix: Suffix.normal(),
      minDate: PDuration(year: 2020, month: 2, day: 10),
      maxDate: PDuration(second: 22),
      onConfirm: (p) {
        print('longer >>> 返回数据：$p');
        setState(() {
          switch (model) {
            case DateMode.YMD:
              selectDataTwo[model] = '${p.year}年${p.month}月${p.day}日';
              break;
          }
        });
      },
      // onChanged: (p) => print(p),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  Widget _buildFuncAreaItem(String image, String title, String content) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 15.w, bottom: 20.w),
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8.w, left: 10.w, right: 10.w, bottom: 8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 42.w,
            height: 44.w,
          ),
          SizedBox(
            height: 1.w,
          ),
          Text(title,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff898a93))),
          SizedBox(
            height: 13.w,
          ),
          Text(content,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff353e4d))),
        ],
      ),
    );
  }
}
