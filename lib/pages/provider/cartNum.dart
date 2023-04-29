import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'CartProvider.dart';

class CartNum extends StatefulWidget {
  CartNum({Key? key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  late CartProvider _cartProvider;
  int? selectNum = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //左侧按钮
    Widget _leftBtn() {
      return InkWell(
        onTap: () {
          if (selectNum! > 1) {
            // 数据不是直接绑定在provider
            selectNum! - 1;
            // 但没有存储到本地，重新运行后值还是以前的
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 19.w,
          height: 19.w,
          child: Text("-"),
        ),
      );
    }

    //右侧按钮
    Widget _rightBtn() {
      return InkWell(
        onTap: () {
          // 改变了_cartList的值
          selectNum! + 1;
          // 但没有存储到本地，重新运行后值还是以前的
          this._cartProvider.itemCountChange();
        },
        child: Container(
          alignment: Alignment.center,
          width: 19.w,
          height: 19.w,
          child: Text("+"),
        ),
      );
    }

    Widget _centerArea() {
      return Container(
        alignment: Alignment.center,
        width: 24.w,
        decoration: BoxDecoration(
            border: Border(
          left: BorderSide(width: 2.0, color: Colors.black12),
          right: BorderSide(width: 2.0, color: Colors.black12),
        )),
        height: 19.w,
        child: Text("45"),
      );
    }

    return Container(
      width: 70.w,
      height: 20.w,
      decoration:
          BoxDecoration(border: Border.all(width: 2.0, color: Colors.black12)),
      child: Row(
        children: <Widget>[_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }
}
