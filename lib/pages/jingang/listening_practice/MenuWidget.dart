import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../base/AppUtil.dart';
import '../../../r.dart';

//筛选控件
class MenuWidget extends StatefulWidget {
  final String title;
  final List<String> items;
  final void Function(int) onSelected;

  const MenuWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w, bottom: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10.w),
            bottomLeft: Radius.circular(10.w)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 3),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isOpen = !_isOpen;
              });
              if (_isOpen) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xff353e4d),
                  ),
                ),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
                Expanded(child: Text('')),
                SizedBox(
                  width: 4.w,
                )
              ],
            ),
          ),
          SizeTransition(
            axisAlignment: -1.0,
            sizeFactor: _animation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25.w,
                  width: MediaQuery.of(context).size.width / 4,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 12.w, top: 18.w),
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f6f9),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = -1;
                        _isOpen = false;
                      });
                      _controller.forward();
                      widget.onSelected(-1);
                    },
                    child: Text(
                      '全部分类',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color:
                            _selectedIndex == -1 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 18.w,
                    runSpacing: 4.w,
                    children: List.generate(
                      widget.items.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                            _isOpen = false;
                          });
                          _controller.forward();
                          widget.onSelected(index);
                        },
                        child: Container(
                          height: 25.w,
                          width: MediaQuery.of(context).size.width / 4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xfff5f6f9),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            widget.items[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: _selectedIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
