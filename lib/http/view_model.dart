import 'package:dio/dio.dart';
import 'package:flutterjdshop/http/mvvms.dart';

class ViewModel<V extends IMvvmView> {
  V view;
  CancelToken cancelToken;
}
