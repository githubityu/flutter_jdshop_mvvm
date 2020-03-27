import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/common/api_exception.dart';
import 'package:flutterjdshop/common/common.dart';
import 'package:flutterjdshop/config/api.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/http/base_response.dart';
import 'package:flutterjdshop/http/mvvms.dart';
import 'package:flutterjdshop/routes/application.dart';
import 'package:flutterjdshop/utils/dialog_utils.dart';

import 'dio_utils.dart';

// 请求计数
var _id = 0;

/*
* 请求类型枚举
* */
enum RequestType { GET, POST }

class ReqModel {
  // 请求url路径
  String url() => null;

  // 请求参数
  Map<String, dynamic> params() => {};

  String encodeData() => null;

  IMvvmView view;
  CancelToken cancelToken;

  /*
  * get请求
  * */
  Future<dynamic> get() async {
    return this._request(
      url: url(),
      method: RequestType.GET,
      params: params(),
    );
  }

  /*
  * post请求
  * */
  Future post() async {
    return this
        ._request(url: url(), method: RequestType.POST, params: params());
  }

  /*
  * post请求-文件上传方式
  * */
  Future postUpload(
    ProgressCallback progressCallBack, {
    FormData formData,
  }) async {
    return this._request(
      url: url(),
      method: RequestType.POST,
      formData: formData,
      progressCallBack: progressCallBack,
      params: params(),
    );
  }

  /*
  * 请求方法
  * */
  Future _request(
      {String url,
      RequestType method,
      Map params,
      FormData formData,
      ProgressCallback progressCallBack}) async {
    final httpUrl = '${API.reqUrl}$url';
    print('HTTP_REQUEST_URL::$httpUrl');

    final id = _id++;
    int statusCode;
    Response response;
    view?.showProgress();
    try {
      if (method == RequestType.GET) {
        ///组合GET请求的参数
        if (mapNoEmpty(params)) {
          response = await DioUtils.instance
              .getDio()
              .get(url, queryParameters: params, cancelToken: cancelToken);
        } else {
          response = await DioUtils.instance
              .getDio()
              .get(url, cancelToken: cancelToken);
        }
      } else {
        if (mapNoEmpty(params)) {
          response = await DioUtils.instance.getDio().post(url,
              queryParameters: params,
              data: formData,
              onSendProgress: progressCallBack,
              cancelToken: cancelToken);
        } else {
          response = await DioUtils.instance
              .getDio()
              .post(url, data: encodeData(), cancelToken: cancelToken);
        }
      }
    } catch (e) {
      view?.closeProgress();
      handError(-1, msg: e.toString());
    }
    statusCode = response.statusCode;
    if (response != null && statusCode == 200) {
      if (mapNoEmpty(params)) print('HTTP_REQUEST_BODY::[$id]::$params');
      print('HTTP_RESPONSE_BODY::[$id]::${json.encode(response.data)}');
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      view?.closeProgress();
      if (baseResponse.success == null || baseResponse.success) {
        return baseResponse.result ?? response.data;
      } else {
        handError(-1);
        return;
      }
    }

    ///处理错误部分
    if (statusCode < 0) {
      handError(statusCode);
    }
  }

  ///处理异常
  handError(int statusCode, {msg}) {
    DialogUtil.buildToast(msg ?? "$statusCode");
    if (statusCode == -101) {
//      Application.navKey.currentState.push(
//         MaterialPageRoute(builder: (context) => RegPageAndLoginPage()),
//      );
      UserInfoData.instance.setToken("");
      DialogUtil.buildToast("请求失败~");
    }
    throw ApiException(statusCode, msg);
  }
}
