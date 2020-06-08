import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/page/splash_page.dart';
import 'package:flutterjdshop/provider/Cart.dart';
import 'package:flutterjdshop/provider/CheckOut.dart';
import 'package:flutterjdshop/provider/counter_provider.dart';
import 'package:flutterjdshop/provider/order_page_provider.dart';
import 'package:flutterjdshop/provider/theme_provider.dart';
import 'package:flutterjdshop/routes/application.dart';
import 'package:flutterjdshop/routes/my_navigator_observer.dart';
import 'package:provider/provider.dart';


import 'config/storage_manager.dart';
import 'routes/fluro_navigator.dart';
import 'utils/log_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
}

class MyApp extends StatelessWidget {
  final Widget home;
  final ThemeData theme;
  MyApp({this.home, this.theme}) {
    Log.init();
    NavigatorUtils.initRouter();
    UserInfoData.instance.getUserInfo;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => CheckOut()),
        ChangeNotifierProvider(create: (_) => OrderPageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            //        debugShowCheckedModeBanner: false,
            home: home ?? SplashPage(),
            navigatorKey: Application.navKey,
            onGenerateRoute: Application.router.generator,
            theme: theme??provider.getTheme(),
            darkTheme: provider.getTheme(isDarkMode: true),
            themeMode: provider.getThemeMode(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            navigatorObservers: [
              MyNavigatorObserver.getInstance()
            ],
            supportedLocales: const [Locale('zh', 'CH'), Locale('en', 'US')],
            builder: (context, child) {
              /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
                child: child,
              );
            },
          );
        },
      ),
    );
  }
}
