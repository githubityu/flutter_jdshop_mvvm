import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  static void init(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }

  static double height(double value) {
    return ScreenUtil.getInstance().setHeight(value);
  }

  static double getItemWidth(int number, double padding) {
    return (ScreenUtil.screenWidthDp - padding) / number;
  }
  static double getWidth() {
    return ScreenUtil.screenWidthDp;
  }
  static double width(double value) {
    return ScreenUtil.getInstance().setWidth(value);
  }
  static double sp(double value) {
    return ScreenUtil.getInstance().setSp(value);
  }
}
