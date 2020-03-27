import 'package:flutterjdshop/http/view_model.dart';

import 'ProductModel.dart';


ProductViewModel productViewModel = new ProductViewModel();

class ProductViewModel extends ViewModel {
  /*
  * 发送信息
  * */
  Future<ProductModel> getData({type=0}) async {
    final data = await ProductModel2().data(type);
    if (data != null && data.isNotEmpty) {
      return ProductModel.fromJson(data);
    }
    return Future.value(null);
  }
}
