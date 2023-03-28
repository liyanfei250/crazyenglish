import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'student_list_logic.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final logic = Get.put(StudentListLogic());
  final state = Get.find<StudentListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<StudentListLogic>();
    super.dispose();
  }
}