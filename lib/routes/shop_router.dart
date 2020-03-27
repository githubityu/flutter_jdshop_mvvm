import 'package:fluro/fluro.dart';
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

class ShopRouter implements IRouterProvider {
  // details
  static const PRODUCT_CONTENT = '/productContent';
  static const PRODUCT_CONTENT_2 = '/productContent2';
  static const SEARCH = '/search';

  static const ROOT_PAGE = '/root_page';
  static const GUIDE_PAGE = '/guide_page';
  static const ORDER = '/order';
  static const LOGIN = '/login';
  static const ADDRESS_LIST = '/address_list';
  static const REGISTER_FIRST = '/register_first';
  static const REGISTER_SECOND = '/register_second';
  static const REGISTER_THIRD = '/register_third';
  static const ADDRESS_ADDOREDIT = '/address_add_or_edit';
  static const CHECKOUT = '/checkOut';
  static const PAY = '/pay';
  static const ORDERINFO = '/orderinfo';
  static const PRODUCTLIST = '/productList';

  @override
  void initRouter(Router router) {
    router.define(ROOT_PAGE,
        handler: Handler(handlerFunc: (context, params) => RootPage()));
    router.define(GUIDE_PAGE,
        handler: Handler(handlerFunc: (context, params) => GuidePage()));
    router.define(ADDRESS_LIST,
        handler: Handler(handlerFunc: (context, params) => AddressList()));
    router.define(REGISTER_FIRST,
        handler: Handler(handlerFunc: (context, params) => RegisterFirst()));
    router.define(SEARCH,
        handler: Handler(handlerFunc: (context, params) => SearchPage()));
    router.define(CHECKOUT,
        handler: Handler(handlerFunc: (context, params) => CheckOutPage()));
    router.define(PAY,
        handler: Handler(handlerFunc: (context, params) => PayPage()));
    router.define(ORDER,
        handler: Handler(handlerFunc: (context, params) => OrderPage()));
    router.define(ORDERINFO,
        handler: Handler(handlerFunc: (context, params) => OrderInfoPage()));
    router.define(LOGIN,
        handler: Handler(handlerFunc: (context, params) => LoginPage()));
    router.define(REGISTER_SECOND,
        handler: Handler(
            handlerFunc: (context, params) =>
                RegisterSecond(params["tel"].first)));
    router.define(REGISTER_THIRD,
        handler: Handler(
            handlerFunc: (context, params) =>
                RegisterThird(params["tel"].first, params["code"].first)));
    router.define(PRODUCT_CONTENT,
        handler: Handler(
            handlerFunc: (context, params) =>
                ProductDetail3(sId: params["id"].first)));
    router.define(PRODUCTLIST,
        handler: Handler(
            handlerFunc: (context, params) => ProductListPage(
                cid: params["cid"]?.first, keywords: params["keywords"].first)));
    router.define(PRODUCT_CONTENT_2,
        handler: Handler(
            handlerFunc: (context, params) =>
                ProductDetail2()));
    router.define(ADDRESS_ADDOREDIT,
        handler: Handler(
            handlerFunc: (context, params) => AddressAddOrEdit(
                  address: params,
                )));
  }
}
