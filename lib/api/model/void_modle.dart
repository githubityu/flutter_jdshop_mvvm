import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterjdshop/config/api.dart';
import 'package:flutterjdshop/http/mvvms.dart';
import 'package:flutterjdshop/http/req_model.dart';

class VoidModel extends ReqModel {
  static const SEND_CODE = 1;
  static const REGISTER = 2;
  static const LOGIN = 3;
  static const ADDRESS_LIST = 4;
  static const ADD_ADDRESS = 5;
  static const EDIT_ADDRESS = 6;
  static const DELETE_ADDRESS = 7;
  static const CHANGE_ADDRESS = 8;
  static const PCONTENT = 9;
  static const DOORDER = 10;
  static const ONEADDRESSLIST = 11;
  static const ORDERLIST = 12;
  static const PLIST = 13;

  int type;
  Map<String, dynamic> params2;

  VoidModel(CancelToken cancelToken, IMvvmView view) {
    this.view = view;
    this.cancelToken = cancelToken;
  }

  get isNotEncode {
    return type == ADDRESS_LIST||type==PCONTENT||type==ONEADDRESSLIST||type==ORDERLIST||type==PLIST;
  }

  ///后台正常接收参数 用的是RequestParam
  @override
  Map<String, dynamic> params() {
    return isNotEncode ? params2 : null;
  }

  ///后台用RequestBody接收参数需要传入json
  @override
  String encodeData() {
    return isNotEncode ? null : json.encode(params2);
  }

  @override
  String url() {
    String url = "";
    switch (type) {
      case SEND_CODE:
        url = API.sendCode;
        break;
      case REGISTER:
        url = API.register;
        break;
      case LOGIN:
        url = API.login;
        break;
      case ADDRESS_LIST:
        url = API.addressList;
        break;
      case ADD_ADDRESS:
        url = API.addAddress;
        break;
      case EDIT_ADDRESS:
        url = API.editAddress;
        break;
      case DELETE_ADDRESS:
        url = API.deleteAddress;
        break;
        case CHANGE_ADDRESS:
        url = API.changeDefaultAddress;
        break;
        case PCONTENT:
        url = API.pcontent;
        break;
        case DOORDER:
        url = API.doOrder;
        break;
        case ONEADDRESSLIST:
        url = API.oneAddressList;
        break;
        case ORDERLIST:
        url = API.orderList;
        break;
        case PLIST:
        url = API.plist;
        break;
    }
    return url;
  }

  Future data(type, Map<String, dynamic> params2) {
    this.type = type;
    this.params2 = params2;
    switch (type) {
      case ADDRESS_LIST:
      case PCONTENT:
      case ONEADDRESSLIST:
      case ORDERLIST:
      case PLIST:
        return get();
        break;
    }
    return post();
  }
}
