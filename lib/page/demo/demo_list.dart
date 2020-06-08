import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/provider/counter_provider.dart';
import 'package:flutterjdshop/routes/demo_router.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:provider/provider.dart';

class DemoListPage extends StatefulWidget {
  final Map<String, List<String>> address;

  const DemoListPage({Key key, this.address}) : super(key: key);

  @override
  _DemoListPageState createState() => _DemoListPageState();
}

class _DemoListPageState extends BasePageState<DemoListPage> {
  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "DemoList");
  }

  @override
  void subInitState() {}

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("barcode_scan"),
          subtitle: Text("扫描二维码功能测试"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.BARCODE);
          },
        ),
        ListTile(
          title: Text("ListView和TabBar"),
          subtitle: Text("Tab和滚动同步变化"),
          onTap: () {
            NavigatorUtils.push(context, ShopRouter.PRODUCT_CONTENT_2);
          },
        ),
        ListTile(
          title: Text("小demo"),
          subtitle: Text("不需要单独页面的demo"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMOSIMPLE);
          },
        ),
        ListTile(
          title: Text("监听隐藏显示键盘"),
          subtitle: Text("MediaQuery.of(context).viewInsets.bottom > 0"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMOKEYWORD);
          },
        ),
        ListTile(
          title: Text("分隔符学习"),
          subtitle: Text("Divider"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMODIVIDER);
          },
        ),
        ListTile(
          title: Text("CanvasPaintStudy"),
          subtitle: Text("画布api学习"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMOPAINTERSTUDY);
          },
        ),
        ListTile(
          title: Text("PATH学习"),
          subtitle: Text("PATHapi学习"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMOPATHSTUDY);
          },
        ),
        ListTile(
          title: Text("动画学习"),
          subtitle: Text("Tween AnimatedSwitcher ScaleTransition"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMO_ANIMATION);
          },
        ),
        ListTile(
          title: Text("动画学习2"),
          subtitle: Text("Tween ColorTween CurvedAnimation"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMO_ANIMATION_TWO);
          },
        ),
        ListTile(
          title: Text("动画学习3"),
          subtitle: Text("AnimatedBuilder AnimatedWidget"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMO_ANIMATION_THREE);
          },
        ),
        ListTile(
          title: Text("ai_progress学习"),
          subtitle: Text("AnimatedBuilder AnimatedWidget"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMO_AI_PROGRESS);
          },
        ),
        ListTile(
          title: Text("Overlay的使用方法 点击显示，点击其他部分隐藏"),
          subtitle: Text("Overlay OverlayEntry"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMO_OVERLAY);
          },
        ),
        ListTile(
          title: Selector(builder: (_, value, __) {
            return Text("Selector的使用方法$value");
          }, selector: (_, CounterProvider value) {
            return value.value;
          }),
          subtitle: Text("Selector ChangeNotifierProvider"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMO_SELECTOR);
          },
        ),
        ListTile(
          title: Text("localToGlobal的使用方法"),
          subtitle: Text("localToGlobal"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMO_LOCALTOGLOBAL);
          },
        ),
        ListTile(
          title: Text("InheritedWidget 数据共享"),
          subtitle: Text("InheritedWidget"),
          onTap: () {
            NavigatorUtils.push(context, DemoRouter.DEMO_INHERITEDWIDGET);
          },
        ),
      ],
    );
  }
}
