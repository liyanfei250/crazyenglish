import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShareScreen extends StatelessWidget {
  final Uint8List imageBytes;

  ShareScreen({required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: MemoryImage(imageBytes),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40.w,
            right: 40.w,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 20.w,
            left: 20.w,
            right: 20.w,
            child: Container(
              width: double.infinity,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}