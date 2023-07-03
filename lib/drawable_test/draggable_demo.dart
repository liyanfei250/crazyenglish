import 'package:flutter/material.dart';
import 'draggable_widget.dart';


class DraggableDemo extends StatefulWidget {

  DraggableDemo({Key? key}) : super(key: key);

  @override
  _DraggableDemoState createState() {
    return _DraggableDemoState();
  }
}

class _DraggableDemoState extends State<DraggableDemo> {
   Color  _draggablecolor=Colors.grey;
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
         DraggableWidget(
           widgetcolor: Colors.tealAccent,
         ),
          DraggableWidget(
            widgetcolor: Colors.redAccent,
          ),
          Center(
            child: DragTarget(
              onAccept: (Color color){
                _draggablecolor=color;
              },
              builder: (context,candidateData,rejectedData){
                return Container(
                  width: 200,
                  height: 200,
                  color: _draggablecolor,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}