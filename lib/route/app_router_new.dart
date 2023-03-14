
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutterjdshop/ui/home_page.dart';
import 'package:flutterjdshop/ui/splash_page.dart';
import 'package:go_router/go_router.dart';

///search_page删除跳转
class RoutePath {
  RoutePath._();

  static const String splash = '/splash';
  static const String createOrImport = '/CreateOrImport';
  static const String createWallet = '/CreateWallet';
  static const String importWallet = '/ImportWallet';
  static const String importWalletStyle = '/ImportWalletStyle';
  static const String backupMnemonics = '/BackupMnemonics';
  static const String verifyMnemonics = '/VerifyMnemonics';
  static const String webPage = '/WebPage';
  static const String homePage = '/HomePage';
  static const String transferPage = '/TransferPage';
  static const String receivePage = '/ReceivePage';
  static const String scanPage = '/ScanPage';

  static const List<String> needLoginPages = [];
}

final GoRouter goRouter = GoRouter(
    observers: [
      FlutterSmartDialog.observer
    ],
    routes: [
      GoRoute(
          path: RoutePath.splash,
          builder: (context, state) {
            return  const SplashPage();
          }),
      GoRoute(
          path: RoutePath.homePage,
          builder: (context, state) {
            return const HomePage();
          }),
    ],
    redirect: (context, state) async {
      // bool isLogin = UserinfoData.instance.isLogin;
      // if (!isLogin && RoutePath.needLoginPages.contains(state.subloc)) {
      //   return RoutePath.login;
      // }
    },
    debugLogDiagnostics: true,
    initialLocation: RoutePath.splash);
