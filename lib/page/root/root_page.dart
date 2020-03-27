import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/page/cart/cart_page.dart';
import 'package:flutterjdshop/page/category/category_page.dart';
import 'package:flutterjdshop/page/home/home_page.dart';
import 'package:flutterjdshop/page/user/user_page.dart';
import 'package:flutterjdshop/utils/double_tap_back_exit_app.dart';
import 'package:flutterjdshop/widget/root_tabbar.dart';



class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  DateTime lastPopTime;

  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  /// 检查更新 [check update]
  checkVersion() async {
//    if (Platform.isIOS) return;
//
//    final packageInfo = await PackageInfo.fromPlatform();
//
//    VersionModel model = await versionViewModel.getData();
//
//    int currentVersion = int.parse(removeDot(packageInfo.version));
//
//    int netVersion = int.parse(removeDot(model.appVersion));
//
//    if (currentVersion >= netVersion) {
//      debugPrint('当前版本是最新版本');
//      return;
//    }
//
//    showDialog(
//      context: context,
//      builder: (ctx2) {
//        return UpdateDialog(
//          version: model.appVersion,
//          updateUrl: model.downloadUrl,
//          updateInfo: model.updateInfo,
//          isForce: model.force,
//        );
//      },
//    );
  }

  @override
  Widget build(BuildContext context) {
    List<TabBarModel> pages = <TabBarModel>[
      new TabBarModel(
        title: '首页',
        icon: Icon(Icons.home),
        page: HomePage(),
      ),
      new TabBarModel(
        title: '分类',
        icon: Icon(Icons.search),
        page: CategoryPage(),
      ),
      new TabBarModel(
        title: '购物车',
        icon: Icon(Icons.shopping_cart),
        page: CartPage(),
      ),
      new TabBarModel(
        title: '我的',
        icon: Icon(Icons.people),
        page: UserPage(),
      ),
    ];
    return DoubleTapBackExitApp(
      child: RootTabBar(pages: pages, currentIndex: 0),
    );
    return new RootTabBar(pages: pages, currentIndex: 0);
  }
}
