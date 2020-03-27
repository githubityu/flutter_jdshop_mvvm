import 'package:dio/dio.dart';
import 'package:flutterjdshop/config/user_info_data.dart';

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    options.headers['Authorization'] = UserInfoData.instance.token;
    return super.onRequest(options);
  }
}
