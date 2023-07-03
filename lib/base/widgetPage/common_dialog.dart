import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        // _buildCupertinoAlertDialog(context),
      ],
    );
  }

  Widget _buildRaisedButton(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      foregroundColor: Colors.blue,
    ),

    onPressed: () {
      showDialog(
          context: context,
          builder: (ctx) => buildCupertinoAlertDialog(context));
    },
    child: Text(
      'Just Show It !',
      style: TextStyle(color: Colors.white),
    ),
  );

  Widget buildCupertinoAlertDialog(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CupertinoAlertDialog(
          title: _buildTitle(context),
          content: _buildContent(),
          actions: <Widget>[
            CupertinoButton(
              child: Text("Yes, Delete"),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoButton(
              child: Text("Cancle"),
              onPressed: () => Navigator.pop(context),
            ),
          ]),
    );
  }

  Widget _buildTitle(context) {
    return Row(
      //标题
        children: <Widget>[
          Icon(
            CupertinoIcons.delete_solid,
            color: Colors.red,
          ),
          Expanded(
              child: Text(
                'Delete File',
                style: TextStyle(color: Colors.red, fontSize: 20),
              )),
          InkWell(
            child: Icon(CupertinoIcons.clear_thick),
            onTap: () => Navigator.pop(context),
          )
        ]);
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: <Widget>[
          Text(
            '    Hi toly! If you push the conform buttom ,'
                ' You will lose this file. Are you sure wand to do that?',
            style: TextStyle(color: Color(0xff999999), fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}