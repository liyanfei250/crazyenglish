import 'package:crazyenglish/pages/mine/register/register_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final logic = Get.put(RegisterLogic());
  final state = Get.find<RegisterLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<RegisterLogic>();
    super.dispose();
  }
}