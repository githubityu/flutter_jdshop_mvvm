import 'package:dio/dio.dart';
import 'package:flutterjdshop/config/user_info_data.dart';

class AuthInterceptor extends Interceptor {
    @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    options.headers['Authorization'] = UserInfoData.instance!.token;
    return super.onRequest(options, handler);
  }
}
