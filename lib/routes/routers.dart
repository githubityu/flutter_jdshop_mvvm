
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/page/splash_page.dart';
import 'package:flutterjdshop/page/web_page.dart';
import 'package:flutterjdshop/routes/demo_router.dart';
import 'package:flutterjdshop/routes/router_init.dart';

import '404.dart';
import 'shop_router.dart';


class Routes {

  static String home = '/';
  static String webViewPage = '/webview';

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        debugPrint('未找到目标页');
        return WidgetNotFound();
      });

    router.define(home, handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => SplashPage()));
    
    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));
    
    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(ShopRouter());
    _listRouter.add(DemoRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
