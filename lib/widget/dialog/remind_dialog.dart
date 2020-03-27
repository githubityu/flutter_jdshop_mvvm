import 'package:flutter/material.dart';
import 'package:flutterjdshop/res/styles.dart';
import 'package:flutterjdshop/widget/view/base_dialog.dart';

class RemindDialog extends StatefulWidget {
  final String title;
  final String content;
  final Function confirmFunc;

  RemindDialog({
    Key key,
    this.title: "提示",
    this.content,
    this.confirmFunc,
  }) : super(key: key);

  @override
  _ExitDialog createState() => _ExitDialog();
}

class _ExitDialog extends State<RemindDialog> {
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(widget.content, style: TextStyles.textSize16),
      ),
      onPressed: widget.confirmFunc,
    );
  }
}
