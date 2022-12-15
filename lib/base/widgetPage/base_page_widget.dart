import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crazyenglish/base/widgetPage/dialog_manager.dart';
import 'package:crazyenglish/utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../blocs/login_change_bloc.dart';
import '../../blocs/login_change_state.dart';
import 'empty.dart';
import 'error.dart';
import 'loading.dart';

/**
 * Time: 2021/8/29 10:19 上午
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

abstract class BasePage extends StatefulWidget {

  const BasePage({Key? key}) : super(key: key);

  @override
  BasePageState createState() => getState();

  BasePageState getState();
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  String curPage = "";
  String tag = "BasePageState_";
  bool isLogin = Util.isLogin();
  CancelFunc? _cancelLoading;
  @override
  void initState(){
      super.initState();
      if(isRegisterLoginListener()){
        registerLoginChangeListener();
      }
      onCreate();
      tag = tag+curPage;
      print(tag + "initState\n");
  }

  bool isRegisterLoginListener(){
    return true;
  }

  // 不监听登录状态页面可以
  void registerLoginChangeListener(){
    BlocProvider.of<LoginChangeBloc>(context).stream.listen((event) {
      if(event is LoginChangeSuccess){
        loginChanged();
      }
    });
  }

  void loginChanged(){

  }


  @override
  bool get mounted {
    print(tag + "mounted\n");
    return super.mounted;
  }

  void showLoading(String text){
    if(text == null || text.isEmpty){
      text = "";
    }
    if(_cancelLoading!=null){
      _cancelLoading!();
    }
    _cancelLoading = BotToast.showLoading();
  }

  void hideLoading(){
    if(_cancelLoading!=null){
      _cancelLoading!();
    }
  }

  Widget buildLoadingWidget(){
    return LoadingWidget();
  }

  Widget buildErrorWidget(String emptyText){
    return CustomErrorWidget(
        reloadData:(){
          reLoadingData();
        });
  }

  Widget buildEmptyWidget(String emptyText){
    return EmptyWidget(emptyText);
  }

  Widget buildBackWidget(BuildContext context){
    return Util.buildBackWidget(context);
  }

  num buildBackWidgetWidth(){
    return Util.buildBackWidgetWidth();
  }

  // 加载失败 点击重试的代码
  void reLoadingData(){

  }


  void onCreate();

  void onDestroy();

  @override
  void didUpdateWidget(T oldWidget) {
    print(tag + "didUpdateWidget\n");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    print(tag + "reassemble\n");
    super.reassemble();
  }

  @override
  void deactivate() {
    print(tag + "deactivate\n");
    super.deactivate();
  }

  @override
  void dispose() {
    hideLoading();
    print(tag + "dispose\n");
    onDestroy();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print(tag + "didChangeDependencies\n");
    super.didChangeDependencies();
  }
}
