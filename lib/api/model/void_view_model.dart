

import 'package:dio/dio.dart';
import 'package:flutterjdshop/http/mvvms.dart';
import 'package:flutterjdshop/http/view_model.dart';

import 'void_modle.dart';

VoidViewModel voidViewModel = new VoidViewModel();

class VoidViewModel extends ViewModel {
  VoidViewModel() {
    print("======VoidViewModel()=====");
  }

  VoidViewModel.get(IMvvmView view, CancelToken cancelToken) {
    print("======VoidViewModel.get()=====");
    this.view = view;
    this.cancelToken = cancelToken;
  }

  Future getData(
      {type = 0, Map<String, dynamic> params2}) async {
    final data = await VoidModel(cancelToken, view).data(type, params2);
    if (data != null) {
      return data;
    }
    return Future.value(null);
  }
}
