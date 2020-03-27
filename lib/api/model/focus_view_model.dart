import 'package:flutterjdshop/http/view_model.dart';

import 'FocusModel.dart';


FocusViewModel focusViewModel = new FocusViewModel();

class FocusViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<FocusModel> getData() async {
    final data = await FocusModel2().data();
    if (data != null && data.isNotEmpty) {
      return FocusModel.fromJson(data);
    }
    return Future.value(null);
  }
}
