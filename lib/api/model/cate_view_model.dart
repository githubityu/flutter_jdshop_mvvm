import 'package:flutterjdshop/http/view_model.dart';

import 'CateModel.dart';
import 'FocusModel.dart';

class CateViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  CateViewModel.get(cancelToken, {view}) {
    this.cancelToken = cancelToken;
    this.view = view;
  }

  Future<CateModel> getData({pid = "", type = 0}) async {
    final data = await CateModel2().data(pid, type);
    if (data != null && data.isNotEmpty) {
      return CateModel.fromJson(data);
    }
    return Future.value(null);
  }
}
