import 'package:crazyenglish/base/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/widgetPage/base_page_widget.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import 'change_nick_name_logic.dart';

class ChangeNickNamePage extends BasePage {
  const ChangeNickNamePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToMyOrderPageState();
}

class _ToMyOrderPageState extends BasePageState<ChangeNickNamePage> {
  final logic = Get.put(Change_nick_nameLogic());
  final state = Get.find<Change_nick_nameLogic>().state;
  late TextEditingController _controller;
  final TextStyle textStyle = TextStyle(
      fontSize: 23, color: Color(0xff353e4d), fontWeight: FontWeight.w500);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    logic.addListenerId(GetBuilderIds.toChangeNickName, () {
      //todo nickname
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
                  Util.toast('修改');

                  logic.changeNickName('');
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
