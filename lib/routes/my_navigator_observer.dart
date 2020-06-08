import 'package:flutter/material.dart';

/// 记录路由，便于清空路由栈
/// 可以跳转不需要context
///  pop指定页面
/// MyNavigatorObserver.getInstance().navigator.pushNamed("/login");
///  MyNavigatorObserver.getInstance().list.forEach((element) {
///                  Navigator.removeRoute(context, element);
///               });
///               MyNavigatorObserver.getInstance().list = [];
class MyNavigatorObserver extends NavigatorObserver {
  //清空某些页面
  List<Route<dynamic>> list = [];
  static MyNavigatorObserver _instance;

  static MyNavigatorObserver getInstance() {
    if (_instance == null) {
      _instance = MyNavigatorObserver();
    }
    return _instance;
  }

  ///调用push的时候
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    /// 首页不添加
    //路由名字
    print("didPushname${route.settings.name}");
    if (route.settings.name != '/') {
      list.add(route);
      print(list.length);
    }
  }

  ///调用pop的时候
  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print("didPop${route.settings.name}");
    list.remove(route);
    print(list.length);
  }
}
