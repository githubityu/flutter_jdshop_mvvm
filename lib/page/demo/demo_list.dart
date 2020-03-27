
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/routes/demo_router.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
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
    return CommonBackTopBar(
      title: "DemoList"
    );
  }



  @override
  void subInitState() {

  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("barcode_scan"),
          subtitle: Text("扫描二维码功能测试"),
          onTap: (){
             NavigatorUtils.push(context, DemoRouter.BARCODE);
          },
        ),
        ListTile(
          title: Text("ListView和TabBar"),
          subtitle: Text("Tab和滚动同步变化"),
          onTap: (){
            NavigatorUtils.push(context, ShopRouter.PRODUCT_CONTENT_2);
          },
        )
      ],
    );
  }

}
