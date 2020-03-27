import 'package:fluro/fluro.dart';
import 'package:flutterjdshop/page/demo/demo_list.dart';
import 'package:flutterjdshop/page/demo/flutter_barcode.dart';
import 'package:flutterjdshop/page/guide_page.dart';
import 'package:flutterjdshop/page/home/ProductList.dart';
import 'package:flutterjdshop/page/home/product_detail.dart';
import 'package:flutterjdshop/page/home/product_detail2.dart';
import 'package:flutterjdshop/page/home/product_detail3.dart';
import 'package:flutterjdshop/page/root/root_page.dart';
import 'package:flutterjdshop/page/user/address/address_add_edit.dart';
import 'package:flutterjdshop/page/user/address/address_list.dart';
import 'package:flutterjdshop/page/user/loginregister/login.dart';
import 'package:flutterjdshop/page/user/loginregister/register_first.dart';
import 'package:flutterjdshop/page/user/loginregister/register_second.dart';
import 'package:flutterjdshop/page/user/loginregister/register_third.dart';
import 'package:flutterjdshop/page/user/order/CheckOut.dart';
import 'package:flutterjdshop/page/user/order/Order.dart';
import 'package:flutterjdshop/page/user/order/OrderInfo.dart';
import 'package:flutterjdshop/page/user/order/Pay.dart';
import 'package:flutterjdshop/page/user/order/Search.dart';
import 'package:flutterjdshop/routes/router_init.dart';

class DemoRouter implements IRouterProvider {
  // details
  static const BARCODE = '/barcode';
  static const DEMOLIST = '/demo_list';

  @override
  void initRouter(Router router) {
    router.define(BARCODE,
        handler: Handler(handlerFunc: (context, params) => BracodePage()));
    router.define(DEMOLIST,
        handler: Handler(handlerFunc: (context, params) => DemoListPage()));
  }
}