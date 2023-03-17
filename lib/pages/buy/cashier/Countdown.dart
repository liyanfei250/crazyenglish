import 'dart:async';
import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  final int seconds;
  Countdown({Key? key, required this.seconds}) : super(key: key);

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late Timer _timer;
  late int _seconds;

  @override
  void initState() {
    super.initState();
    _seconds = widget.seconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTimeContainer('${_seconds ~/ 60}'.padLeft(2, '0')),
          _buildTimeContainer('${_seconds % 60}'.padLeft(2, '0')),
        ],
      ),
    );
  }

  Widget _buildTimeContainer(String time) {
    return Row(
      children: [
        _buildDigitContainer(time[0]),
        _buildDigitContainer(time[1]),
      ],
    );
  }

  Widget _buildDigitContainer(String digit) {
    return Container(
      width: 16,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          digit,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
