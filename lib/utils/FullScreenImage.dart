import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  final File? imageFile;

  const FullScreenImage({Key? key, this.imageFile}) : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  double _scale = 1.0;
  late Offset _position;

  @override
  void initState() {
    super.initState();
    _position = Offset.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onScaleUpdate: (details) {
          setState(() {
            _scale = details.scale;
            _position += details.focalPoint - details.localFocalPoint;
          });
        },
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: 'imageHero',
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(_position.dx, _position.dy)
                    ..scale(_scale),
                  child: Image.file(
                    File(widget.imageFile!.path),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
