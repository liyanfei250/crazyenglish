import 'package:flutter/material.dart';

import '../../r.dart';

class EmptyWidget extends StatefulWidget {
  late String text;
  EmptyWidget(this.text,{Key? key}) : super(key: key);

  @override
  _EmptyWidgetState createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(R.imagesPicEmptyNoData,width: 200,),
          Text(widget.text?? "暂无数据")
        ],
      ),
    );
  }
}