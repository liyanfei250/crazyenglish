import 'package:crazyenglish/utils/Util.dart';
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../r.dart';

typedef ReloadData = void Function();

class CustomErrorWidget extends StatefulWidget {
  final ReloadData? reloadData;

  CustomErrorWidget({this.reloadData});

  @override
  _CustomErrorState createState() => _CustomErrorState();
}

class _CustomErrorState extends State<CustomErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset(R.imagesNetError,width: Util.setWidth(215) as double?,height: Util.setWidth(141) as double?,),
              Padding(
                padding: EdgeInsets.only(top:Util.setWidth(30) as double,bottom: Util.setWidth(20) as double),
                child: Text("网络加载异常",style: TextStyle(fontSize: Util.setSP(16) as double?,color: AppColors.c_FF424966),),
              ),
              InkWell(
                onTap: (){
                  widget.reloadData!.call();
                },
                child: InkResponse(
                  child: Container(
                    width: Util.setWidth(150) as double?,
                    height: Util.setWidth(44) as double?,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: AppColors.THEME_COLOR,
                    ),
                    child: Center(
                      child: Text("重新加载",
                        style: TextStyle(fontSize: Util.setSP(16) as double?,color: AppColors.c_FFFFFFFF),),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: Util.setWidth(60) as double)),
            ],
          ),
        ),
    );

  }
}