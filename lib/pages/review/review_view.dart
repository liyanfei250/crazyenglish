import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../r.dart';
import 'review_logic.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final logic = Get.put(ReviewLogic());
  final state = Get.find<ReviewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.imagesReviewTopBg),
              fit: BoxFit.cover
            ),
          ),
          child: Column(

          ),
        ),
    );
  }

  @override
  void dispose() {
    Get.delete<ReviewLogic>();
    super.dispose();
  }
}