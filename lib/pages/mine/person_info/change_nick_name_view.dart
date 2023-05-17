import 'package:crazyenglish/base/AppUtil.dart';
import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/pages/mine/person_info/person_info_logic.dart';
import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ChangeNickNamePage extends BasePage {
  const ChangeNickNamePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<ChangeNickNamePage> {
  final logic = Get.find<Person_infoLogic>();
  late TextEditingController _controller;
  final TextStyle textStyle = TextStyle(
      fontSize: 23, color: Color(0xff353e4d), fontWeight: FontWeight.w500);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    logic.addListenerId(GetBuilderIds.toChangeNickName, () {
      logic.getPersonInfo("${SpUtil.getString(BaseConstant.USER_NAME)}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar(""),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 22.w, left: 41.w, right: 41.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '修改昵称',
              style: textStyle,
            ),
            SizedBox(
              height: 38.w,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: '请输入昵称',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFFBC00), // 修改底部横线颜色
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Color(0xFFFFBC00),
                  ),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
              controller: _controller,
            ),
            SizedBox(
              height: 34.w,
            ),
            Container(
              width: double.infinity,
              height: 47,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFBC00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: Text(
                  '提交',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  // 点击按钮触发的逻辑
                  logic.changeNickName(_controller.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {
    _controller.dispose();
  }
}
