import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/api/model/list_view_model.dart';
import 'package:flutterjdshop/api/model/void_modle.dart';
import 'package:flutterjdshop/api/model/void_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/http/view_model.dart';
import 'package:flutterjdshop/provider/Cart.dart';
import 'package:flutterjdshop/provider/CheckOut.dart';
import 'package:flutterjdshop/receiver/event_bus.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/utils/CheckOutServices.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key}) : super(key: key);

  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends BasePageState<CheckOutPage> {
  List _addressList = [];

  @override
  void initState() {
    super.initState();
    //监听广播
    eventBus.on<CheckOutEvent>().listen((event) {
      this._getDefaultAddress();
    });
  }
  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "订单详情");
  }

  @override
  void subInitState() {
    this._getDefaultAddress();
  }

  _getDefaultAddress() async {
    // print('1234');
    var tempJson = {
      "uid": UserInfoData.instance.id,
      "salt": UserInfoData.instance.salt
    };

    var sign = getSign(tempJson);

    ListViewModel.get(this, getCancelToken()).getData(
        type: VoidModel.ONEADDRESSLIST,
        params2: {
          "uid": UserInfoData.instance.id,
          "sign": sign
        }).then((onValue) {
      setState(() {
        this._addressList = onValue;
      });
    });
  }

  Widget _checkOutItem(item) {
    return Row(
      children: <Widget>[
        Container(
          width: AppSize.width(160),
          child: Image.network("${item["pic"]}", fit: BoxFit.cover),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${item["title"]}", maxLines: 2),
                  Text("${item["selectedAttr"]}", maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥${item["price"]}",
                            style: TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("x${item["count"]}"),
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  this._addressList.length > 0
                      ? ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  "${this._addressList[0]["name"]}  ${this._addressList[0]["phone"]}"),
                              SizedBox(height: 10),
                              Text("${this._addressList[0]["address"]}"),
                            ],
                          ),
                          trailing: Icon(Icons.navigate_next),
                          onTap: () {
                            NavigatorUtils.push(context, ShopRouter.ADDRESS_LIST);
                          },
                        )
                      : ListTile(
                          leading: Icon(Icons.add_location),
                          title: Center(
                            child: Text("请添加收货地址"),
                          ),
                          trailing: Icon(Icons.navigate_next),
                          onTap: () {
                            Navigator.pushNamed(context, '/addressAdd');
                          },
                        ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(AppSize.width(20)),
              child: Consumer<CheckOut>(
                builder: (context, checkOutProvider, child) {
                  return Column(
                      children: checkOutProvider.checkOutListData.map((value) {
                    return Column(
                      children: <Widget>[_checkOutItem(value), Divider()],
                    );
                  }).toList());
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(AppSize.width(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("商品总金额:￥100"),
                  Divider(),
                  Text("立减:￥5"),
                  Divider(),
                  Text("运费:￥0"),
                ],
              ),
            )
          ],
        ),
        Positioned(
          bottom: 0,
          width: AppSize.width(750),
          height: AppSize.height(100),
          child: Container(
            padding: EdgeInsets.all(5),
            width: AppSize.width(750),
            height: AppSize.height(100),
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(width: 1, color: Colors.black26))),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("总价:￥140", style: TextStyle(color: Colors.red)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    child: Text('立即下单', style: TextStyle(color: Colors.white)),
                    color: Colors.red,
                    onPressed: () async {
                      if (this._addressList.length > 0) {
                        //注意：商品总价保留一位小数
                        var allPrice = CheckOutServices.getAllPrice(
                                Provider.of<CheckOut>(context,listen: false).checkOutListData)
                            .toStringAsFixed(1);

                        //获取签名
                        var sign = getSign({
                          "uid": UserInfoData.instance.id,
                          "phone": this._addressList[0]["phone"],
                          "address": this._addressList[0]["address"],
                          "name": this._addressList[0]["name"],
                          "all_price": allPrice,
                          "products": json.encode(
                              Provider.of<CheckOut>(context, listen: false)
                                  .checkOutListData),
                          "salt": UserInfoData.instance.salt //私钥
                        });
                        //请求接口

                        VoidViewModel.get(this, getCancelToken())
                            .getData(type: VoidModel.DOORDER, params2: {
                          "uid": UserInfoData.instance.id,
                          "phone": this._addressList[0]["phone"],
                          "address": this._addressList[0]["address"],
                          "name": this._addressList[0]["name"],
                          "all_price": allPrice,
                          "products": json.encode(
                              Provider.of<CheckOut>(context, listen: false)
                                  .checkOutListData),
                          "sign": sign
                        }).then((onValue) {
                          //删除购物车选中的商品数据
                          CheckOutServices.removeUnSelectedCartItem();
                          //调用CartProvider更新购物车数据
                          Provider.of<Cart>(context, listen: false)
                              .updateCartList();
                          //跳转到支付页面
                          NavigatorUtils.push(context, ShopRouter.PAY);
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
