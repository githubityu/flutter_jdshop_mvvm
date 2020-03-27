import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutterjdshop/common/common.dart';

class Cart with ChangeNotifier {
  List _cartList = []; //购物车数据
  bool _isCheckedAll = false; //全选
  double _allPrice = 0; //总价

  List get cartList => this._cartList;
  bool get isCheckedAll => this._isCheckedAll;
  double get allPrice => this._allPrice;

  Cart() {
    this.init();
  }
  //初始化的时候获取购物车数据
  init() async {
    try {
      List cartListData = json.decode(SharedUtil.instance.getString('cartList'));
      this._cartList = cartListData;
    } catch (e) {
      this._cartList = [];
    }
    //获取全选的状态
    this._isCheckedAll = this.isCheckAll();
    //计算总价
    this.computeAllPrice();
    
    notifyListeners();
  }

  updateCartList() {
    this.init();
  }

  itemCountChange() {
    SharedUtil.instance.saveString("cartList", json.encode(this._cartList));
    //计算总价
    this.computeAllPrice();
    
    notifyListeners();
  }

  //全选 反选
  checkAll(value) {
    for (var i = 0; i < this._cartList.length; i++) {
      this._cartList[i]["checked"] = value;
    }
    this._isCheckedAll = value;
    //计算总价
    this.computeAllPrice();

    SharedUtil.instance.saveString("cartList", json.encode(this._cartList));
    notifyListeners();
  }

  //判断是否全选
  bool isCheckAll() {
    if (this._cartList.length > 0) {
      for (var i = 0; i < this._cartList.length; i++) {
        if (this._cartList[i]["checked"] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  //监听每一项的选中事件
  itemChage() {
    if (this.isCheckAll() == true) {
      this._isCheckedAll = true;
    } else {
      this._isCheckedAll = false;
    }
     //计算总价
    this.computeAllPrice();

    SharedUtil.instance.saveString("cartList", json.encode(this._cartList));
    notifyListeners();
  }

  //计算总价
  computeAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]["checked"] == true) {
        tempAllPrice += this._cartList[i]["price"] * this._cartList[i]["count"];
      }
    }
    this._allPrice = tempAllPrice;
    notifyListeners();
  }
  //删除数据
  removeItem() {
              //  1        2
    // ['1111','2222','333333333','4444444444']
    // 错误的写法 
    // for (var i = 0; i < this._cartList.length; i++) {
    //   if (this._cartList[i]["checked"] == true) {
    //      this._cartList.removeAt(i);
    //   }
    // }

    List tempList=[];
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]["checked"] == false) {
         tempList.add(this._cartList[i]);
      }
    }
    this._cartList=tempList;
    //计算总价
    this.computeAllPrice();
    SharedUtil.instance.saveString("cartList", json.encode(this._cartList));
    notifyListeners();
  }
}
