//四种视图状态
import 'package:crazyenglish/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MultiState { State_Success, State_Error, State_Loading, State_Empty }
//NeedWork 2020/12/16 此处需要后续操作：暂时不用，有问题
///根据不同状态来展示不同的视图
class MultiStateLayout extends StatefulWidget {
  final MultiState state; //页面状态
  final Widget? successWidget; //成功视图
  final VoidCallback? errorRetry; //错误事件处理
  final VoidCallback? emptyRetry; //空数据事件处理

  MultiStateLayout(
      {Key? key,
      this.state = MultiState.State_Loading, //默认为加载状态
      this.successWidget,
      this.errorRetry,
      this.emptyRetry})
      : super(key: key);

  @override
  _MultiStateLayoutState createState() => _MultiStateLayoutState();
}

class _MultiStateLayoutState extends State<MultiStateLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //宽高都充满屏幕剩余空间
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget,
    );
  }

  ///根据不同状态来显示不同的视图
  Widget? get _buildWidget {
    switch (widget.state) {
      case MultiState.State_Success:
        return widget.successWidget;
        break;
      case MultiState.State_Error:
        return _errorView;
        break;
      case MultiState.State_Loading:
        return _loadingView;
        break;
      case MultiState.State_Empty:
        return _emptyView;
        break;
      default:
        return null;
    }
  }

  ///加载中视图
  Widget get _loadingView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Colors.white,
      child: Container(
        height: 200,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              child: Image.asset('images/cargo_loading.gif'),
            ),
            Text(
              '拼命加载中...',
              style: TextStyle(
                  color: AppColors.c_FF424966,
                  fontSize: ScreenUtil().setSp(24)),
            )
          ],
        ),
      ),
    );
  }

  ///错误视图
  Widget get _errorView {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: InkWell(
          onTap: widget.errorRetry,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(405),
                height: ScreenUtil().setHeight(317),
                child: Image.asset('images/load_error.png'),
              ),
              Text(
                "加载失败，请轻触重试!",
                style: TextStyle(
                    color: AppColors.c_FF424966,
                    fontSize: ScreenUtil().setSp(24)),
              ),
            ],
          ),
        ));
  }

  ///错误视图
  Widget get _emptyView {
    return Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(750),
        height: double.infinity,
        child: InkWell(
          onTap: widget.emptyRetry,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(405),
                height: ScreenUtil().setHeight(281),
                child: Image.asset('images/no_data.png'),
              ),
              Text(
                '暂无相关数据,轻触重试~',
                style: TextStyle(
                    color: AppColors.c_FF424966,
                    fontSize: ScreenUtil().setSp(24)),
              )
            ],
          ),
        ));
  }
}
