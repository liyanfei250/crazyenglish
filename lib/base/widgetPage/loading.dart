import 'package:crazyenglish/utils/Util.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../r.dart';
import '../../widgets/images_anim.dart';

class LoadingWidget extends StatefulWidget {

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  Map<int,Image> imageCaches = {
    // 0:Image.asset(R.imagesIeltsPageLoading00000),
    // 1:Image.asset(R.imagesIeltsPageLoading00001),
    // 2:Image.asset(R.imagesIeltsPageLoading00002),
    // 3:Image.asset(R.imagesIeltsPageLoading00003),
    // 4:Image.asset(R.imagesIeltsPageLoading00004),
    // 5:Image.asset(R.imagesIeltsPageLoading00005),
    // 6:Image.asset(R.imagesIeltsPageLoading00006),
    // 7:Image.asset(R.imagesIeltsPageLoading00007),
    // 8:Image.asset(R.imagesIeltsPageLoading00008),
    // 9:Image.asset(R.imagesIeltsPageLoading00009),
    // 10:Image.asset(R.imagesIeltsPageLoading00010),
    // 11:Image.asset(R.imagesIeltsPageLoading00011),
    // 12:Image.asset(R.imagesIeltsPageLoading00012),
    // 13:Image.asset(R.imagesIeltsPageLoading00013),
    // 14:Image.asset(R.imagesIeltsPageLoading00014),
    // 15:Image.asset(R.imagesIeltsPageLoading00015),
    // 16:Image.asset(R.imagesIeltsPageLoading00016),
    // 17:Image.asset(R.imagesIeltsPageLoading00017),
  };

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ImagesAnim(
            imageCaches,
            Util.setWidth(255) as double,
            Util.setWidth(140) as double,
            Colors.transparent,
            milliseconds: 36,),
      );
  }
}