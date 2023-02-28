import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../r.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 11.w, left: 14.w, right: 14.w),
      padding: EdgeInsets.only(top: 17.w, bottom: 17.w, left: 16.w, right: 16.w),

      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.c_0FA50D1A.withOpacity(0.05), // 阴影的颜色
              offset: Offset(10, 20), // 阴影与容器的距离
              blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 0,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(6.w)),
          color: AppColors.c_FFFFFFFF),

      // cell
      child: Row(
        children: <Widget>[
          // 单选框
          Container(
            width: 14.w,
            margin: EdgeInsets.only(right: 12.w),
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

          ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                R.imagesShopImageLogoTest,
                width: 80.w,
                height: 80.w,
              )),
          // 标题
          Expanded(
            // 浮动
            flex: 1,
            child: Container(
              height: 80.w,
              padding: EdgeInsets.only(left: 16.w, ),
              child: Column(
                // 上title 下detail
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "英语周刊 年度订阅",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xff151619),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "¥ 199.00",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xff1b1d2c),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),

                    ],
                  ),

                  // attr
                  Row(
                    children: [
                      Expanded(
                          child: Text("已选：高考综合",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Color(0xff8a9098),
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
