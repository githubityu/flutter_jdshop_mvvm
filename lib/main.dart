import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterjdshop/util/extension/log_extensions.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'exports.dart';
import 'hook/use_router.dart';
import 'providers/providers.dart';
import 'theme/theme_exports.dart';
import 'util/local_data_util.dart';

Future<void> main() async {
  await initLocalData();
  if (kReleaseMode) {
    debugPrint = (message, {wrapWidth}) {};
  }
  //InAppWebView使用
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark));
  if (kIsWeb) {
    // Increase Skia cache size to support bigger images.
    const int megabyte = 1000000;
    SystemChannels.skia
        .invokeMethod('Skia.setResourceCacheMaxBytes', 512 * megabyte);
    await Future<void>.delayed(Duration.zero);
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  PaintingBinding.instance?.imageCache?.maximumSize = 1000000; // 2000 entries
  PaintingBinding.instance?.imageCache?.maximumSizeBytes = 300 << 20; //
  runZonedGuarded(() {
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stackTrace) {
    '$stackTrace $error'.log();
  });
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final appRouter = userAppRouter();
    return MaterialApp.router(
      theme: theme,
      darkTheme: AppTheme.darkThemeData,
      themeMode: themeMode,
      title: 'FilWallet',
      builder: FlutterSmartDialog.init(),
      locale: ref.watch(localChange),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ja'),
        Locale('zh')
      ],
      routerConfig: appRouter,
    );
  }
}

