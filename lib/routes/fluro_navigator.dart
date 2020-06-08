import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/routes/my_navigator_observer.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:rxdart/rxdart.dart';

import 'application.dart';
import 'routers.dart';

/// fluro的路由跳转工具类
class NavigatorUtils {
  static initRouter() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  static pops(BuildContext context, List<String> names) {
    names.forEach((f) {
      Navigator.of(context).popUntil(ModalRoute.withName(f));
    });
  }

  static push(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Map<String, dynamic> params}) {
    FocusScope.of(context).unfocus();
    Observable.just(1).delay(Duration(milliseconds: 100)).listen((onData) {
      Application.router.navigateTo(
          context, navigateToReplace(path, params: params),
          replace: replace,
          clearStack: clearStack,
          transition: TransitionType.native);
    });
  }

  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false,
      bool clearStack = false,
      Map<String, dynamic> params}) {
    FocusScope.of(context).unfocus();
    Observable.just(1).delay(Duration(milliseconds: 100)).listen((onData) {
      Application.router
          .navigateTo(context, navigateToReplace(path, params: params),
              replace: replace,
              clearStack: clearStack,
              transition: TransitionType.native)
          .then((result) {
        // 页面返回result为null
        if (result == null) {
          return;
        }
        function(result);
      }).catchError((error) {
        print('$error');
      });
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    pop(context, isPop: false);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    pop(context, result: result);
  }

  static void pop<T>(BuildContext context, {T result, isPop = true}) {
    FocusScope.of(context).unfocus();
    if (isPop == true) {
      Navigator.pop(context, result);
    } else {
      Navigator.maybePop(context, result);
    }
  }

  /// 跳到WebView页
  static goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持传中文,需转换
    push(context, Routes.webViewPage, params: {"title": title, "url": url});
  }

  static goRootPage(BuildContext context) {
    //fluro 不支持传中文,需转换
    push(context, ShopRouter.ROOT_PAGE, replace: true);
  }

  static bool isLogin(context) {
    if (!UserInfoData.instance.isLogin) {
      //push(context, ShopRouter.login_page);
      return false;
    }
    return true;
  }

  ///Route<dynamic> route
  static removeRouteByName(context, String routeName) {
    var route = getRouteByName(routeName);
    if (route != null) {
      Navigator.removeRoute(context, route);
      MyNavigatorObserver.getInstance().list.remove(route);
    }
  }

  static Route<dynamic> getRouteByName(String routeName) {
    var firstWhere = MyNavigatorObserver.getInstance()
        .list
        .firstWhere((element) => element.settings.name == routeName);
    return firstWhere;
  }

  static String navigateToReplace(String path, {Map<String, dynamic> params}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
//    print('我是navigateTo传递的参数：$query');
    return path = path + query;
  }
}
