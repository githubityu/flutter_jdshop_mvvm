import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterjdshop/http/mvvms.dart';
import 'package:flutterjdshop/http/view_model.dart';

import 'void_modle.dart';

ListViewModel listViewModel = new ListViewModel();

class ListViewModel extends ViewModel {
  ListViewModel() {
    print("======VoidViewModel()=====");
  }

  ListViewModel.get(IMvvmView view, CancelToken cancelToken) {
    print("======VoidViewModel.get()=====");
    this.view = view;
    this.cancelToken = cancelToken;
  }

  Future<List> getData({type : 0, Map<String, dynamic> params2}) async {
    final List data = await VoidModel(cancelToken, view).data(type, params2);
    if (data != null) {
      return data;
    }
    return Future.value(null);
  }
}
