import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/provider/Cart.dart';
import 'package:flutterjdshop/provider/CheckOut.dart';
import 'package:flutterjdshop/utils/CartServices.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/view/load_state_layout.dart';
import 'package:provider/provider.dart';

import 'CartItem.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends BasePageState<CartPage>
    with AutomaticKeepAliveClientMixin {
  LoadState _layoutState = LoadState.State_Success;

  bool _isEdit = false;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize.init(context);
    return getScaffold();
  }

  @override
  Widget getAppBar(BuildContext context) {
    return CommonBackTopBar(
      title: "购物车",
      isBack: false,
      rightW: Icon(Icons.launch),
      onRight: () {
        setState(() {
          _isEdit = !_isEdit;
        });
      },
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        //重新加载当前数据
      },
      successWidget: Consumer<Cart>(
        builder: (BuildContext context, cartProvider, Widget child) {
          return cartProvider.cartList.length > 0
              ? Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        Column(
                            children: cartProvider.cartList.map((value) {
                          return CartItem(value);
                        }).toList()),
                        SizedBox(height: AppSize.height(100))
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      width: AppSize.width(750),
                      height: AppSize.height(78),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(width: 1, color: Colors.black12)),
                          color: Colors.white,
                        ),
                        width: AppSize.width(750),
                        height: AppSize.height(78),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: AppSize.width(60),
                                    child: Checkbox(
                                      value: cartProvider.isCheckedAll,
                                      activeColor: Colors.pink,
                                      onChanged: (val) {
                                        //实现全选或者反选
                                        cartProvider.checkAll(val);
                                      },
                                    ),
                                  ),
                                  Text("全选"),
                                  SizedBox(width: 20),
                                  this._isEdit == false
                                      ? Text("合计:")
                                      : Text(""),
                                  this._isEdit == false
                                      ? Text("${cartProvider.allPrice}",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.red))
                                      : Text(""),
                                ],
                              ),
                            ),
                            this._isEdit == false
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: RaisedButton(
                                      child: Text("结算",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: Colors.red,
                                      onPressed: doCheckOut,
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: RaisedButton(
                                      child: Text("删除",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: Colors.red,
                                      onPressed: () {
                                        cartProvider.removeItem();
                                      },
                                    ),
                                  )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Center(
                  child: Text("购物车空空的..."),
                );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  //去结算

  doCheckOut() async {
    //1、获取购物车选中的数据
    List checkOutData = await CartServices.getCheckOutData();
    //2、保存购物车选中的数据
    Provider.of<CheckOut>(context,listen: false).changeCheckOutListData(checkOutData);
    //3、购物车有没有选中的数据
    if (checkOutData.length > 0) {
      //4、判断用户有没有登录
      var loginState = UserInfoData.instance.isLogin;
      if (loginState) {
        Navigator.pushNamed(context, '/checkOut');
      } else {
        showToast('您还没有登录，请登录以后再去结算');
        Navigator.pushNamed(context, '/login');
      }
    } else {
      showToast('购物车没有选中的数据');
    }
  }
}
