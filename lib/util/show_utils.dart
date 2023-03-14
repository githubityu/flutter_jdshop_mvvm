import 'dart:math';
import 'dart:math' as math;

import 'package:decimal/decimal.dart';
import 'package:flutterjdshop/local/constants.dart';
import 'package:flutterjdshop/providers/providers.dart';
import 'package:flutterjdshop/util/extension/build_context_ext.dart';
import 'package:flutter/material.dart';

import 'local_data_util.dart';

class ShowUtils {
  static void setLanguage({String? type}) {
    putString('localChange', type ?? LanguageType.ZH_TYPE.type);
  }

  static ThemeMode setTheme({bool isDark = false}) {
    putInt(Constants.theme, isDark ? 1 : 0);
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }
  static String getLockNum() {
    return getString(pinCodeTemporary);
  }
  static void setLockNum(String lockNum) {
    return putString(pinCodeTemporary,lockNum);
  }

  static String showSafeString(String? data) {
    return data ?? '';
  }

  static List<int> getVerifyNumS() {
    List<int> resultList = [];
    var rng = Random();
    int count = 0;
    while (count < 5) {
      //生成6个
      int index = rng.nextInt(24) + 1; // 1-12之间区间
      if (!resultList.contains(index)) {
        resultList.add(index);
        count++;
      }
    }
    resultList.sort();
    return resultList;
  }

  static double showFilBalance(String? data) {
    if (data == null) return 0;
    final d = Decimal.parse(data) / getPow();
    return d.toDouble();
  }

  static Decimal getPow({int num = 18}) {
    return Decimal.fromBigInt(BigInt.from(math.pow(10, num)));
  }



  static String formatDecimal(Decimal decimal,
      {int scale = 6, String unit = 'FIL'}) {
    return '${decimal.floor(scale: scale).toString()}$unit';
  }

  static String showFormatFilBalance(String? data) {
    if (data == null) return '';
    final d = (Decimal.parse(data) /
            Decimal.fromBigInt(BigInt.from(math.pow(10, 18))))
        .toDecimal()
        .toStringAsFixed(6);
    return '${Decimal.parse(d).toString()} FIL';
  }

  static String showHideMiddle(String? data) {
    if (data == null) return '';
    if (data.length > 30) {
      final start = data.substring(0, 15);
      final end = data.substring(data.length - 15, data.length);
      return '$start...$end';
    }
    return data;
  }
}
