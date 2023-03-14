import 'package:flutterjdshop/exports.dart';
import 'package:flutterjdshop/util/extension/log_extensions.dart';
import 'package:flutter/material.dart';

import '../local/local_exports.dart';
import '../theme/app_theme.dart';
import '../util/local_data_util.dart';

///读取属性
///展示数据用watch
///修改用read.notifier
//

enum LanguageType {
  ZH_TYPE('zh'),
  EN_TYPE('en'),
  JP_TYPE('ja');
  final String type;
  const LanguageType(this.type);
}

final localChange = StateProvider((ref)=>Locale(getString('localChange', defaultValue: LanguageType.ZH_TYPE.type)));
final getBalancePriceProvider = StateProvider((ref)=>false);

final appThemeModeProvider = StateProvider(
  (ref) => getInt(Constants.appTheme) == 0 ? ThemeMode.light : ThemeMode.dark,
);

final keyWordProvider = StateProvider.autoDispose((ref) => '');

//
final appThemeProvider = Provider<ThemeData>(
  (ref) {
    final mode = ref.watch(appThemeModeProvider);
    switch (mode) {
      case ThemeMode.dark:
        return AppTheme.darkThemeData;
      case ThemeMode.light:
      default:
        return AppTheme.darkThemeData;
    }
  },
);
