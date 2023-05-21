import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/blocs/refresh_bloc_bloc.dart';
import 'package:crazyenglish/blocs/refresh_bloc_event.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:crazyenglish/widgets/image_get_widget/image_get_widget_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../base/common.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/FullScreenImage.dart';
import '../../../utils/permissions/permissions_util.dart';
import '../../../utils/sp_util.dart';
import 'person_info_logic.dart';
import 'dart:io' as FileNew;

class PersonInfoPage extends BasePage {
  bool isStudent = false;

  PersonInfoPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      isStudent = Get.arguments['isStudent'];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<PersonInfoPage> {
  final logic = Get.put(Person_infoLogic());
  final state = Get.find<Person_infoLogic>().state;
  final TextStyle textStyle = TextStyle(
      fontSize: 14, color: Color(0xff4d3535), fontWeight: FontWeight.w500);
  final TextStyle textSenStyle = TextStyle(
      fontSize: 12, color: Color(0xff898a93), fontWeight: FontWeight.w500);
  final TextStyle styleScend = TextStyle(
      fontSize: 11, color: Color(0xff4d3535), fontWeight: FontWeight.w400);

  @override
  void initState() {
    super.initState();

    //从本地或者接口获取个人信息
    logic.getPersonInfo("${SpUtil.getInt(BaseConstant.USER_ID)}");

    logic.addListenerId(GetBuilderIds.toChangeHeadImg, () {
      Util.toast('头像更换成功');
      logic.getPersonInfo("${SpUtil.getInt(BaseConstant.USER_ID)}");
      BlocProvider.of<RefreshBlocBloc>(context)
          .add(RefreshPersonInfoEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("个人信息"),
      backgroundColor: AppColors.theme_bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 21.w,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              GetBuilder<Person_infoLogic>(
                  id: GetBuilderIds.getPersonInfo,
                  builder: (logic){
                return ImageGetWidgetPage("headimg_${SpUtil.getInt(BaseConstant.USER_ID)}_img","${logic.state.infoResponse?.obj?.url}",(imgUrl){
                  logic.toChangeHeadImg(imgUrl);
                },(){
                  return true;
                  },true);
              }),
              Positioned(
                bottom: 0.w,
                left: 1.w,
                right: 1.w,
                child: Image.asset(
                  R.imagesMinePhone,
                  width: 31.w,
                  height: 19.w,
                ),
              ),
            ],
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: 10.w, bottom: 10.w, left: 13.w, right: 13.w),
              margin: EdgeInsets.only(left: 34.w, right: 34.w, top: 16.w),
              decoration: BoxDecoration(
                color: Color(0xfffef4e6),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '头像一自然年只能提交一次，无论是否修改成功，提交即消耗本年度修改次数，请谨慎提交。',
                style: styleScend,
              )),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 25.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.w,
                  ),
                  GetBuilder<Person_infoLogic>(
                    id: GetBuilderIds.getPersonInfo,
                    builder: (logic){
                    return buildItemType('修改昵称', logic.state.infoResponse?.obj?.nickname);
                  }),
                  SizedBox(
                    height: 14.w,
                  ),
                  Divider(),
                  SizedBox(
                    height: 14.w,
                  ),
                  buildItemType('修改密码'),
                  // SizedBox(
                  //   height: 14.w,
                  // ),
                  // Divider(),
                  // SizedBox(
                  //   height: 14.w,
                  // ),
                  // TODO 必改
                  // GetBuilder<Person_infoLogic>(
                  //     id: GetBuilderIds.getPersonInfo,
                  //     builder: (logic){
                  //       return buildItemType('更换手机号', logic.state.infoResponse?.obj?.phone);
                  //     }),
                  SizedBox(
                    height: 20.w,
                  ),
                ],
              )),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 25.w),
              padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 14.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 29.w,
                      ),
                      Text(
                        '所属学校',
                        style: textStyle,
                      ),
                      SizedBox(
                        width: 38.w,
                      ),
                      GetBuilder<Person_infoLogic>(
                          id: GetBuilderIds.getPersonInfo,
                          builder: (logic){
                            return Expanded(
                              child: Text(
                                logic.state.infoResponse?.obj?.affiliatedSchool??"",
                                style: textSenStyle,
                              ),
                            );
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 14.w,
                  ),
                  Visibility(
                    child: Divider(),
                    visible: widget.isStudent,
                  ),
                  Visibility(
                    child: SizedBox(
                      height: 14.w,
                    ),
                    visible: widget.isStudent,
                  ),
                  Visibility(
                    visible: widget.isStudent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 29.w,
                        ),
                        Text(
                          '所属年级',
                          style: textStyle,
                        ),
                        SizedBox(
                          width: 38.w,
                        ),
                        GetBuilder<Person_infoLogic>(
                            id: GetBuilderIds.getPersonInfo,
                            builder: (logic){
                              return Expanded(
                                child: Text(
                                  logic.state.infoResponse?.obj?.affiliatedGradeName??"",
                                  style: textSenStyle,
                                ),
                              );
                            }),

                      ],
                    ),
                  ),
                  Visibility(
                    child: SizedBox(
                      height: 14.w,
                    ),
                    visible: widget.isStudent,
                  ),
                ],
              )),
          Expanded(child: Text('')),
        ],
      ),
    );
  }

  Widget buildItemType(String menu, [String? second]) {
    return GestureDetector(
      onTap: () {
        switch (menu) {
          case '修改昵称':
            RouterUtil.toNamed(AppRoutes.ChangeNickNamePage);
            break;
          case '修改密码':
            RouterUtil.toNamed(AppRoutes.ChangePsdPage);
            break;
          case '更换手机号':
            RouterUtil.toNamed(AppRoutes.ChangePhonePage);
            break;
          default:
            return;
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 29.w,
          ),
          Text(
            menu,
            style: textStyle,
          ),
          SizedBox(
            width: 38.w,
          ),
          Expanded(
            child: (second != null)
                ? Text(
                    second,
                    style: textSenStyle,
                  )
                : Text(''),
          ),
          Image.asset(
            R.imagesHomeNextIcBlack,
            height: 7.w,
            width: 11.w,
          ),
          SizedBox(
            width: 25.w,
          ),
        ],
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}

class NicknameDialog extends StatefulWidget {
  final String currentNickname;
  final Function(String) onUpdateNickname;

  NicknameDialog(
      {required this.currentNickname, required this.onUpdateNickname});

  @override
  _NicknameDialogState createState() => _NicknameDialogState();
}

class _NicknameDialogState extends State<NicknameDialog> {
  late TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: widget.currentNickname);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '修改昵称',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: '昵称',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    widget.onUpdateNickname(_nicknameController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text('确定'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
