import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterjdshop/config/api.dart';
import 'package:flutterjdshop/http/intercept.dart';

import 'my_navigator_observer.dart';

class Application {
  static late FluroRouter router;
  static GlobalKey<NavigatorState>? navKey;
  final dio = Dio()
    ..options = BaseOptions(baseUrl: API.reqUrl, connectTimeout: Duration(seconds: 30), receiveTimeout: Duration(seconds: 30))
    ..interceptors.add(AuthInterceptor())
    ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
}
