import 'dart:convert';

import 'package:flutterjdshop/common/common.dart';
class CheckOutServices{
  //计算总价
  static getAllPrice(checkOutListData) {
    var tempAllPrice=0.0; 
    for (var i = 0; i < checkOutListData.length; i++) {
      if (checkOutListData[i]["checked"] == true) {
        tempAllPrice += checkOutListData[i]["price"] * checkOutListData[i]["count"];
      }
    }
    return tempAllPrice;
  }
  static removeUnSelectedCartItem() async{

    List _cartList=[];
    List _tempList=[];
    //获取购物车的数据
    try {
      List cartListData = json.decode(SharedUtil.instance.getString('cartList'));
      _cartList = cartListData;
    } catch (e) {
      _cartList = [];
    }
 
    for (var i = 0; i < _cartList.length; i++) {
      if (_cartList[i]["checked"] == false) {
         _tempList.add(_cartList[i]);
      }
    }

    SharedUtil.instance.saveString("cartList", json.encode(_tempList));
    
  }
}