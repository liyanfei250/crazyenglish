import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import 'CartProvider.dart';
import 'cartNum.dart';

class CartItem extends StatefulWidget {
  CartItem({Key? key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 删除中间数据 _itemData 不会重新赋值，因为该initState不会被触发，但是build方法会重新触发
    // 也就是该页面_itemData仍为旧数据, 但是List数量删除后减少了，原来5条，删除中间2条后剩余3条，这样页面显示的是前面3条
    // 当重新运行的时候init执行获取数据，显示正确
    // this._itemData = widget._itemData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112.w,
      width: 347.w,
      padding: EdgeInsets.all(5),

      // 底部线条
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 2.0, color: Colors.black12))),

      // cell
      child: Row(
        children: <Widget>[
          // 单选框
          Container(
            width: 14.w,
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Checkbox(
              value: true,
              activeColor: Colors.pink,
              onChanged: (value) {
                setState(() {
                  // 改变了_itemData --》 改变了_cartList
                });
                // 判断是否全选
              },
            ),
          ),

          // 图片
          Container(
              width: 80.w,
              height: 80.w,
              color: Colors.red,
              child: Image.network(
                  "https://www.baidu.com/img/flexible/logo/pc/result.png",
                  fit: BoxFit.cover)),

          // 标题
          Expanded(
            // 浮动
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                // 上title 下detail
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // title
                  Text(
                    "英语周刊 年度订阅",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.c_FF101010,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  // attr
                  Row(
                    children: [
                      Expanded(
                          child: Text("已选：高考综合",
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppColors.c_FF585858,
                                  fontSize: 10.sp))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(),
                      )
                    ],
                  ),
                  // 左：￥12  右：+-
                  Stack(
                    children: <Widget>[
                      // ￥12
                      Align(
                          alignment: Alignment.centerRight,
                          child:
                              Text("￥100", style: TextStyle(color: Colors.red)))
                      // +-
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
