import 'package:flutterjdshop/local/local_exports.dart';
import 'package:flutter/material.dart';






class CustomToast extends StatelessWidget {
  final Color bgColor;

  const CustomToast(this.msg, {Key? key, this.bgColor = Colors.green})
      : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            left: 20, right: 20, top: Screens.topSafeHeight + 10, bottom: 10),
        color: bgColor,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          //icon
          Text(
            msg,
            style: const TextStyle(color: Colors.white),
          )
        ]),
      ),
    );
  }
}
