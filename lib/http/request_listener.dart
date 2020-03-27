import 'package:flutter/material.dart';

import 'base_response.dart';

///网络请求监听
class RequestListener {
  RequestListener({@required this.onSuccessListener, @required this.onErrorListener});

  //请求成功
  final ValueChanged<BaseResponse> onSuccessListener;

  //请求失败
  final ValueChanged<BaseResponse> onErrorListener;

  void onSuccess(BaseResponse response) {
    if (onSuccessListener != null) onSuccessListener(response);
  }

  void onError(BaseResponse response) {
    if (onErrorListener != null) onErrorListener(response);
  }
}