import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterjdshop/common/shared_util.dart';
import 'package:flutterjdshop/config/api.dart';
import 'package:crypto/crypto.dart';
import 'package:flutterjdshop/utils/app_size.dart';

String getSafeData(String data) {
  return data ?? "";
}

Widget hideKeyword(Widget child, BuildContext context) {
  return GestureDetector(

      ///透明也响应处理
      behavior: HitTestBehavior.opaque,
      child: child,
      onTap: () {
        FocusScope.of(context).unfocus();
      });
}

//显示键盘
void showKeyword(BuildContext context, FocusNode _focusNode) {
  if (MediaQuery.of(context).viewInsets.bottom == 0) {
    final focusScope = FocusScope.of(context);
    focusScope.requestFocus(FocusNode());
    Future.delayed(Duration.zero, () => focusScope.requestFocus(_focusNode));
  }
}

//隐藏键盘
void hideKeyword2(BuildContext context) {
  FocusScope.of(context).unfocus();
}

String getFullPath(String path) {
  path = path.replaceAll('\\', '/').replaceAll('api/', '');
  return !path.startsWith('http') ? "${API.baseUrl}$path" : path;
}

String getSign(json) {
  List attrKeys = json.keys.toList();
  attrKeys.sort(); //排序  ASCII 字符顺序进行升序排列
  String str = '';
  for (var i = 0; i < attrKeys.length; i++) {
    str += "${attrKeys[i]}${json[attrKeys[i]]}";
  }
  return md5.convert(utf8.encode(str)).toString();
}

String getStrByKey(String key) {
  return getSafeData(SharedUtil.instance.getString(key));
}

Future saveStrByKey(String key, String data) async {
  await SharedUtil.instance.saveString(key, data);
}


double getY(BuildContext buildContext) {
  final RenderBox box = buildContext.findRenderObject();
  final size = box.size;
  ////代表的意思是说 button 组件中（0，0）点转换成全屏幕上的点的坐标值
  final topLeftPosition = box.localToGlobal(Offset.zero);
  return topLeftPosition.dy;
}


void get(){
//  FileImage(file).resolve(config)
}


