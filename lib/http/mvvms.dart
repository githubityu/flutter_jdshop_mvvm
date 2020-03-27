import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class IMvvmView {
  BuildContext getContext();

  /// 显示Progress
  void showProgress();

  /// 关闭Progress
  void closeProgress();

  /// 展示Toast
  void showToast(String string);
}
