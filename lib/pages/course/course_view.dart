import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'course_logic.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final logic = Get.put(CourseLogic());
  final state = Get.find<CourseLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<CourseLogic>();
    super.dispose();
  }
}