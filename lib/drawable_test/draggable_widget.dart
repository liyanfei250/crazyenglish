import 'package:flutter/material.dart';


class DraggableWidget extends StatefulWidget {
  final Offset? offset;
  final Color widgetcolor;

  DraggableWidget({Key? key,this.offset,required this.widgetcolor}) : super(key: key);

  @override
  _DraggableWidgetState createState() {
    return _DraggableWidgetState();
  }
}

class _DraggableWidgetState extends State<DraggableWidget> {

  Offset offset=Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    offset =Offset(0.0, 0.0);
    if(widget.offset!=null){
      offset = widget.offset!;
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Draggable(
      data: widget.widgetcolor,
      child: Container(
        width: 100.0,
        height: 100.0,
        color: widget.widgetcolor,

      ),
      feedback: Container(
        width: 110.0,
        height: 110.0,
        color: widget.widgetcolor.withOpacity(0.5),
      ),
      onDraggableCanceled: (Velocity velocity, Offset offset){
        setState(() {
          this.offset=offset;
        });
      },
    );
  }
}