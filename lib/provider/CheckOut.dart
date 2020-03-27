import 'package:flutter/material.dart';

class CheckOut with ChangeNotifier {
  List _checkOutListData = []; //购物车数据
  List get checkOutListData => this._checkOutListData;

  changeCheckOutListData(data){
    this._checkOutListData=data;
    notifyListeners();
  }

}
