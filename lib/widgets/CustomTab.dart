import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTab extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CustomTab({required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : null,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Color(0xffffbc00) : Colors.grey)),
      ),
    );
  }
}
