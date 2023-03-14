import 'package:flutterjdshop/local/local_exports.dart';
import 'package:flutterjdshop/widget/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

final inputFormatters = [
  FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z]'))
];
final inputDenyZHFormatters = [
  FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))
];
final inputNumberFormatters = [
  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
];
final inputEmailFormatters = [
  FilteringTextInputFormatter.allow(RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
];

class Utils {
  static void showToast(String content,
      {backgroundColor = Colors.white, textColor = Colors.black}) {
    SmartDialog.showToast(content, alignment: Alignment.bottomCenter);
  }

  static void showCustomToast(String content,
      {backgroundColor = Colors.green, textColor = Colors.black}) {
    SmartDialog.showToast('',
        builder: (_) => CustomToast(content, bgColor: backgroundColor));
  }

  static void showInSnackBar(BuildContext context, Widget child,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: backgroundColor,
        content: child,
      ),
    );
  }

  static int getSafeLength(dynamic data) {
    return data == null ? 0 : data.length;
  }

  static bool getSafeBool(dynamic data) {
    return data ?? false;
  }

  static bool getSafeIsEmpty(dynamic data) {
    return (data == null ? 0 : data.length) == 0;
  }

  static double getTextWidth(String text, TextStyle textStyle) {
    TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: text, style: textStyle))
      ..layout(maxWidth: Screens.width);
    return textPainter.width;
  }
  static void copyText(String content) {
    Clipboard.setData(ClipboardData(text: content));
  }

  static void popExt(BuildContext context, Future future, [bool mounted = true]) async {
    await future;
    if (!mounted) return;
    Navigator.pop(context);
  }
}
