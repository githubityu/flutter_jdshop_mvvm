import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterjdshop/utils/app_size.dart';

import 'dimens.dart';


/// 间隔
class Gaps {


  static Widget getGaps(double number,{bool isHorizontal = true}){
    return isHorizontal?SizedBox(height:AppSize.height(number) ):SizedBox(width: AppSize.width(number));
  }


  /// 水平间隔
  static const Widget hGap4 = const SizedBox(width: Dimens.dp_4);
  static const Widget hGap5 = const SizedBox(width: Dimens.dp_5);
  static const Widget hGap8 = const SizedBox(width: Dimens.dp_8);
  static const Widget hGap10 = const SizedBox(width: Dimens.dp_10);
  static const Widget hGap12 = const SizedBox(width: Dimens.dp_12);
  static const Widget hGap15 = const SizedBox(width: Dimens.dp_15);
  static const Widget hGap16 = const SizedBox(width: Dimens.dp_16);
  static const Widget hGap30 = const SizedBox(width: Dimens.dp_30);
  static const Widget hGap20 = const SizedBox(width: Dimens.dp_20);
  static const Widget hGap50 = const SizedBox(width: Dimens.dp_50);
  /// 垂直间隔
  static const Widget vGap4 = const SizedBox(height: Dimens.dp_4);
  static const Widget vGap5 = const SizedBox(height: Dimens.dp_5);
  static const Widget vGap8 = const SizedBox(height: Dimens.dp_8);
  static const Widget vGap10 = const SizedBox(height: Dimens.dp_10);
  static const Widget vGap12 = const SizedBox(height: Dimens.dp_12);
  static const Widget vGap15 = const SizedBox(height: Dimens.dp_15);
  static const Widget vGap16 = const SizedBox(height: Dimens.dp_16);
  static const Widget vGap20 = const SizedBox(height: Dimens.dp_20);
  static const Widget vGap50 = const SizedBox(height: Dimens.dp_50);
  
//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static Widget line = const Divider();

  static Widget vLine = const SizedBox(
    width: 0.6,
    height: 24.0,
    child: const VerticalDivider(),
  );
  
  static const Widget empty = const SizedBox.shrink();
}
