import 'package:flutter/material.dart';

class MyImageLoader extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Widget placeholder;

  MyImageLoader({required this.imageUrl, required this.width, required this.height, required this.placeholder});

  @override
  _MyImageLoaderState createState() => _MyImageLoaderState();
}

class _MyImageLoaderState extends State<MyImageLoader> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      await precacheImage(NetworkImage(widget.imageUrl), context);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_isError) {
      return widget.placeholder;
    } else {
      return Image.network(
        widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
      );
    }
  }
}
