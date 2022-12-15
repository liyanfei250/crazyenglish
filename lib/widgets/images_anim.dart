import 'package:flutter/cupertino.dart';



class ImagesAnim extends StatefulWidget {
  final Map<int, Image> imageCaches;
  final double width;
  final double height;
  final Color backColor;
  final int? milliseconds;

  ImagesAnim(this.imageCaches, this.width, this.height, this.backColor, {Key? key,this.milliseconds})
      : assert(imageCaches != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _WOActionImageState();
  }
}

class _WOActionImageState extends State<ImagesAnim> {
  late bool _disposed;
  late Duration _duration;
  late int _imageIndex;
  late Container _container;

  @override
  void initState() {
    super.initState();
    _disposed = false;
    _duration = Duration(milliseconds: widget.milliseconds!);
    _imageIndex = 1;
    _container = Container(height: widget.height, width: widget.width);
    _updateImage();
  }

  void _updateImage() {
    if (_disposed || widget.imageCaches.isEmpty) {
      return;
    }

    setState(() {
      if (_imageIndex > widget.imageCaches.length) {
        _imageIndex = 1;
      }
      _container = Container(
          color: widget.backColor,
          child: widget.imageCaches[_imageIndex],
          height: widget.height,
          width: widget.width);
      _imageIndex++;
    });
    Future.delayed(_duration, () {
      _updateImage();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    widget.imageCaches.clear();
  }

  @override
  Widget build(BuildContext context) {
    return _container;
  }
}