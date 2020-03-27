import 'package:dio/dio.dart';
import 'package:flutterjdshop/config/api.dart';
import 'package:flutterjdshop/config/config.dart';

import 'intercept.dart';

class DioUtils {
  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal() {
    var options = BaseOptions(
      connectTimeout: connectTimeOut,
      receiveTimeout: receiveTimeOut,
      //responseType: ResponseType.plain,
      headers: {
        'content-type': 'application/json',
      },
      validateStatus: (status) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: API.reqUrl,
//      contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
    );
    _dio = new Dio(options);
    _dio.interceptors.add(AuthInterceptor());
    /// Fiddler抓包代理配置 https://www.jianshu.com/p/d831b1f7c45b
  }
}
