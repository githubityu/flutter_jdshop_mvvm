import 'package:flutterjdshop/exports.dart';
import 'package:flutterjdshop/util/extension/build_context_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils{


 static  Future<bool?> showTipsDialog(
      BuildContext context,
      String content, {
        String? title,
        String left = '取消',
        String right = '确定',
        bool singleBtn = false,
      }) async {
    return await showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Theme(
            data: context.theme.copyWith(
                colorScheme: const ColorScheme.light(primary: Colors.black)),
            child: CupertinoAlertDialog(
              title: title == null ? null : Text(title),
              content: Text(content),
              actions: [
                if (!singleBtn)
                  CupertinoDialogAction(
                      child:
                      Text(left, style: const TextStyle(color: Colors.white)),
                      onPressed: () => Navigator.of(context).pop(false)),
                CupertinoDialogAction(
                    child:
                    Text(right, style: const TextStyle(color: Colors.white)),
                    onPressed: () => Navigator.of(context).pop(true)),
              ],
            ),
          );
        });
  }

}